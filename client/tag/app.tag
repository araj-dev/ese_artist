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
        function sendName(){
            self.socket.emit('inRommCtoS',{id:self.socket.id,user:self.user});
        }
        sendName();
    </script>
</app>