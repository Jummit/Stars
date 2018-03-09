local tiles = assets.tiles.spaceship
local tileset = {}
for tileName, tileAsset in pairs(tiles) do
  tileset[tileName] = tileAsset
end
local spaceship = {
  x = w/2,
  y = h/2,
  quests = {
    quest.new({
      name = "Collect Items!",
      icon = assets.items.apple,
      description = "Collect an item on a planet!",
      finished = function()
        return #spaceship.inventory>4
      end,
      finishedFunc = function()
        print("test")
      end
    })
  },
  move = {
    x = 0,
    y = 0
  },
  inventory = {
    items.test, items.apple, items.apple, items.test
  },
  acceleration = 1.8,
  rotationAcceleration = 3,
  brakeStrenght = 0.01,
  icon = assets.spaceship,
  rotation = 0,
  draw = function(self)
    local offX, offY = mathUtils.getThingOffset(spaceship)
    local drawX, drawY = self.x+offX, self.y+offY
    self.map:draw(drawX, drawY)
  end,
  update = function(self, dt)
    self.map.rotation = self.rotation
    if love.keyboard.isDown("d") and self.move.x == 0 and self.move.y == 0 then
      local system = galaxy.systems[localSystem]
      for planetNum = 1, #system.planets do
        local planet = system.planets[planetNum]
        if mathUtils.getDistance(self.x, self.y, planet.x, planet.y) < planet.icon.image:getWidth()/2 then
          localPlanet = planetNum
          location = galaxy.systems[localSystem].planets[localPlanet]
          gamestate = "onGround"
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
  map = tilemap.new(tileset, 30, 30, 0.3),
  npcs = {}
}
spaceship.map.layers[1] = {
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
