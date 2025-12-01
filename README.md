# Marine Aquaculture Habitat on the US West Coast 

##### Author
Henry Oliver

###### Date
###### November 30, 2025

### Purpose
The purpose of this analysis is to view the viable aquaculture range of American cupped oysters **Crassostrea virginica** and Pacific calico scallops **Argopecten ventricosus** as well as a provide a function that can estimate the extent viable aquaculture habitats for any aquatic species given the temperature and depth ranges for growth. Rendering the 'analysis.qmd' quarto document in the 'docs' folder in this repository will perform referenced analysis. This project should serve as a tool for preliminary estimation of aquaculture habitat for species with known ground ranges.

### Contents
```
├── data #This folder is currently empty but, once populated, should have the
|        #structure indicated below. See 'Data Access' sections for details
│   ├── depth.tif
│   ├── sst
│   │   ├── average_annual_sst_2008.tif
│   │   ├── average_annual_sst_2009.tif
│   │   ├── average_annual_sst_2010.tif
│   │   ├── average_annual_sst_2011.tif
│   │   └── average_annual_sst_2012.tif
│   ├── wc_regions_clean.dbf
│   ├── wc_regions_clean.prj
│   ├── wc_regions_clean.shp
│   └── wc_regions_clean.shx
├── docs
│   ├── analysis.qmd  #Rendering this document will produce analysis referenced above
│   
├── functions
│   └── aquaculture_habitat_function.R #Contains the function used in analysis.qmd
├── marine-aquaculture-eez.Rproj
└── README.md
```

### Data Access
The data used in this analysis consists of three key pieces. The file names for each are listed below. All data was obtained here: https://drive.google.com/file/d/1u-iwnPDbe6ZK7wSFVMI-PpCKaRQ3RVmg/view

1) Average annual Sea Surface Temperatures 2008-2012
 - average_annual_sst_2008.tif
 - average_annual_sst_2009.tif
 - average_annual_sst_2010.tif
 - average_annual_sst_2011.tif
 - average_annual_sst_2012.tif

2) Ocean Depth Bathymetry Raster
 - depth.tif


3) West Coast Economic Zones
 - wc_regions_clean.dbf
 - wc_regions_clean.prj
 - wc_regions_clean.shp
 - wc_regions_clean.shx


### References
Hall, S. J., Delaporte, A., Phillips, M. J., Beveridge, M., & O’Keefe, M. (2011). 
*Blue Frontiers: Managing the Environmental Costs of Aquaculture*. 
The WorldFish Center, Penang, Malaysia.

Gentry, R. R., Froehlich, H. E., Grimm, D., Kareiva, P., Parke, M., Rust, M., 
Gaines, S. D., & Halpern, B. S. (2017). Mapping the global potential for marine aquaculture. 
*Nature Ecology & Evolution*, 1, 1317–1324.

SeaLifeBase. “United States (contiguous states) – Species summary for Argopecten ventricosus.” Accessed November 30, 2025. https://www.sealifebase.ca/country/CountrySpeciesSummary.php?Country=United+States+(contiguous+states)&genusname=Argopecten&speciesname=ventricosus

GEBCO Compilation Group (2022). *GEBCO_2022 Grid* 
(doi:10.5285/e0f0bb80-ab44-2739-e053-6c86abc0289c).




