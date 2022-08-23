# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


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
NEI_vehicle_balt = merged_data %>%
    filter(grepl("Vehicles|vehicles", 
                 EI.Sector),
           fips == "24510")

# calculate the mean emissions for each year
NEI_total_vehicle_balt = NEI_vehicle_balt %>%
    group_by(year) %>%
    summarize(total = sum(Emissions, na.rm = TRUE))



# save the plots as png file
png(file="plot5.png", width=480, height=400)


ggplot(data = NEI_total_vehicle_balt,
            aes(x = year,
                y = total)) +
    geom_point(alpha = .5) +
    geom_smooth(method = "lm",
                formula = y~x,
                se = FALSE) +
    labs(title = "The total of vehicle emissions from PM2.5 for each year in Baltomore",
         x = "Year",
         y = "Total of emissions from PM2.5")

dev.off()