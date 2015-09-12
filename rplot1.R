library(dplyr)
pwrdata <- read.csv("household_power_consumption.txt", header = FALSE, sep = ";", skip = 1)
pwrdata1 <- filter(pwrdata, c(pwrdata$V1 == "1/2/2007"))
pwrdata2 <- filter(pwrdata, c(pwrdata$V1 == "2/2/2007"))
pwrdata3 <- bind_rows(pwrdata1, pwrdata2)

d <- as.Date( pwrdata3$V1, "%d/%m/%Y")
x <- paste(d, pwrdata3$V2)
y <- strptime(x, "%Y-%m-%d %H:%M:%S", tz = "UTC")
z <- data.frame(y)

pwrdata4 <- bind_cols(pwrdata3, z)
#tidy the data - name the variables
pwrdata5 <- pwrdata4[,3:10]
names(pwrdata5)[1] <- "global_active_power"
names(pwrdata5)[2] <- "global_reactive_power"
names(pwrdata5)[3] <- "voltage"
names(pwrdata5)[4] <- "global_intensity"
names(pwrdata5)[5] <- "sub_metering_1"
names(pwrdata5)[6] <- "sub_metering_2"
names(pwrdata5)[7] <- "sub_metering_3"
names(pwrdata5)[8] <- "datetime"

#plot1
png(file = "plot1.png", bg = "white")
hist(as.numeric(as.character(pwrdata5$global_active_power)), 
main = "Global Active Power", xlab="Global Active Power (kilowats)", col = "red")
dev.off()