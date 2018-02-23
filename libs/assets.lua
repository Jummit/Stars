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
  spaceship = new("spaceship")
}
