# 0.0.7 - 20240824

- include both LUCKINet and GPW in the LUCKINet repository.
- any changes will be recorded in the other changelog (this changelog will be appended to that changelog)

# 0.0.6 - 20230619

- rebuilding everything that was present so far to ensure that a bug that occurred for France didn't spread to other nations
- re-matching territory names with gezatteer after removing water bodies from that gazetteer

# 0.0.5 - 20230606

- rebuilding glw3 dataset after extending the gazetteer to level 6

# 0.0.4 - 20230602

- make sure scripts produce valid outputs (argentina, brazil, paraguay, eurostat, glw3)
- store all output tables as *.csv instead of *.rds

# 0.0.3 - 20230526

- include script for germany at level 4
- make sure scripts produce valid output (fao, agriwanet)

# 0.0.2 - 20230428

- include more scripts from LUCKINet that contain livestock data (russia, syria, taiwan, usa, malaysia, india, indonesia, china, burkinaFaso, newZealand, nigeria, sudan, thailand, uganda)
- include script for gridded livestock of the world dataset

# 0.0.1 - 20230418 - initial setup

- set project up by copying the luckinet script and build the censusDB for the first time
- copy previous geometries and fao tables into the new directories
- run scripts of gadm and fao to register data into inventory tables
- normalize geometries to derive polygons
