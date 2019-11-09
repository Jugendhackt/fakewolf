class Room:
    users = []
    id = 0
    cards = []
    timer = 90
    phase = 0
    running = False
    
    def __init___(self, id):
        self.id = id
            
    
    def addUser(self, user):
        self.users.push(user)
        for u in self.users:
            #allert the u
    
    def changePhase(self,phase):
        self.phase = phase
        switch(phase){
        case 0:break#schreibphase
        case 1:break#kartenphase
        case 2:break#aktionsphase
        }
        
    def sendMessages(self,Message):
        for u in users
            #alltert the u
       
    