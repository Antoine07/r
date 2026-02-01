# Setup minimal du mini-projet

rproj_files <- list.files(pattern = "\\.Rproj$")
stopifnot(length(rproj_files) >= 1)

paths <- list(
  raw_sales = "data/raw/sales.csv",
  out_tables = "output/tables",
  out_figures = "output/figures"
)

stopifnot(file.exists(paths$raw_sales))

dir.create(paths$out_tables, recursive = TRUE, showWarnings = FALSE)
dir.create(paths$out_figures, recursive = TRUE, showWarnings = FALSE)
