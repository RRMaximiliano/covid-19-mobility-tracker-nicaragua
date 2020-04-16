#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Download data from the 
# repo: pastelsky/covid-19-mobility-tracker
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Get current date
date <- Sys.Date()

#------------------------------------------------------------------------------#
# Nicaragua ----
#------------------------------------------------------------------------------#
data <- readRDS("data/nic-google-mobility-data-2020-04-15.rds") %>% 
    mutate(
        variable = stringr::str_to_title(gsub("and", "&", variable))
    )

# Plol
data %>% 
    ggplot(aes(x = date, y = value, fill = variable)) + 
    geom_ribbon(aes(ymin = 0, ymax = value)) + 
    geom_line(size = 1) +
    facet_wrap(~variable) + 
    scale_y_continuous(labels = function(x) paste0(x, "%")) + 
    labs(x = NULL,
         y = NULL,
         color = NULL, 
         subtitle = "The baseline is the median value, for the day of the week, during the 5-week period Jan 3–Feb 6, 2020.",
         title = "Mobility changes in Nicaragua",
         caption = "Data: Google Community Mobility Report | Plot: @rrmaximiliano") + 
    theme_ipsum_rc() + 
    theme(
        legend.position = ""
    )

ggsave(paste0(figures, "/fig-", date, ".pdf"), 
       device = cairo_pdf, 
       height = 6, width = 10)

ggsave(paste0(figures, "/fig-", date, ".png"), dpi = 750, 
       height = 6, width = 10)

#------------------------------------------------------------------------------#
# Central America ----
#------------------------------------------------------------------------------#

data <- readRDS("data/ca-google-mobility-data-2020-04-15.rds")

data <- data %>% 
    mutate(
        country = case_when(country == "CR" ~ "Costa Rica", 
                            country == "GT" ~ "Guatemala", 
                            country == "HN" ~ "Honduras", 
                            country == "NI" ~ "Nicaragua", 
                            country == "SV" ~ "El Salvador", 
                            country == "PA" ~ "Panama", 
                            country == "BZ" ~ "Belize"),
        variable = stringr::str_to_title(gsub("and", "&", variable))
    )


# Plot
data %>% 
    ggplot(aes(x = date, y = value, fill = variable)) + 
    geom_ribbon(aes(ymin = 0, ymax = value)) + 
    geom_line(size = 1) +
    facet_grid(country~variable, switch = "both") + 
    labs(x = NULL,
         y = NULL,
         color = NULL, 
         subtitle = "The baseline is the median value, for the day of the week, during the 5-week period Jan 3–Feb 6, 2020.",
         title = "Mobility changes in Central America",
         caption = "Data: Google Community Mobility Report | Plot: @rrmaximiliano") + 
    theme_ipsum_rc() + 
    theme(
        legend.position = "",
        strip.placement = "outside",
        strip.text.y.left = element_text(size = 16, angle = 0, face = "bold"),
        strip.text.x = element_text(size = 14),
        plot.title = element_text(size = 20),
        plot.subtitle = element_text(size = 18),
        plot.caption = element_text(size = 14)
    )

ggsave(paste0(figures, "/ca-fig-", date, ".pdf"), 
       device = cairo_pdf, 
       width = 22, height = 16, scale = 0.65)

ggsave(paste0(figures, "/ca-fig-", date, ".png"), dpi = 750, 
       width = 22, height = 16, scale = 0.65)

