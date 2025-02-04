local playerMoney = 0
local center = Config.Openmenu
local uiText = Config.Uitext

local point = lib.points.new({
  coords = center,
  distance = 20,
})

local marker = lib.marker.new({
  coords = center,
  type = 2,
  width = 0.4,
  height = 0.2,
  color = { r = 50, g = 168, b = 82, a = 170 },
})

TriggerServerEvent('getmoney')

RegisterNetEvent('getmoney')
AddEventHandler('getmoney', function(money)
    playerMoney = money
end)

function teleport(x, y, z)
    local playerPed = PlayerPedId()
    SwitchOutPlayer(playerPed, 0, 1)
    Wait(2000)
    SetEntityCoordsNoOffset(playerPed, x, y, z, false, false, false)
    Wait(1000)
    SwitchInPlayer(playerPed)
end

function point:nearby()
  marker:draw()

  if self.currentDistance < 1.5 then
    if not lib.isTextUIOpen() then
      lib.showTextUI(Config.Uitext)
    end

    if IsControlJustPressed(0, 51) then
        TriggerServerEvent('getmoney')
        Wait(500)
        if playerMoney then
            lib.showContext('lennumenu')
        else
            lib.notify({
                title = Config.Nomoneytitle,
                type = 'error'
            })
        end
    end
  else
    local isOpen, currentText = lib.isTextUIOpen()
    if isOpen and currentText == uiText then
      lib.hideTextUI()
    end
  end
end

lib.registerContext({
  id = 'lennumenu',
  title = Config.Menutitle,
  options = {
    {
      title = Config.Teleport1label,
      description = Config.Pricelabel .. ': ' .. Config.Teleport1price,
      icon = 'forward-fast',
      onSelect = function()
        local teleportCost = tonumber(Config.Teleport1price)
        if playerMoney and teleportCost and teleportCost <= playerMoney then
          TriggerServerEvent('money', 'money', teleportCost)
          teleport(Config.Teleportlocation1)
        else
          lib.notify({
            title = Config.Nomoneytitle,
            type = 'error'
          })
        end
      end
    },
    {
      title = Config.Teleport2label,
      description = Config.Pricelabel .. ': ' .. Config.Teleport2price,
      icon = 'forward-fast',
      onSelect = function()
        local teleportCost = tonumber(Config.Teleport2price)
        if playerMoney and teleportCost and teleportCost <= playerMoney then
          TriggerServerEvent('money', 'money', teleportCost)
          teleport(Config.Teleportlocation2)
        else
          lib.notify({
            title = Config.Nomoneytitle,
            type = 'error'
          })
        end
      end
    },
    {
      title = Config.Teleport3label,
      description = Config.Pricelabel .. ': ' .. Config.Teleport3price,
      icon = 'forward-fast',
      onSelect = function()
        local teleportCost = tonumber(Config.Teleport3price)
        if playerMoney and teleportCost and teleportCost <= playerMoney then
          TriggerServerEvent('money', 'money', teleportCost)
          teleport(Config.Teleportlocation3)
        else
          lib.notify({
            title = Config.Nomoneytitle,
            type = 'error'
          })
        end
      end
    }
  }
})
