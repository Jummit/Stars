local assets = require "libs.assets"
local mathUtils = require "libs.math"
local tilemap = require "libs.tilemap"
local w, h = love.graphics.getDimensions()
local tiles = assets.tiles.spaceship
local tileset = {}
for tileName, tileAsset in pairs(tiles) do
  tileset[tileName] = tileAsset
end
local spaceship = {
  x = w/2,
  y = h/2,
  move = {
    x = 0,
    y = 0
  },
  acceleration = 1.8,
  rotationAcceleration = 3,
  brakeStrenght = 0.01,
  icon = assets.spaceship,
  rotation = 0,
  draw = function(self)
    local offX, offY = mathUtils.getThingOffset(spaceship)
    local drawX, drawY = self.x+offX, self.y+offY
    self.tilemap:draw(drawX, drawY)
  end,
  update = function(self, dt)
    self.tilemap.rotation = self.rotation
    if love.keyboard.isDown("d") and self.move.x == 0 and self.move.y == 0 then
      local localSystem = galaxy.systems[localSystem]
      for planetNum = 1, #localSystem.planets do
        local planet = localSystem.planets[planetNum]
        if mathUtils.getDistance(self.x, self.y, planet.x, planet.y) < planet.icon.image:getWidth()/2 then
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
      self.move.x = mathUtils.reduce(self.move.x, self.brakeStrenght)
      self.move.y = mathUtils.reduce(self.move.y, self.brakeStrenght)
    end
  end,
  tilemap = tilemap.new(tileset, 30, 30, 0.3)
}
spaceship.tilemap.layers[1] = {
  {false, false, "engine"},
  {false, "plating", "plating"},
  {"cockpit", "plating", "engine"},
  {false, "plating", "plating"},
  {false, false, "engine"},
}
--[[
  e
 pp
cpp
 pp
  e
]]
return spaceship
