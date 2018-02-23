local gamestates = {}
local gamestateFiles = love.filesystem.getDirectoryItems("/gamestates/")
for gamestateFileNum = 1, #gamestateFiles do
  local file = gamestateFiles[gamestateFileNum]
  local gamestateName = string.gsub(file,"%.lua$", "")
  gamestates[gamestateName] = require (".gamestates."..gamestateName)
end
return gamestates
