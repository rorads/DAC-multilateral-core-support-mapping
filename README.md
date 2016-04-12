These scripts can be used to aggregate the 'Members' use of the Multilateral System' (MUMS) dataset from [OECD.stat](https://stats.oecd.org/Index.aspx?DataSetCode=CRS1#).

To run this script:

* download the full [MUMS dataset](https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=MULTISYSTEM). This is a horrible flat file, which uses a '|' separator, instead of CSV. The easiest way to convert it is to import it to Excel, check the row structure has been preserved, and then export it to CSV.

  Once this is done, move it to this repository and call it `MultiSystem entire dataset.csv`

* Then change line 7 of Dac_Multilateral_Retrieval.r and manipulation.r to:

  ``` R
  setwd('<path to this repo\'s current directory>')
  ```
* Finally, set the year configuration in manipulation.r:

  ``` R
  # Set the year you want
  year <- 2014
  ```

Once these steps have been taken, run Dac_Multilateral_Retrieval.r, then manipulation.r. This will produce a CSV file in this directory called `filtered_by_agency_2014.csv`.
