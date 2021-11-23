## PostService

PostService is a library made for Roblox by Madonox.  This library exists to add more functionality to RemoteEvents and RemoteFunctions, with some of the primary functions being able to send bulk remote event fires (fire one remote, but send over multiple actions), create and register remotes by script with ease, interact with a pre-made central channel, and much more!

### Installing the Library

Installing the library is quite simple, simply just insert the model linked below into your Roblox game, place it into ReplicatedStorage, and you're done!

### Utilizing the API

In order to begin utilzing the Library, you must firstly install it.  In order to install it, see the steps above.  Once you have done that, you may begin to script with it!

#### Requiring the API:

The first step to begin programming with the API is to firstly require the main file, below is some example code:
```lua
local PostService = require(game.ReplicatedStorage.PostService.PostService)

PostService.start()

local server = PostService.get() -- If it's used in a Local Script, it would return the client methods instead.
```

#### Defining your first remote connection:

Now, in order to setup your first remote connection, you will want to use the `OpenNetwork` method on the server, and the `OpenConnection` method on client.

```lua
server.OpenNetwork(nil,function(player,...) -- The first argument would be a RemoteEvent or RemoteFunction, if you wished to assign this to a pre-existing one.
  print(player.Name)
  print(...)
end)
```
