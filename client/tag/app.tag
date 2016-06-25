<app>
    <h2>Application Root</h2>
    <enter if={!entered} enterroom = {enterRoom}></enter>
    <userlist if={entered} userslist = {users} ></userlist>
    <div if={entered} class="info">
        <p>あなたの情報</p>
        <p>名前：{user.name}</p>
        <p if={user.ese} style={"color":"red"}>あなたがエセ芸術家です</p>
        <input type="button" onclick="{onReady}" value="Next Game?">
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
        socket.on('updateUserStoC',function(data){
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
        onReady = function(){
            self.user.ready = true;
            socket.emit('updateUserCtoS',self.user);
            self.update();
        }
    </script>
</app>