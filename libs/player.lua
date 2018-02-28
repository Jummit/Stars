local w, h = love.graphics.getDimensions()
local assets = require "libs.assets"
local pressed = love.keyboard.isDown

return {
  x = w/2, y = h/2,
  icon = assets.player,
  moves = {
    w = {0, -1},
    a = {-1, 0},
    s = {0, 1},
    d = {1, 0},
  },
  speed = 200,
  draw = function(self)
    local planet = galaxy.systems[localSystem].planets[localPlanet]
    local offX, offY = mathUtils.getThingOffset(self, planet.map:getDimensions(1))
    self.icon:draw(self.x+offX, self.y+offY)
  end,
  update = function(self, dt)
    local x, y = 0, 0
    local planet = galaxy.systems[localSystem].planets[localPlanet]
    local offX, offY = mathUtils.getThingOffset(self, planet.map:getDimensions(1))
    for key, move in pairs(self.moves) do
      if pressed(key) then
        x =  move[1] * self.speed * dt
        y =  move[2] * self.speed * dt

        if not planet.map:collide(offX, offY, self.x+x, self.y+y, 23, 28) then
          self.x = self.x+x
          self.y = self.y+y
        end
      end
    end
  end
}
