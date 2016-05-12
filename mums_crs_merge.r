# Import modified CRS data 
# TODO: direct import from CRS rather than using pre-processed file
crs_unfiltered <- read.csv("~/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/data/DAC 2014 disbursement.csv", stringsAsFactors=FALSE)
by_agency <- read.csv("~/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/output/simplified_filtered_by_agency.csv", stringsAsFactors=FALSE)

# Create common column names to merge on
names(crs_unfiltered)[names(crs_unfiltered)=="donor_name"] <- "donornameE"
names(crs_unfiltered)[names(crs_unfiltered)=="loc_agency_name"] <- "agencynameE"


crs_disbursement <- select(crs_unfiltered, donornameE, agencynameE, total_usd_disbursement)

# smash the two together
# TODO: This is broken - for some reason identical strings aren't matching up
temp <- left_join(by_agency, crs_disbursement)

# reverse cardinality
reverse_temp <- left_join(crs_unfiltered, by_agency, by = c("donornameE", "agencynameE"))
# remove the crud
reverse_temp <- select(reverse_temp, -X.x, -X.1, -X.y)

# write out the partially complete: need manual processing of 50 rows atm :C
write.csv(temp, file = "combined.csv")

write.csv(reverse_temp, file = "reverse_combined.csv")

