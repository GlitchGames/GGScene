local SceneB = {}
local SceneB_mt = { __index = SceneB }

local widget = require( "widget" )

--- Called when the scene is first initialised.
function SceneB:new()
    
    local self = {}
    
    setmetatable( self, SceneB_mt )
    
    return self
    
end

--- Called when the scene is first created.
-- @param data Optional data to pass on to the scene.
function SceneB:onCreate( data )	

	local back = display.newImage( "glitch.png" )
	self.view:insert( back )

	local onButtonEvent = function( event )
		if event.phase == "release" then
        	self.sceneManager:gotoPreviousScene() --gotoScene( "SceneA", "slideFromLeft" ) --gotoPreviousScene() --
    	end
	end
	
	local backButton = widget.newButton
	{
		id = "back",
		label = "Back",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	backButton.x = back.x
	backButton.y = back.y + back.contentHeight * 0.5 - backButton.contentHeight * 0.7
	self.view:insert( backButton )
	
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