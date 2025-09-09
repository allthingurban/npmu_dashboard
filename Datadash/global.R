# -----------------------------------------------------------------------------
# GLOBAL SCRIPT
# -----------------------------------------------------------------------------
# This script runs once when the app starts.
# It loads packages, sources functions, and prepares data.

# Load necessary R packages
library(shiny)
library(googlesheets4)
library(dplyr)
library(DT)

# Source the configuration file and the data loader module
source("config.R")
source("R/data_loader.R")

# Load the data initially when the app starts
# These objects will be available to both ui.R and server.R
initial_data <- load_data(SHEET_ID)
domain_choices <- unique(initial_data$Domain)