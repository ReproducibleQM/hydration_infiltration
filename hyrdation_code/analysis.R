#we're going to start here by bringing in the data, and checking it for errors

#data files are tagged with sensor serial numbers. we have recorded this in the metadata

# Snowville Soil Moisture SNs:
#   Pre-rip, Flat:
#   SN: 20386723 Microstation
# SN: 20385905 20 cm
# SN: 20385906 48 cm
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

data1<-read.csv(file="https://raw.githubusercontent.com/ReproducibleQM/hydration_infiltration/master/Data_%20soil_moisture/20180713_FLAT_20386723.csv", 
                header=T, skip=1)

summary(data1)

names(data1)<-c("Observation","Date_time", "Water_top", "Water_bottom")
