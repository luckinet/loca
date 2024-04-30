# author and date of creation ----
# Luise Quoß, April 2021

# script description ----
#
# PADDD & WDPA: rasterize all single features 10x10 meters 
# already spatially adjust them to the 100x100 raster with ul corner -180,90
# change values in dictionary 'cats' to change the value the pixel get assigned (in case the definition of the categories changes)
# the PADDD year is always accounted in the following year. a degazetted protected area with PADDD_YR=1990 will still be included in 1990 and removed beginning in 1991
# all features with missing years are removed - should be no problem anymore after missing values treatment (lines 70-72)
# outputname: DATASET_preprocessing_02_YEAR_CATEGORY_ID.tif

# load packages ----
#
import ogr, gdal
import osr
import os
import time
from tqdm import tqdm
import pandas as pd
from datetime import date

# set paths ----
#
input_root = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_01'
paddd_path = os.path.join(input_root, 'PADDD_preprocessing_01.shp')
wdpa_path = os.path.join(input_root, 'WDPA_preprocessing_01.shp')
out_path = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_02'

# load data ----
#
# global variables
cats = {'Ia': 1, 'Ib': 2, 'I': 2, 'II': 2, 'III': 2,'IV': 2, 'V': 5, 'VI':3, 'Not Applicable':6, 'Not Assigned':6, 'Not Reported':6}
res_y = round((10/111319.5), 10)
res_x = round((10/111319.5), 10) 
#log file
log = {'ID': ['Year', 'type', 'yearPADD', 'yearRV', 'REV', 'IUCN_cat']}

#open shp files
inDriver = ogr.GetDriverByName("ESRI Shapefile")
wdpa_datasource = inDriver.Open(wdpa_path, 1)
wdpa = wdpa_datasource.GetLayer()

driver = ogr.GetDriverByName("ESRI Shapefile")
paddd_datasource = driver.Open(paddd_path, 1)
paddd = paddd_datasource.GetLayer()

# data processing ----
#
# write output ----
#

#get years of all polygons
years = []
for feature in wdpa:
    y = feature.GetField("STATUS_YR")
    if y not in years:
        years.append(y)

for feature in paddd:
    y1 = feature.GetField("YearPAGaze")
    y2 = feature.GetField("YearPADDD")
    y3 = feature.GetField("YR_Reverse")
    if y1 not in years:
        years.append(y1)
    if y2 not in years:
        years.append(y2)
    if y3 not in years:
        years.append(y3)

years.sort()
years.remove('na') #no reverse
years.remove('0') #unknown WDPA
years.remove('unk') #unknown PADDD
years.remove('n/a')

remove = []
for year in years:
    #print(int(year))
    if int(year) < 1970:
        remove.append(year)

for r in remove:
    years.remove(r)


