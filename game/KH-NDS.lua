-- This is a placeholder for the old loadstring

if setclipboard then
  setclipboard('loadstring(game:HttpGet("https://raw.githubusercontent.com/KaterHub-Inc/NaturalDisasterSurvival/refs/heads/main/main.lua"))()')
  game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "NDS Hub";
      Text = "Please update your loadstring!!\n\nThe new one has been copied to your clipboard.";
      Duration = 60;
  })
else
  game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "NDS Hub";
      Text = "Please update your loadstring!!";
      Duration = 60;
  })
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/KaterHub-Inc/NaturalDisasterSurvival/refs/heads/main/main.lua"))()
