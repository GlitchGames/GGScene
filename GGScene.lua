-- Project: GGScene
--
-- Date: November 26, 2012
--
-- Version: 0.1
--
-- File name: GGScene.lua
--
-- Author: Graham Ranson of Glitch Games - www.glitchgames.co.uk
--
-- Update History:
--
-- 0.1 - Initial release
--
-- Comments: 
--
--		GGScene manager is an easy to use scene management class. It has plenty of transitions, 
--		with more that can be added, and is very easy to use.			
--
-- Copyright (C) 2012 Graham Ranson, Glitch Games Ltd.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this 
-- software and associated documentation files (the "Software"), to deal in the Software 
-- without restriction, including without limitation the rights to use, copy, modify, merge, 
-- publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
-- to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or 
-- substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.
--
----------------------------------------------------------------------------------------------------

local GGScene = {}
local GGScene_mt = { __index = GGScene }

GGScene.Transition = {}
GGScene.Transition.SlideFromRight = "slideFromRight"
GGScene.Transition.SlideFromLeft = "slideFromLeft"
GGScene.Transition.SlideFromTop = "slideFromTop"
GGScene.Transition.SlideFromBottom = "slideFromBottom"
GGScene.Transition.SlideToRight = "slideToRight"
GGScene.Transition.SlideToLeft = "slideToLeft"
GGScene.Transition.SlideToTop = "slideToTop"
GGScene.Transition.SlideToBottom = "slideToBottom"
GGScene.Transition.Fade = "fade"
GGScene.Transition.Crossfade = "crossFade"
GGScene.Transition.OverFromRight = "overFromRight"
GGScene.Transition.OverFromLeft = "overFromLeft"
GGScene.Transition.OverFromTop = "overFromTop"
GGScene.Transition.OverFromBottom = "overFromBottom"
GGScene.Transition.ZoomOutIn = "zoomOutIn"
GGScene.Transition.ZoomInOut = "zoomInOut"
GGScene.Transition.ZoomInOutFade = "zoomInOutFade"
GGScene.Transition.ZoomOutInFade = "zoomOutInFade"
GGScene.Transition.ZoomOutInRotate = "zoomOutInRotate"
GGScene.Transition.ZoomInOutRotate = "zoomInOutRotate"
GGScene.Transition.ZoomInOutFadeRotate = "zoomInOutFadeRotate"
GGScene.Transition.ZoomOutInFadeRotate = "zoomOutInFadeRotate"
GGScene.Transition.Dissolve = "dissolve"
GGScene.Transition.MosaicFlip = "mosaicFlip"
GGScene.Transition.MosaicFlipUp = "mosaicFlipUp"
GGScene.Transition.MosaicScale = "mosaicScale"
GGScene.Transition.Flip = "flip"
GGScene.Transition.FlipUp = "flipUp"

local random = math.random

--- Creates a new GGScene object.
-- @return The new object.
function GGScene:new( defaultTime, defaultEasing )
    
    local self = {}
    
    setmetatable( self, GGScene_mt )
  
  	self.currentSceneName = nil
   	self.currentScene = nil
   	
   	self.previousSceneName = nil
   	self.previousEffect = nil
   	
   	self.defaultTime = defaultTime or 500
   	self.defaultEasing = defaultEasing or easing.inOutQuad
   	
   	self.popups = {}
   	 
   	self.view = display.newGroup()
   	
   	Runtime:addEventListener( "enterFrame", self )
   	
    return self
    
end

function GGScene:enableDebug()
	self.debugEnabled = true
end

function GGScene:disableDebug()
	self.debugEnabled = false
end

function GGScene:isDebugEnabled()
	return self.debugEnabled
end

function GGScene:printOutTranstionTypes()
	for k, v in pairs( GGScene.Transition ) do
		print( v )
	end
end

