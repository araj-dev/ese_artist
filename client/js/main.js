var USERID;
//Connect Server
var socket = io.connect();

//Set USERID when connected
socket.on('connect',function(){
    USERID = socket.id;
    console.log("Set "+USERID+" at local USERID");
});

//EventListener
socket.on('newuserStoC',function(data){
});
socket.on('removeuserStoC',function(id){
});
socket.on('updateUserStoC',function(data){
});
