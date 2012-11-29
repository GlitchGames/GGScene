local SceneA = {}
local SceneA_mt = { __index = SceneA }

local widget = require( "widget" )

--- Called when the scene is first initialised.
function SceneA:new()
    
    local self = {}
    
    setmetatable( self, SceneA_mt )

    return self
    
end

--- Called when the scene is first created.
-- @param data Optional data to pass on to the scene.
function SceneA:onCreate( data )	

	local back = display.newRect( 0, 0, 320, 480 )
	back:setFillColor( 255, 0, 0 )   			
	self.view:insert( back )

	local onButtonEvent = function( event )
		if event.phase == "release" then
        	self.sceneManager:gotoScene( "SceneB", event.target.id )
    	end
	end
	
	local slideFromRightButton = widget.newButton
	{
		id = "slideFromRight",
		left = 5,
		top = 5,
		label = "Slide From Right",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( slideFromRightButton )

	local slideFromLeftButton = widget.newButton
	{
		id = "slideFromLeft",
		left = 165,
		top = 5,
		label = "Slide From Left",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( slideFromLeftButton )
	
	local slideFromTopButton = widget.newButton
	{
		id = "slideFromTop",
		left = 5,
		top = 45,
		label = "Slide From Top",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( slideFromTopButton )
	
	local slideFromBottomButton = widget.newButton
	{
		id = "slideFromBottom",
		left = 165,
		top = 45,
		label = "Slide From Bottom",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( slideFromBottomButton )
	
	local overFromRightButton = widget.newButton
	{
		id = "overFromRight",
		left = 5,
		top = 85,
		label = "Over From Right",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( overFromRightButton )

	local overFromLeftButton = widget.newButton
	{
		id = "overFromLeft",
		left = 165,
		top = 85,
		label = "Over From Left",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( overFromLeftButton )
	
	local overFromTopButton = widget.newButton
	{
		id = "overFromTop",
		left = 5,
		top = 125,
		label = "Over From Top",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( overFromTopButton )
	
	local overFromBottomButton = widget.newButton
	{
		id = "overFromBottom",
		left = 165,
		top = 125,
		label = "Over From Bottom",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( overFromBottomButton )
	
	local zoomOutInButton = widget.newButton
	{
		id = "zoomOutIn",
		left = 5,
		top = 165,
		label = "Zoom Out In",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( zoomOutInButton )
	
	local zoomInOutButton = widget.newButton
	{
		id = "zoomInOut",
		left = 165,
		top = 165,
		label = "Zoom In Out",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( zoomInOutButton )
	
	local zoomOutInFadeButton = widget.newButton
	{
		id = "zoomOutInFade",
		left = 5,
		top = 205,
		label = "Zoom Out In Fade",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( zoomOutInFadeButton )

	local zoomInOutFadeButton = widget.newButton
	{
		id = "zoomInOutFade",
		left = 165,
		top = 205,
		label = "Zoom In Out Fade",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( zoomInOutFadeButton )

	local crossFadeButton = widget.newButton
	{
		id = "crossFade",
		left = 5,
		top = 245,
		label = "Cross Fade",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( crossFadeButton )
	
	local fadeButton = widget.newButton
	{
		id = "fade",
		left = 165,
		top = 245,
		label = "Fade",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( fadeButton )

	local zoomOutInRotateButton = widget.newButton
	{
		id = "zoomOutInRotate",
		left = 5,
		top = 285,
		label = "Zoom Out In Rotate",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( zoomOutInRotateButton )
	
	local zoomInOutRotateButton = widget.newButton
	{
		id = "zoomInOutRotate",
		left = 165,
		top = 285,
		label = "Zoom In Out Rotate",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( zoomInOutRotateButton )
	
	local zoomOutInFadeRotateButton = widget.newButton
	{
		id = "zoomOutInFadeRotate",
		left = 5,
		top = 325,
		label = "Zoom Out In Fade Rotate",
		width = 150, 
		height = 28,
		fontSize = 11,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( zoomOutInFadeRotateButton )

	local zoomInOutFadeRotateButton = widget.newButton
	{
		id = "zoomInOutFadeRotate",
		left = 165,
		top = 325,
		label = "Zoom In Out Fade Rotate",
		width = 150, 
		height = 28,
		fontSize = 11,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( zoomInOutFadeRotateButton )
	
	local mosaicFlipButton = widget.newButton
	{
		id = "mosaicFlip",
		left = 5,
		top = 365,
		label = "Mosaic Flip",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( mosaicFlipButton )

	local mosaicFlipUpButton = widget.newButton
	{
		id = "mosaicFlipUp",
		left = 165,
		top = 365,
		label = "Mosaic Flip Up",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( mosaicFlipUpButton )
		
	local mosaicScaleButton = widget.newButton
	{
		id = "mosaicScale",
		left = 5,
		top = 405,
		label = "Mosaic Scale",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( mosaicScaleButton )

	local dissolveButton = widget.newButton
	{
		id = "dissolve",
		left = 165,
		top = 405,
		label = "Dissolve",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( dissolveButton )
		
	local flipButton = widget.newButton
	{
		id = "flip",
		left = 5,
		top = 445,
		label = "Flip",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( flipButton )	
	
	local flipUpButton = widget.newButton
	{
		id = "flipUp",
		left = 165,
		top = 445,
		label = "Flip Up",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	self.view:insert( flipUpButton )	
	
end

--- Called in the enterFrame event.
function SceneA:onUpdate( event )

end

--- Called when the scene is about to get loaded.
function SceneA:onLoad()

end

--- Called when the scene is about to get unloaded.
function SceneA:onUnload()

end

--- Called when the scene is ready, i.e. fully loaded and on the screen.
function SceneA:onReady()

end

--- Called when the scene is about to get destroyed.
function SceneA:onDestroy()

end

return SceneA