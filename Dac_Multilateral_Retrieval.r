# This script takes the 'Members' total use of the multilateral system' table from the OECD.stat page, at https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=MULTISYSTEM.
# The file initially comes in a '|' separated format, which for some reason doesn't play nice with R. As such it needs to be converted to CSV in excel first, ideally.

#### Setup ####

# Change this to the folder with the zip project
setwd('/Users/roryscott/Organisation/Projects/Coverage/')

# Load the file (could possibly be done with an API Call but CBA right now)
mums = read.csv("MultiSystem entire dataset.csv")

# Extract all of the 'Multilateral Core' records
B02 = subset(mums, Aid_T == "B02")

#### Diagnostics for 2014 ####

# Sweden table + spend
sweden_2014 = subset(B02, Year == 2014 & donornameE == "Sweden")
total_sweden_spend_2014 = sum(sweden_2014$usd_extended_defl, na.rm = 1)

# Netherlands table + spend
netherlands_2014 = subset(B02, Year == 2014 & donornameE == "Netherlands")
total_netherlands_spend_2014 = sum(netherlands_2014$usd_extended_defl, na.rm = 1)

# United Kingdom table + spend
UK_2014 = subset(B02, Year == 2014 & donornameE == "United Kingdom")
total_UK_spend_2014 = sum(UK_2014$usd_extended_defl, na.rm = 1)