NFL Team Performance (2019 Season)
========================================================
author: Clay Girdner
date: 3/19/2020
autosize: true

Introduction
========================================================

This Shiny app shows the relative efficiency of offenses and defenses around the NFL in 2019.

The user selects offense or defense from the dropdown box on the left hand side and the plot automatically adjusts.

The app can be found at https://claygirdner.shinyapps.io/nflTeamRanks2019/, and the github repository found here https://github.com/ClayGirdner/Developing_Data_Projects.



Data
========================================================

Data for this product is provided by the nflscrapR package developed and maintained by Ron Yurko and collegues.

In order to get the aggregate data points, I had to read in the play-by-play data for the 2019 season and do a bit of data cleaning before aggregating the data by team.

The file `load_clean_save_data_NFL.R` houses the data cleaning/transformation process.

```
library(nflscrapr)
```

EPA
========================================================

The specific statistic used to compare different units around the NFL is "EPA", more specifically EPA per play.

EPA stands for expected points added, and is among the most informative statistics when describing/comparing NFL teams. The statistic was originally developed by Brian Burke, now the head of football analytics at ESPN.

In essence, EPA tells us how well a unit performs on a play relative to other teams in the recent past after taking into account important variables such as field position and yards to go. For example: a 10 yard pass on 3rd and 8 is much more valuable than a 10 yard pass on 3rd and 15. EPA goes a long way in capturing some of this nuance.

Results
========================================================

Unsurprisingly, the upstart Baltimore Ravens were in a class of their own offensively in 2019 as they were top of the league in both passing and rushing offense.

Answering which defense as best in 2019 is a bit more difficult question to answer. While the New England Patriots were clearly the best team in terms of defending the pass, they trailed several teams when it came to defending the run, most notibly the Tampa Bay Buccaneers who took the top spot in rush EPA per play.
