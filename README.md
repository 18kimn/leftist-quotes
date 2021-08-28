# leftist-quotes

A super, super simple API to interact with 778 communist/leftist quotes, all from [marxists.org](marxists.org). There are three endpoints: 

** / ** (the root): returns a random quote

** /daily ** : returns a single quote every day, matches with the marxists.org [quote-a-day page](https://www.marxists.org/subject/quotes/index.htm)

** /all-quotes ** : returns all quotes. 

Quotes are returned as objects in the form: 
- body: the text of the quote
- link: the link to a page on marxists.org with the associated reading
- attribution: the name of the author and often the date or title of the original text

The first two routes return a single object, and the last route returns an array of objects. 

Contact nathan.kim@yale.edu for any questions.
