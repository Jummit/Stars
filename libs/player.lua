local pressed = love.keyboard.isDown

return {
  x = 50, y = 50,
  icon = assets.player,
  moves = {
    w = {0, -1},
    a = {-1, 0},
    s = {0, 1},
    d = {1, 0},
  },
  speed = 200,
  draw = function(self)
    local offX, offY = mathUtils.getThingOffset(self, location.map:getDimensions(1))
    self.icon:draw(self.x+offX, self.y+offY)
  end,
  update = function(self, dt)
    local x, y = 0, 0
    local offX, offY = mathUtils.getThingOffset(self, location.map:getDimensions(1))
    for key, move in pairs(self.moves) do
      if pressed(key) then
        x = move[1] * self.speed * dt
        y = move[2] * self.speed * dt
        if not location.map:collide(offX, offY, self.x+x, self.y+y, 23, 28) then
          self.x = self.x+x
          self.y = self.y+y
        end
      end
    end
  end
}
