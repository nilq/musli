doctype html
html
  head
    title muslichat

    meta charset="utf8"

    script src="https://code.jquery.com/jquery-1.11.3.js"
    javascript:
      $(document).ready(function() {
        var ws = new WebSocket("ws://" + location.host + "/chat");

        ws.onmessage = function(e) {
          $('#chat').append(e.data + "\\n");
        };

        $("form").bind('submit', function(e) {
          var mesage = $('#message').val();

          ws.send(String(message.value));

          $('#message').val('');
          $('#message').focus();

          e.preventDefault();
        });

        window.onbeforeunload = function() {
          ws.onclose = function () {};
          ws.close();
        };
      });

  body
    pre id="chat"
    form
      input id="message" placeholder="type message..."
      input type="submit" value="send"