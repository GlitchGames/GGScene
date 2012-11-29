local PopupC = {}
local PopupC_mt = { __index = PopupC }

local widget = require( "widget" )

--- Called when the scene is first initialised.
function PopupC:new()
    
    local self = {}
    
    setmetatable( self, PopupC_mt )
    
    return self
    
end

--- Called when the scene is first created.
-- @param data Optional data to pass on to the scene.
function PopupC:onCreate( data )	

	local back = display.newRect( 0, 0, 150, 480 )
	back.x = back.contentWidth * 0.5
	back.y = display.contentCenterY
	back:setFillColor( 0, 255, 255 )
	self.view:insert( back )

	local text = display.newText( "Popup C", 0, 0, "Helvetica", 20 )
	text.x = back.x
	text.y = back.y - back.contentHeight * 0.5 + text.contentHeight
	text:setTextColor( 0, 0, 0 )
	self.view:insert( text )
	
	local onButtonEvent = function( event )
        if event.phase == "release" then
        	self.sceneManager:closePopup( self.name, "slideToLeft" )
        end
        return true
	end
	
	local closeButton = widget.newButton
	{
		id = "close",
		label = "Close",
		width = 130, 
		height = 28,
		cornerRadius = 8,
		onEvent = onButtonEvent
	}
	closeButton.x = back.x
	closeButton.y = back.y + back.contentHeight * 0.5 - closeButton.contentHeight
	
	self.view:insert( closeButton )
	
end

--- Called in the enterFrame event.
function PopupC:onUpdate( event )

end

--- Called when the scene is about to get loaded.
function PopupC:onLoad()

end

--- Called when the scene is about to get unloaded.
function PopupC:onUnload()

end

--- Called when the scene is ready, i.e. fully loaded and on the screen.
function PopupC:onReady()

end

--- Called when the scene is about to get destroyed.
function PopupC:onDestroy()

end

return PopupC