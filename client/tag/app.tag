<app>
    <h2>Application Root</h2>
    <enter if={!entered} enterroom = {enterRoom}></enter>
    <userlist if={entered} userslist = {users} ></userlist>
    <div if={entered} class="info">
        <p>あなたの情報</p>
        <p>名前：{user.name}</p>
        <p if={user.ese} style={"color":"red"}>あなたがエセ芸術家です</p>
    </div>
    
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
            self.update();
        });
        socket.on('removeUserStoC',function(data){
            console.log(data);
            self.users = data;
            self.update();
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