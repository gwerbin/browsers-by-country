library(dplyr)
library(tidyr)
library(maps)
library(rworldmap)
library(RColorBrewer)
rowselect <- dplyr::filter

reorder_freq <- function(x, biggest_first = TRUE) {
  if (biggest_first)
    reorder(x, x, function(x) -length(x))
  else reorder(x, x, length)
}

browsers <- read.csv('browsers.csv', stringsAsFactors = FALSE) %>%
  gather('Country', 'Fraction', -Year, -Month, -Browser) %>%
  mutate(DateRange = Year)
for (year in unique(browsers$Year)) {
  if (year < 2015) {
    rows <- with(browsers,
                 (Year == year & Month >= 7) | (Year == year + 1 & Month < 7)
    )
    daterange <- paste(year, year + 1, sep = "-")
    browsers$DateRange[rows] <- daterange
  } else {
    browsers <- browsers[-which(browsers$Year == 2015 & browsers$Month == 7), ]
  }
}
browsers$DateRange <- factor(browsers$DateRange)

most_popular <- browsers %>%
  group_by(Country, DateRange, Browser) %>%
  summarize(Fraction = mean(Fraction)) %>%
  ungroup %>% group_by(Country, DateRange) %>%
  summarize(MostPopular = Browser[which.max(Fraction)]) %>%
  ungroup %>% mutate(MostPopular = reorder_freq(MostPopular))

mostpop <- unique(most_popular$MostPopular)
cols <- setNames(brewer.pal(length(mostpop), "Set3"), mostpop)

plot_map <- function(dates, cols) {
  op <- par(no.readonly = TRUE)
  on.exit(par(op))
  par(mar = c(5,0,0,0) + 0.1)
  mapdat <- most_popular %>% rowselect(DateRange == dates) %>%
    joinCountryData2Map(joinCode = "ISO2", nameJoinColumn = "Country")
  m <- mapCountryData(mapdat, nameColumnToPlot = "MostPopular", addLegend = FALSE,
                 colourPalette = cols, catMethod = "categorical", mapTitle = "")
  addMapLegendBoxes(cutVector = m$cutVector, colourVector = m$colourVector,
                    ncol = 2, x = -100, y = -100, xpd = TRUE, title = NULL)
}
plot_map("2008-2009", cols)
