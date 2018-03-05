local fw = {}
function fw.boxClicked(box, checkMouse, offX, offY)
  local offX, offY = offX or 0, offY or 0
  local mouseX, mouseY = love.mouse.getPosition()
  if box.x and box.y and box.w and box.h and ((not checkMouse) or love.mouse.isDown("l")) then
    return box.x<=mouseX and box.y<=mouseY and box.x+box.w>mouseX and box.y+box.h>mouseY
  end
end
function fw.update(elements, dt)
  for _, element in pairs(elements) do
    if love.mouse.isDown("l") then
      element.clicked = fw.boxClicked(element, var2, var3)
      if element.clicked and element.clickedFunc then element:clickedFunc(var1, var2, var3) end
    else
      element.clicked = false
    end
    if element.update then
      element:update(event, dt)
    end
  end
end
function fw.draw(elements)
  for _, element in pairs(elements) do
    element:draw()
  end
end

fw.elements = {}
fw.elements.button = {
  clicked = false,
  draw = function(self)
    if self.clicked then
      love.graphics.setColor(self.clickedCol.r, self.clickedCol.g, self.clickedCol.b)
      love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    else
      love.graphics.setColor(self.color.r, self.color.g, self.color.b)
      love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(self.textColor.r, self.textColor.g, self.textColor.b)
    local textX = (self.x+self.w/2)-love.graphics.getFont():getWidth(self.label)/2
    local textY = self.y+self.h/2-love.graphics.getFont():getHeight(self.label)/2
    love.graphics.print(self.label, textX, textY)
  end
}

function fw.new(type, args)
  return setmetatable(args,{__index=fw.elements[type]})
end

return fw
