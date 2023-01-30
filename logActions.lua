local function logAction(player, action)
  local log = game:GetService("DataStoreService"):GetDataStore("LogStore")
  local playerId = player.UserId
  local timestamp = os.time()
  
  log:SetAsync(playerId .. "-" .. timestamp, {
    playerId = playerId,
    timestamp = timestamp,
    action = action
  })
end

game.Players.PlayerAdded:Connect(function(player)
  player.Chatted:Connect(function(message)
    logAction(player, "chat")
  end)
  
  player.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(function(part)
      logAction(player, "partAdded")
    end)
  end)
end)
