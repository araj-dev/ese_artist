<app>
    <h1>this is app</h1>
    <script>
    this.socket = opts;
    socket.on('connect',function(){
        console.log(socket.id);
        console.log('connected');
    });
    </script>
</app>