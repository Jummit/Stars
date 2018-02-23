local assets = require "libs.assets"
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
  acceleration = 0.4,
  rotationAcceleration = 1,
  brakeStrenght = 0.5,
  icon = assets.spaceship,
  rotation = 0,
  draw = function(self)
    local offX, offY = self:getPlanetOff()
    self.icon:draw(self.x+offX-self.icon.image:getWidth()/2, self.y+offY-self.icon.image:getHeight()/2, self.rotation)
  end,
  update = function(self, dt)
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
      self.move.x = self.move.x - self.brakeStrenght
      self.move.y = self.move.y - self.brakeStrenght
    end
    if love.keyboard.isDown("b") then
      if self.rotation > 0 then
        self.rotation = self.rotation - 0.05
      elseif self.rotation < 0 then
        self.rotation = self.rotation + 0.05
      end
    end
  end
}
return spaceship
