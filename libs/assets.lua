local new = function(path)
  return {
    image = love.graphics.newImage(path),
    draw = function(self, ...)
      love.graphics.setColor(255, 255, 255)
      love.graphics.draw(self.image, ...)
    end
  }
end

local function loadImages(path)
  local images = {}
  local paths = love.filesystem.getDirectoryItems(path)
  for fileNum = 1, #paths do
    local file = paths[fileNum]
    local pathToFile = path.."/"..file
    local fileName = string.gsub(file,"%.png$", "")
    if love.filesystem.isDirectory(pathToFile) then
      images[fileName] = loadImages(pathToFile)
    else
      images[fileName] = new(pathToFile)
    end
  end
  return images
end

local images = loadImages("/assets")
print(images.world.planet.water)
images.draw = function(self)
  self.icon:draw(self.x, self.y)
end
return images
