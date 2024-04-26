# author and date of creation ----
# Luise Quoß, April 2021

# script description ----
#
# merge all 100x100 rasterized features (WDPA and PADDD together)
# all files are sorted so the last feature has the highest category --> will overwrite the other value --> result: layer that always includes the highest category
# outputnames: WDPA_PADDD_preprocessing_04_YEAR.tif

# load packages ----
#
from osgeo import gdal, ogr
import os
from tqdm import tqdm

# set paths ----
#
root_path = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_03'
out_path = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_04'
#check output path
if not os.path.exists(out_path):
    os.mkdir(out_path)

# load data ----
#
#global variables
old_res = round((10/111319.5), 10)
res_y = old_res * 10
res_x =  old_res * 10

#list all files
files = os.listdir(root_path)

# data processing ----
# write output ----
#
#get all years
years = []
for file in files:
    if file.endswith('.tif'):
        y = file.split('_')[3]
    if y not in years:
        years.append(y)
years.sort()
print(years)

#loop through years
for year in tqdm(years):
    print(year)
    file_list = []
    for file in files:
        #get all files of the specific year
        if file.split('_')[3]==year:
            #only use the tif files
            if file.endswith('.tif'):
                #add filename to list
                file_list.append(file)
    if len(file_list) > 0 :
        #when files overlap: gdalwarp writes last file, therefore sort, to write highest IUCN cat (lowest value)
        #sort list from biggest do lowest category
        file_list.sort(reverse=True, key= lambda x: x.split('_')[4])
        i=0
        j=1
        year_list = []
        while i <= (len(file_list)-1):
            file_list_joined = ''
            while len(file_list_joined) < (8178-422-46) and i < len(file_list): #max-length cmd 8191 - length base cmd command - length new filename+1
                #print(i)
                file_list_joined = file_list_joined + file_list[i] + ' '
                i += 1
            name = 'WDPA_PADDD_preprocessing_04_{}_{}.tif'.format(year, j)
            #join output path and name
            out = os.path.join(out_path, name)
            year_list.append(out)
            if not os.path.exists(out):
                cmd = 'cd /D {} && gdalwarp -of GTiff -ot Byte -co BIGTIFF=YES -r near -tr {} {} -co COMPRESS=DEFLATE -overwrite --config GDAL_CACHEMAX 8000 -wm 8000 -te -180 -90 180 90 {} {}'.format(root_path, res_x, res_y, file_list_joined, out)
                #print(cmd)
                print(len(cmd))
                #run command
                os.system(cmd)
            j += 1
        #merge all files of one year
        final = os.path.join(out_path, 'WDPA_PADDD_preprocessing_04_{}.tif'.format(year))
        if not os.path.exists(final):
            if len(year_list) > 1:
                year_list = ' '.join(year_list)
                #define output name according to year
                name = 'WDPA_PADDD_preprocessing_04_{}_.tif'.format(year)
                #join output path and name
                result = os.path.join(out_path, name)
                print(result)
                cmd = 'gdalwarp -of GTiff -ot Byte -co BIGTIFF=YES -r near -tr {} {} -co COMPRESS=DEFLATE -overwrite --config GDAL_CACHEMAX 8000 -wm 8000 -te -180 -90 180 90 {} {}'.format(res_x, res_y, year_list, result)
                #run command
                os.system(cmd)
                #remove old files
                for old_file in year_list:
                    os.rm(old_file)
            #if only one file: rename
            else:
                cmd = 'rename {} {}'.format(year_list[0], final)
                os.system(cmd)