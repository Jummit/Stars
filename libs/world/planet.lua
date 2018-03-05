local assets = require "libs.assets"
local tilemap = require "libs.tilemap"
local mathUtils = require "libs.math"
local npcs = require "libs.npcs"

local systemWidth, systemHeight = 1000, 1000
local w, h = love.graphics.getDimensions()
local tiles = assets.tiles.planet
local tileset = {}
for tileName, tileAsset in pairs(tiles) do
  tileset[tileName] = tileAsset
end
tileset.wall.solid = true
return {
  new = function()
    local planet = {
      npcs = {
        npcs.new({
          x=math.random(1, w), y=math.random(1, h),
          icon="basic",
          interactedFunc = function(self)
            error("interacted")
          end
        })
      },
      map = tilemap.new(tileset, 30, 30),
      icon = assets.world.planet.water,
      draw = function(self)
        local offX, offY = mathUtils.getThingOffset(spaceship)
        self.icon:draw(
          self.x+offX-self.icon.image:getWidth()/2,
          self.y+offY-self.icon.image:getHeight()/2
        )
      end,
      x = math.random(-systemWidth/2, systemWidth/2), y = math.random(-systemHeight/2, systemHeight/2)
    }
    planet.map:setRectangle(1, 1, 1, 40, 40, "grass")
    for i = math.random(2), math.random(5) do
      local w = math.random(5, 7)
      local h = math.floor(w*1.4)
      local x, y = math.random(h, 40-w), math.random(h, 40-w)
      planet.map:setRectangle(1, x, y, x+w, y+h, "wall")
    end
    return planet
  end
}
