#we're going to start here by bringing in the data, and checking it for errors

#data files are tagged with sensor serial numbers. we have recorded this in the metadata

# Snowville Soil Moisture SNs:
#   Pre-rip, Flat:
#   SN: 20386723 Microstation
# SN: 20385905 20 cm (top)
# SN: 20385906 48 cm (bottom)
# Pre-rip, Slope:
#   SN: 20386722 Microstation
# SN: 20385903 20 cm
# SN: 20385904 50 cm
# Post-rip, Flat:
#   SN: 20386723 Microstation
# SN: 20385903 10 cm, cross-rip
# SN: 20385904 20 cm, no rip
# Pre-rip, Slope:
#   SN: 20386722 Microstation
# SN: 20385906 10 cm, cross-rip
# SN: 20385905 10 cm, EW rip
# SN: 20469555 10 cm, NS rip

#start with pre-rip, flat data
data1<-read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20180713_FLAT_20386723.csv", 
                header=T, skip=1)

summary(data1)

#change column names
names(data1)<-c("Observation","Date_time", "Water_top", "Water_bottom")

#add incline and rip status variables
incline<-rep("flat", length(data1$Observation))
rip_status<-rep("pre", length(data1$Observation))

data2<-cbind(data1,incline, rip_status)

#now we need to melt the data to get it in long form
library(reshape2)

data3<-melt(data2, id=c("Observation", "Date_time", "incline", "rip_status"))

#change column names
names(data3)[names(data3) == "variable"] <- "sensor_depth"
names(data3)[names(data3) == "value"] <- "water_content"

#next, pre-rip, slope data
pre_slope1<-read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20180713_SLOPE_20386722.csv", 
                header=T, skip=1)
summary(pre_slope1)

#change column names
names(pre_slope1)<-c("Observation","Date_time", "Water_top", "Water_bottom")

#add incline and rip status variables
incline<-rep("slope", length(pre_slope1$Observation))
rip_status<-rep("pre", length(pre_slope1$Observation))
pre_slope2<-cbind(pre_slope1,incline, rip_status)

#now we need to melt the data to get it in long form
library(reshape2)

pre_slope3<-melt(pre_slope2, id=c("Observation", "Date_time", "incline", "rip_status"))

#change column names
names(pre_slope3)[names(pre_slope3) == "variable"] <- "sensor_depth"
names(pre_slope3)[names(pre_slope3) == "value"] <- "water_content"

#change column names
names(pre_slope3)[names(pre_slope3) == "sensor_depth"] <- "sensor"

#adding value for sensor depth
depth<- if ("sensor"== "Water_top") {
  20
} else {
    48
  }

#insert column between sensor and water_content
library(tibble)
add_column(pre_slope3, sensor_depth=depth, .after = 5)

