library(foreign)
library(data.table)


blueFlags2008 <- read.dbf('source files/galazies_shmaies_2008.dbf')
blueFlags2009 <- read.dbf('source files/galazies_shmaies_2009.dbf')
blueFlags2010 <- read.dbf('source files/galazies_shmaies_2010.dbf')

data2008 <- blueFlags2008[c('C_EDPP', 'NUMIND', 'COMMUNE', 'PRELEV', 'REGION',
                            'PROVINCE', 'CODEAU', 'LONGITUDE', 'LATITUDE')]

data2008$YEAR <- '2008'

data2009 <- blueFlags2009[c('C_EDPP', 'NUMIND', 'COMMUNE', 'PRELEV', 'REGION',
                            'PROVINCE', 'CODEAU', 'LONGITUDE', 'LATITUDE')]

data2009$YEAR <- '2009'


data2010 <- blueFlags2010[c('C_EDPP', 'NUMIND', 'COMMUNE','PRELEV', 'REGION',
                            'PROVINCE', 'CODEAU', 'LONGITUDE', 'LATITUDE')]

data2010$YEAR <- '2010'

data <- rbind(data2008 ,data2009, data2010)
data$REGION <- as.character(data$REGION)

rm(blueFlags2008, blueFlags2009, blueFlags2010,data2008, data2009, data2010)


data$REGION <- gsub('ANATOLOKI MAKEDONIA, THRAKI', 
                       'ANATOLIKI MAKEDONIA, THRAKI', data$REGION)


data$PROVINCE <- gsub('D\xefdekanisos', 
                    'Dodekanisos', data$PROVINCE)

all <- as.data.table('All') 
colnames(all) <- 'Year'

AvYears <- as.data.table(unique(data$YEAR))
colnames(AvYears) <- 'Year'

AvYears <- rbind(AvYears, all)

all <- as.data.table('All') 
colnames(all) <- 'Region'

AvRegions <- as.data.table(unique(data$REGION))
colnames(AvRegions) <- 'Region'

AvRegions$Region <- as.character(AvRegions$Region) 

AvRegions <- AvRegions[order(Region),] 

AvRegions <- rbind(AvRegions, all)

rm(all)