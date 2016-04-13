## Available Data

|                File                |       Description        |                                                           Link                                                           |
|------------------------------------|--------------------------|--------------------------------------------------------------------------------------------------------------------------|
| simplified_filtered_by_agency.csv  | agency level B02 totals  | [link](https://github.com/rory09/dac_multilateral_core_support_by_agency/blob/master/simplified_filtered_by_agency.csv)  |
| simplified_filtered_by_country.csv | country level B02 totals | [link](https://github.com/rory09/dac_multilateral_core_support_by_agency/blob/master/simplified_filtered_by_country.csv) |


## Methodology


These scripts can be used to aggregate the 'Members' use of the Multilateral System' (MUMS) dataset from [OECD.stat](https://stats.oecd.org/Index.aspx?DataSetCode=CRS1#).

To run this script:

* download the full [MUMS dataset](https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=MULTISYSTEM). This is a horrible flat file, which uses a '|' separator, instead of CSV. The easiest way to convert it is to import it to Excel, check the row structure has been preserved, and then export it to CSV.

  Once this is done, move it to this repository and call it `MultiSystem entire dataset.csv`

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
