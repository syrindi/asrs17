cmsData = readRDS("~/Dropbox/cms/allData/enhancedData.rds")

cmsData = data.table(cmsData)
load("~/Dropbox/cms/eyeDataFinal.rda")
unique(cmsData$year)  #2012, 2013, 2014


# - select specified fields
unique(cmsData$providertype)
field = "Ophthalmology"
eyes = cmsData[providertype ==field]


# - add additional fields


zip = read_csv("~/Dropbox/cms/zip_code_database.csv")


