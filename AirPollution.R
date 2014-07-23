pollavg <- read.csv("pollavg_a.csv")
pollavg.d <- read.csv("pollavg_d.csv")
pollavg.d$Latitude <- round(pollavg.d$Latitude, 5)
pollavg.d$Longitude <- round(pollavg.d$Longitude, 5)
pollavg.d$Date <- as.Date(pollavg.d$Date,"%Y-%m-%d")

monitors <- data.matrix(pollavg[, c("Longitude", "Latitude")])
monitors.d <- data.matrix(pollavg.d[, c("Longitude", "Latitude")])

library(fields)

pollutant <- function(df) {
        x <- data.matrix(df[, c("lon", "lat")])
        r <- df$radius
        
		dist <- rdist.earth(monitors, x)

		use <- lapply(seq_len(ncol(dist)), function(i) {
                which(dist[, i] < r[i])})
		
        levels <- sapply(use, function(idx) {
                with(pollavg[idx, ], tapply(level, Parameter.Name, mean))})
        		
		dlevel <- as.data.frame(t(levels))
        data.frame(df, dlevel)

}

pm2.5plot <- function(df) {
        x <- data.matrix(df[, c("lon", "lat")])
        r <- df$radius
        
       dist.d <- rdist.earth(monitors.d, x)

		mon <- which(dist.d == min(dist.d))[1]
		mon.lat <- pollavg.d[mon,]$Latitude; mon.long <- pollavg.d[mon,]$Longitude
        mon.levels <- pollavg.d[pollavg.d$Latitude == mon.lat & pollavg.d$Longitude == mon.long,][,c(4,5)]
		plot(mon.levels$Date, mon.levels$level, type = "l", main = "PM2.5 closest monitor", xlab = "Date", ylab = "PM2.5 (Micrograms/cubic meter)")

}
