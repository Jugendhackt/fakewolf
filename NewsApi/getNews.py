# importing the requests library 
import requests 
import json
import configparser


config = configparser.ConfigParser()
config.read('config.ini')

# api-endpoint 
URL = config['DEFAULT']['url']

# location given here 
language = input("language:")
apiKey = config['DEFAULT']['apiKey']
pageSize = config['DEFAULT']['pageSize']
print(apiKey)
  
# defining a params dict for the parameters to be sent to the API 
data = {'language':language, 'apiKey':apiKey, 'pageSize':pageSize, 'sortBy':"popularity", "sources":"bild"} 

 
# sending get request and saving the response as response object 
r = requests.get(URL, params = data)
 
  
# extracting data in json format 
#r = r.content.decode("utf-8")

filename = input("please enter the output file")
f= open(filename,"w+",encoding="utf-8")
f.write(r.text)
f.close
  
# extracting latitude, longitude and formatted address  
# of the first matching location 

# printing the output 
print(r)

print(r.json()["totalResults"])