
## PostService

PostService is a library made for Roblox by Madonox.  This library exists to add more functionality to RemoteEvents and RemoteFunctions, with some of the primary functions being able to send bulk remote event fires (fire one remote, but send over multiple actions), create and register remotes by script with ease, interact with a pre-made central channel, and much more!

**NOTICE:** This service is in **ALPHA** release, expect more features to be added quite soon!

### Installing the Library

Installing the library is quite simple, simply just insert the model linked below into your Roblox game, place it into ReplicatedStorage, and you're done!  The model can be found [here](https://www.roblox.com/library/8225940888/PostService)

### Utilizing the API

In order to begin utilzing the Library, you must firstly install it.  In order to install it, see the steps above.  Once you have done that, you may begin to script with it!

#### Requiring the API:

The first step to begin programming with the API is to firstly require the main file, below is some example code:
```lua
local PostService = require(game.ReplicatedStorage.PostService.PostService)

PostService.start()

local Server = PostService.get() -- If it's used in a Local Script, it would return the Server methods instead.
```

#### Creating your first Remote Connection:

Now, in order to setup your first remote connection, you will want to use the `.add` method.
Method arguments:
`Server.add(MethodName,function)` -- Does not return.


```lua
Server.add("TestArgument",function(player,argument1,argument2,...)
	print(argument1)
	print(argument2)
	print(...)
end)
-- Client method:
Client.add("TestArgument",function(argument1,argument2,...) -- Client does NOT get a player.
	print(argument1)
	print(argument2)
	print(...)
end)
```

**Note:** The Client method takes the same arguments as the Server, it just does not get a player instance passed as the first argument.

#### Firing Connections:

Now, in order to fire a method to the server or client and vice versa, you'll want to use the `.fire` method.
Method arguments:
`Server.fire(player(s),MethodName,...)` -- Does not return.

```lua
Server.fire(game.Players.Player1,"TestArgument","argument 1","argument 2","argument 3","etc")
Server.fire({game.Players.Player1,game.Players.Player2},"TestArgument","argument 1","argument 2","argument 3","etc")
-- Client method:
Client.fire("TestArgument","argument 1","argument 2","argument 3","etc")
```

**Note:** If you are firing multiple users at once from the server, please put their player instances in a table.

#### Fetching Data from Connections:

If you wish to get the return value from a pre-defined method, you can use the `.get` method.
Method arguments:
`Server.get(player,methodName,...)` -- Returns value sent by client.

```lua
-- Client setup:
Client.add("TestArgument_Returns",function(...)
	return table.pack(...)
end)
-- Server setup:
Server.add("TestArgument_Returns",function(...)
	return table.pack(...)
end)
-- Server method:
local responseServer = Server.get(game.Players.Player1,"TestArgument_Returns","argument 1","argument 2","argument 3","etc")
-- Client method:
local responseClient = Client.get("TestArgument_Returns","argument 1","argument 2","argument 3","etc")
```

#### Bulk Firing Connections:

Now that you understand how the basics of PostService work, we'll get into one of the core functions of PostService, bulk firing.  Bulk firing allows you to send multiple pieces of Event data at once, with one fire.  This can be done using the `.bulkFire` method.
Method arguments:
`Server.bulkFire(player(s),{ {methodName,...},{methodName2,...},{"etc etc"} }` -- No return value.

```lua
Server.bulkFire(game.Players.Player1,{ {"TestArgument","argument 1","argument 2","argument 3"},{"TestArgument","second argument 1","second argument 2","second argument 3"} })
-- Client method:
Client.bulkFire({ {"TestArgument","argument 1","argument 2","argument 3"},{"TestArgument","second argument 1","second argument 2","second argument 3"} })
```
