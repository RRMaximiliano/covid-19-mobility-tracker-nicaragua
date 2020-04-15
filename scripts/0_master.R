#------------------------------------------------------------------------------#
# PROJECT:                  Rwanda Land Markets
# COUNTRY:                      Muyanza
#------------------------------------------------------------------------------#
#                             Muyanza fup1
#                                2020
#------------------------------------------------------------------------------#
# 
# Outline:
#   1.  Settings
#       1.1. Load packages
#   2.  File paths
#       2.1. Dropbox and GitHub paths
#       2.2. Folder paths
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

