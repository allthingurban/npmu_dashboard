# -----------------------------------------------------------------------------
# DATA LOADING MODULE
# -----------------------------------------------------------------------------
# This function fetches and combines data from the specified Google Sheet.

load_data <- function(sheet_id) {
  
  # Authenticate to read a public sheet. No login required.
  gs4_deauth()
  
  # We use tryCatch to handle potential errors if a sheet doesn't exist
  tryCatch({
    urban_data <- read_sheet(sheet_id, sheet = "Urban") %>% 
      mutate(Area = "Urban") # Add a column to identify the area
    
    rural_data <- read_sheet(sheet_id, sheet = "Rural") %>% 
      mutate(Area = "Rural") # Add a column to identify the area
    
    # Combine the two datasets into one
    all_data <- bind_rows(urban_data, rural_data)
    
    return(all_data)
    
  }, error = function(e) {
    # If there's an error, stop the app and show a helpful message
    stop(paste("Error reading Google Sheet. Please check the Sheet ID and sharing settings. Error details:", e$message))
  })
}