require "kemal"

require "slang"
require "kilt"
require "kilt/slang"

SOCKETS = [] of HTTP::WebSocket

get "/" do
  render "views/index.slang"
end

ws "/chat" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    SOCKETS.each { |socket| socket.send message }
  end

  socket.on_close do
    SOCKETS.delete socket
  end
end

Kemal.run