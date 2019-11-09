# importing the requests library 
import requests 
import json
  
# api-endpoint 
URL = "https://newsapi.org/v2/top-headlines"

# location given here 
country = "de"
apiKey =  "4a6694e1f008452db8a44bc3f70b5606"
  
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