#Loading libraries
library(tidyverse)
library(lubridate)

#Loading data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"EDA/household_power_consumption.zip")
unzip("EDA/household_power_consumption.zip",exdir = "EDA")

#Loading a subset of the data from the dates 2007-02-01 and 2007-02-02

data <- read_delim("EDA/household_power_consumption.txt",
                   delim = ";",
                   na    = c("?"),
                   col_types = list(col_date(format = "%d/%m/%Y"),
                                    col_time(format = ""),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number())) %>%
        filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

#Converting the Date and Time variables to Date/Time classes 
data1<-mutate(data,datetime=ymd_hms(paste(Date,Time)))
names(data1)

#Plotting
plot1<-hist(data$Global_active_power,
            xlab = "Global Active Power (kilowatts)",
            col  = "red",
            main = "Global Active Power")
#Saving the plot to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, "plot1.png",
         width  = 480,
         height = 480)

dev.off()

rm(list = ls())
