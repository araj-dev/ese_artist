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
            id:self.socke.id,
            name:"michael",
            ese:false,
            ready:false,
        };
        this.users = [];
        this.entered=false;
        socket.on('connect',function(){
            console.log('connected');
        });
        socket.on('inRoomStoC',function(data){
            console.dir(data);
            self.users = data;
            self.user = data[self.socket.id];
            self.update;
        });
        enterRoom = function(name){
            self.user.name = name;
            self.entered = true;
            self.socket.emit('inRoomCtoS',{id:self.socket.id,user:self.user});
            self.update();
        };
    </script>
</app>