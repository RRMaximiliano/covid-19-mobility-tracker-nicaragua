#------------------------------------------------------------------------------#
# COVID - Mobility tracker: Nicaragua
#------------------------------------------------------------------------------#
# 
# Outline:
#   1.  Settings
#       1.1. Load packages
#   2.  File paths
#   3.  Codes
#       3.1. Graphs
#
#------------------------------------------------------------------------------#
# 1. SETTINGS----
#------------------------------------------------------------------------------#
run_codes <- FALSE
#------------------------------------------------------------------------------#
#   1.1. Load packages
#------------------------------------------------------------------------------#

if (!require("pacman")) install.packages("pacman")

pacman::p_load(tidyverse, hrbrthemes, janitor, lubridate, wesanderson,
               here, extrafont, patchwork, scales, viridis)

#------------------------------------------------------------------------------#
# 2. FILE PATHS----
#------------------------------------------------------------------------------#

project <- file.path("D:/Documents/GitHub/covid-19-mobility-tracker-nicaragua")
scripts <- file.path(project, "scripts")
data    <- file.path(project, "data")
outputs <- file.path(project, "outputs")
figures <- file.path(outputs, "figures") 

#------------------------------------------------------------------------------#
# 2. CODES----
#------------------------------------------------------------------------------#

if (run_codes==TRUE) {
    source(file.path(scripts, "1_download_data.R"))
    source(file.path(scripts, "2_figures.R"))
} 