local systemWidth, systemHeight = 1000, 1000
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
          x=math.random(1, 1000), y=math.random(1, 1000),
          icon="basic",
          interactedFunc = function(self)
            --table.insert(spaceship.inventory, items.apple)
            --return "destroy"
          end,
          dialog = {
            text = "Hello new person!",
            option = {
              {
                option = "I will kill ya!",
                dialog = {
                  text = "Oh no! Quick, run!",
                  func = function(self)
                    self.updateFunc = function() return "destroy" end
                  end,
                }
              },
              {
                option = "Hi!",
                dialog = {
                  text = "What are you doing here?",
                  option = {
                    {
                      option = "Nothing...",
                      dialog = {
                        text = "GET OOOOOUT!"
                      }
                    },
                    {
                      option = "searching cool items",
                      dialog = {
                        text = "Then have this and now go!",
                        func = function()
                          table.insert(spaceship.inventory, items.apple)
                        end
                      }
                    }
                  }
                }
              },
              {
                option = "Do you have cool stuff?",
                dialog = {
                  text = "Not now, and now go."
                }
              }
            }
          }
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
    planet.map:setRectangle(1, 1, 1, 60, 60, "grass")
    for i = math.random(2), math.random(5) do
      local w = math.random(5, 7)
      local h = math.floor(w*1.4)
      local x, y = math.random(h, 60-w), math.random(h, 60-w)
      planet.map:setRectangle(1, x, y, x+w, y+h, "wall")
    end
    return planet
  end
}
