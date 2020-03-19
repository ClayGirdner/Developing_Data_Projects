library(tidyverse)
library(nflscrapR)

# Load in data
pbp_2019 <- read_csv("https://github.com/ryurko/nflscrapR-data/raw/master/play_by_play_data/regular_season/reg_pbp_2019.csv")
games_2019 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/games_data/regular_season/reg_games_2019.csv")
nfl_logos <- read_csv("https://raw.githubusercontent.com/ClayGirdner/Baker/master/nfl_team_logos.csv")
write.csv(nfl_logos, "nfl_logos.csv")


# Transform raw data
pbp_2019 <- pbp_2019 %>%
    # Join game data onto play-by-play dataset
    left_join(games_2019[,c("game_id", "type", "season", "week")],
              by="game_id") %>%
    # grab only penalties, pass, and run plays
    filter(!is.na(epa), play_type == "no_play" | play_type == "pass" | play_type == "run") %>%
    # create pass, rush columns
    # use information from desc column to determine if penalty plays were run or pass
    mutate(pass = if_else(str_detect(desc, "(pass)|(sacked)|(scramble)"), 1, 0),
           rush = if_else(str_detect(desc, "(left end)|(left tackle)|(left guard)|(up the middle)|(right guard)|(right tackle)|(right end)") & pass == 0, 1, 0)
    ) %>%
    # filter to only pass or rush plays, remove kneels and spikes
    filter(pass == 1 | rush == 1, qb_kneel == 0, qb_spike == 0)

# Aggregate offensive data by team
off_2019 <- pbp_2019 %>%
    group_by(posteam) %>%
    summarise(pass_plays = sum(pass),
              rush_plays = sum(rush),
              tot_plays = pass_plays + rush_plays,
              pass_epa = sum(epa[pass == 1]),
              rush_epa = sum(epa[rush == 1]),
              tot_epa = sum(epa),
              epa_per_pass = pass_epa / pass_plays,
              epa_per_rush = rush_epa / rush_plays,
              epa_per_play = tot_epa / tot_plays) %>%
    mutate(pass_rank = rank(desc(epa_per_pass)),
           rush_rank = rank(desc(epa_per_rush)),
           tot_rank = rank(desc(epa_per_play))) %>%
    rename(team = posteam) %>%
    mutate(team = as.character(team))

write.csv(off_2019, "off_2019.csv")


# Aggregate defensive data by team
def_2019 <- pbp_2019 %>%
    group_by(defteam) %>%
    summarise(pass_plays = sum(pass),
              rush_plays = sum(rush),
              tot_plays = pass_plays + rush_plays,
              pass_epa = sum(epa[pass == 1]),
              rush_epa = sum(epa[rush == 1]),
              tot_epa = sum(epa),
              epa_per_pass = pass_epa / pass_plays,
              epa_per_rush = rush_epa / rush_plays,
              epa_per_play = tot_epa / tot_plays) %>%
    mutate(pass_rank = rank(epa_per_pass),
           rush_rank = rank(epa_per_rush),
           tot_rank = rank(epa_per_play)) %>%
    rename(team = defteam) %>%
    mutate(team = as.character(team))

write.csv(def_2019, "def_2019.csv")