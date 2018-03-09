mathUtils = {
  getDistance = function(x1, y1, x2, y2)
    return math.sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2)))
  end,
  getOffset = function(middle, w)
    return (-middle)+w/2
  end,
  reduce = function(value, reduceValue)
    if value > 0 then
      if value-reduceValue < 0 then
        value = 0
      else
        value = value - reduceValue
      end
    else
      if value+reduceValue > 0 then
        value = 0
      else
        value = value + reduceValue
      end
    end
    return value
  end,
  collideBoxes = function(x1, y1, w1, h1, x2, y2, w2, h2)
    return ((x2<(x1+w1)) and ((x2+w2)>x1)) and ((y2<(y1+h1)) and ((y2+h2)>y1))
  end
}

mathUtils.getThingOffset = function(thing, mapW, mapH)
  local offX, offY = mathUtils.getOffset(thing.x, w), mathUtils.getOffset(thing.y, h)
  if mapW and mapH then
    if offX > 0 then offX = 0 end
    if offY > 0 then offY = 0 end
    if offX < -mapW+w then offX = -mapW+w end
    if offY < -mapH+h then offY = -mapH+h end
    if mapW < w then offX = w/2 end
    if mapH < h then offY = h/2 end
  end
  return offX, offY
end

return mathUtils
