#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Download data from the 
# repo: pastelsky/covid-19-mobility-tracker
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Get current date
date <- Sys.Date()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Only Nicaragua  ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Read CSVs files --------------------------------------------------------------

# Terms
files <- c("mobility-grocery-and-pharmacy",
           "mobility-parks",
           "mobility-residential",
           "mobility-retail-and-recreation",
           "mobility-transit-stations",
           "mobility-workplaces")
# Base url
url <- "https://raw.githubusercontent.com/pastelsky/covid-19-mobility-tracker/master/output/NI/"

# Full url
full_url <- paste0(url, files, ".csv")

# Load Data --------------------------------------------------------------------

## Initialize dataframe
df_all <- data.frame(NULL)

for(var in files){
    
    df <- lapply(var, function(i){
        ## Print current variable
        print(i)
        
        ## Get full url
        url <- paste0(url, i, ".csv")
        
        ## Read csv
        temp <- read.csv(url) %>% 
            mutate(variable = i)
    }) %>% 
        bind_rows()
    
    df_all <- bind_rows(df_all, df)
}

# Clean the dataset -----------------------------------------------------------
df_all <- df_all %>%
    mutate(variable = gsub("mobility-", "", variable), 
           variable = gsub("-", " ", variable),
           country = "Nicaragua",
           date = as_date(date)) %>%
    select(country, date, variable, value) 

# Save the full dataset -------------------------------------------------------
write.csv(df_all, here::here("data", paste0("nic-google-mobility-data-", date, ".csv")),
          row.names = FALSE)
saveRDS(df_all, here::here("data", paste0("nic-google-mobility-data-", date, ".rds")))


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Central America ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Read CSVs files --------------------------------------------------------------

# Countries
countries <- c("CR", "GT", "HN", "NI", "SV", "PA", "BZ")

# Base URL
url <- "https://raw.githubusercontent.com/pastelsky/covid-19-mobility-tracker/master/output/"

# Load Data --------------------------------------------------------------------

## Initialize dataframe
df_all <- data.frame(NULL)

for(c in countries){
    for(var in files){
        
        df <- lapply(var, function(i){
            ## Print current variable
            print(i)
            
            ## Get full url
            url <- paste0(url, c, "/", i, ".csv")
            
            print(url)
            
            ## Read csv
            temp <- read.csv(url) %>% 
                mutate(variable = i,
                       date = as_date(date))
        }) %>% 
            bind_rows() %>% 
            mutate(country = c)
        
        df_all <- bind_rows(df_all, df) 
    }
}

# Clean the dataset -----------------------------------------------------------
df_all <- df_all %>%
    mutate(variable = gsub("mobility-", "", variable), 
           variable = gsub("-", " ", variable),
           date = as_date(date)) %>%
    select(country, date, variable, value) 

# Save the full dataset -------------------------------------------------------
write.csv(df_all, here::here("data", paste0("CA-google-mobility-data-", date, ".csv")),
          row.names = FALSE)
saveRDS(df_all, here::here("data", paste0("CA-google-mobility-data-", date, ".rds")))
