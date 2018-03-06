return {
  new = function()
    local galaxy = {
      systems = {},
      draw = function(self)
        for systemNum = 1, #self.systems do
          local system = self.systems[systemNum]
          assets.draw(system)
        end
      end
    }

    for i = 1, 10 do
      galaxy.systems[i] = system.new()
    end

    return galaxy
  end
}
