# author and date of creation ----
# 
# Luise Quoß, April 2021

# script description ----
# 
# PADDD: match 188 features with missinge gazette year to the IUCN dataset by name matching (using the status_yr column of IUCN to fill missing Gazette Year)
# after this script: added a column exclude: check manually if some matches should be excluded

# load packages ----
# 
import ogr, gdal
import osr
import os
from csv import reader
from fuzzywuzzy import fuzz
import pandas as pd

# set paths ----
#
out_root = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_01'
wdpa_select = os.path.join(out_root, 'WDPA_preprocessing_01.shp')
table_root = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\TablesMissingValues'
table = os.path.join(table_root, 'PADDD_YearPAGaze_filled.csv')

# load data ----
#
driver = ogr.GetDriverByName("ESRI Shapefile")
ds = driver.Open(wdpa_select, 0)
wdpa = ds.GetLayer()

# data processing ----
#
names = []
ids = []
for feat in wdpa:
    names.append(feat.GetField("NAME"))
    ids.append(feat.GetField('WDPA_PID'))

result = {'WDPA_PID': ['PADDD_ID', 'Country', 'primaryname_PADDD', 'name_WDPA', 'STATUS_YR']}

with open(table, 'r') as paddd:
    csv = reader(paddd)
    for row in csv:
        input = row[2].lower()
        #remove: national, park, state, protected, area
        for r in ['national', 'park', 'state', 'protected', 'area', 'nature', 'reserve', 'conservation', 'hunting']:
            input = input.replace(r, '')
        input = input.strip(' ')
        i = 0
        for name_iucn in names:
            name = name_iucn.lower()
            for r in ['national', 'park', 'state', 'protected', 'area', 'nature', 'reserve', 'conservation', 'hunting']:
                name = name.replace(r, '')
            name = name.strip(' ')
            #https://www.datacamp.com/community/tutorials/fuzzy-string-python
            ratio = fuzz.token_set_ratio(input,name)
            if ratio > 90:
                #print(input, '\t', name)
                filter = "WDPA_PID = '{}'".format(ids[i])
                wdpa.SetAttributeFilter(filter)
                for feat in wdpa:
                    year = feat.GetField('STATUS_YR')
                    cnt = feat.GetField('ISO3')
                if row[1] == cnt:
                    #print(input, '\t', name, year)
                    result[ids[i]] = [row[0], cnt, row[2], name_iucn, year]
            i += 1

# write output ----
#            
outpath = os.path.join(table_root, 'PADDD_YearPAGaze_deteced.csv')
pd.DataFrame.from_dict(data=result, orient='index').to_csv(outpath, header=False)
