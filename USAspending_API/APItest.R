library(httr)
# url encoding
base_url = "https://api.usaspending.gov"
path = "/api/v2/search/spending_by_award/"
url = modify_url(base_url, path = path)


# query 

###### FILTER OBJECT FORMAT NOT CORRECT: SEE PY CODE FOR CORRECT FORMAT ######
filterObjectJSON = jsonlite::toJSON(list(time_period = 
                                           c(list(start_date = '2008-01-01', end_date = '2018-12-31'))))


# get response
resp = POST(url, body = filterObjectJSON, encode = 'raw')
jsonlite::fromJSON(content(resp,'text'), simplifyVector = FALSE)