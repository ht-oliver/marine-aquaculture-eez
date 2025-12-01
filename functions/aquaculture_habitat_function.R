### This script contains the function referenced in responses.qmd
library(terra)
library(sf)
library(tidyverse)

aquaculture_range <- function(sst_min, sst_max, depth_min, depth_max, species_name = "Species") {
  
  # Calculate the mean sea surface temperature
  mean_sst <- mean(sst_rast)
  
  #Adjust from Kelvin to Celsius
  adjusted_mean_sst <- mean_sst - 273.15
  
  # Reproject sst to a CRS with meters instead of degrees
  sst_reprojected <- project(adjusted_mean_sst, "EPSG:32611")
  
  # Create a matrix to reclassify SST
  sst_matrix <- matrix(c(
    -Inf, sst_min, 0,
    sst_min, sst_max, 1,
    sst_max, Inf, 0),
    ncol = 3,
    byrow = TRUE
  )
  # Matrix for depth
  depth_matrix <- matrix(c(
    -Inf, depth_min, 0,
    depth_min, depth_max, 1,
    depth_max, Inf, 0),
    ncol = 3,
    byrow = TRUE
  )
  
  bathymetry_reprojected <-  project(bathymetry, sst_reprojected) %>% # Reproject
    resample(sst_reprojected) %>%  # Resample
    crop(sst_reprojected) # Crop to sst extent
  
  # Reclassify
  bath_mask <- classify(bathymetry_reprojected, depth_matrix)
  sst_mask <- classify(sst_reprojected, sst_matrix)
  
  # Multiply, return raster where both bath and sst have a value of 1
  species_mask <- bath_mask*sst_mask
  
  # Reproject
  eez_proj <- st_transform(eez, crs(species_mask))
  
  # Clip species habitat to eez extent with mask
  species_eez <- mask(species_mask, vect(eez_proj))
  
  # Get cellsizes in m^2
  species_cell_sizes <- cellSize(species_eez, unit = "m")
  
  # Get area from cell sizes
  species_area <- species_eez*species_cell_sizes
  
  # Suitable habitat per zone in km^2
  zone_area <- zonal(species_area, eez_vect, fun = "sum", na.rm = TRUE) / 1e6
  
  # Add column to eez_proj with the suitable areas from zone_area
  eez_suitable_area <- eez_proj %>% 
    mutate(suitable_area = zone_area$depth)
  
  eez_zones_map <-
    tm_shape(eez_suitable_area) +
    tm_polygons(
      fill = 'suitable_area',
      fill.scale = tm_scale_continuous(values = "viridis"),
      fill.legend = tm_legend(title = "Suitable Area (km^2)")
    ) +
    tm_compass(position = c(0, 0.2)) +
    tm_scalebar(position = c(0, 0.075)) +
    tm_title(text = paste("Suitable Habitat for", species_name, "by Zone"))
  
  eez_zones_table <-
    st_drop_geometry(eez_suitable_area) %>% 
    select(c('rgn', 'suitable_area'))
  
  return(list(map = eez_zones_map, table = eez_zones_table))
}
