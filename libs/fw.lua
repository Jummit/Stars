local fw = {
  update = function(elements, dt)
    for _, element in pairs(elements) do
      if love.mouse.isDown(1) then
        element.clicked = boxClicked(element, var2, var3)
      else
        if element.clicked and element.clickedFunc then element:clickedFunc(var1, var2, var3) end
        element.clicked = false
      end
      if element.update then
        element:update(event, dt)
      end
    end
  end,
  draw = function(elements)
    for _, element in pairs(elements) do
      element:draw()
    end
  end
}

function fw.boxClicked(box)
  local mouseX, mouseY = love.mouse.getPosition()
  if box.x and box.y and box.w and box.h then
    return box.x<=mouseX and box.y<=mouseY and box.x+box.w>mouseX and box.y+box.h>mouseY
  end
end

fw.elements = {}
fw.elements.button = {
  clicked = false,
  draw = function(self)
    if self.clicked then
      love.graphics.setBackgroundColor(self.clickedCol.r, self.clickedCol.g, self.clickedCol.b)
    else
      love.graphics.setBackgroundColor(self.color.r, self.color.g, self.color.b)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setBackgroundColor(self.textColor.r, self.textColor.g, self.textColor.b)
    love.graphics.print(self.label, (self.x+self.w/2)-#self.label/2, self.y+self.h/2)
  end
}

function fw.new(type, args)
  return setmetatable(args,{__index=elements[type]})
end

return fw
