local assets = require "libs.assets"
local planet = require "libs.world.planet"
local windowW, windowH = love.graphics.getDimensions()
local galaxyWidth, galaxyHeight = windowW-40, windowH-40

return {
  new = function()
    local system = {
      icon = assets.world.system,
      planets = {},
      x = math.random(1, galaxyWidth), y = math.random(1, galaxyHeight),
      draw = function(self)
        for planetNum = 1, #self.planets do
          local planet = self.planets[planetNum]
          planet:draw()
        end
      end
    }

    for i = 1, 5 do
      system.planets[i] = planet.new()
    end
    return system
  end
}
