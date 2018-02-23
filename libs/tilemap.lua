local assets = require "libs.assets"

return {
  new = function(tileset, w, h)
    local map = {
      layers = {{}},
      tileset = tileset,
      draw = function(self, offX, offY)
        for layerNum = 1, #self.layers do
          for x = 1, #self.layers[layerNum] do
            for y = 1, #self.layers[layerNum][x] do
              local tile = self.layers[layerNum][x][y]
              assets.tiles[tile]:draw((x-1)*w,(y-1)*w)
            end
          end
        end
      end,
      setTile = function(self, layer, x, y, tile)
        if not self.layers[layer] then self.layers[layer] = {} end
        if not self.layers[layer][x] then self.layers[layer][x] = {} end
        self.layers[layer][x][y] = tile
      end,
      getTile = function(self, layer, x, y)
        if self.layers[layer] and self.layers[layer][x] then return self.layers[layer][x][y] end
      end,
      setRectangle = function(self, layer, x1, y1, x2, y2, tile)
        for x = x1, x2 do
          for y = y1, y2 do
            self:setTile(layer, x, y, tile)
          end
        end
      end
    }
    return map
  end
}
