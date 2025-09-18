# -----------------------------------------------------------------------------
# SERVER LOGIC
# -----------------------------------------------------------------------------
# This script contains the instructions that your computer needs to build the app.

function(input, output, session) {
  
  # --- Reactive Value for Storing Data ---
  # 'initial_data' is created in global.R
  data_rv <- reactiveVal(initial_data)
  
  # --- Refresh Button Logic ---
  observeEvent(input$refresh, {
    showNotification("Refreshing data from Google Sheet...", type = "message", duration = 3)
    
    # The 'load_data' function is sourced from global.R
    refreshed_data <- load_data(SHEET_ID)
    data_rv(refreshed_data)
    
    new_domain_choices <- unique(refreshed_data$Domain)
    updateSelectInput(session, "domain", choices = new_domain_choices)
    
    showNotification("Data refreshed successfully!", type = "message", duration = 3)
  })
  
  # --- Filtered Data ---
  filtered_data <- reactive({
    req(input$area_type, input$domain)
    
    data_rv() %>%
      filter(
        Area == input$area_type,
        Domain == input$domain
      ) %>%
      # IMPORTANT: Change these column names if yours are different!
      select(COL_NAMES)
  })
  
  # --- Render the Table ---
  output$data_table <- renderDT({
    datatable(
      filtered_data(),
      extensions = 'Buttons',
      
      options = list(
        # NEW: 'dom' positions the buttons ('B') in the table's layout
        dom = 'Bfrtip',
        # NEW: Define which buttons to show
        buttons = c('copy', 'excel'),
        pageLength = 10,
        autoWidth = TRUE
      ),
      rownames = FALSE,
      class = 'cell-border stripe'
    )
  })
  
  # --- Disable State Selection ---
  observe({
    if (input$level == "state") {
      updateRadioButtons(session, "level", selected = "national")
      showNotification("State-level data is not yet implemented.", type = "warning")
    }
  })
}