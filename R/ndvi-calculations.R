# NDVI - Stack erzeugen
ndvi_stack <- timeStack(x = dir_ndvi, pattern = glob2rx('*.grd'), filename = file.path(dir_results, 'ndvi_stack.grd'), datatype = 'INT2S')
x <- ndvi_stack


# Standardmodell, Analysezeitraum 1 Jahr. Zunächst BFM, dann daraus Magnitude und Change
ndvi_long_std_bfm <- bfmSpatial(x, start=2016, monend=2017, mc.cores = 2)
writeRaster(ndvi_long_std_bfm, paste0(dir_results,"/ndvi_long_std_bfm"), format = "GTiff")


ndvi_long_std_change <- raster(ndvi_long_std_bfm,1)
writeRaster(ndvi_long_std_change, paste0(dir_results,"/ndvi_long_std_change"), format = "GTiff")


ndvi_long_std_magnitude <- raster(ndvi_long_std_bfm,2)
writeRaster(ndvi_long_std_magnitude, paste0(dir_results,"/ndvi_long_std_magnitude"), format = "GTiff")


# Angepasstes Modell, Analysezeitraum 1 Jahr. Zunächst BFM, dann daraus Magnitude und Change
ndvi_long_exp_bfm <- bfmSpatial(x, start=2016, monend=2017, formula = response ~ harmon, order = 1, mc.cores = 2)
writeRaster(ndvi_long_exp_bfm, paste0(dir_results, "/ndvi_long_exp_bfm"), format = "GTiff")


ndvi_long_exp_change <- raster(ndvi_long_exp_bfm,1)
writeRaster(ndvi_long_exp_change, paste0(dir_results, "/ndvi_long_exp_change"), format = "GTiff")


ndvi_long_exp_magnitude <- raster(ndvi_long_exp_bfm,2)
writeRaster(ndvi_long_exp_magnitude, paste0(dir_results,"/ndvi_long_exp_magnitude"), format = "GTiff")
