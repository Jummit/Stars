local assets = require "libs.assets"
local fw = require "libs.fw"

--[[{
  quests = {

  },
  x = 100,
  y = 100,
  icon = "image",
  interactFunc = function(self)
    error("interacted")
  end
}]]

return {
  new = function(tab)
    return setmetatable(tab,
      {
        __index = {
          draw = function(self, offx, offy)
            if type(self.icon) == "string" then
              self.icon = assets.npcs[tab.icon]
            end
            self.icon:draw(self.x+offx, self.y+offy)
            --love.graphics.rectangle("fill", self.x+offx, self.y+offy, 40, 40)
          end,
          update = function(self, dt, offx, offy)
            if self.updateFunc then self:updateFunc(dt) end
            if self.interactedFunc and mathUtils.getDistance(self.x, self.y, player.x, player.y) <= 40 and fw.boxClicked({x=self.x+offx, y=self.y+offy, w=40, h=40}, true) then
              self:interactedFunc()
            end
          end
        }
      }
    )
  end
}
