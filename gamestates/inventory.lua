local fw = require "libs.fw"

local function getItemPos(itemNum)
  return 50+(itemNum-1)*40, 100
end
local selectedItem = 1
local descriptionLineLegth = 20
local state = "ship"
statedraws = {
  inventory = {
    draw = function()
      for itemNum = 1, #spaceship.inventory do
        spaceship.inventory[itemNum]:draw(getItemPos(itemNum))
      end
      local item = spaceship.inventory[selectedItem]
      love.graphics.print(item.name, 580, 250)
      for i = 1, #item.description/descriptionLineLegth do
        love.graphics.print(string.sub(item.description, (i-1)*descriptionLineLegth, (i)*descriptionLineLegth-1), 540, 270+(i-1)*20)
      end
      item.icon:draw(540, 100, 0, 5)
    end,
    update = function(dt)
      for itemNum = 1, #spaceship.inventory do
        local x, y = getItemPos(itemNum)
        if fw.boxClicked({x=x,y=y,w=40,h=40}, true) then
          selectedItem = itemNum
        end
      end
    end
  },
  quest = {
    draw = function()
    end,
    update = function(dt)
    end
  },
  ship = {
    draw = function()
      spaceship.icon:draw(540, 90, 0, 10)
      love.graphics.print("Stats:", 540, 320)
      love.graphics.print("Health: "..20, 540, 340)
      love.graphics.print("X position: "..math.floor(spaceship.x), 540, 360)
      love.graphics.print("Y position: "..math.floor(spaceship.y), 540, 380)
      love.graphics.print("Rotation: "..math.floor(spaceship.rotation), 540, 400)
    end,
    update = function(dt)
    end
  },
}
return {
  update = function(dt)
    if love.keyboard.isDown("escape") then gamestate = "inSystem" end
    statedraws[state].update(dt)
  end,
  draw = function()
    statedraws[state].draw()
  end,
  elements = {
    fw.new(
    "button", {
      x=10,y=10,w=250,h=60,
      label = "Ship",
      clickedFunc = function() state = "ship" end
    }),
    fw.new(
    "button", {
      x=270,y=10,w=250,h=60,
      label = "Inventory",
      clickedFunc = function() state = "inventory" end
    }),
    fw.new(
     "button", {
      x=530,y=10,w=250,h=60,
      label = "Quests",
      clickedFunc = function() state = "quest" end
    })
  }
}
