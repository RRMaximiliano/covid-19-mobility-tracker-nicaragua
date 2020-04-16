#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Download data from the 
# repo: pastelsky/covid-19-mobility-tracker
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

data <- readRDS("data/nic-google-mobility-data-2020-04-15.rds")

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

ggsave(paste0(figures, "/fig-", date, ".png"), dpi = 400, 
       height = 6, width = 10)
