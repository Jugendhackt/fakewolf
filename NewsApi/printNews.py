import json
import msvcrt

filename = input("please enter the json filename ")

r = open(filename,"r",encoding="utf-8")
data = r.read()

data = json.loads(data)

out = []

for news in data['articles']:
    title = news['title']
    description = news['description']
    print("\nTitle: ",title)
    print("\nDescription:",description,"\n")
    inp = input ("\nWrite d to delete article")
    if(inp=="d"):
        continue
    inp = input("please write the keywords").split(" ")
    n = {"title":title,"description":description,"keywords":inp}
    out.append(n)
    
r = json.dumps(out, indent=4,ensure_ascii=False)


filename = input("please enter the output file")

f= open(filename,"w+")
f.write(r)
f.close