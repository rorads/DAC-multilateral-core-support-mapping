# This script takes the initialised variables from Dac_Multilateral_Retrieval.r, and collates the agency level data for B02 data.

#### Setup ####

# Change this to the folder with the zip project
setwd('/Users/roryscott/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/')

# Uncomment if running solo:
#source('Dac_Multilateral_Retrieval.r')

# Set the year you want
year <- 2014

#### Logic ####

# filter on year
B02_by_year <- subset(B02, Year == year)
# aggregate by country and agency and record to new frame
new_output_by_agency <- summarise(group_by(B02_by_year, donornameE, agencynameE), "usd_extended_defl"= sum(usd_extended_defl, na.rm = TRUE))
# aggregate by country and record to new frame
new_output_by_country <- summarise(group_by(B02_by_year, donornameE), "usd_extended_defl"= sum(usd_extended_defl, na.rm = TRUE))

# Write the files out
setwd('/Users/roryscott/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/output/')
write.csv(new_output_by_agency, file = "simplified_filtered_by_agency.csv")
write.csv(new_output_by_country, file = "simplified_filtered_by_country.csv")

remove(B02_by_year, new_output_by_country, new_output_by_agency)