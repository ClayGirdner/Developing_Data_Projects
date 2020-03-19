library(shiny)
library(tidyverse)
library(nflscrapR)
library(ggplot2)
library(ggimage)

# Load in team color/logo data
nfl_logos <- read_csv("nfl_logos.csv")

# Load in team offensive/defensive data
off_2019 <- read.csv("off_2019.csv")
def_2019 <- read.csv("def_2019.csv")

# Define server logic required to draw a scatterplot
shinyServer(function(input, output) {

    output$scatterPlot <- renderPlot({

        # input$phase from ui.R used to select off_2019 or def_2019
        agg_2019 <- if(input$phase == "Offense"){
            off_2019
        } else {
            def_2019
        }
        
        agg_2019$team <- as.character(agg_2019$team)
        nfl_logos$team_code <- as.character(nfl_logos$team_code)
        nflteams$abbr <- as.character(nflteams$abbr)
        
        # add team logos/colors
        agg_2019 <- agg_2019 %>%
            left_join(nfl_logos, by = c("team" = "team_code")) %>%
            left_join(nflteams[,c("abbr", "primary", "secondary", "tertiary")], by = c("team" = "abbr")) %>%
            rename(name = team.y)

        # draw the scatterplot
        plot <- agg_2019 %>%
            ggplot(aes(x = epa_per_pass, y = epa_per_rush)) + 
            geom_image(aes(image = url))
        
        plot


    })

})
