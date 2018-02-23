local fw = require "libs.fw"

return {
  elements = {
    buttons = fw.new("button", {
      x=10,y=10,w=100,h=40,
      textColor={r=200,g=200,b=255},
      color={r=100,g=100,b=255},
      clickedCol={r=140,g=140,b=240},
      label = "Back",
      clickedFunc = function()
        gamestate = "inSystem"
      end
    })
  },
  update = function(dt)
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
