<app>
    <h1>Application Root</h1>
    <script>
        var self = this;
        this.socket = opts;
        this.id = self.socket.id;
        this.user = {
            name:"michael"
        };
        this.users = [];
        socket.on('connect',function(){
            console.log(socket.id);
            console.log('connected');
        });
        this.sendName = function(){
            self.socket.emit('inRoomCtoS',{id:self.socket.id,user:self.user});
        }
        this.on('mount',function(){
            self.sendName();
        });
    </script>
</app>