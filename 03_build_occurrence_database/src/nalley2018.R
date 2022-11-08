# script arguments ----
#
thisDataset <- "Nalley2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0209598.ris"))

regDataset(name = thisDataset,
           description = "Although classified as an upper middle-income country, food insecurity is still a concern throughout South Africa, as was evident in 2014–2015 when a drought left 22% of households food insecure. Further, a range of domestic and international factors make the local currency unstable, leaving South Africa exposed to risk in global wheat and exchange rate markets and increasing its food insecurity vulnerability. As such, agricultural research in South Africa is needed specifically in plant breeding to increase yields and help mitigate future food insecurity. To foster scientific innovation for food security, the South African government funds the Agricultural Research Council (ARC), which conducts holistic research on wheat and other crops. This study estimates the proportions of increases in yield of ARC’s wheat cultivars, which are attributable solely to genetic improvements. In total, 25,690 yield observations from 125 countrywide test plots from 1998 to 2014 were utilized to estimate the proportions of yield increases attributable to the ARC. We found that South African farmers who adopted the ARC’s wheat varieties experienced an annual yield gain of 0.75%, 0.30%, and 0.093% in winter, facultative, and irrigated spring wheat types, respectively. Using observed area sown to ARC varieties, we estimated that wheat producers gained $106.45 million (2016 USD) during 1992–2015 via the adoption of ARC varieties. We estimated that every dollar invested in the ARC wheat breeding program generated a return of $5.10. Assuming the South African per capita wheat consumption is 60.9 kg/year, our results suggest that the ARC breeding program provided an average of 253,318 additional wheat rations from 1992–2015. Further, the net surplus (consumer plus producer) from the ARC breeding program was estimated at 42.64 million 2016 USD from 1992–2015. Public breeding programs, especially those focused on wheat and other staple foods, must continue if South Africa is to meet growing global food demand, decrease present global food insecurity, and maintain the genetic enhancements that directly enhances yield and benefits low-income consumers.",
           url = "https://doi.org/10.1371/journal.pone.0209598",
           download_date = "2022-05-30",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#

data <- read_excel(paste0(thisPath, "Nalley2018.xlsx"), skip = 1)
data <- data[-1,]


# harmonise data ----
#

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    type = "areal",
    x = Long,
    y = Lat,
    geometry = NA,
    year = "1998_1999_2000_2001_2002_2003_2004_2005_2006_2007_2008_2009_2010_2011_2012_2013_2014",
    month = NA_real_,
    day = NA_integer_,
    country = "South Africa",
    irrigated = F,
    area = 7.5,
    presence = F,
    externalID = Station,
    externalValue = "wheat",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
