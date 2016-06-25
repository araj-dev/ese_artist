<app>
    <h2>Application Root</h1>
    <enter if={!entered} enterroom = {enterRoom}></enter>
    <userlist if={entered} users = {this.users} ></userlist>
    
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
        this.users = [];
        this.entered=false;
        socket.on('connect',function(){
            self.user.id = self.socket.id;
        });
        socket.on('inRoomStoC',function(data){
            console.dir(data);
            self.users = data;
            self.user = data[self.socket.id];
            self.update;
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