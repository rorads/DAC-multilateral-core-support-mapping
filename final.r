# setup
options(scipen=999) # turn off scientific notation
setwd('/Users/roryscott/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/')

corrected_iati_reverse_integrated <- read.csv("~/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/data/corrected_iati_reverse_integrated.csv", stringsAsFactors=FALSE)

cleaned <- corrected_iati_reverse_integrated[!is.na(corrected_iati_reverse_integrated$publisher_name),]

trimmed <- cleaned %>% group_by(publisher_name) %>% select(publisher_name, donornameE, total_usd_disbursement, usd_extended_defl)
trimmed[is.na(trimmed)] <- 0
trimmed$total_usd_disbursement <- as.numeric(trimmed$total_usd_disbursement)
trimmed$usd_extended_defl <- as.numeric(trimmed$usd_extended_defl)


summed <- trimmed %>% mutate(total = total_usd_disbursement + usd_extended_defl)

final <- summed %>% summarise(total = sum(total))

# select output folder
setwd('/Users/roryscott/Organisation/Projects/Coverage/dac_multilateral_core_support_by_agency/output')

# cleanup - commend out for variable debug
remove(cleaned, corrected_iati_reverse_integrated, final, summed, trimmed)

# No missing B02
write.csv(final, file = "iati_reference_spends.csv")