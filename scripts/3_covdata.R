#------------------------------------------------------------------------------#
# Packages ----
#------------------------------------------------------------------------------#
if (!require("drat")) {
    install.packages("drat")
    library("drat")
}

drat::addRepo("kjhealy")
pacman::p_load("tidyverse", "hrbrthemes", "covdata")

# Get current date
date <- Sys.Date()

#------------------------------------------------------------------------------#
# Google Mobility Changes ----
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# Nicaragua ----
#------------------------------------------------------------------------------#
google_mobility %>% 
    filter(country_region_code == "NI") %>% 
    mutate(type = case_when(type == "retail" ~ "retail & recreation",
                            type == "grocery" ~ "grocery & pharmacy",
                            type == "transit" ~ "transit stations",
                            TRUE ~ type),
           type = str_to_title(type)) %>% 
    ggplot(aes(x = date, y = pct_diff, fill = type)) + 
    geom_ribbon(aes(ymin = 0, ymax = pct_diff)) + 
    geom_line(size = 1) +
    facet_wrap(~type) + 
    scale_y_continuous(labels = function(x) paste0(x, "%")) + 
    labs(x = NULL,
         y = NULL,
         color = NULL, 
         subtitle = "The baseline is the median value, for the day of the week, during the 5-week period Jan 3-Feb 6, 2020.",
         title = "Mobility changes in Nicaragua",
         caption = "Data: Google Community Mobility Report | Plot: @rrmaximiliano") + 
    theme_ipsum_rc() + 
    theme(
        legend.position = ""
    )

# Save plot
ggsave(file.path(figures, paste0("fig-", date, ".pdf")), 
       device = cairo_pdf, 
       height = 6, width = 10)

ggsave(file.path(figures, paste0("fig-", date, ".png")), 
       dpi = 750, height = 6, width = 10)


#------------------------------------------------------------------------------#
# Central America ---- 
#------------------------------------------------------------------------------#
countries <- c("CR", "GT", "HN", "NI", "SV", "PA", "BZ")

google_mobility %>% 
    filter(country_region_code %in% countries) %>% 
    mutate(
        country = country_region_code, 
        country = case_when(country == "CR" ~ "Costa Rica", 
                            country == "GT" ~ "Guatemala", 
                            country == "HN" ~ "Honduras", 
                            country == "NI" ~ "Nicaragua", 
                            country == "SV" ~ "El Salvador", 
                            country == "PA" ~ "Panama", 
                            country == "BZ" ~ "Belize")
    ) %>% 
    mutate(type = case_when(type == "retail" ~ "retail & recreation",
                            type == "grocery" ~ "grocery & pharmacy",
                            type == "transit" ~ "transit stations",
                            TRUE ~ type),
           type = str_to_title(type)) %>% 
    ggplot(aes(x = date, y = pct_diff, fill = type)) + 
    geom_ribbon(aes(ymin = 0, ymax = pct_diff)) + 
    geom_line(size = 1) +
    facet_grid(country~type, switch = "both") + 
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

# Save plot
ggsave(file.path(figures, paste0("ca-fig-", date, ".pdf")), 
       device = cairo_pdf, 
       width = 24, height = 16, scale = 0.65)

ggsave(file.path(figures, paste0("ca-fig-", date, ".png")), 
       dpi = 750, width = 24, height = 16, scale = 0.65)
