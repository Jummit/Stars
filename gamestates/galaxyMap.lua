local fw = require "libs.fw"

return {
  update = function(dt)
    if love.keyboard.isDown("escape") then gamestate = "inSystem" end
    for systemNum = 1, #galaxy.systems do
      local box = {
        x = galaxy.systems[systemNum].x,
        y = galaxy.systems[systemNum].y,
        w = 40,
        h = 40
      }
      if fw.boxClicked(box, true) then
        gamestate = "inSystem"
        localSystem = systemNum
      end
    end
  end,
  draw = function()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.clear()
    galaxy:draw()
  end
}
