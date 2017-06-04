cmsData = readRDS("~/Dropbox/cms/allData/enhancedData.rds")

cmsData = data.table(cmsData)

unique(cmsData$year)  #2012, 2013, 2014

# - select specified fields
unique(cmsData$providertype)
field = "Ophthalmology"
eyes = cmsData[providertype ==field]


# - add additional fields