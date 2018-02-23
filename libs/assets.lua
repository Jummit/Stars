local new = function(path)
  return {
    image = love.graphics.newImage(path),
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
      water = new("/assets/world/planet/water.png")
    },
    system = new("/assets/world/system.png")
  }
}
