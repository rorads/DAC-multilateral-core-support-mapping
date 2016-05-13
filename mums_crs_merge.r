# First run Dac_Multilateral_Retrieval.r, then mums_manipulation.r

# Import modified CRS data 
# TODO: direct import from CRS rather than using pre-processed file
crs_unfiltered <- read.csv("~/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/data/DAC 2014 disbursement.csv", stringsAsFactors=FALSE)
by_agency <- read.csv("~/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/output/simplified_filtered_by_agency.csv", stringsAsFactors=FALSE)
iati_pubs <- read.csv("~/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/data/IATI_publishers_to_DAC_Agencies.csv", stringsAsFactors=FALSE)

# Create common column names to merge on
names(crs_unfiltered)[names(crs_unfiltered)=="donor_name"] <- "donornameE"
names(crs_unfiltered)[names(crs_unfiltered)=="loc_agency_name"] <- "agencynameE"

# Trim CRS file
crs_disbursement <- select(crs_unfiltered, donornameE, agencynameE, total_usd_disbursement)

# smash the two together
mums_by_crs <- left_join(by_agency, crs_disbursement)

# reverse cardinality
crs_by_mums <- left_join(crs_unfiltered, by_agency, by = c("donornameE", "agencynameE"))
# remove the crud
crs_by_mums <- select(crs_by_mums, -X.x, -X.1, -X.y)

# remove blanks and N/A values
iati_pubs_filtered <- iati_pubs[!is.na(iati_pubs$publisher_name),]

# This should now match up iati publishers with agencies, but will still have B02 figures missing for Canada, Lithuania, Romania, and others. Must be manually checked.
iati_reverse_integrated <- left_join(crs_by_mums, iati_pubs_filtered, by = c("agency_code", "donor_code"))

# select output folder
setwd('/Users/roryscott/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/output')

# This file needs manual correcting, and then feeding into final_process.r. This is the closest managable automated mapping of iati publisher to CRS to B02. 
# Shouldn't be any missing CRS, but will be missing B02. 
# Missing valuas can be manually found in 'combined.csv' below.
write.csv(iati_reverse_integrated, file = "iati_reverse_integrated.csv")

# No missing B02
write.csv(mums_by_crs, file = "mums_by_crs.csv")

# No missing CRS
write.csv(crs_by_mums, file = "crs_by_mums.csv")

remove(crs_unfiltered, by_agency, iati_pubs, crs_disbursement, mums_by_crs, crs_by_mums, iati_pubs_filtered, iati_reverse_integrated)