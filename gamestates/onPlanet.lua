return {
  update = function(dt)
    if love.keyboard.isDown("escape") then
      gamestate = "inSystem"
    end
  end,
  draw = function()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.clear()
    galaxy.systems[localSystem].planets[localPlanet].map:draw(1, 1)
  end
}
