local w, h = love.graphics.getDimensions()

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
  end
}

mathUtils.getThingOffset = function(thing)
  return mathUtils.getOffset(thing.x, w), mathUtils.getOffset(thing.y, h)
end

return mathUtils
