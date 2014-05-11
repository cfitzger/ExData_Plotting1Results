#  scripts for Explore Data project 1

# Set working directory -- uncomment the following line 
# and set working directory

# setwd("your working directory")

# Check to see if raw data file or zip file is in working 
# directory, unzip as needed

if (c("household_power_consumption.txt") %in% dir()) {
  
  print("Note: household_power_consumption.txt is unzipped in your working directory - ready to read data")

} else {
  
  if (c("exdata-data-household_power_consumption.zip") %in% dir()) {
    
    filePath  <- file.path(getwd())
    files <- unzip( "exdata-data-household_power_consumption.zip" , exdir = filePath )
    
  } else {
    
    stop("Note: exdata-data-household_power_consumption.zip file not found; copy file to this directory and re-run script")
    
  }
}
  
# Read raw data file, subset to include Dates = 2007-02-01, 
# 2007-02-02, add POSIXDate Var combining Date + Time and 
# changing date format to POSIXlt

df <- read.csv("./household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
df <- subset(df, df$Date %in% c("1/2/2007","2/2/2007"))
POSIXDate <- strptime(paste(df[,1]," ",df[,2]),"%d/%m/%Y %H:%M:%S", tz = "")
df <- data.frame(df,POSIXDate=POSIXDate)

# Convert variables from character to numeric

for (i in 3:9) {
  
  df[,i] <- as.numeric(df[,i])

}


# Create Plot 2

with(df,plot(POSIXDate, Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", type="l", cex.axis=.8, cex.main=.8, cex.lab=.8))

dev.copy(png, file = "plot2.png")
dev.off()
