# author and date of creation ----
# Luise Quoß, April 2021

# script description ----
#
# PADDD & WDPA: upsample all single features 100x100 meters 
# 1 tif per feature with 2 bands 
# 1. band including the category
# 2. band including the percentage of the 100x100 pixel covered by the 10x10 pixels of the feature
# outputname: DATASET_preprocessing_03_YEAR_CATEGORY_ID.tif


# load packages ----
#
import os
import osgeo.gdalnumeric as _gdalnum
import osgeo.gdalconst as _gdalcon
import gdal
import numpy as _np
import sys as _sys
from tqdm import tqdm

# define functions
#
def _read_data(inTif, band_nr, verbose):
    '''
    internale function to read the data from raster
    '''
    try:
        band = inTif.GetRasterBand(band_nr)
        data = _gdalnum.BandReadAsArray(band)
        if type(data)==None.__class__:
            raise Exception('no data to read')
        else:
            noda = band.GetNoDataValue()
            if verbose:
                if noda == None:
                    print('\n\n   WARNING: There is no "NODATA" value inside the raster specified \n \
       --> continue without\n\n')
            return data, noda
    except Exception: 
        print('can not read input as array')
    finally:
        inTif = None
def read(tif, band='all', nodata=False, verbose=True):
    '''
    reads in a tif, and returns a numpy array;

    to read a tif into numpy array
    
    tif -- full path to tif to read in
    band -- number of band to read, default read all bands
    nodata -- return nodata value default False
    
    >>> data = mp.tif.read(fullPath) # or e.g. (fullpath, band=2, nodata=True)

    fullPath --> full path plus the filename
    bandNr   --> the number of the band you want to read

    if band is set to a certain value it will read just this band;
    default is to read the first band; to read in all bands set band to zero;
    band can also be a list e.g.: [1,4,5] will be readin in the same order as passed
    (if band is a list start counting by 1);
    creates a 2d or 3d stack;
    
    shape is (rows, columns for 2d) (band, rows, columns for 3d)
    '''
    #default band is 1 and default for return nodata value is False ~ 0 ;1 ~ True
    inTif = _gdalnum.gdal.Open(tif, _gdalcon.GA_ReadOnly)
    if inTif == None:
        raise IOError ('input is not a file or file is broken: {}'.format(tif))
        _sys.exit(1)
    if inTif.GetGeoTransform() == (0.0, 1.0, 0.0, 0.0, 0.0, 1.0):
        if verbose:
            print('\n\n   WARNING: Missing Geo Information \n\
    --> origin, resolution and tilt not specified\n\
    --> continue without\n')
    availeble_bands = inTif.RasterCount # number of available bands in tif
    if band == 'all':
        #get number of available bands and create list from it with range
        if availeble_bands != 1:
            nr_of_bands = [x for x in range(1, availeble_bands+1)]
        else:
            nr_of_bands = 1
    elif type(band)== int and band <= availeble_bands and band>0:
        nr_of_bands = 1
    elif type(band)==list and \
            all(type(item) == int for item in band) and \
            all(item > 0 for item in band) and len(band)>0:
            nr_of_bands = band
            #test if max passed value is in the range of possible bands
            if _np.array(nr_of_bands).max() <= availeble_bands:
                pass
    else:
        raise ValueError('Error: in passed band value(s): {}; type of: {}; number of available bands: {}'.format(
                band, type(band), availeble_bands))
        _sys.exit(1)
    array_to_return = []
    if nr_of_bands == 1:
        if type(band)==str:
            band = 1
        array_to_return, nodata_val =  _read_data(inTif, band, verbose)
    elif type(nr_of_bands) == list and len(nr_of_bands) > 1:
        for b in nr_of_bands:
        #initialize and create the stack
            if b == 1 :
                stack, nodata_val = _read_data(inTif, b, verbose)
                stack = stack.reshape(1, stack.shape[0], stack.shape[1])
            else:
                #read in all other bands
                stack = _np.vstack((stack, _read_data(inTif, b, verbose=None)[0].reshape((1, stack.shape[1], stack.shape[2]))))
        array_to_return =  stack
    if nodata:
        return array_to_return, nodata_val
    else:
        return array_to_return

# set paths ----
#
src_path = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_02'
out_path = r'I:\MAS\01_projects\LUCKINet\01_data\gridded_data\PA_gridded\WDPA_PADDD_preprocessing\preprocessing_03'
#check outputpath
if not os.path.exists(out_path):
    os.mkdir(out_path)

# load data ----
#    
#global variables
old_res = round((10/111319.5), 10)
res_y = old_res * 10
res_x =  old_res * 10
    
#list files
files = os.listdir(src_path)

# data processing ----
# write output ----
#

#loop through files
for file in tqdm(files):
    if file.endswith('.tif'):
        #basic variables
        name = file.replace('_02_', '_03_')
        file = os.path.join(src_path, file)
        outfile = os.path.join(out_path, name)
        if not os.path.exists(outfile):
            #open file to numpy array
            array = read(file, 1, verbose=False)
            #empty array with 100x100 m resolution
            result = _np.empty([int(array.shape[0]/10),int(array.shape[1]/10)], dtype=int)
            percentage = _np.empty([int(array.shape[0]/10),int(array.shape[1]/10)], dtype=int)
            #moving window to decide for new value
            i=0
            for row in range(0, array.shape[0], 10): #range(1, array.shape[0], 10)
                j = 0        
                for col in range(0, array.shape[1], 10): #range(1, array.shape[1], 10):
                    end_row = row+10
                    end_col = col+10
                    #read subpart 10x10
                    part = array[row:end_row, col:end_col]
                    #count all non-zero pixels
                    count = _np.count_nonzero(part)
                    #check if more than 50% of the area are covered by a PA
                    result[i,j] = len(_np.bincount(_np.reshape(part, part.size)))-1
                    percentage[i,j] = count 
                    j += 1
                i += 1    
            #write data
            inTiff = _gdalnum.gdal.Open(file, _gdalcon.GA_ReadOnly)
            inRows, inCols = result.shape[0], result.shape[1]
            geotrans = inTiff.GetGeoTransform() 
            #get ul corner
            ul_x = geotrans[0]
            ul_y = geotrans[3]
            #create empty file
            driver = _gdalnum.gdal.GetDriverByName('GTiff')
            dataOut = driver.Create(outfile,inCols,inRows,2, _gdalcon.GDT_Int16)
            #set projection
            prj = inTiff.GetProjectionRef()
            l= dataOut.SetProjection(prj)
            #set extent/resolution
            l= dataOut.SetGeoTransform((ul_x, res_x, 0, ul_y, 0, -res_y))
            #write data - band 1
            bandOut = dataOut.GetRasterBand(1)
            l= bandOut.SetNoDataValue(0)
            _gdalnum.BandWriteArray(bandOut,result)
            #write data - band 2
            bandOut = dataOut.GetRasterBand(2)
            l = bandOut.SetNoDataValue(0)
            l = _gdalnum.BandWriteArray(bandOut,percentage)
            #close file
            bandOut = None
            dataOut = None
            inTiff = None