--- Gets the opposite version of an effect, used for going back to the previous scene. I don't really like this as it isn't flexible but it'll have to do for now.
-- @param effect A string with the name of the effect. Must be a GGScene.Transition or equivalent string.
-- @return The flipped effect.
function GGScene:flipTransition( effect )

	if effect == GGScene.Transition.SlideFromRight then
		effect = GGScene.Transition.SlideFromLeft
	elseif effect == GGScene.Transition.SlideFromLeft then
		effect = GGScene.Transition.SlideFromRight
	elseif effect == GGScene.Transition.SlideFromTop then
		effect = GGScene.Transition.SlideFromBottom
	elseif effect == GGScene.Transition.SlideFromBottom then
		effect = GGScene.Transition.SlideFromTop
	elseif effect == GGScene.Transition.OverFromRight then
		effect = GGScene.Transition.OverFromLeft
	elseif effect == GGScene.Transition.OverFromLeft then
		effect = GGScene.Transition.OverFromRight
	elseif effect == GGScene.Transition.OverFromTop then
		effect = GGScene.Transition.OverFromBottom
	elseif effect == GGScene.Transition.OverFromBottom then
		effect = GGScene.Transition.OverFromTop
	elseif effect == GGScene.Transition.Fade then
		effect = GGScene.Transition.Fade	
	elseif effect == GGScene.Transition.Crossfade then
		effect = GGScene.Transition.Crossfade	
	elseif effect == GGScene.Transition.ZoomOutIn then
		effect = GGScene.Transition.ZoomOutIn
	elseif effect == GGScene.Transition.ZoomInOut then
		effect = GGScene.Transition.ZoomInOut
	elseif effect == GGScene.Transition.ZoomOutInFade then
		effect = GGScene.Transition.ZoomOutInFade
	elseif effect == GGScene.Transition.ZoomInOutFade then
		effect = GGScene.Transition.ZoomInOutFade
	elseif effect == GGScene.Transition.ZoomOutInRotate then
		effect = GGScene.Transition.ZoomOutInRotate
	elseif effect == GGScene.Transition.ZoomInOutRotate then
		effect = GGScene.Transition.ZoomInOutRotate
	elseif effect == GGScene.Transition.ZoomInOutFadeRotate then
		effect = GGScene.Transition.ZoomInOutFadeRotate
	elseif effect == GGScene.Transition.ZoomOutInFadeRotate then
		effect = GGScene.Transition.ZoomOutInFadeRotate		
	elseif effect == GGScene.Transition.Flip then
		effect = GGScene.Transition.Flip
	elseif effect == GGScene.Transition.FlipUp then
		effect = GGScene.Transition.FlipUp
	elseif effect == GGScene.Transition.Dissolve then
		effect = GGScene.Transition.Dissolve
	elseif effect == GGScene.Transition.MosaicFlip then
		effect = GGScene.Transition.MosaicFlip
	elseif effect == GGScene.Transition.MosaicFlipUp then
		effect = GGScene.Transition.MosaicFlipUp
	elseif effect == GGScene.Transition.MosaicScale then
		effect = GGScene.Transition.MosaicScale
	end
	
	return effect
	
end

--- Loads the previous scene.
-- @param data Optional data to pass onto the new scene upon initiation.
function GGScene:gotoPreviousScene( data )
	if self.previousSceneName then
		if self.previousEffect then
			self:gotoScene( self.previousSceneName, self:flipTransition( self.previousEffect ), data )
		else
			self:gotoScene( self.previousSceneName, nil, data )
		end
	end
end

