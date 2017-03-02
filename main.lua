-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
display.setStatusBar( display.HiddenStatusBar )

local jogador
local neutro
local fiscal
local GameLoopTimer
 _W = display.contentWidth -- Get the width of the screen
 _H = display.contentHeight -- Get the height of the screen
 motiony = 0
 motionx = 0 -- Variable used to move character along x axis
 speed = 2 -- Set Walking Speed

local backGroup = display.newGroup()  -- Display group for the background image
local mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
local uiGroup = display.newGroup()

local background = display.newImageRect (backGroup, "background.jpg", 1400, 800)
background.x = display.contentCenterX
background.y = display.contentCenterY

jogador = display.newImageRect (mainGroup, "JogadorSprite.png", 32, 32)
jogador.x = _W - 50
jogador.y = display.contentHeight - 200
physics.addBody (jogador,"dynamic", {radius = 10})
jogador.myName = "jogador"

neutro = display.newImageRect (mainGroup, "NeutroSprite.png", 32, 32)
neutro.x = display.contentCenterX
neutro.y = display.contentCenterY
physics.addBody (neutro, "static", {radius = 10})
neutro.myName = "neutro"

fiscal = display.newImageRect (mainGroup, "Fiscal.png", 64, 64)
fiscal.x = display.contentCenterX
fiscal.y = display.contentHeight - 50
physics.addBody( fiscal, { radius=15, isSensor=true } )
fiscal.myName = "fiscal"
-- Buttons for controls

local left = display.newImageRect (uiGroup,"SetaEsquerda.png", 32, 32)
left.x = _W - 80
left.y = 270
local right = display.newImageRect (uiGroup,"SetaDireita.png", 32, 32)
right.x = _W - 30
right.y = 270
local up = display.newImageRect (uiGroup,"SetaCima.png", 32, 32)
up.x = _W - 55
up.y = 240
local down = display.newImageRect (uiGroup,"SetaBaixo.png", 32, 32)
down.x = _W - 55
down.y = 300

function left:touch()
  motionx = -speed;
end
left:addEventListener("touch",left)

function right:touch()
  motionx = speed;
end
right:addEventListener("touch",right)

function up:touch()
	motiony = -speed;
end
up:addEventListener("touch", up)

function down:touch()
  motiony = speed;
end
down:addEventListener("touch",down)

-- Move character
local function moveJogador (event)
	jogador.x = jogador.x + motionx
	jogador.y = jogador.y + motiony
end
Runtime:addEventListener("enterFrame", moveJogador)

local function stop (event)
	if event.phase == "ended" then
		motionx= 0
		motiony = 0
	end
end
Runtime:addEventListener ("touch", stop)

local function onCollision( event )
	if ( event.phase == "began") then

		print ("Colisão: " .. event.object1.myName .. " com " .. event.object2.myName .. "." )
	elseif (event.phase == "ended") then

		print ("It's over")
	end
end

Runtime:addEventListener("collision", onCollision)
