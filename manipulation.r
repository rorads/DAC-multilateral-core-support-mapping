# This script takes the initialised variables from Dac_Multilateral_Retrieval.r, and collates the agency level data for B02 data.

#### Setup ####

# Change this to the folder with the zip project
setwd('/Users/roryscott/Organisation/Projects/Coverage/')

# Uncomment if running solo:
# source('Dac_Multilateral_Retrieval.r')

# Set the year you want
year <- 2014

#### Logic ####

# Initialise the empty frame
output = data.frame(country_name=character(),agency_name=character(), B02_spend=double(), stringsAsFactors=FALSE)

# Loop over each distinct country and create a temporary frame for its rows
for (country in sort(unique(B02$donornameE))) {
  country_specific <- subset(B02, Year == year & donornameE == country)
  
  # For each distinct agency givne the above country, create another temporary frame
  for (agency in sort(unique(country_specific$agencynameE))) {
    temp <- subset(country_specific, agencynameE == agency)
    
    # create and append a vector comprising of the curent country and agency, and the aggregated B02 spend
    result_row <- c(country, agency, sum(temp$usd_extended_defl, na.rm = 1))
    l <- length(output$country_name)
    output <- rbind.data.frame(output[1:l,],result_row,output[-(1:l),])
    # cleanup
    remove(l, result_row)
  }
}

# re-format: remove N/A row and convert the spend column back to a double - rbind is a nightmare!
output <- output[-1,]
output$B02_spend <- as.double(output$B02_spend)

# Write the file out
# write.csv(output, file = "filtered_by_agency_2014.csv")

#### Diagnostics & Cleanup ####

# diagnostic
inspection_country <- "Netherlands"
country_filtered <- subset(output, country_name == inspection_country)
print(sum(country_filtered$B02_spend, na.rm = 1))

# cleanup
remove(country_filtered, temp, country_specific, year, agency, country)