--- Performs a scene change transition.
-- @param effect A string with the name of the effect. Must be a GGScene.Transition or equivalent string.
-- @param nextScene The next scene object to transition to.
-- @param currentScene The current scene object to transition from.
-- @param onComplete Optional function to be called when the transition is completed.
-- @param time Time for the transition. Optional, if left out then defaultTime will be used.
-- @param easing Easing for the transition. Optional, if left out then defaultEasing will be used.
function GGScene:doTransition( effect, nextScene, currentScene, onComplete, time, easing )

	local transitions = {}
	local timers = {}
	
	local transitionFinished = function()
	
		for i = 1, #transitions, 1 do
			if transitions[ i ] then
				transition.cancel( transitions[ i ] )
			end
			transitions [ i ] = nil
		end
		transitions = nil
		
		for i = 1, #timers, 1 do
			if timers[ i ] then
				timer.cancel( timers[ i ] )
			end
			timers [ i ] = nil
		end
		timers = nil
		
		if onComplete then
			onComplete()
		end
		
	end
	
	local t = { time = time or self.defaultTime, x = nextScene.view.x, y = nextScene.view.y, transition = easing or self.defaultEasing }

	if effect == GGScene.Transition.SlideFromRight then
	
		t.x = display.contentWidth
		
		if not currentScene then
			t.onComplete = transitionFinished
		end
		
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
		
		if currentScene then
			t.x = -display.contentWidth
			t.onComplete = transitionFinished
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
	elseif effect == GGScene.Transition.SlideFromLeft then
		
		t.x = -display.contentWidth
		
		if not currentScene then
			t.onComplete = transitionFinished
		end
		
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
		
		if currentScene then
			t.x = display.contentWidth
			t.onComplete = transitionFinished
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
	elseif effect == GGScene.Transition.SlideFromTop then
		
		t.y = -display.contentHeight
	
		if not currentScene then
			t.onComplete = transitionFinished
		end
		
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
		
		if currentScene then
			t.y = display.contentHeight
			t.onComplete = transitionFinished
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
	elseif effect == GGScene.Transition.SlideFromBottom then
		
		t.y = display.contentHeight
	
		if not currentScene then
			t.onComplete = transitionFinished
		end
		
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
		
		if currentScene then
			t.y = -display.contentHeight
			t.onComplete = transitionFinished
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
	
	elseif effect == GGScene.Transition.SlideToRight then
	
		t.x = display.contentWidth
		t.onComplete = transitionFinished
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )
	
	elseif effect == GGScene.Transition.SlideToLeft then
	
		t.x = -display.contentWidth
		t.onComplete = transitionFinished
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )

	elseif effect == GGScene.Transition.SlideToTop then
	
		t.y = -display.contentHeight
		t.onComplete = transitionFinished
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )
	
	elseif effect == GGScene.Transition.SlideToBottom then
	
		t.y = display.contentHeight
		t.onComplete = transitionFinished
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )
			
	elseif effect == GGScene.Transition.OverFromRight then
	
		t.x = display.contentWidth
		t.onComplete = transitionFinished
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
	
	elseif effect == GGScene.Transition.OverFromLeft then
	
		t.x = -display.contentWidth
		t.onComplete = transitionFinished
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
					
	elseif effect == GGScene.Transition.OverFromTop then
	
		t.y = -display.contentHeight
		t.onComplete = transitionFinished
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
	
	elseif effect == GGScene.Transition.OverFromBottom then
	
		t.y = display.contentHeight
		t.onComplete = transitionFinished
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
	
	elseif effect == GGScene.Transition.Fade then
	
		nextScene.view.alpha = 0
		
		if currentScene then
			t.alpha = 0
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
		t.alpha = 1
		
		if currentScene then
			t.delay = t.time
		end
		 
		t.onComplete = transitionFinished
	
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )
		
	elseif effect == GGScene.Transition.Crossfade then
	
		t.alpha = 0
		t.onComplete = transitionFinished
		
		transitions[ #transitions + 1 ] = transition.from( nextScene.view, t )
		
	elseif effect == GGScene.Transition.ZoomOutIn then
	
		nextScene.view.xScale = 0.001
		nextScene.view.yScale = 0.001
		nextScene.view.x = display.contentCenterX
		nextScene.view.y = display.contentCenterY
		
		if currentScene then
			t.xScale = 0.001
			t.yScale = 0.001
			t.x = display.contentCenterX
			t.y = display.contentCenterY
			
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
		if currentScene then	
			t.delay = t.time
		end
		
		t.xScale = 1
		t.yScale = 1
		t.x = 0
		t.y = 0
		t.onComplete = transitionFinished
		
		if currentScene then
			currentScene.view:toBack()
		end
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )	
	
	elseif effect == GGScene.Transition.ZoomInOut then
		
		nextScene.view.alpha = 0
		nextScene.view.xScale = 2
		nextScene.view.yScale = 2
		nextScene.view.x = -display.contentCenterX
		nextScene.view.y = -display.contentCenterY
		
		if currentScene then
			t.xScale = 2
			t.yScale = 2
			t.x = -display.contentCenterX
			t.y = -display.contentCenterY
			
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
		if currentScene then		
			t.delay = t.time
		end
		
		t.xScale = 1
		t.yScale = 1
		t.x = 0
		t.y = 0
		t.onComplete = transitionFinished
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, { alpha = 1, time = 1, delay = t.delay } )	
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )	
	
	elseif effect == GGScene.Transition.ZoomOutInFade then
	
		nextScene.view.alpha = 0
		nextScene.view.xScale = 0.001
		nextScene.view.yScale = 0.001
		nextScene.view.x = display.contentCenterX
		nextScene.view.y = display.contentCenterY
		
		if currentScene then
			t.xScale = 0.001
			t.yScale = 0.001
			t.alpha = 0
			t.x = display.contentCenterX
			t.y = display.contentCenterY
			
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
		if currentScene then
			t.delay = t.time
		end
		
		t.xScale = 1
		t.yScale = 1
		t.alpha = 1
		t.x = 0
		t.y = 0
		t.onComplete = transitionFinished
		
		if currentScene then
			currentScene.view:toBack()
		end
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )	
	
	elseif effect == GGScene.Transition.ZoomInOutFade then
		
		nextScene.view.alpha = 0
		nextScene.view.xScale = 2
		nextScene.view.yScale = 2
		nextScene.view.x = -display.contentCenterX
		nextScene.view.y = -display.contentCenterY
		
		if currentScene then
			t.alpha = 0
			t.xScale = 2
			t.yScale = 2
			t.x = -display.contentCenterX
			t.y = -display.contentCenterY
			
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
		if currentScene then	
			t.delay = t.time
		end
		
		t.xScale = 1
		t.yScale = 1
		t.x = 0
		t.y = 0
		t.alpha = 1
		t.onComplete = transitionFinished
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )	
			
	elseif effect == GGScene.Transition.Flip then
	
		nextScene.view.xScale = 0.001
		currentScene.view:toFront()
		
		if currentScene then
			t.xScale = 0.001
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		
			t.x = display.contentCenterX
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
		t.xScale = 1
		nextScene.view.x = t.x
		t.x = 0
		
		if currentScene then
			t.delay = t.time
		end
		
		t.onComplete = transitionFinished
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )
		timers[ #timers + 1 ] = timer.performWithDelay( t.delay, function() nextScene.view:toFront() end, 1 )
						
	elseif effect == GGScene.Transition.FlipUp then
	
		nextScene.view.yScale = 0.001
		currentScene.view:toFront()
		
		if currentScene then
			t.yScale = 0.001
		
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		
			t.y = display.contentCenterY
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )	
		end
		
		t.yScale = 1
		nextScene.view.y = t.y
		t.y = 0
		
		if currentScene then
			t.delay = t.time
		end
		
		t.onComplete = transitionFinished
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )
		timers[ #timers + 1 ] = timer.performWithDelay( t.delay, function() nextScene.view:toFront() end, 1 )
				
	elseif effect == GGScene.Transition.ZoomOutInRotate then
	
		nextScene.view.xScale = 0.001
		nextScene.view.yScale = 0.001
		nextScene.view.x = display.contentCenterX
		nextScene.view.y = display.contentCenterY
		
		if currentScene then
			t.xScale = 0.001
			t.yScale = 0.001
			t.rotation = -360
			t.x = display.contentCenterX
			t.y = display.contentCenterY
			
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
		if currentScene then
			t.delay = t.time
		end
		
		t.xScale = 1
		t.yScale = 1
		t.rotation = 360
		t.x = 0
		t.y = 0
		t.onComplete = transitionFinished
		
		if currentScene then
			currentScene.view:toBack()
		end
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )	
							
	elseif effect == GGScene.Transition.ZoomInOutRotate then
	
		nextScene.view.xScale = 0.001
		nextScene.view.yScale = 0.001
		nextScene.view.x = display.contentCenterX
		nextScene.view.y = display.contentCenterY
		
		if currentScene then
			t.rotation = -360
			t.x = display.contentCenterX
			t.y = display.contentCenterY
			
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, { alpha = 0, time = 1, delay = t.time } )
		end
		
		if currentScene then			
			t.delay = t.time
		end
		
		t.rotation = 360
		t.x = 0
		t.y = 0
		t.onComplete = transitionFinished
		
		if currentScene then
			currentScene.view:toBack()
		end
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, { xScale = 1, yScale = 1, time = 1, delay = t.delay } )
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )	
	
	elseif effect == GGScene.Transition.ZoomOutInFadeRotate then
		
		nextScene.view.alpha = 0
		nextScene.view.xScale = 0.001
		nextScene.view.yScale = 0.001
		nextScene.view.x = display.contentCenterX
		nextScene.view.y = display.contentCenterY
		
		if currentScene then
			t.xScale = 0.001
			t.yScale = 0.001
			t.rotation = -360
			t.alpha = 0
			t.x = display.contentCenterX
			t.y = display.contentCenterY
			
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
		end
		
		if currentScene then
			t.delay = t.time
		end
		
		t.xScale = 1
		t.yScale = 1
		t.rotation = 360
		t.alpha = 1
		t.x = 0
		t.y = 0
		t.onComplete = transitionFinished
		
		if currentScene then
			currentScene.view:toBack()
		end
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )				
	
	elseif effect == GGScene.Transition.ZoomInOutFadeRotate then
		
		nextScene.view.alpha = 0
		nextScene.view.xScale = 0.001
		nextScene.view.yScale = 0.001
		nextScene.view.x = display.contentCenterX
		nextScene.view.y = display.contentCenterY
		
		if currentScene then
			t.rotation = -360
			t.alpha = 0
			t.x = display.contentCenterX
			t.y = display.contentCenterY
			
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, t )
			transitions[ #transitions + 1 ] = transition.to( currentScene.view, { alpha = 0, time = 1, delay = t.time } )
		end
		
		if currentScene then
			t.delay = t.time
		end
		
		t.rotation = 360
		t.alpha = 1
		t.x = 0
		t.y = 0
		t.onComplete = transitionFinished
		
		if currentScene then
			currentScene.view:toBack()
		end
		
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, { xScale = 1, yScale = 1, time = 1, delay = t.delay } )
		transitions[ #transitions + 1 ] = transition.to( nextScene.view, t )	
	
	elseif effect == GGScene.Transition.Dissolve or effect == GGScene.Transition.MosaicFlip or effect == GGScene.Transition.MosaicFlipUp or effect == GGScene.Transition.MosaicScale then
		
		local nextScenePath = os.time() .. ".jpg"
		local currentScenePath = os.time() + math.random( 1 ) .. ".jpg"
		
		display.save( nextScene.view, nextScenePath, system.TemporaryDirectory )
		nextScene.view.alpha = 0
		
		if currentScene then
			display.save( currentScene.view, currentScenePath, system.TemporaryDirectory )
			currentScene.view.alpha = 0
		end
		
		local rows = 15
		local columns = 10
		
		local options =
		{
			width = display.pixelWidth / columns,
			height = display.pixelHeight / rows,
			numFrames = rows * columns,
			sourceWidth = display.pixelWidth / columns,
			sourceHeight = display.pixelHeight / rows
		}
	
		local nextSceneSheet = graphics.newImageSheet( nextScenePath, system.TemporaryDirectory, options )
		local currentSceneSheet = graphics.newImageSheet( currentScenePath, system.TemporaryDirectory, options )
		
		os.remove( system.pathForFile( nextScenePath, system.TemporaryDirectory ) ) 
		os.remove( system.pathForFile( currentScenePath, system.TemporaryDirectory ) ) 
		
		local nextSceneTiles = {}
		local currentSceneTiles = {}
		local nextSceneTileGroup = display.newGroup()
		local currentSceneTileGroup = display.newGroup()
	
		nextSceneTileGroup.xScale = display.contentScaleX
		nextSceneTileGroup.yScale = display.contentScaleY
		
		currentSceneTileGroup.xScale = display.contentScaleX
		currentSceneTileGroup.yScale = display.contentScaleY
		
		local i = 1
		for row = 1, rows, 1 do
			for column = 1, columns, 1 do
				
				nextSceneTiles[ i ] = display.newImageRect( nextSceneTileGroup, nextSceneSheet, i, options.width, options.height )
				
				local x = column * options.width - ( options.width * 0.5 )
				local y = row * options.height - ( options.height * 0.5 )
				
				nextSceneTiles[ i ].x = x
				nextSceneTiles[ i ].y = y
				
				if currentSceneSheet then
					currentSceneTiles[ i ] = display.newImageRect( currentSceneTileGroup, currentSceneSheet, i, options.width, options.height )
					currentSceneTiles[ i ].x = x
					currentSceneTiles[ i ].y = y
				end
				
				i = i + 1
				
			end
		end
	
		local flippedTiles = {}
		local flippedTileCount = 0
		
		t.x = nil
		t.y = nil
		
		while flippedTileCount < options.numFrames do
			
			local index = random( 1, options.numFrames )
			
			if not flippedTiles[ "tile" .. index ] then
			
				flippedTileCount = flippedTileCount + 1
				flippedTiles[ "tile" .. index ] = true
				
				local onComplete = function()
							
					nextScene.view.alpha = 1
					
					if currentScene then 
						currentScene.view.alpha = 0
					end
					
					display.remove( nextSceneTileGroup )
					nextSceneTileGroup = nil
					
					display.remove( currentSceneTileGroup )
					currentSceneTileGroup = nil
					
					transitionFinished()
					
				end
				
				if effect == GGScene.Transition.Dissolve then
					
					nextSceneTiles[ index ].alpha = 0
					if currentSceneTiles[ index ] then
						currentSceneTiles[ index ].alpha = 0
					end
					
					t.alpha = 1
					
					t.delay = random( 1, t.time )
				
					if flippedTileCount == options.numFrames then
						t.delay = t.time
					end
					
					if currentSceneTiles[ index ] then
						transitions[ #transitions + 1 ] = transition.from( currentSceneTiles[ index ], t )
					end
					
					if flippedTileCount == options.numFrames then
						t.onComplete = onComplete
					end
					
					t.alpha = 1
					transitions[ #transitions + 1 ] = transition.to( nextSceneTiles[ index ], t )
								
				elseif effect == GGScene.Transition.MosaicFlip or GGScene.Transition.MosaicFlipUp or effect == GGScene.Transition.MosaicScale then
				
					if effect == GGScene.Transition.MosaicFlip then
						t.xScale = 0.001
					elseif effect == GGScene.Transition.MosaicFlipUp then
						t.yScale = 0.001
					elseif effect == GGScene.Transition.MosaicScale then
					
						local horizontal = random( 1, 100 ) > 50
						
						if horizontal then
							t.xScale = 0.001
						else
							t.yScale = 0.001
						end
						
					end
					
					t.delay = random( 1, t.time * 0.5 )
					
					transitions[ #transitions + 1 ] = transition.to( currentSceneTiles[ index ], t )
					
					t.delay = random( t.time * 0.5, t.time )
					
					if flippedTileCount == options.numFrames then
						t.delay = t.time
					end
					
					if flippedTileCount == options.numFrames then
						t.onComplete = onComplete
					end
					
					transitions[ #transitions + 1 ] = transition.from( nextSceneTiles[ index ], t )
					
				end
				
			end
			
		end
		
	
	end
		
end

--- Loads a new scene.
-- @param name The name of the scene file.
-- @param effect A string with the name of the effect. Must be a GGScene.Transition or equivalent string.
-- @param time Time for the transition. Optional, if left out then defaultTime will be used.
-- @param easing Easing for the transition. Optional, if left out then defaultEasing will be used.
-- @param data Optional data to pass onto the new scene upon initiation.
function GGScene:gotoScene( name, effect, time, easing, data )
	
	if self.currentSceneName and self.currentSceneName == name then
	--	return
	end
	
	-- Only allow transitions if another isn't already happening
	if self.currentScene and not self.currentScene.isReady then
		return
	end
	
	self.previousSceneName = self:getCurrentSceneName()
	self.previousEffect = effect
	
	local scene = self:createScene( name )
		
	if scene then
	
		local previousScene = self.currentScene
		
		self:loadScene( scene )
		
		if effect then
		
			local onComplete = function( event )
								
				self:destroyScene( previousScene )
				
				self:readyScene( scene )
				
			end
			
			self:doTransition( effect, scene, previousScene, onComplete, time, easing )
			
		else

			self:destroyScene( previousScene )
			
			self:readyScene( scene )
			
		end
	
		self.currentScene = scene
		self.currentSceneName = name
		
	end
		
end

--- Loads a new scene as a popup, i.e. it doesn't close the current scene.
-- @param name The name of the scene file.
-- @param effect A string with the name of the effect. Must be a GGScene.Transition or equivalent string.
-- @param time Time for the transition. Optional, if left out then defaultTime will be used.
-- @param easing Easing for the transition. Optional, if left out then defaultEasing will be used.
-- @param data Optional data to pass onto the new scene upon initiation.
function GGScene:loadPopup( name, effect, time, easing, data )
	
	if not self.popups[ name ] then
		
		local popup = self:createScene( name )
			
		if popup then
			
			self:loadScene( popup )
			
			self.popups[ name ] = popup
			
			if effect then
			
				local onComplete = function( event )
					self:readyScene( popup )
				end
			
				self:doTransition( effect, popup, nil, onComplete, time, easing, data )
				
			end
			
			
		end
	
	end
		
end

--- Closes a popup.
-- @param name The name of the scene file.
-- @param effect A string with the name of the effect. Must be a GGScene.Transition or equivalent string.
-- @param onClose Optional function to call when the close is done.
function GGScene:closePopup( name, effect, onClose )

	if self.popups[ name ] then
		
		local onComplete = function( event )
		
			self:destroyScene( self.popups[ name ] )
			self.popups[ name ] = nil		
			
			if onClose then
				onClose()
			end
			
		end
		
		if effect then
			self:doTransition( effect, self.popups[ name ], nil, onComplete )
		else
			onComplete()
		end
			
	end
				
end

--- Closes all open popups.
-- @param effect A string with the name of the effect. Must be a GGScene.Transition or equivalent string.
function GGScene:closeAllPopups( effect )
	for k, v in pairs( self.popups ) do
		self:closePopup( k, effect )
	end
end

--- Gets the name of the current scene.
-- @return The name of the scene.
function GGScene:getCurrentSceneName()
	return self.currentSceneName
end

--- Gets the name of the previous scene.
-- @return The name of the scene.
function GGScene:getPreviousSceneName()
	return self.previousSceneName
end

--- Creates a scene. Called internally.
-- @param name The name of the scene to create.
function GGScene:createScene( name )
	
	if name then
		
		local sceneClass = require( name )
		
		if sceneClass then
		
			local scene = sceneClass:new()
			
			scene.view = display.newGroup()

			scene.sceneManager = self
			scene.name = name
			
			if scene then
				if scene[ "onCreate" ] then
					scene:onCreate( data )
				end
				self:displayInformation( "onCreate()" .. " - " .. scene.name )
			end
			
			self.view:insert( scene.view )
		
			return scene
			
		else
			self:displayError( "Scene not loaded: " .. name )
		end
		
	end

end

--- Loads a scene. Called internally.
-- @param scene The scene to load.
function GGScene:loadScene( scene )
	if scene then
		if scene[ "onLoad" ] then
			scene:onLoad()
		end
		self:displayInformation( "onLoad()" .. " - " .. scene.name )
	end
end

--- Readys a scene. Called internally.
-- @param scene The scene to ready.
function GGScene:readyScene( scene )
	if scene then
		scene.isReady = true
		if scene[ "onReady" ] then
			scene:onReady()
		end
		self:displayInformation( "onReady()" .. " - " .. scene.name )
	end
end

--- Destroys a scene. Called internally.
-- @param scene The scene to destroy.
function GGScene:destroyScene( scene )

	if scene then
	
		if scene[ "onDestroy" ] then
			scene:onDestroy()
		end
		
		self:displayInformation( "onDestroy()" .. " - " .. scene.name )
		
		if scene.view then
			display.remove( scene.view )
		end
		
		if package.loaded[ scene.name ] then
			package.loaded[ scene.name ] = nil
		end
		
		if _G[ scene.name ] then
			_G[ scene.name ] = nil
		end
		
		scene.view = nil
		scene.sceneManager = nil
		scene.name = nil
		
		for k, v in pairs( scene ) do
			 scene[ k ] = nil
		end
		
		scene = nil
		
	end
	
end

--- Prints out an error message to the console. Only if debug mode is enabled.
-- @param args The text values to display.
function GGScene:displayError( ... )
	if self:isDebugEnabled() then
		print( "GGScene Error: " .. ( ... or "" ) )
	end
end

--- Prints out an information message to the console. Only if debug mode is enabled.
-- @param message The message to display.
function GGScene:displayInformation( message )
	if self:isDebugEnabled() then
		print( "GGScene:" .. message )
	end
end

--- Updates the current scene.
function GGScene:enterFrame( event )
	if self.currentScene and self.currentScene.isReady and self.currentScene[ "onUpdate" ] then
		self.currentScene:onUpdate( event )
	end
	for k, v in pairs( self.popups ) do
		if v and v.isReady and v[ "onUpdate" ] then
			v:onUpdate( event )
		end
	end
end

--- Destroys this GGScene object.
function GGScene:destroy()
	
	Runtime:removeEventListener( "enterFrame", self )
	
	self:closeAllPopups()
	
	if self.currentScene then
		if self.currentScene[ "onDestroy" ] then
			self.currentScene:onDestroy()	
		end
		self:destroyScene( self.currentScene )
	end
				
	self.currentSceneName = nil
   	self.currentScene = nil
   	
   	self.previousSceneName = nil
   	self.previousEffect = nil
   	
   	self.defaultTime = nil
   	self.defaultEasing = nil
   	
   	self.popups = nil
   	
   	display.remove( self.view )
   	self.view = nil
   	
end

return GGScene