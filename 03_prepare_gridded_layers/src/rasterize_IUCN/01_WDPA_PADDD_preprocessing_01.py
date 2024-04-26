# author and date of creation ----
# 
# Luise Quoß, April 2021

# script description ----
# 
# Selection of subset for creation of rasterized dataset
# a. PADDD Dataset
# - selection: "EnactedPro" = 'Enacted'
# - explanation: exclude proposed
# b. IUCN Protected Areas (WDPA)
# - selection: "STATUS" != 'Not Reported' and "STATUS" != 'Proposed'
# - explanation: only include protected area or OECM definitions(see pages 39/40 in pdf: I:\MAS\01_projects\LUCKINet\01_data\WDPA_WDOECM\Resources_in_English\WDPA_WDOECM_Manual_1_6.pdf)


# load packages ----
# 
import ogr, gdal
import osr
import os
import time
from tqdm import tqdm

# set paths ----
#
#input files
wdpa_root = r'I:\MAS\01_projects\LUCKINet\01_data\WDPA_WDOECM\WDPA_WDOECM_merged_shps'
paddd_root = r'I:\MAS\01_projects\LUCKINet\01_data\PADDDtracker_DataReleaseV2_May2019'
wdpa = os.path.join(wdpa_root,'IUCN_Protected_Areas_merged.shp')
paddd = os.path.join(paddd_root,'PADDDtracker_DataReleaseV2_May2019_Poly.shp')
out_root = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_01'

#output dir paddd
if not os.path.exists(os.path.join(paddd_root, 'selection')):
    os.mkdir(os.path.join(paddd_root, 'selection'))
    
#output shps
paddd_select = os.path.join(out_root, 'PADDD_preprocessing_01.shp')
wdpa_select = os.path.join(out_root, 'WDPA_preprocessing_01.shp')

# data processing ----
# write output ----
#
#selection paddd
if not os.path.exists(paddd_select):
    filter = """"SELECT * FROM PADDDtracker_DataReleaseV2_May2019_Poly where "EnactedPro"='Enacted'" """
    cmd = 'ogr2ogr -sql {} {} {}'.format(filter, paddd_select, paddd)
    os.system(cmd)
    
#selection wdpa
if not os.path.exists(wdpa_select):
    filter = """ "SELECT * FROM IUCN_Protected_Areas_merged where "STATUS" != 'Not Reported' and "STATUS" != 'Proposed'" """
    cmd = 'ogr2ogr -sql {} {} {}'.format(filter, wdpa_select, wdpa)
    os.system(cmd)