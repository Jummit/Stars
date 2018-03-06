local function new(tab)
  return setmetatable(tab,{
    __index = {
      draw = function(self, x, y)
        if type(self.icon) == "string" then
          self.icon = assets.items[self.icon]
        else
          self.icon:draw(x, y)
        end
      end
    }
  })
end

return {
  test = new({
    icon = "test",
    name = "Test Item",
    description = "This is only a test item, don't eat it! May have BUGS!"
  }),
  apple = new({
    icon = "apple",
    name = "Apple",
    description = "A red, tasty apple with many worms and BUGS!"
  })
}
