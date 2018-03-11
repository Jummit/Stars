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
          interacted = false,
          draw = function(self, offx, offy)
            if type(self.icon) == "string" then
              self.icon = assets.npcs[tab.icon]
            end
            self.icon:draw(self.x+offx, self.y+offy)
          end,
          update = function(self, dt, offx, offy)
            if self.updateFunc then self:updateFunc(dt) end
            if mathUtils.getDistance(self.x, self.y, player.x, player.y) <= 40 and fw.boxClicked({x=self.x+offx, y=self.y+offy, w=40, h=40}, true) then
              if self.dialog then
                localDialogNPC = self
                localDialog = self.dialog
                newDialog = true
              end
              if self.interactedFunc then
                return self:interactedFunc()
              end
            end
          end
        }
      }
    )
  end
}
