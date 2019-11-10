# Fake Wolf 

![](https://raw.githubusercontent.com/Jugendhackt/fakewolf/master/logo%20und%20pr/logo.png)

Fake Wolf is a game similar to the "Werwolf" game 
for running the game please ignore the folders backend and backend_python.

### Installation:

	backend:
		-replace the ip fields in the last lines of code and put in your adress and port
		-run the test.php file on a server and keep the file running in the background

	news Api scripts:
		-navigate to /NewsApi
		-copy config.ini.example to config.ini
		-go to https://newsapi.org and create an api key
		-paste that api key in the cofig file
		-run the files and be happy
		
## Game: 
We created this Game to show how we are being influenced by fake news. 
The Code is a game wich you can play together in a group. This group can be a room in realty or you send the roomID to outher frends and than you can play together.
	
### course of the game: 
**On the first site**


You get a card with real news, we pulled from the net using NewsAPI. You are given a certain time to read the card. When the time is over you will be sent to the next page.

**On the second page**


You write a headline for a news paper. You are assigned one of two teams, either the journalists or the populists. If you are a populist you write a headline with that contains fake news. The game shows you a selection of keywords, a few words must be written in your hadline. If you are using more than needed, you will gain more points. The game is sending random informations during the game that might be helpfil the detect fake news. 

**On the last page**


In the last game pahse you will have to decide on a certain article which you think might be fake news, if you are a populist you of course want to choose the real news.The player with the most votes on his article gets kicked from the game. You can talk with the other players. For this we made an ingame chat. 

## We hope that you will have fun when you play it :) 
