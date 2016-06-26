<app>
   <div class="wrapper">
    <h2>芸術家、ニューヨークへ行く</h2>
    <enter if={!entered} enterroom = {enterRoom}></enter>
    <userlist if={entered} userslist = {users} ></userlist>
       <h3>テーマ:{theme}</h3>
    <div if={entered} class="info">
        <p>あなたの情報</p>
        <p>名前：{user.name}</p>
        <p if={!user.ese}>あなたは<strong>芸術家</strong>です</p>
        <p if={user.ese} >あなたは<strong>エセ芸術家</strong>です</p>
        <p if={!user.ese}>お題は「{user.odai}」です</p>
        <input type="button" onclick="{onReady}" value="Next Game?">
    </div>
    </div>
    <script>
        var self = this;
        this.entered = false;
        this.socket = opts;
        this.user = {
            id:"",
            name:"michael",
            ese:false,
            ready:false,
            odai:"odai"
        };
        this.users = [];
        this.theme = "";
        socket.on('connect',function(){
            self.user.id = self.socket.id;
        });
        socket.on('updateUsersStoC',function(data){
            self.users = data;
            self.update();
        });
        socket.on('updateUserStoC',function(data){
            self.users = data;
            data.forEach(function(user){
                if(user.id==self.user.id){
                    self.user = user;
                }
            });
            self.update();
        });
        socket.on('themeUpdate',function(data){
            self.theme = data;
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
            socket.emit('startGame',self.user);
            self.update();
        }
    </script>
    
    <style scoped>
        .wrapper {
            width:800px;
            padding:30px;
            margin:auto;
            background: rgba(122, 219, 171, 0.69);
        }
        .info{
            width:400px;
            padding:20px;
            margin:auto;
            background: rgba(248, 248, 222, 0.64);
        }
    </style>
</app>