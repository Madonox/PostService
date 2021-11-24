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
-- The first argument would be a RemoteEvent or RemoteFunction, if you wished to assign this to a pre-existing one.
local NetworkInstance = server.OpenNetwork(nil,function(player,...)
  print(player.Name)
  print(...)
end)
```

**Note:** The client method, OpenConnection takes the same arguments as the server, just without the player argument on the function you supply.

##### Using the NetworkInstance:

The NetworkInstance has a lot of methods that go with it, from the ability to toggle if it can be triggered, to destroying it.
Below are some examples of how to use it:
```lua
NetworkInstance:Close()  -- Will prevent it from being fired.
NetworkInstance:Open()  -- Will allow it to be fired, it is assigned to this state by default.
NetworkInstance:Destroy(true)  -- Deletes the NetworkInstance, you will not be able to interact with it anymore.  Setting the first argument to true will [SEE BELOW]
-- delete the instance as well (the RemoteEvent or RemoteFunction).
```
The NetworkInstance also has some properties that go with it, below are a list of properties:
**Note:** None of these properties are made to be assigned new values, they should only be read!
```lua
print(NetworkInstance.closed)  -- Will print true if the NetworkInstance is currently closed.
print(NetworkInstance.instance.Name)  -- The RemoteEvent or RemoteFunction.
```
