<app>
    <h1>Application Root</h1>
    <enter if={!user.entered} enterroom = {enterRoom}></enter>
    <userlist if={user.entered} users = {this.users} ></userlist>
    
    <script>
        var self = this;
        this.socket = opts;
        this.id = self.socket.id;
        this.user = {
            name:"michael",
            entered:false,
        };
        this.users = [];
        this.entered=false;
        socket.on('connect',function(){
            console.log('connected');
        });
        enterRoom = function(name){
            self.user.name = name;
            self.socket.emit('inRoomCtoS',{id:self.socket.id,user:self.user});
            console.log('enter');
            self.user.entered = true;
            self.update;
        };
    </script>
</app>