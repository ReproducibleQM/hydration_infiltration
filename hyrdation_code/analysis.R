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

pre_flat_june1<-read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20180713_FLAT_20386723.csv",
                         header=T, skip=1)

summary(pre_flat_june1)

#change column names
names(pre_flat_june1)<-c("Observation","Date_time", "Water_top", "Water_bottom")

#add incline and rip status variables
incline<-rep("flat", length(pre_flat_june1$Observation))
rip_status<-rep("pre", length(pre_flat_june1$Observation))

pre_flat_june2<-cbind(pre_flat_june1,incline, rip_status)

#now we need to melt the data to get it in long form
library(reshape2)

pre_flat_june3<-melt(pre_flat_june2, id=c("Observation", "Date_time", "incline", "rip_status"))

#change column names
names(pre_flat_june3)[names(pre_flat_june3) == "variable"] <- "sensor_depth"
names(pre_flat_june3)[names(pre_flat_june3) == "value"] <- "water_content"

#rename sensor_depth so that we also have a continuous variable representing this

names(pre_flat_june3)[names(pre_flat_june3) == "sensor_depth"]<-"sensor"

#adding value for sensor depth
pre_flat_june3$sensor_depth<-ifelse(pre_flat_june3$sensor=="Water_top", 20,48)


#now we need to bring our data frames together
prerip<-rbind(data3, pre_slope3)

summary(prerip)

#Load the 3rd dataset (SnowFlat)
post_flat <- read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_ soil_moisture/20190524-snowflat-20386723.csv", header = T, skip = 1)

names(post_flat)<-c("Observation","Date_time", "Water_crossrip", "Water_norip")

incline<-rep("flat", length(post_flat$Observation))
rip_status<-rep("post", length(post_flat$Observation))

post_flat_2<-cbind(post_flat,incline, rip_status)

#now we need to melt the data to get it in long form
library(reshape2)

post_flat_3<-melt(post_flat_2, id=c("Observation", "Date_time", "incline", "rip_status"))

names(post_flat_3)[names(post_flat_3) == "variable"] <- "sensor_depth"
names(post_flat_3)[names(post_flat_3) == "value"] <- "water_content"

#rename sensor_depth so that we also have a continuous variable representing this

names(post_flat_3)[names(post_flat_3) == "sensor_depth"]<-"sensor"

#adding value for sensor depth
pre_slope3$sensor_depth<-ifelse(pre_slope3$sensor=="Water_top", 20,50)


#input snowslope dataset
postslope_oct <- read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20190524-snowslope-20386722.csv", 
                          header = T, skip = 1)

names(postslope_oct)<-c("Observation","Date_time", "Water_crossrip", "Water_EWrip", "Water_NSrip")
incline<-rep("slope", length(postslope_oct$Observation))
rip_status<-rep("post", length(postslope_oct$Observation))
                      
postslope_oct2<-cbind(postslope_oct,incline, rip_status)
                      
                      
postslope_oct3<-melt(postslope_oct2, id=c("Observation", "Date_time", "incline", "rip_status"))

#these lines do work
names(postslope_oct3)[names(postslope_oct3) == "variable"] <- "sensor"
names(postslope_oct3)[names(postslope_oct3) == "value"] <- "water_content"
#adding value for sensor depth
postslope_oct3$sensor_depth<-ifelse(postslope_oct3$sensor=="Water_crossrip",
                                    10,10)#all sensors at 10 cm

#first attempt at pulling in SN20386722 - cross rip, EW, and NS rips

post_Cross_EWNS<-read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20190628_SnowvilleSlope_20386722_.csv",
                          header=T, skip=1)

#changing column names
names(post_Cross_EWNS)<-c("Observation","Date_Time","Cross_Rip","EW_Rip","NS_Rip")

summary(post_Cross_EWNS)

#so far so good, now adding incline and rip status
incline<-rep("slope", length(post_Cross_EWNS$Observation))
rip_status<-rep("post", length(post_Cross_EWNS$Observation))

#binding
post_cross_EWNS2<-cbind(post_Cross_EWNS,incline,rip_status)


post_cross_EWNS3<-melt(post_cross_EWNS2, id=c("Observation", "Date_Time", "incline", "rip_status"))

summary(post_cross_EWNS3)

#still looks good - now I'll change the column names
names(post_cross_EWNS3)[names(post_cross_EWNS3) == "variable"]<-"sensor"
names(post_cross_EWNS3)[names(post_cross_EWNS3) == "value"]<-"water_content"

#now I have to add a sensor depth column and give it values
post_cross_EWNS3$sensor_depth<-ifelse(post_cross_EWNS3$sensor=="Cross_Rip", 10,10)

#I realized later that every sensor depth for this data set is 10


### SNOWVILLE FLAT
svflat1<-read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20190628_SnowvilleFlat_20386723.csv", 
                  header=T, skip=1)
summary(svflat1)

#change column names
names(svflat1)<-c("Observation","Date_time", "Water_top", "Water_bottom")

#add incline and rip status variables
incline<-rep("flat", length(svflat1$Observation))
rip_status<-rep("pre", length(svflat1$Observation))
svflat2<-cbind(svflat1,incline, rip_status)

#now we need to melt the data to get it in long form
svflat3<-melt(svflat2, id=c("Observation", "Date_time", "incline", "rip_status"))

#change column names
names(svflat3)[names(svflat3) == "variable"] <- "sensor_depth"
names(svflat3)[names(svflat3) == "value"] <- "water_content"

#rename sensor_depth so that we also have a continuous variable representing this
names(svflat3)[names(svflat3) == "sensor_depth"]<-"sensor"

#adding value for sensor depth
svflat3$sensor_depth<-ifelse(svflat3$sensor=="Water_top", 20,48)
