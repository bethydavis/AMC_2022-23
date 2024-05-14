source("setup.R")
cfg = read_configuration("C:/Users/bydav/Desktop/SpeciesList_Cleaning2024/input/cleaning0.00.yaml")

listbase = read_spListMeta(cfg$specieslistmeta$filename, header = cfg$specieslistmeta$header, encoding = cfg$specieslistmeta$encoding)

metadf = consol_source(x = listbase)

listbase[listbase$Species_Name == "Acipenser brevirostrum", ]
