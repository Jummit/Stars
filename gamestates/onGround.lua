local mathUtils = require "libs.math"
localDialog = {}
localDialogNPC = {}
newDialog = false
local dialogTimer = 0
local dialogTextTimer = 0
onGround = {
  elements = {},
  draw = function()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.clear()

    local offX, offY = mathUtils.getThingOffset(player, location.map:getDimensions(1))
    location.map:draw(offX, offY, 1, 0)
    player:draw()
    for npcNum = 1, #location.npcs do
      local npc = location.npcs[npcNum]
      npc:draw(offX, offY)
    end
    if localDialog.text then
      love.graphics.print(localDialog.text, 500, 300)
    end
  end
}
onGround.update = function(dt)
  player:update(dt)
  dialogTextTimer = dialogTextTimer + 1
  dialogTimer = dialogTimer + 1
  local offX, offY = mathUtils.getThingOffset(player, location.map:getDimensions(1))
  if love.keyboard.isDown("escape") then
    changeState("inSystem")
  end
  for npcNum = 1, #location.npcs do
    local npc = location.npcs[npcNum]
    if npc:update(dt, offX, offY) == "destroy" then
      location.npcs[npcNum] = nil
    end
  end
  if newDialog then
    onGround.elements = {}
    if localDialog.option then
      for optionNum = 1, #localDialog.option do
        table.insert(onGround.elements,
          fw.new(
           "button", {
            x=260*(optionNum-1),y=400,w=250,h=60,
            label = localDialog.option[optionNum].option,
            clickedFunc = function(localDialogNPC)
              if dialogTimer > 5 then
                if localDialog.option[optionNum].dialog.func then
                  localDialog.option[optionNum].dialog.func(localDialogNPC)
                end
                dialogTimer = 0
                localDialog = localDialog.option[optionNum].dialog
                newDialog = true
                dialogTextTimer = 0
              end
            end
          })
        )
      end
    end
    newDialog = false
  elseif not localDialog.option and dialogTextTimer > 200 then
    onGround.elements = {}
    localDialog = {}
    localDialogNPC = {}
  end
end
return onGround
