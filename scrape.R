## To clean data
## Starting point. https://www.r-bloggers.com/2021/07/politely-scraping-wikipedia-tables-2/
library(tidyverse)
library(lubridate)
library(janitor)

# To scrape data
library(rvest)
library(httr)
library(polite)


## url <- "https://en.wikipedia.org/wiki/List_of_national_independence_days"
## https://www.r-bloggers.com/2021/07/politely-scraping-wikipedia-tables-2/

url <- "https://oad.simmons.edu/oadwiki/University_rights-retention_OA_policies"
url_bow <- polite::bow(url)
url_bow

ind_html <-
  polite::scrape(url_bow) %>%  # scrape web page
  rvest::html_nodes("table.wikitable") %>% # pull out specific table
  rvest::html_table(fill = TRUE) 


ind_html <-
  polite::scrape(url_bow) %>%  # scrape web page
  rvest::html_nodes("table.wikitable") %>% # pull out specific table
  rvest::html_table(fill = TRUE) 



ind_tab <- 
  ind_html[[1]] %>% 
  clean_names()

%% https://stackoverflow.com/questions/42455210/using-rvest-to-extract-both-hypertext-and-hyperlink-from-a-column-in-a-table?rq=3
