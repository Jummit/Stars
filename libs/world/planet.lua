local assets = require "libs.assets"
local tilemap = require "libs.tilemap"
local systemWidth, systemHeight = 1000, 1000
local w, h = love.graphics.getDimensions()

return {
  new = function()
    local planet = {
      map = tilemap.new({}, 30, 30),
      icon = assets.world.planet.water,
      draw = function(self)
        local offX, offY = spaceship:getPlanetOff()
        self.icon:draw(
          self.x+offX-self.icon.image:getWidth()/2,
          self.y+offY-self.icon.image:getHeight()/2
        )
      end,
      x = math.random(-systemWidth/2, systemWidth/2), y = math.random(-systemHeight/2, systemHeight/2)
    }
    planet.map:setRectangle(1, 1, 1, 40, 40, "grass")
    for i = 1, 2 do
      local w = math.random(5, 7)
      local x, y = math.random(1, 20), math.random(1, 20)
      planet.map:setRectangle(1, x, y, x+w, y+math.floor(w*1.4), "wall")
    end
    return planet
  end
}
