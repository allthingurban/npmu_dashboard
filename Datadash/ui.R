# -----------------------------------------------------------------------------
# USER INTERFACE (UI)
# -----------------------------------------------------------------------------
# This script defines the layout and appearance of the app.

fluidPage(
  
  # App title
  titlePanel("Social Group Indicators Dashboard"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
    # Sidebar panel for user inputs
    sidebarPanel(
      h3("Controls"),
      
      # Input: Select Level (National/State)
      radioButtons(
        "level", 
        "Select Level:",
        choices = c("National" = "national", "State" = "state"),
        selected = "national"
      ),
      p(em("Note: State level data is not yet available.")),
      
      # Input: Select Area (Urban/Rural)
      radioButtons(
        "area_type", 
        "Select Area:",
        choices = c("Urban", "Rural"),
        selected = "Urban"
      ),
      
      # Input: Select a domain from a dropdown list
      # The 'domain_choices' object is created in global.R
      selectInput(
        "domain", 
        "Select Domain:",
        choices = domain_choices
      ),
      
      # Input: Action button to refresh the data
      actionButton("refresh", "Refresh Data", icon = icon("sync"), class = "btn-primary")
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      # Output: A dynamic table
      DTOutput("data_table")
    )
  )
)