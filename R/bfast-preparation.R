

library(bFastSpatial)
library(Mapview)
library(raster)



setwd("/data")
dir.create(paste0(getwd(), "/tarballs"))
dir_tar = paste0(getwd(), "/tarballs")
dir.create(paste0(getwd(), "/output"))
dir_out = paste0(getwd(), "/output")
dir.create(paste0(dir_out, "/results"))
dir_results = paste0(dir_out, "/results")
dir.create(paste0(dir_out, "/nbr"))
dir_nbr = paste0(dir_out, "/nbr")
dir.create(paste0(dir_out, "/ndvi"))
dir_ndvi = paste0(dir_out, "/ndvi")
dir.create(paste0(getwd(), "/shapes"))
dir_shapes = paste0(getwd(), "/shapes")
dir.create(paste0(getwd(), "/sample"))
dir_sample = paste0(getwd(), "/sample")

# /tarballs is supposed to contain landsat scenes, as a .tar.gz
# /sample needs to contain the unpacked contents of one of these scenes
# /shapes needs to contain the shapefile of an extent (if required), and the shapefile or .csv of points of interest


# Prepare shapefile and sample

villages = readOGR(dsn = dir_shapes, layer = "villages_jebelmarra")
sample_list <- list.files(dir_sample, full.names = TRUE)
plot(raster(sample_list[7]))
points(villages)


# set extent. alternatively, read the extent shapefile into "ext"

ext = drawExtent()


# Prepare NBR and NDVI

processLandsatBatch(x = dir_tar, outdir = dir_out, delete = TRUE, mask = "pixel_qa", e = ext, keep = c(322, 386), vi = 'nbr', overwrite = TRUE)
processLandsatBatch(x = dir_tar, outdir = dir_out, delete = TRUE, mask = "pixel_qa", e = ext, keep = c(322, 386), vi = 'ndvi', overwrite = TRUE)
