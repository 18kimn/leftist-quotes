library(tidyverse)
library(magrittr)
library(jsonlite)
temp <- tempfile()
download.file('https://www.marxists.org/subject/quotes/quote-abs.js', 
              temp)

readChar(temp, file.info(temp)$size) %>% 
  str_match_all("(?<=<p>)(.*?)(?=</p>)") %>% 
  extract2(1) %>% 
  map_dfr(function(quote){
    message()
    body <- str_extract(quote, ".*<br />") %>% 
      str_remove_all("<(.*?)>")
    link <- str_extract(quote, '(?<=href=\")(.*?)(?=\">)')
    attribution <- str_extract(quote, "<br />(.*?)$") %>% 
      str_remove_all("<(.*?)>")
    tibble(body = body, 
           link = link,
           attribution = attribution)
  }) %>% 
  write_json("quotes.json")
