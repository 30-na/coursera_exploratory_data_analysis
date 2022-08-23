# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


#load library
library(dplyr)
library(ggplot2)
library(gridExtra)

### read zip file
NEI <- readRDS(unzip("exdata_data_NEI_data.zip",
                     "summarySCC_PM25.rds"))


# filter the Baltimore
NEI_baltimore = NEI %>%
    dplyr::filter(fips == "24510")



# calculate the mean emissions for each year
NEI_total_balt = NEI_baltimore %>%
    group_by(year, type) %>%
    summarize(total = sum(Emissions, na.rm = TRUE))

# save the plots as png file
png(file="plot3.png", width=480, height=400)


ggplot(data = NEI_total_balt,
       aes(x = year,
           y = total)) +
    geom_point(alpha = .5) +
    geom_smooth(method = "lm",
                formula = y~x,
                se = FALSE) +
    facet_wrap(~type) +
    labs(title = "The total emissions from PM2.5 for each year in Baltomore",
         x = "Year",
         y = "Total of emissions from PM2.5")

dev.off()
