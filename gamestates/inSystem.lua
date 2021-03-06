local fw = require "libs.fw"
return {
  elements = {
    galaxyMap = fw.new("button", {
      x=10,y=10,w=140,h=40,
      textColor={r=200,g=200,b=255},
      color={r=100,g=100,b=255},
      clickedCol={r=140,g=140,b=240},
      label = "Galaxy Map",
      clickedFunc = function()
        changeState("galaxyMap")
      end
    })
  },
  update = function(dt)
    if love.keyboard.isDown("escape") then changeState("inventory") end
    if love.keyboard.isDown("i") then
      location = spaceship
      changeState("onGround")
    end
    spaceship:update(dt)
  end,
  draw = function()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.clear()
    galaxy.systems[localSystem]:draw()
    spaceship:draw()
  end
}
