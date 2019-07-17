# Subsetting of the magnitude raster

plot(nbr_long_std_magnitude)

# summarize change raster by months
nbr_long_std_changemonth <- changeMonth(nbr_long_std_change)
writeRaster(nbr_long_std_changemonth, paste0(dir_results, "/nbr_long_std_changemonth"), format = "GTiff", overwrite = TRUE)

# isolate january - march breaks
nbrchange_q1 <- nbr_long_std_changemonth
nbrchange_q1[nbr_long_std_changemonth > 3] <- NA
writeRaster(nbrchange_q1, paste0(dir_results, "/nbrchange_q1"), format = "GTiff")

# reduce magnitude raster to locations where a break in jan - march was found
nbr_magnitude_only_q1breaks <- nbr_long_std_magnitude
nbr_magnitude_only_q1breaks[is.na(nbrchange_q1)] <- NA
writeRaster(nbr_magnitude_only_q1breaks, paste0(dir_results, "/nbr_magnitude_only_q1breaks"), format = "GTiff")

# thresh to contain only negative and slightly positive (NBR 0.025) results
nbr_magnitude_only_q1breaks_thresh <- nbr_magnitude_only_q1breaks
nbr_magnitude_only_q1breaks_thresh[nbr_magnitude_only_q1breaks > 250] <- NA
writeRaster(nbr_magnitude_only_q1breaks_thresh, paste0(dir_results, "/nbr_magnitude_only_q1breaks_thresh"), format = "GTiff")

# area Sieve to exclude single pixel events
nbr_magnitude_only_q1breaks_thresh_sieve <- areaSieve(nbr_magnitude_only_q1breaks_thresh, thresh=1800)
writeRaster(nbr_magnitude_only_q1breaks_thresh_sieve, paste0(dir_results, "/nbr_magnitude_only_q1breaks_thresh_sieve"), format = "GTiff")

# area Sieve to exclude events smaller than .5 acres
nbr_magnitude_only_q1breaks_thresh_sieve_05ha <- areaSieve(nbr_magnitude_only_q1breaks_thresh)
writeRaster(nbr_magnitude_only_q1breaks_thresh_sieve_05ha, paste0(dir_results, "/nbr_magnitude_only_q1breaks_thresh_sieve_05ha"), format = "GTiff")

# display the results in mapview, add villages. ready to export as html
colors <- colorRampPalette(c("red", "purple", "blue"))
mapview(nbr_magnitude_only_q1breaks_thresh_sieve_05ha) + mapview(nbr_magnitude_only_q1breaks_thresh_sieve) + mapview(villages)
