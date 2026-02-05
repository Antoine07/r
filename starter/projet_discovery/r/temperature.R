d <- as.Date("05|02|2026", format = "%d|%m|%Y")
e <- as.Date("2026***02***05", format = "%Y***%m***%d")

# install.packages("tidyverse") # en console
library(tidyverse)
f <- dmy("05 février 2026", locale = "fr_FR")

print(f)