#loop through years:
for year in tqdm(years[0:7]): #CHANGE
    print(year)
    year = int(year)+1 #to avoid <= symbol
    #select features from wdpa
    filter_wdpa = "STATUS_YR < '{}'".format(year)
    #print(filter_wdpa)
    t = wdpa.SetAttributeFilter(filter_wdpa)   
    #select features from paddd
    filter_paddd = "YearPAGaze < '{}'".format(year)
    t = paddd.SetAttributeFilter(filter_paddd)
    #loop through features WDPA
    #print('wdpa', wdpa.GetFeatureCount())
    for feature in wdpa:
        id = feature.GetField("WDPA_PID")
        iucn_cat = feature.GetField("IUCN_CAT")
        cat = cats[iucn_cat]
        #output = os.path.join(out_path, str(year-1) + '_'+ str(cat) + '_' + id +  '_wdpa_10m.tif')
        output = os.path.join(out_path, 'WDPA_preprocessing_02_' + str(year-1) + '_'+ str(cat) + '_' + id + '.tif')
        if not (os.path.exists(output)):
            #filter for the one shape with the corresponding ID
            filter_gdal = """ "SELECT * FROM WDPA_preprocessing_01 where "WDPA_PID" = '{}'" """.format(id) 
            #get extent of that shape
            geom=feature.GetGeometryRef()
            #extent = geom.GetEnvelope()
            x_min, x_max, y_min, y_max = geom.GetEnvelope()
            #align extent of output as if it started at -180, 90 ul corner   
            geotrans = [-180, (res_x*10), 0, 90, 0, (-res_y*10)]
            xmin_factor = int((x_min- geotrans[0])/ geotrans[1])
            xmax_factor = int((x_max- geotrans[0])/ geotrans[1])
            ymax_factor = int((y_max - geotrans[3])/ geotrans[-1])
            ymin_factor = int((y_min - geotrans[3])/ geotrans[-1])
            new_x_min =  geotrans[0]+xmin_factor * geotrans[1]
            new_y_max = geotrans[3]+ymax_factor * geotrans[-1]
            new_x_max =  geotrans[0]+xmax_factor * geotrans[1]
            new_y_min = geotrans[3]+ymin_factor * geotrans[-1]
            #make sure the whole area is still covered
            while new_x_max < x_max:
                new_x_max = new_x_max + (res_x*10)
            while new_y_min > y_min:
                new_y_min = new_y_min - (res_x*10)
            te = str(new_x_min) + ' ' + str(new_y_min) + ' ' + str(new_x_max) + ' ' + str(new_y_max)
            cmd = 'gdal_rasterize -burn {} -at -sql {} -tr {} {} -ot Byte -te {} -co compress=deflate {} {}'.format(cat, filter_gdal, res_x, res_y, te, wdpa_path, output)
            #print(cmd)
            os.system(cmd)            
    #loop through features PADDD
    print('paddd', paddd.GetFeatureCount())
    for feature in paddd:
        id = feature.GetField("PADDD_ID")
        paddd_type = feature.GetField("EventType")
        rev = feature.GetField("Reversal")
        try:
            rev_year = int(feature.GetField("YR_Reverse"))
        except: 
            rev_year = 2020 #highest year so no reverse is set
        paddd_year = int(feature.GetField("YearPADDD"))
        #get cat based on EventType and Reversal 
        #degazatted in a later year: IUCN_pre is valid
        if paddd_type == 'Degazette' and paddd_year >= (year-1):
            iucn_cat = feature.GetField("IUCN_pre")
            cat = cats[iucn_cat]
        #reversed degazatte
        elif paddd_type == 'Degazatte' and rev == 'Y' and rev_year < (year-1):
            iucn_cat = feature.GetField("IUCN_pre")
            cat = cats[iucn_cat]
        #downsize does not change the IUCN cat
        elif paddd_type == 'Downsize':
            iucn_cat = feature.GetField("IUCN_pre")
            cat = cats[iucn_cat]
        #downgrade is not yet reversed
        elif paddd_type == 'Downgrade' and paddd_year < (year-1) and rev_year >= (year-1) and rev == 'Y':
            iucn_cat = feature.GetField("IUCN_post")
            cat = cats[iucn_cat]
        #downsized and not reversed
        elif paddd_type == 'Downgrade' and paddd_year < (year-1) and rev == 'N':
            iucn_cat = feature.GetField("IUCN_post")
            cat = cats[iucn_cat]
        #not yer downgegraded
        elif paddd_type == 'Downgrade' and paddd_year >= (year-1):
            iucn_cat = feature.GetField("IUCN_pre")
            cat = cats[iucn_cat]
        #erversed downgrade
        elif paddd_type == 'Downgrade' and rev_year < (year-1) and rev == 'Y':
            iucn_cat = feature.GetField("IUCN_pre")
            cat = cats[iucn_cat]
        #PAs that are degazatted during that year
        elif (paddd_type == 'Degazette' and paddd_year < (year-1) and rev == 'N') or (paddd_type == 'Degazette' and paddd_year < (year-1) and rev_year > (year-1) and rev == 'Y'):
            print('degazatted', id, paddd_year, rev_year)
            continue #jumps the feature in this for loop - no feature should be created
        else:
            log[id] = [year-1,paddd_type, paddd_year,  rev_year, rev, iucn_cat]
        #output = os.path.join(out_path, str(year-1) + '_'+ str(cat) + '_' + id +  '_paddd_10m.tif')
        output = os.path.join(out_path, 'WDPA_preprocessing_02_' + str(year-1) + '_'+ str(cat) + '_' + id + '.tif')
        if not (os.path.exists(output)):
            #filter for the one shape with the corresponding ID
            filter_gdal = """ "SELECT * FROM PADDD_preprocessing_01 where "PADDD_ID" = '{}'" """.format(id)
            #get extent of that shape
            geom=feature.GetGeometryRef()
            x_min, x_max, y_min, y_max = geom.GetEnvelope()
            #align extent of output as if it started at -180, 90 ul corner   
            geotrans = [-180, (res_x*10), 0, 90, 0, (-res_y*10)]
            xmin_factor = int((x_min- geotrans[0])/ geotrans[1])
            xmax_factor = int((x_max- geotrans[0])/ geotrans[1])
            ymax_factor = int((y_max - geotrans[3])/ geotrans[-1])
            ymin_factor = int((y_min - geotrans[3])/ geotrans[-1])
            new_x_min =  geotrans[0]+xmin_factor * geotrans[1]
            new_y_max = geotrans[3]+ymax_factor * geotrans[-1]
            new_x_max =  geotrans[0]+xmax_factor * geotrans[1]
            new_y_min = geotrans[3]+ymin_factor * geotrans[-1]
            #make sure the whole area is still covered
            while new_x_max < x_max:
                new_x_max = new_x_max + (res_x*10)
            while new_y_min > y_min:
                new_y_min = new_y_min - (res_x*10)
            te = str(new_x_min) + ' ' + str(new_y_min) + ' ' + str(new_x_max) + ' ' + str(new_y_max)
            cmd = 'gdal_rasterize -burn {} -at -sql {} -tr {} {} -ot Byte -te {} -co compress=deflate {} {}'.format(cat, filter_gdal, res_x, res_y, te, paddd_path, output)
            os.system(cmd)

#write log
date = str(date.today()).replace('-', '_')
outpath = os.path.join(out_path, 'log_'+ date +'.csv')
pd.DataFrame.from_dict(data=log, orient='index').to_csv(outpath, header=False)

#close shps
wdpa = None
wdpa_datasource = None
paddd = None
paddd_datasource = None


