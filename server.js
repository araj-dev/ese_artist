//
// # ese_artist game
//
//server using Socket.IO, Express,Async
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

var words = [
    ["動物",["ライオン","トラ","ヒョウ","チーター","アザラシ","タヌキ","コアラ","カンガルー","ゾウ",
    "豚","イノシシ","キリン","カバ","トナカイ","シカ","サイ","サル","リス","カピバラ","ウサギ","ペンギン",
        "クジラ","いるか","フクロウ","ダチョウ","ワニ","フラミンゴ"
    ]],
    ["乗り物",["自転車","自動車","ヨット","バイク","いかだ","蒸気機関車","電車","ヘリコプター","気球","戦車",
    "飛行機","戦闘機","宇宙船","バス","ボート","セグウェイ","フォークリフト","パラグライダー","トラック","スポーツカー",
    "船"]],
    ["スポーツ",["サッカー","野球","バスケットボール","セパタクロー","バトミントン","卓球","短距離走","ハンマー投げ",
    "棒高跳び","走り幅跳び","やり投げ","水泳","ゴルフ","ハンドボール","ラグビー","スキー","スノーボード","スケート",
        "サーフィン","アイスホッケー","テニス","ラクロス"
    ]],
    ["野菜",["ナス","トマト","唐辛子","かぼちゃ","きゅうり","オクラ","トウモロコシ","枝豆","もやし",
        "キャベツ","白菜","ニラ","パセリ","アスパラガス","玉ねぎ","大根","わさび","人参","レンコン",
        "エリンギ","キクラゲ","しいたけ","しめじ","松茸"
    ]]
    ];

var rdmWord = function(){
    var r = Math.floor(Math.random()*3);
    var wordr = Math.floor(Math.random()*words[r][1].length);
    return {theme:words[r][0],word:words[r][1][wordr]};
};

io.on('connection', function (socket) {
  //Identify
  console.log("ID: "+socket.id.substring(2)+" has connected");

  //Add new user to Client
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
              var odai = rdmWord();
              for(var k = 0; k < users.length; k++){
                  users[k].odai = odai.word;
                  users[k].ready = false;
                  users[k].ese = false;
              }
              io.sockets.emit('themeUpdate',odai.theme)
              next();
          },
          function(next){
              var r = Math.floor(Math.random()*users.length);
              users[r].ese = true;
              users[r].odai = "エセなので非表示";
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
    var id = searchIndex(socket.id.substring(2));
    if(typeof users[id] !== "undefined"){
      console.log(users[id].name + " has leaved");
    }
    console.log("ID: " + socket.id.substring(2) + " has disconnected");
    users.splice(id, 1);
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