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
# Post-rip, Slope:
#   SN: 20386722 Microstation
# SN: 20385906 10 cm, cross-rip
# SN: 20385905 10 cm, EW rip
# SN: 20469555 10 cm, NS rip


#add 1st dataset "FLAT"
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

#add 2nd dataset "SLOPE"
pre_slope_june1<-read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20180713_SLOPE_20386722.csv",
                          header=T, skip=1)

summary(pre_slope_june1)

#change column names
names(pre_slope_june1)<-c("Observation","Date_time", "Water_top", "Water_bottom")

#add incline and rip status variables
incline<-rep("slope", length(pre_slope_june1$Observation))
rip_status<-rep("pre", length(pre_slope_june1$Observation))

pre_slope_june2<-cbind(pre_slope_june1,incline, rip_status)

#now we need to melt the data to get it in long form
pre_slope_june3<-melt(pre_slope_june2, id=c("Observation", "Date_time", "incline", "rip_status"))

#change column names
names(pre_slope_june3)[names(pre_slope_june3) == "variable"] <- "sensor_depth"
names(pre_slope_june3)[names(pre_slope_june3) == "value"] <- "water_content"

#rename sensor_depth so that we also have a continuous variable representing this

names(pre_slope_june3)[names(pre_slope_june3) == "sensor_depth"]<-"sensor"

#adding value for sensor depth
pre_slope_june3$sensor_depth<-ifelse(pre_slope_june3$sensor=="Water_top", 20,50)

#now we need to bring our data frames together
prerip<-rbind(pre_flat_june3, pre_slope_june3)

summary(prerip)

#Load the 3rd dataset (SnowFlat) and second reading of it
post_flat_oct1 <- read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_ soil_moisture/20190524-snowflat-20386723.csv", header = T, skip = 1)
post_flat_may <- read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20190628_SnowvilleFlat_20386723.csv", header = T, skip = 1)

#these tow should be in identical formats so let's stick them together and manipulate from there 
post_flat1<-rbind(post_flat_oct1, post_flat_may)


names(post_flat1)<-c("Observation","Date_time", "Water_crossrip", "Water_norip")

incline<-rep("flat", length(post_flat1$Observation))
rip_status<-rep("post", length(post_flat1$Observation))

post_flat2<-cbind(post_flat1,incline, rip_status)

#now we need to melt the data to get it in long form
library(reshape2)

post_flat3<-melt(post_flat2, id=c("Observation", "Date_time", "incline", "rip_status"))

names(post_flat3)[names(post_flat3) == "variable"] <- "sensor_depth"
names(post_flat3)[names(post_flat3) == "value"] <- "water_content"

#rename sensor_depth so that we also have a continuous variable representing this

names(post_flat3)[names(post_flat3) == "sensor_depth"]<-"sensor"

#adding value for sensor depth
post_flat3$sensor_depth<-ifelse(post_flat3$sensor=="Water_top", 20,50)


#input post slope dataset
post_slope_oct <- read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20190524-snowslope-20386722.csv", 
                          header = T, skip = 1)
post_slope_may <- read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20190628_SnowvilleSlope_20386722_.csv", header = T, skip = 1)

#these tow should be in identical formats so let's stick them together and manipulate from there 
post_slope1<-rbind(post_slope_oct, post_slope_may)


names(post_slope1)<-c("Observation","Date_time", "Water_crossrip", "Water_EWrip", "Water_NSrip")
incline<-rep("slope", length(post_slope1$Observation))
rip_status<-rep("post", length(post_slope1$Observation))
                      
post_slope2<-cbind(post_slope1,incline, rip_status)
                      
                      
post_slope3<-melt(post_slope2, id=c("Observation", "Date_time", "incline", "rip_status"))

#change column names
names(post_slope3)[names(post_slope3) == "variable"] <- "sensor"
names(post_slope3)[names(post_slope3) == "value"] <- "water_content"
#adding value for sensor depth
post_slope3$sensor_depth<-ifelse(post_slope3$sensor=="Water_crossrip",
                                    10,10)#all sensors at 10 cm

postrip<-rbind(post_flat3, post_slope3)

#bring all the data together

allrips<-rbind(prerip,postrip)

library(lubridate)
str(allrips$Date_time)
allrips$new_date<-mdy_hms(allrips$Date_time, tz="UTC")+hours(4)

allrips$year<-year(allrips$new_date)
allrips$doy<-yday(allrips$new_date)


# let's look at these data!
library(plyr)
library(ggplot2)

averages<-ddply(allrips, c("incline", "rip_status","sensor_depth"), summarize,
                average=mean(water_content), sd=sd(water_content),
                max=max(water_content))

plot1<-ggplot(allrips, aes(x=rip_status, y=water_content, fill=incline))+
  geom_boxplot()+
  theme_classic()+
  scale_fill_brewer(palette="Blues")

plot1


################################################################

#bring in the weather data

#onset is doing terrible things to me again

#get a list of file names:

setwd("../Data_weather_station/")
file_list<-list.files()
namelist<-c('obs', 'date_time', 'pressure', 'wind_speed', 'gust_speed',
            'sol_rad', 'wind_dir', 'rain', 'temperature', 'rh', 'dew_point',
            'temperature2')


library(tidyverse)
#create an empty data frame to put stuff in
weather<-data.frame(matrix(vector(), 0, 12,
                           dimnames=list(c(), c(namelist))),
                    stringsAsFactors=F)

#loop through the files, merge 'em together
for (i in 1:length(file_list)){
  data<-read.csv(file=file_list[i], header=T) #read data in as a csv
  #now use varnames to rename columns
  names(data)<-namelist
  #because sometimes there is a comma thousands separator in pressure and sol_rad
  data$pressure<-as.numeric(gsub(",", "", data$pressure))
  data$sol_rad<-as.numeric(gsub(",", "", data$sol_rad))
  weather<-bind_rows(weather, data)
  
}
summary(weather)

str(weather$date_time)

weather$new_date<-mdy_hms(weather$date_time)

weather$year<-year(weather$new_date)
weather$doy<-yday(weather$new_date)
