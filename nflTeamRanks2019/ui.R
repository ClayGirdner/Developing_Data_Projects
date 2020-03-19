library(shiny)
library(tidyverse)
library(nflscrapR)
library(plotly)
library(ggplot2)

# Define UI for application that draws a barplot based on NFL team 2019 performance
shinyUI(fluidPage(

    # Application title
    titlePanel("NFL Team Performance (2019 Regular Season)"),

    # Sidebar drop down to select offense or defense
    sidebarLayout(
        sidebarPanel(
            h3("Select Offense or Defense"),
            selectInput("phase", NULL, c("Offense", "Defense"),
                        selected = "Offense")),

        # Show a scatter plot showing offensive and defensive epa per play
        # broken down by pass or rush
        mainPanel(
            plotOutput("scatterPlot"),
            h4("The best offenses will be found towards the top right (as they generate the most points over expected), while best defenses will be in bottom left (give up fewer points than expected).")
        )
    )
))
