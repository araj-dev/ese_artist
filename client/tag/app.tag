<app>
    <h2>Application Root</h2>
    <enter if={!entered} enterroom = {enterRoom}></enter>
    <userlist if={entered} userslist = {users} ></userlist>
    
    <script>
        var self = this;
        this.entered = false;
        this.socket = opts;
        this.odai = "お題"
        this.user = {
            id:"",
            name:"michael",
            ese:false,
            ready:false,
        };
        this.entered=false;
        this.users = [];
        socket.on('connect',function(){
            self.user.id = self.socket.id;
        });
        socket.on('inRoomStoC',function(data){
            self.users = data;
            self.update;
            console.log(self.users);
        });
        enterRoom = function(name){
            self.user.id = self.socket.id;
            self.user.name = name;
            self.entered = true;
            self.socket.emit('inRoomCtoS',self.user);
            self.update();
        };
    </script>
</app>