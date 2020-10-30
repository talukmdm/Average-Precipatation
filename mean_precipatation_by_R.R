rm(list=ls())

###Calling essnetial libraries
library(ncdf4)
library(raster)
library(sp)
library(tidyverse)
library(sp)



### reading the netcdf file
data <- nc_open('prcp-195101-grd-scaled.nc')
print(data)
attributes (data$var)



###making raster brick layers with predication data
rasbrick <- brick('prcp-195101-grd-scaled.nc')
#df <-as.data.frame(rasbrick[[1]],xy=T)



### reading basin latitudes and longitudes
basin <- read.csv('02387000.BDY')
basin1<- basin %>% separate(X023870....621,c('lon','lat'),sep=("  ")) ##making two column for latitude and longitude
basin2<-type.convert(basin1) #converting the data to float

### making a polygon for the basin
p1 <- Polygons(list(Polygon(cbind(c(basin2$lon),c(basin2$lat)))),ID="a") 
SPs <- SpatialPolygons(list(p1)) # converting into spatial polygon
poly <- SpatialPolygonsDataFrame(SPs,data.frame(onecol=c("one"),row.names = c("a"))) #converting into spatial polygon  data frame

#plot(poly,add=T,border='red')

### #overlapping the polygons into the raster brick
result <- as.data.frame(raster::extract(rasbrick, poly,weights=T,normalizeWeights=F))
#colnames(result)

### calculating daily average precipatation
new <- data.frame(result[,c(1:31)]*result$weight)
pavg<- function (x){
  day = new[x]
  y=result[32]
  avg =sum(day)/sum(y)
  sprintf("Average precipitation for %s is %f",colnames(new[x]),avg)
}

print(pavg(8)) #giving the date of th month will show the average precipitation
