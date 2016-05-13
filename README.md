## Available Data
_last updated 2016-13-04_

There are various resources in the [output folder](https://github.com/rory09/dac_multilateral_core_support_by_agency/tree/master/output), most of which are of little use out of context, though more may be added soon. The primary output of this project is [iati_reference_spends.csv](https://github.com/rory09/dac_multilateral_core_support_by_agency/blob/master/output/iati_reference_spends.csv), which shows the aggregated CRS and MUMS spend for each IATI publish which also publishes to the DAC CRS.

That said, there are quite a few interesting resources which can be found in intermediate variables within the scripts below. Feel free to contact me with any queries on how to run this package yourself, or on any of the data contained witihin it.


## Methodology & Instructions for Refresh


These scripts can be used to aggregate the 'Members' use of the Multilateral System' (MUMS) dataset from [OECD.stat](https://stats.oecd.org/Index.aspx?DataSetCode=CRS1#), and also take some pre-processed data from the DAC CRS.

The these scripts should be run in this order:

* Dac_Multilateral_Retrieval.r
* mums_manipulation.r
* mums_crs_merge.r
* final.r

To run Dac_Multilateral_Retrieval:

* Download the full [MUMS dataset](https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=MULTISYSTEM). This is a horrible flat file, which uses a '|' separator, instead of CSV. The easiest way to convert it is to import it to Excel, check the row structure has been preserved, and then export it to CSV. To save time a csv version of this can be found within the 'data' folder.


* Then change these lines of Dac_Multilateral_Retrieval.r and manipulation.r to:

  ``` R
  setwd('<path to this repo\'s current directory>')
  ```
* Finally, set the year configuration in manipulation.r:

  ``` R
  # Set the year you want
  year <- 2014
  ```

Once these steps have been taken, run then manipulation.r. This will run Dac_Multilateral_Retrieval.r, and produce CSV file in this directory called `simplified_filtered_by_agency.csv` and `simplified_filtered_by_country.csv` for country and agency level aggregates. These files are small, so I've included them for reference. If you run manipulation, it will overwrite them with data from whichever year you choose.

The rest of the scripts can be run with data currently in this repository.
