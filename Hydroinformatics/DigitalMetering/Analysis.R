library(RODBC)
library(tidyverse)
library(lubridate)

# Colour palatte
ColPal <- c("#23b5ff", "#00006e", "#a1bf11", "#ff570c")

# Fetch data
sandbox <- odbcDriverConnect("driver={SQL Server};server=SQLSandbox;DATABASE=WQSandbox;trusted_connection=true")
meter_reads <- sqlFetch(sandbox, "DM_Data")
odbcClose(dwh)

