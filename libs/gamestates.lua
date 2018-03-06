local gamestates = {}
local gamestateFiles = love.filesystem.getDirectoryItems("/gamestates/")
for gamestateFileNum = 1, #gamestateFiles do
  local file = gamestateFiles[gamestateFileNum]
  local gamestateName = string.gsub(file,"%.lua$", "")
  gamestates[gamestateName] = require (".gamestates."..gamestateName)
end

return {
  states = gamestates,
  update = function(gamestate, dt)
    local gamestate = gamestates[gamestate]
    gamestate.update(dt)
    if gamestate.elements then
      fw.update(gamestate.elements, dt)
    end
  end,
  draw = function(gamestate)
    local gamestate = gamestates[gamestate]
    gamestate.draw()
    if gamestate.elements then
      fw.draw(gamestate.elements)
    end
  end
}
