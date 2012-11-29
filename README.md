GGScene
============

GGScene manager is an easy to use scene management class. It has plenty of transitions, 
with more that can be added, and is very easy to use.

Basic Usage
-------------------------

##### Require the code.
```lua
local GGScene = require( "GGScene" )
```

##### Create your scene manager.
```lua
local sceneManager = GGScene:new()
```

##### Create your scene manager with some default info set, default transition time and default easing.
```lua
local sceneManager = GGScene:new( 500, easing.inOutExpo )
```

##### Change to a new scene without a transition.
```lua
sceneManager:gotoScene( "SceneA" )
```

##### Change to a new scene with a transition using the default time and easing type.
```lua
sceneManager:gotoScene( "SceneB", "slideFromRight" )
```

##### Change to a new scene with a transition and override the default time and easing type.
```lua
sceneManager:gotoScene( "SceneB", "flipUp", 2000, easing.inOutExpo )
```

##### Print out a list of available transition types.
```lua
sceneManager:printOutTranstionTypes()
```

##### Load the previous scene using the reverse effect. If you want more fine-grained control just use the gotoScene function.
```lua
sceneManager:gotoPreviousScene()
```

##### Load a popup.
```lua
sceneManager:loadPopup( "PopupA" )
```

##### Load a popup with a transition. Not all transitions will work for popups yet.
```lua
sceneManager:loadPopup( "PopupB", "slideFromRight" )
```

##### Close a popup.
```lua
sceneManager:closePopup( "PopupA" )
```

##### Enable debug mode for printing of info and errors.
```lua
sceneManager:enableDebug()
```

##### Disable debug mode.
```lua
sceneManager:disableDebug()
```

##### Destroy the scene manager
```lua
sceneManager:destroy()
sceneManager = nil
```

Scene Properties
-------------------------

##### Each Scene has the following properties by default accessible via 'self':
```lua
self.view -- A display group that all your display objects should be inserted into.
self.name -- The name of the scene, i.e. "SceneB.lua" would be named "SceneB".
self.sceneManager -- A reference to the GGScene object, useful for calling other scenes without it having to be a global variable.
self.isReady -- Boolean representing whether the screen is ready, i.e. fully loaded after the transition.
```

Scene Template - "SceneB.lua"
-------------------------

```lua
local SceneB = {}
local SceneB_mt = { __index = SceneB }

--- Called when the scene is first initialised.
function SceneB:new()
    
    local self = {}
    
    setmetatable( self, SceneB_mt )
    
    return self
    
end

--- Called when the scene is first created.
-- @param data Optional data to pass on to the scene.
function SceneB:onCreate( data )	
	
end

--- Called in the enterFrame event.
function SceneB:onUpdate( event )

end

--- Called when the scene is about to get loaded.
function SceneB:onLoad()

end

--- Called when the scene is about to get unloaded.
function SceneB:onUnload()

end

--- Called when the scene is ready, i.e. fully loaded and on the screen.
function SceneB:onReady()

end

--- Called when the scene is about to get destroyed.
function SceneB:onDestroy()

end

return SceneB
```

Update History
-------------------------

##### 0.1
Initial release