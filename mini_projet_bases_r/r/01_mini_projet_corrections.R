# Mini-projet — Bases R (corrigé)

source("r/00_setup.R")

# Étape 1 — Import
sales <- read.csv(paths$raw_sales, stringsAsFactors = FALSE)

# Étape 2 — Décrire
head(sales)
str(sales)

# Étape 3 — Types
sales$date <- as.Date(sales$date)
if (any(is.na(sales$date))) stop("Conversion de `date` en Date: valeurs invalides")

sales$units <- suppressWarnings(as.integer(sales$units))
if (any(is.na(sales$units))) stop("Conversion de `units` en entier: valeurs invalides")

sales$price <- suppressWarnings(as.numeric(sales$price))
if (any(is.na(sales$price))) stop("Conversion de `price` en numérique: valeurs invalides")

# Étape 4 — Dérivation (vectorisée)
sales$revenue <- sales$units * sales$price

# Étape 5 — Filtrer / sélectionner
north <- sales[sales$region == "North", c("date", "product", "units", "price", "revenue")]
print(north)

# Étape 6 — Agréger
revenue_by_region <- aggregate(revenue ~ region, data = sales, sum)
revenue_by_region <- revenue_by_region[order(revenue_by_region$revenue, decreasing = TRUE), ]
print(revenue_by_region)

# Étape 7 — Sorties
out_csv <- file.path(paths$out_tables, "revenue_by_region.csv")
write.csv(revenue_by_region, out_csv, row.names = FALSE)

out_png <- file.path(paths$out_figures, "revenue_by_region.png")
png(out_png, width = 900, height = 500)
barplot(
  revenue_by_region$revenue,
  names.arg = revenue_by_region$region,
  main = "Revenu total par région",
  ylab = "Revenu",
  col = "steelblue"
)
dev.off()

message("OK: sorties générées dans output/")
