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
var async = require('async');

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
    console.log(data.name + " has entered");
      async.waterfall([
          function(next){
              users.push(data);
              console.log("pushed");
              next(null);
          },
          function(next) {
              console.log(users);
              io.sockets.emit('updateUsersStoC', users);
              console.log("emit");
              next(null);
          }
      ],
      function(){
          console.log("updated");
      });
  });
  
  socket.on('startGame',function(data){
      async.waterfall([
          function(next){
              var s = searchIndex(socket.id.substring(2));
              users[s] = data;
              next();
          },
          function(next){
              io.sockets.emit('updateUsersStoC', users);
              next();
          },
          function(next){
              for(var i = 0; i < users.length; i++){
                  if(!users[i].ready) return;
              }
              next();
          },
          function(next){
              for(var k = 0; k < users.length; k++){
                  users[k].odai = "ゴリラ（仮）";
                  users[k].ready = false;
                  users[k].ese = false;
              }
              console.log(users);
              next();
          },
          function(next){
              var r = Math.floor(Math.random()*users.length);
              users[r].ese = true;
              users[r].odai = "エセ";
              next();
          }
      ],function(){
          io.sockets.emit('updateUserStoC',users);
      });
  });
  
  socket.on('updateUserCtoS',function(data){
    var i = searchIndex(socket.id.substring(2));
    users[i] = data;
    io.sockets.emit('updateUsersStoC',users);
  });
    
  //Disconnecting action
  socket.on('disconnect',function(){
    console.log(users);
    var id = searchIndex(socket.id.substring(2));
    if(typeof users[id] !== "undefined"){
      console.log(users[id].name + " has leaved");
    }
    console.log("ID: " + socket.id.substring(2) + " has disconnected");
    users.splice(id, 1);
    console.log(users);
    io.sockets.emit('updateUsersStoC', users);
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