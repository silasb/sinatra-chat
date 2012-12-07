$(function(){

  $('#chat-container').css('height', window.document.height - 70 - 33)

  $('#chat-entry input[name="entry"]').focus();

  var client = new Faye.Client('/faye');

  var subscription = client.subscribe('/messages', function(message) {
    add_chat(message['name'], message['text'])
  });

  $('#chat-entry').submit(function(e){
    e.preventDefault();
    var message = $('#chat-entry input[name="entry"]').val()
    $('#chat-entry input[name="entry"]').val('')
    client.publish('/messages', {text: message, name: Name});
  });

  var showDebugMessages = false;
  Faye.Logging.logLevel = 'debug';

  Faye.logger = function(msg) {
    if (window.console)
      console.log(msg);
    if (showDebugMessages)
      $("<li/>").text(msg).appendTo("#debug");
  };
  
});

add_chat = function(name, msg) {
  $('#chat-container').append( $('<div>').html(name + ": " + msg) )
  var objDiv = document.getElementById("chat-container");
  objDiv.scrollTop = objDiv.scrollHeight;
}