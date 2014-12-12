# Chatitude

A start on a chat server built using Sinatra and server sent events. The SSE necessitated the use of an evented web server so WEBrick was swapped out for Thin.

## Notes

The *client* closes connections after around 40 seconds and the only remedy I could find is to require the client to send a PING message periodically and have the server respond with a PONG message. The server response is what will actually keep the connection open.

Chat users are identified by their ID which is stored in the session. Users have to sign up and have an account (username & password) to begin chatting.

This line in the `get '/chat'` endpoint adds a method called `user` to the instance of Sinatra::Helpers::Stream so that they can be identified for keeping connections open and later for private messages.
```
def out.user; @current_user['id']; end
```
