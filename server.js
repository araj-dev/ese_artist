//
// # ese_artist game
//
//server using Socket.IO, Express
//
var http = require('http');
var path = require('path');
var fs = require('fs');
var socketio = require('socket.io');
var express = require('express');

var router = express();
var server = http.createServer(router);
var io = socketio.listen(server);

router.use(express.static(path.resolve(__dirname, 'client')));

var users = [];

io.on('connection', function (socket) {
  //Identify
  console.log("ID: "+socket.id.substring(2)+" has connected");

  //Add new user to Client map
  socket.on('inRoomCtoS',function(data){
    console.log(data);
    console.log(data.name + " has entered");
    users.push(data);
    io.sockets.emit('updateUserStoC', users);
  });
  
  socket.on('startGame',function(data){
    var cnt;
    for(var i = 0; i < users.length; i++){
      if(users[i].ready) cnt++;
    }
    if(cnt != users.length){
      io.sockets.emit('updateUserCtoS', users);
      return;
    }
    var eseID = Math.floor(Math.random() * users.length);
    for(var i = 0; i < users.length; i++){
      if(i == eseID) {
        data[i].ese = true;
        data[i].odai = "エセ";
      }
      data[i].odai = "ゴリラ（仮）"
    }
    io.sockets.emit('updateUserCtoS', users);
  });
  
  socket.on('updateUserCtoS',function(data){
    var i = searchIndex(socket.id.substring(2));
    users[i] = data;
    io.sockets.emit('updateUserStoC',users);
  });
    
  //Disconncting action
  socket.on('disconnect',function(){
    console.log(users);
    var id = searchIndex(socket.id.substring(2));
    if(typeof users[id] !== "undefined"){
      console.log(users[id].name + " has leaved");
    }
    console.log("ID: " + socket.id.substring(2) + " has disconnected");
    users.splice(id, 1);
    console.log(users);
    io.sockets.emit('updateUserStoC', users);
  });

  function searchIndex(socketID){
    for(var i=0; i < users.length; i++){
      if(users[i].id == socketID) return i; 
    }
  }
  
});


server.listen(process.env.PORT || 3000, process.env.IP || "0.0.0.0", function(){
  var addr = server.address();
  console.log("App server listening at", addr.address + ":" + addr.port);
});