local new = function(path)
  return {
    image = love.graphics.newImage("/assets/"..path..".png"),
    draw = function(self, ...)
      love.graphics.draw(self.image, ...)
    end
  }
end

return {
  draw = function(self)
    self.icon:draw(self.x, self.y)
  end,
  world = {
    planet = {
      water = new("world/planet/water")
    },
    system = new("world/system")
  },
  tiles = {
    grass = new("tiles/grass"),
    doorLower = new("tiles/doorLower"),
    doorUpper = new("tiles/doorUpper"),
    roof = new("tiles/roof"),
    roofLeft = new("tiles/roofLeft"),
    roofRight = new("tiles/roofRight"),
    wall = new("tiles/wall"),
    window = new("tiles/window"),
  },
  spaceship = new("spaceship")
}
