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

#plot 3
x <- pwrdata5$datetime
y1 <- as.numeric(as.character(pwrdata5$sub_metering_1))
y2 <- as.numeric(as.character(pwrdata5$sub_metering_2))
y3 <- as.numeric(as.character(pwrdata5$sub_metering_3))
png(file = "plot3.png", bg = "white")
plot(x, y1, ylab="Energy sub metering", xlab = "", type="l")
points(x, y2, type="l", col="red")
points(x, y3, type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col = c("black","red","blue"))
dev.off()
