# importing the requests library 
import requests 
import json
import configparser

# api-endpoint 
URL = "https://newsapi.org/v2/top-headlines"

# location given here 
country = input("country:")
config = configparser.ConfigParser()
apiKey = config['apiKey'] 
  
# defining a params dict for the parameters to be sent to the API 
data = {'country':country, 'apiKey':apiKey} 
  
# sending get request and saving the response as response object 
r = requests.get(URL, params = data) 
  
# extracting data in json format 
data = r.json() 
  
f= open("news.txt","w+")
f.write(r.text)
f.close
  
# extracting latitude, longitude and formatted address  
# of the first matching location 

# printing the output 
print(r.text)