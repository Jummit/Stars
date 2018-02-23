local assets = require "libs.assets"
local planet = require "libs.world.planet"

return {
  new = function()
    local system = {
      icon = assets.world.system,
      planets = {},
      x = math.random(1, 500), y = math.random(1, 300),
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
