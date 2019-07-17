# NBR-Stack erzeugen

nbr_stack <- timeStack(x = dir_nbr, pattern = glob2rx('*.grd'), filename = file.path(dir_results, 'nbr_stack.grd'), datatype = 'INT2S')
x <- nbr_stack


# Standardmodell, Analysezeitraum 1 Jahr. Zunächst BFM, dann daraus Magnitude und Change

nbr_long_std_bfm_2015 <- bfmSpatial(x, start=2015, monend=2016, mc.cores = 2)
writeRaster(nbr_long_std_bfm_2015, paste0(dir_results,"/nbr_long_std_bfm_2015"), format = "GTiff")


nbr_long_std_change <- raster(nbr_long_std_bfm,1)
writeRaster(nbr_long_std_change, paste0(dir_results,"/nbr_long_std_change"), format = "GTiff")


nbr_long_std_magnitude <- raster(nbr_long_std_bfm,2)
writeRaster(nbr_long_std_magnitude, paste0(dir_results,"/nbr_long_std_magnitude"), format = "GTiff")



# Angepasstes Modell, Analysezeitraum 1 Jahr. Zunächst BFM, dann daraus Magnitude und Change

nbr_long_exp_bfm <- bfmSpatial(x, start=2016, monend=2017, formula = response ~ harmon, order = 1, mc.cores = 2)
writeRaster(nbr_long_exp_bfm, paste0(dir_results, "/nbr_long_exp_bfm"), format = "GTiff")


nbr_long_exp_change <- raster(nbr_long_exp_bfm,1)
writeRaster(nbr_long_exp_change, paste0(dir_results, "/nbr_long_exp_change"), format = "GTiff")


nbr_long_exp_magnitude <- raster(nbr_long_exp_bfm,2)
writeRaster(nbr_long_exp_magnitude, paste0(dir_results,"/nbr_long_exp_magnitude"), format = "GTiff")
