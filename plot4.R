#Working directory
if(!dir.exists("EDA")) { dir.create("EDA") }

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

# Set graphics device to  2 rows and 2 columns


(mfcol = c(2, 2))

# Plot 1:Top Left

plot(Global_active_power ~ datetime, data1, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)



# Plot 2:Bottom Left

plot(Sub_metering_1 ~ datetime, data1, type = "l",
     ylab = "Energy Sub Metering",
     xlab = NA)

lines(Sub_metering_2 ~ datetime, data1, type = "l", col = "red")

lines(Sub_metering_3 ~ datetime, data1, type = "l", col = "blue")

legend("topright",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       bty = "n")


# Plot 3: Top Right
plot(Voltage ~ datetime, data1, type = "l")



# Plot 4: Bottom Right

plot(Global_reactive_power ~ datetime, data1, type = "l")


#Writing to graphics device
png("plot4.png",
    width  = 480,
    height = 480)



dev.off()

rm(list = ls())
