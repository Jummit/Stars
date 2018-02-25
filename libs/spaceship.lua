local assets = require "libs.assets"
local mathUtils = require "libs.math"
local w, h = love.graphics.getDimensions()
local spaceship = {
  x = w/2,
  y = h/2,
  move = {
    x = 0,
    y = 0
  },
  getPlanetOff = function(self)
    return (-self.x)+w/2, (-self.y)+h/2
  end,
  acceleration = 1.8,
  rotationAcceleration = 3,
  brakeStrenght = 0.01,
  icon = assets.spaceship,
  rotation = 0,
  draw = function(self)
    local offX, offY = self:getPlanetOff()
    self.icon:draw(
      self.x+offX,
      self.y+offY,
      self.rotation,
      1,1,10,10
    )
  end,
  update = function(self, dt)
    if love.keyboard.isDown("d") then
      local localSystem = galaxy.systems[localSystem]
      for planetNum = 1, #localSystem.planets do
        local planet = localSystem.planets[planetNum]
        if mathUtils.getDistance(self.x, self.y, planet.x, planet.y) < 40 then
          localPlanet = planetNum
          gamestate = "onPlanet"
        end
      end
    end
    if love.keyboard.isDown("up") then
      self.move.x = self.move.x + math.sin(self.rotation)*dt*self.acceleration
      self.move.y = self.move.y - math.cos(self.rotation)*dt*self.acceleration
    end
    if love.keyboard.isDown("down") then
      self.move.x = self.move.x - math.sin(self.rotation)*dt*self.acceleration
      self.move.y = self.move.y + math.cos(self.rotation)*dt*self.acceleration
    end
    if love.keyboard.isDown("left") then self.rotation = self.rotation - self.rotationAcceleration*dt end
    if love.keyboard.isDown("right") then self.rotation = self.rotation + self.rotationAcceleration*dt end
    self.x = self.x + self.move.x
    self.y = self.y + self.move.y

    if love.keyboard.isDown("b") then
      self.move.x = mathUtils.reduceValue(self.move.x, self.brakeStrenght)
      self.move.y = mathUtils.reduceValue(self.move.y, self.brakeStrenght)
    end
  end
}
return spaceship
