return {
  new = function(tileset, w, h, scale, rotation)
    local map = {
      w = w, h = h,
      layers = {{}},
      tileset = tileset,
      scale = scale or 1,
      rotation = rotation or 0,
      getDimensions = function(self, layer)
        return #self.layers[layer][1]*w, #self.layers[layer]*h
      end,
      scale = scale or 1,
      rotation = rotation or 0,
      draw = function(self, offX, offY)
        local w, h = self.w*self.scale, self.h*self.scale
        for layerNum = 1, #self.layers do
          for x = 1, #self.layers[layerNum] do
            for y = 1, #self.layers[layerNum][x] do
              local tile = self.layers[layerNum][x][y]
              if tile then
                if self.rotation ~= 0 then
                  local width, height = self:getDimensions(1)
                  love.graphics.translate(offX, offY)
                  love.graphics.rotate(self.rotation)
                  self.tileset[tile]:draw(((x-1)*w),((y-1)*h), 0, self.scale, self.scale, height/2, width/2)
                  love.graphics.rotate(-self.rotation)
                  love.graphics.translate(-offX, -offY)
                else
                  self.tileset[tile]:draw(((x-1)*w)+offX,((y-1)*h)+offY, 0, self.scale, self.scale)
                end
              end
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
      end,
      collide = function(self, offX, offY, x, y, w, h)
        for layerNum = 1, #self.layers do
          local layer = self.layers[layerNum]
          for tileX = 1, #layer do
            for tileY = 1, #layer[tileX] do
              local tile = self.tileset[layer[tileX][tileY]]
              if tile.solid and mathUtils.collideBoxes((tileX-1)*self.w, (tileY-1)*self.h, self.w, self.h, x, y, w, h) then return true end
            end
          end
        end
      end
    }
    return map
  end
}
