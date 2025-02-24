local funcs = {VC = game:GetService("VoiceChatService");}

function funcs:Connect()
  funcs.VC:joinVoice()
end

return
