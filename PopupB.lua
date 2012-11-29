local PopupB = {}
local PopupB_mt = { __index = PopupB }

local widget = require( "widget" )

--- Called when the scene is first initialised.
function PopupB:new()
    
    local self = {}
    
    setmetatable( self, PopupB_mt )
    
    return self
    
end

--- Called when the scene is first created.
-- @param data Optional data to pass on to the scene.
function PopupB:onCreate( data )	

	local back = display.newRect( 0, 0, 200, 200 )
	back.x = display.contentCenterX 
	back.y = display.contentCenterY + 130
	back:setFillColor( 0, 255, 255 )
	self.view:insert( back )

	local text = display.newText( "Popup B", 0, 0, "Helvetica", 30 )
	text.x = back.x
	text.y = back.y - back.contentHeight * 0.5 + text.contentHeight
	text:setTextColor( 0, 0, 0 )
	self.view:insert( text )
	
	local onButtonEvent = function( event )
		if event.phase == "release" then
        	self.sceneManager:closePopup( self.name )
    	end
    	return true
	end
	
	local closeButton = widget.newButton
	{
		id = "close",
		label = "Close",
		width = 150, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	closeButton.x = back.x
	closeButton.y = back.y + back.contentHeight * 0.5 - closeButton.contentHeight
	
	self.view:insert( closeButton )
	
end

--- Called in the enterFrame event.
function PopupB:onUpdate( event )

end

--- Called when the scene is about to get loaded.
function PopupB:onLoad()

end

--- Called when the scene is about to get unloaded.
function PopupB:onUnload()

end

--- Called when the scene is ready, i.e. fully loaded and on the screen.
function PopupB:onReady()

end

--- Called when the scene is about to get destroyed.
function PopupB:onDestroy()

end

return PopupB