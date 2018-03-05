local mathUtils = require "libs.math"

return {
  update = function(dt)
    local planet = galaxy.systems[localSystem].planets[localPlanet]
    local offX, offY = mathUtils.getThingOffset(player, planet.map:getDimensions(1))
    if love.keyboard.isDown("escape") then
      gamestate = "inSystem"
    end
    player:update(dt)
    for npcNum = 1, #planet.npcs do
      local npc = planet.npcs[npcNum]
      npc:update(dt, offX, offY)
    end
  end,
  draw = function()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.clear()

    local planet = galaxy.systems[localSystem].planets[localPlanet]
    local offX, offY = mathUtils.getThingOffset(player, planet.map:getDimensions(1))
    planet.map:draw(offX, offY)
    player:draw()
    for npcNum = 1, #planet.npcs do
      local npc = planet.npcs[npcNum]
      npc:draw(offX, offY)
    end
  end
}
