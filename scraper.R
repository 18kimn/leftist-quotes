library(tidyverse)
library(magrittr)
library(xml2)
library(jsonlite)
temp <- tempfile()
download.file('https://www.marxists.org/subject/quotes/quote-abs.js', 
              temp)

unescape_html2 <- function(str){
  html <- paste0("<x>", paste0(str, collapse = "#_|"), "</x>")
  parsed <- xml2::xml_text(xml2::read_html(html))
  strsplit(parsed, "#_|", fixed = TRUE)[[1]]
}

readChar(temp, file.info(temp)$size, useBytes = TRUE) %>% 
  str_match_all("(?<=<p>)(.*?)(?=</p>)") %>% 
  extract2(1) %>% 
  map_dfr(function(quote){
    body <- str_extract(quote, ".*<br />") %>% 
      str_remove_all("<(.*?)>")
    link <- str_extract(quote, '(?<=href=\")(.*?)(?=\">)')
    attribution <- str_extract(quote, "<br />(.*?)$") %>% 
      str_remove_all("<(.*?)>")
    tibble(body = body, 
           link = link,
           attribution = attribution)
  }) %>% 
  mutate(across(.fns = unescape_html2)) %>% 
  write_json("quotes.json")
