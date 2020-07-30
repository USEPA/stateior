library(httr)
# url encoding
base_url = "https://api.usaspending.gov"
path = "/api/v2/search/spending_by_award/"
url = modify_url(base_url, path = path)


# query 
filterObject = list(award_type_codes = 
                      c('A', 'B', 'C', 'D')
                    )

queryObject = list(filters = filterObject,
                   fields = c("Award ID", "Recipient Name", "Start Date", "End Date", "Award Amount", "Awarding Agency", "Funding Agency", "Contract Award Type", "Place of Performance State Code", "Place of Performance Zip5"),
                   limit = 100,
                   page = 1)

# get response
resp = POST(url, 
            body = queryObject, 
            encode = 'json')

gresp = jsonlite::fromJSON(content(resp,'text'), simplifyVector = FALSE)