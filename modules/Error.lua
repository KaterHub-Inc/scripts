
Error = {
    GetBlock = function(title,message,button)
        local Dialog = game.CoreGui.HeadsetDisconnectedDialog:Clone()
        Dialog.Parent = game:GetService("CoreGui")
        Dialog.Name = "ERR_POPUP"
        local AlertContents = Dialog.Overlay.Alert.AlertContents
        local Buttons = AlertContents.Footer.Buttons
        AlertContents.TitleContainer.TitleArea.Title.Text = title
        AlertContents.MiddleContent.Content.BodyText.Text = message
        Buttons["1"].ButtonContent.ButtonMiddleContent.Text.Text = button
        Buttons["1"].MouseButton1Down:Connect(function()
            Buttons["1"].ImageColor3 = Color3.new(0.474510, 0.474510, 0.474510)
        end)
        Buttons["1"].MouseButton1Up:Connect(function()
            Buttons["1"].ImageColor3 = Color3.fromRGB(255,255,255)
        end)
        local Block = {
            Show = function()
                Dialog.Enabled = true
            end,
            Hide = function()
                Dialog.Enabled = false
            end,
            Close = function()
                Dialog:Destroy()
            end,
            SetCallback = function(callback)
                Buttons["1"].Activated:Connect(function()
                    callback()
                end)
            end
        }
        return Block
    end
}

return Error
