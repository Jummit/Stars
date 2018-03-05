local fw = require "libs.fw"

return {
  update = function(dt)
  end,
  draw = function()
  end,
  elements = {
    fw.new(
    "button", {
      x=10,y=10,w=250,h=60,
      label = "Ship"
    }),
    fw.new(
    "button", {
      x=270,y=10,w=250,h=60,
      label = "Inventory"
    }),
    fw.new(
    "button", {
      x=530,y=10,w=250,h=60,
      label = "Quests"
    })
  }
}
