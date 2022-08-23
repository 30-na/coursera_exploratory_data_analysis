# 6. compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

#load library
library(dplyr)
library(ggplot2)
library(gridExtra)

### read zip file
NEI <- readRDS(unzip("exdata_data_NEI_data.zip",
                     "summarySCC_PM25.rds"))


SCC <- readRDS(unzip("exdata_data_NEI_data.zip",
                     "Source_Classification_Code.rds"))


# merge two datasets
merged_data = NEI %>%
    left_join(SCC, by= "SCC")


# filter motor vehicle
NEI_vehicle_balt_los = merged_data %>%
    filter(grepl("Vehicles|vehicles", 
                 EI.Sector),
           fips %in% c("24510", "06037")) %>%
    mutate(city = ifelse(fips == "06037", "Los Angeles" , "Baltimore")) %>%
    
    group_by(city, year) %>%
    summarize(total = sum(Emissions, na.rm = TRUE))



# save the plots as png file
png(file="plot6.png", width=480, height=400)

ggplot(data = NEI_vehicle_balt_los,
            aes(x = as.factor(year),
                y = total,
                color = city,
                group = city)) +
    geom_point() +
    geom_smooth(method = "lm",
                formula  = y~x,
                se = FALSE)+
    labs(title = "Vehicle emissions from PM2.5 for each year in Baltimore and Los Angeles",
         x = "Year",
         y = "Total of emissions from PM2.5")

dev.off()