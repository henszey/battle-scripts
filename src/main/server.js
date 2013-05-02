
var express = require("express");
var app = require('express')();
var server = require('http').createServer(app);
var io = require('socket.io').listen(server, { log: false });
var sockets = io.sockets;

server.listen(3000);

app.get('/', function (req, res) {
  res.sendfile(__dirname + '/webapp/html/index.html');
});
app.use("/", express.static(__dirname + '/webapp/'));

var nextClientId = 0;
sockets.on('connection', function (socket) {
  var clientId = nextClientId++;
  socket.clientId = clientId;
  socket.emit('player',{id: clientId});
  sockets.emit('players',{join: clientId, x: 500, y: 250});
  console.log("Player " + clientId + " connected");
  socket.emit('news', { msg: 'Welcome client ' + clientId });

  io.sockets.clients().forEach(function (otherSocket) {
    if(clientId != otherSocket.clientId){
      socket.emit('players',{join: otherSocket.clientId, x: 500, y: 250});
    }
  });

  socket.on('ship', function (data) {
//    console.log(data);
    data.id = clientId;
    sockets.emit('ship-' + clientId,data);
  });

  socket.on('ping',function(data){
    var latency = (new Date().getTime() - data.p)/2;
    console.log(latency);
  });

  socket.on('disconnect',function(socket) {
    console.log("Player " + clientId + " disconnected");
    sockets.emit('players',{part: clientId});
  });
});
setInterval(function(){
  //sockets.emit('ping',{p: new Date().getTime()});
}, 1000);

