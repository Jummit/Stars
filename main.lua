function love.load()
  math.randomseed(os.time())
  galaxy = require "libs.world.galaxy"
  gamestates = require "libs.gamestates"

  spaceship = require "libs.spaceship"
  player = require "libs.player"
  galaxy = galaxy.new()
  localSystem = 1
  localPlanet = 1
  gamestate = "inventory"
end

function love.update(dt)
  gamestates.update(gamestate, dt)
  for questNum = 1, #spaceship.quests do
    local quest = spaceship.quests[questNum]
    if quest:update() then
      quest.finishedFunc()
      table.remove(spaceship.quests, questNum)
    end
  end
end

function love.draw()
  gamestates.draw(gamestate)
end
