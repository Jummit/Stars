local mathUtils = require "libs.math"
return {
  update = function(dt)
    local offX, offY = mathUtils.getThingOffset(player, location.map:getDimensions(1))
    if love.keyboard.isDown("escape") then
      changeState("inSystem")
    end
    player:update(dt)
    for npcNum = 1, #location.npcs do
      local npc = location.npcs[npcNum]
      if npc:update(dt, offX, offY) == "destroy" then
        location.npcs[npcNum] = nil
      end
    end
  end,
  draw = function()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.clear()

    local offX, offY = mathUtils.getThingOffset(player, location.map:getDimensions(1))
    location.map:draw(offX, offY, 1, 0)
    player:draw()
    for npcNum = 1, #location.npcs do
      local npc = location.npcs[npcNum]
      npc:draw(offX, offY)
    end
  end
}
