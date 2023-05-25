# 1.1.0 - 20230526 - animal types

- include animal types to distinguish cattle, goats and sheep further
- provide use_type and used_part from the respective look-up table
- revise mapping attributes to commodities and to animal types
- revise documentation of the attributes per section


# 1.0.1 - 20230421 - initial recording (changes from 1.0.0)

- reorganise land use and land cover classification. It's questionable whether land use concepts can properly be nested within land cover, because different covers can have the same use (where unique nesting is impossible) and because different data products of land cover have different legends (where a land use may have to be mapped to different land covers, with potentially the same name but different meaning in different land cover products)
- include a clc (Corine landcover) and esalc (ESA CCI Landcover) label that assign the land use class to (several) land cover classes
- write clearer descriptions for all concepts
- introduce attributes for commodities and create mappings for them. Those are intended for modelling and allocation
