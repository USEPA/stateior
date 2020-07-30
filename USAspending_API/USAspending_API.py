import requests
import numpy as np
import pandas as pd
import copy
import os

os.chdir('/Users/eloncha/Documents/GitHub/USEEIO-CountyMethod/USAspending_API/data')


def apiCall(url, method = ['GET','POST'], filter = {}):
    if method =='GET':
        resp = requests.get(url)
        outcome = resp.json()
        return outcome
    elif method == 'POST':
        resp = requests.post(url, json = filter)
        outcome = resp.json()
        return outcome

def Create_PSC_Object(pscTable):
    templist = []
    for i in np.arange(0, pscTable.shape[0] - 1):
        if (pscTable.iloc[i,8] == 'Product'):
            psc = [pscTable.iloc[i, 8], pscTable.iloc[i, 1][0:2], pscTable.iloc[i, 1]]
        elif (pscTable.iloc[i,8] == 'Service'):
            psc = [pscTable.iloc[i, 8], pscTable.iloc[i, 1][0], pscTable.iloc[i, 1][0:2], pscTable.iloc[i, 1]]
        elif (pscTable.iloc[i,8] == 'Research and Development'):
            psc = [pscTable.iloc[i, 8], pscTable.iloc[i, 1][0:2], pscTable.iloc[i, 1][0:3], pscTable.iloc[i, 1]]
        templist.append(psc)
    pscObject = {'require': templist}

    return(pscObject)



'''
STATE CODE IMPORT (NOT IN USE)

stateTable = pd.read_csv('StateAbbreviation.csv')
stateCode = stateTable['Code']
'''


'''
PSCCODE IMPORT (BASED ON DAVE'S LIST)
'''
pscTable = pd.read_csv('PSC_Classification2.csv', encoding = 'unicode_escape')
pscIntermediate, pscEquip, pscIP, pscStructure = pscTable[pscTable['Purchase_Type'] == 'Intermediate'], \
                                                 pscTable[pscTable['Final_Demand_Category'] == 'Equipment'], \
                                                 pscTable[pscTable['Final_Demand_Category'] == 'Intellectual_Property'], \
                                                 pscTable[pscTable['Final_Demand_Category'] == 'Structures']


'''
PSCCODE OBJECT 
'''
psclist_intermediate, psclist_equip, psclist_ip, psclist_structure = Create_PSC_Object(pscIntermediate), \
                                                                     Create_PSC_Object(pscEquip), \
                                                                     Create_PSC_Object(pscIP), \
                                                                     Create_PSC_Object(pscStructure)


'''
NAICS CODE IMPORT (PER MO'S REQUEST)
'''
NAICStoPull = np.unique(pd.read_csv('NAICS_to_pull.csv').iloc[:, 2])


'''
BE AWARE: THIS FUNCTION CAN TAKE VERY LONG TO RUN
'''
def USASpending_search_by_award(PSCObject):
    base_url = 'https://api.usaspending.gov'
    search_url = '/api/v2/search/spending_by_award/'

    startDate = '2008-01-01'  # manual time setting
    endDate = '2018-12-31'
    TimePeriodObject = {'start_date': startDate, 'end_date': endDate}
    ## AwardTypesObject = [['A','B','C','D'], ['02', '03', '04', '05']] # contract A-D and grant 02-05 only , '02', '03', '04', '05'
    AwardTypesObject = ['A', 'B', 'C', 'D']  # contract only
    LocationObject = {'country': 'USA'}


    orderList = []
    tempList = []
    i = 0

    for naics in NAICStoPull:  #loop through all NAICS sectors

        NAICSCodeObject = {'require':[str(naics)]}
        filterObject = {'naics_codes': NAICSCodeObject,
                        'time_period': [TimePeriodObject],
                        'place_of_performance_locations': [LocationObject],
                        'award_type_codes': AwardTypesObject,
                        'psc_codes': PSCObject,
                        }  # filterObject
        apiData = {'filters': filterObject,
                    "fields": ["Award ID", "Recipient Name", "Start Date", "End Date", "Award Amount", "Awarding Agency", "Funding Agency", "Contract Award Type", "Place of Performance State Code", "Place of Performance Zip5"],
                    'limit': 100,
                    'page': 1}
        response = apiCall(base_url + search_url, method = 'POST', filter = apiData)
        orderList.append(response['results'])

        if response['page_metadata']['hasNext'] == True:  #in case there are multiple pages, update filter to fetch next page
            apiData['page'] += 1
            response = apiCall(base_url + search_url, method = 'POST', filter = apiData)
            orderList.append(response['results'])
        for page in orderList:  #store state data in tempList
            if (len(page) != 0):
                for item in page:
                    item['NAICS'] = naics
                    tempList.append(item)
        # reset
        orderList = []
        print(i,  "   {0} to go".format(len(NAICStoPull) - i))
        print('\n')
        i += 1

    df = pd.DataFrame(tempList)
    return(df)


'''
OUTPUT
'''
df_ip = USASpending_search_by_award(psclist_ip)
df_ip.to_csv('../output/fedspending_ip.csv')

df_structure = USASpending_search_by_award(psclist_structure)
df_structure.to_csv('../output/fedspending_structure.csv')

df_equip = USASpending_search_by_award(psclist_equip)
df_equip.to_csv('../output/fedspending_equipment_0724.csv')

'''
For intermediate demand, we split the intermediate psc list into 2 sublists as the query since USASpending API does not accept psc list of 1000+ size
'''
psclist_intermediate_A = {'require':psclist_intermediate['require'][0:700]}
psclist_intermediate_B = {'require':psclist_intermediate['require'][700:]}

df_intermediate_A = USASpending_search_by_award(psclist_intermediate_A)
df_intermediate_A.to_csv('../output/fedspending_intermediate_A.csv')

df_intermediate_B = USASpending_search_by_award(psclist_intermediate_B)
df_intermediate_B.to_csv('../output/fedspending_intermediate_B.csv')