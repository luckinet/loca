# author and date of creation ----
# Luise Quoß, April 2021

# script description ----
#
# WDPA&PADDD: creating several csv lists with the missing values (regarding IUCN category and different year values)
# find tables here: I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\TablesMissingValues
# all tables with ending '_filled' some added values and corresponding sources

# load packages ----
#
import ogr, gdal
import osr
import os
import pandas as pd

# set paths ----
#
tables_root = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\TablesMissingValues'
out_root = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_01'
paddd_select = os.path.join(out_root, 'PADDD_preprocessing_01.shp')
wdpa_select = os.path.join(out_root, 'WDPA_preprocessing_01.shp')

if not os.path.exists(tables_root):
    os.mkdir(tables_root)

# load data ----
#
# PADDD
driver = ogr.GetDriverByName("ESRI Shapefile")
dataSource = driver.Open(paddd_select, 0)
layer = dataSource.GetLayer()

# data processing ----
# write output ----
#
# PADDD

#YearPADDD
layer.SetAttributeFilter("YearPADDD = 'unk'")
result = {'PADDD_ID': ['Country', 'allnames', 'EventType', 'Areaaffect', 'YearPADDD']}
for feat in layer:
    id = feat.GetField("PADDD_ID")
    country= feat.GetField("Country")
    names = feat.GetField("allnames")
    type = feat.GetField("EventType")
    area = feat.GetField("Areaaffect")
    result[id] = [country, names, type, area, '']

outpath = os.path.join(tables_root, 'PADDD_YearPADDD.csv')
pd.DataFrame.from_dict(data=result, orient='index').to_csv(outpath, header=False)

    
#reversed with unknown year
layer.SetAttributeFilter("Reversal = 'Y' and YR_Reverse = 'unk'")
result = {'PADDD_ID': ['Country', 'allnames', 'EventType', 'Areaaffect', 'YR_Reverse']}
for feat in layer:
    id = feat.GetField("PADDD_ID")
    country= feat.GetField("Country")
    names = feat.GetField("allnames")
    type = feat.GetField("EventType")
    area = feat.GetField("Areaaffect")
    result[id] = [country, names, type, area, '']
    
outpath = os.path.join(tables_root, 'PADDD_YR_Reverse.csv')
pd.DataFrame.from_dict(data=result, orient='index').to_csv(outpath, header=False)


#unknown year of gazette
layer.SetAttributeFilter("YearPAGaze = 'unk'")
result = {'PADDD_ID': ['Country', 'primarynam','allnames','EventType', 'Areaaffect', 'YearPAGaze']}
for feat in layer:
    id = feat.GetField("PADDD_ID")
    country= feat.GetField("ISO3166")
    primary = feat.GetField('primarynam')
    names = feat.GetField("allnames")
    type = feat.GetField("EventType")
    area = feat.GetField("Areaaffect")
    result[id] = [country, primary, names, type, area, '']   

outpath = os.path.join(tables_root, 'PADDD_YearPAGaze.csv')
pd.DataFrame.from_dict(data=result, orient='index').to_csv(outpath, header=False)
    
    
#is there downgrade with unknown IUCN_pre and/or IUCN_post?
layer.SetAttributeFilter("(IUCN_post = 'unk' or IUCN_pre = 'unk') and EventType = 'Downgrade'")
print(layer.GetFeatureCount())
result = {'PADDD_ID': ['Country', 'allnames', 'EventType', 'Areaaffect', 'YearPAGaze', 'IUCN_post', 'IUCN_pre']}
i = 0
for feat in layer:
    id = feat.GetField("PADDD_ID")
    country= feat.GetField("Country")
    names = feat.GetField("allnames")
    type = feat.GetField("EventType")
    area = feat.GetField("Areaaffect")
    year = feat.GetField("YearPAGaze")
    post = feat.GetField("IUCN_post")
    pre = feat.GetField("IUCN_pre")
    result[id] = [country, names, type, area, year, post, pre] 
    i += 1

outpath = os.path.join(tables_root, 'PADDD_downgrade_missing_IUCN.csv')
pd.DataFrame.from_dict(data=result, orient='index').to_csv(outpath, header=False)
 
#close file
dataSource = None
layer = None

# load data ----
#
# WDPA
dataSource = driver.Open(wdpa_select, 0)
layer = dataSource.GetLayer()

# data processing ----
# write output ----
#
# WDPA

#STATUS_YR
layer.SetAttributeFilter("STATUS_YR = '0'")
result = {'WDPA_PID': ['name', 'iso3', 'desig_eng', 'iucn_cat', 'gis_area', 'Status_yr']}
for feat in layer:
    id = feat.GetField("WDPA_PID")
    name = feat.GetField("NAME")
    iso3 = feat.GetField("ISO3")
    desig_eng = feat.GetField("DESIG_ENG")
    iucn_cat = feat.GetField("IUCN_CAT")
    gis_area = feat.GetField("GIS_AREA")
    result[id] = [name, iso3, desig_eng, iucn_cat, gis_area, '']

outpath = os.path.join(tables_root, 'WDPA_status_yr.csv')
pd.DataFrame.from_dict(data=result, orient='index').to_csv(outpath, header=False)

#STATUS_YR
layer.SetAttributeFilter("IUCN_CAT = 'Not Assigned'")
result = {'WDPA_PID': ['name', 'iso3', 'desig_eng', 'iucn_cat', 'gis_area']}
for feat in layer:
    id = feat.GetField("WDPA_PID")
    name = feat.GetField("NAME")
    iso3 = feat.GetField("ISO3")
    desig_eng = feat.GetField("DESIG_ENG")
    iucn_cat = feat.GetField("IUCN_CAT")
    gis_area = feat.GetField("GIS_AREA")
    result[id] = [name, iso3, desig_eng, iucn_cat, gis_area]

outpath = os.path.join(tables_root, 'WDPA_not_assigned.csv')
pd.DataFrame.from_dict(data=result, orient='index').to_csv(outpath, header=False)


#close file
dataSource = None
layer = None
