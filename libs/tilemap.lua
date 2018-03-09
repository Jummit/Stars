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
      draw = function(self, offX, offY, scale, rotation)
        local rotation = rotation or self.rotation
        local scale = scale or self.scale
        local w, h = self.w*scale, self.h*scale
        self:forAllTiles(
          function(tile, x, y, layerNum)
            if tile then
              if self.rotation ~= 0 then
                local width, height = self:getDimensions(1)
                love.graphics.translate(offX, offY)
                love.graphics.rotate(rotation)
                self.tileset[tile]:draw(((x-1)*w),((y-1)*h), 0, scale, scale, height/2, width/2)
                love.graphics.rotate(-rotation)
                love.graphics.translate(-offX, -offY)
              else
                self.tileset[tile]:draw(((x-1)*w)+offX,((y-1)*h)+offY, 0, scale, scale)
              end
            end
          end
        )
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
      forAllTiles = function(self, func)
        for layerNum = 1, #self.layers do
          for x = 1, #self.layers[layerNum] do
            for y = 1, #self.layers[layerNum][x] do
              local tile = self.layers[layerNum][x][y]
              func(tile, x, y, layerNum)
            end
          end
        end
      end,
      collide = function(self, offX, offY, x, y, w, h)
        local coll = false
        self:forAllTiles(
          function(tile, tileX, tileY, layerNum)
            if tile then
              tile = self.tileset[tile]
              if tile.solid then
                if mathUtils.collideBoxes((tileX-1)*self.w, (tileY-1)*self.h, self.w, self.h, x, y, w, h) then
                  coll = true
                end
              end
            end
          end
        )
        return coll
      end
    }
    return map
  end
}
