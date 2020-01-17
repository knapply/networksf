# URL: https://ucdp.uu.se/downloads/index.html#ged_global
#
# Date Obtained: 2020-01-10
#
# Citations:
# - Sundberg, Ralph, and Erik Melander, 2013, “Introducing the UCDP Georeferenced Event Dataset”, Journal of Peace Research, vol.50, no.4, 523-532
# - Högbladh Stina, 2019, “UCDP GED Codebook version 19.1”, Department of Peace and Conflict Research, Uppsala University
#

# URLs ===================================================================================
data_url <- "http://ucdp.uu.se/downloads/ged/ged_syria.csv.zip"
file_name <- "ged_syria.csv"
# get data ===============================================================================
temp_file <- tempfile()
temp_dir <- tempdir()
download.file(data_url, destfile = temp_file)
unzip(temp_file, files = file_name, exdir = temp_dir)


file_path <- dir(temp_dir)

# prep data ==============================================================================
library(data.table)

data_file <- "inst/datasets/ucdp_syria/ged_syria.csv"

ucdp_syria_df <- data.table::fread(data_file)

actors_to_ignore <- c(
  "Civilians",
  "Government of Iran", "Government of Iraq", "Government of Israel",
  "Government of Jordan", "Government of Turkey", 
  "Government of Syria", "Government of United States of America"
)

cols_to_keep <- c("id", "side_a", "side_b", "latitude", "longitude",
                  "date_start", "date_end")
dyad_cols <- c("side_a", "side_b")

split_dyads <- copy(ucdp_syria_df
                    )[, ..cols_to_keep
                      ][, (dyad_cols) := .map(.SD, function(.x) {
                          .map(strsplit(.x, ", "), function(.y) {
                            .y[!.y %chin% actors_to_ignore]
                          })
                        }),
                        .SDcols = dyad_cols
                        ][!.map_lgl(side_a, .is_empty)
                          ][!.map_lgl(side_b, .is_empty)
                            ]

ucdp_syria_hyper_df <- copy(split_dyads)[, -"id"]

unnested <- setDT(tidyr::unnest(split_dyads, cols = c(side_a, side_b)))

ucdp_simple_df <- copy(unnested)[, -"id"]

# ucdp_bipartite_df
unnested
