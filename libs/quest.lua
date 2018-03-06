--[[{
  name = "Quest Name",
  description = "Simply press 'q' and finish this quest!",
  finished = function()
    return love.keyboard.isDown("q")
  end,
  finishedFunc = function()
  end
}]]

return {
  new = function(args)
    return setmetatable(args, {
      __index = {
        update = function(self)
          if self.finished() then
            self.finishedFunc()
            return true
          end
        end
      }
    })
  end
}
