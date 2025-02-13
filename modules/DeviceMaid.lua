-- || Services
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService")

-- || Variables
local maid = {};

function maid:getEnabled()
	return {
		["Keyboard"] = UserInputService.KeyboardEnabled;
		["Gamepad"] = UserInputService.GamepadEnabled;
		["Touch"] = UserInputService.TouchEnabled;
	};
end

function maid:getPlatform()
	local res = maid:getEnabled();

	--local isPC = res.Keyboard or (res.Keyboard and res.Touch)
	local isMobile = res.Touch and not res.Gamepad and not res.Keyboard
	local isConsole = res.Gamepad and not res.Touch and not res	.Keyboard

	if isMobile then
		return "Mobile"
	elseif isConsole then
		return "Keyboard"
	else
		return "PC"
	end

end

function maid:isController()
	return maid:getEnabled().Gamepad;
end

function maid:isVR()
	return (UserInputService.VREnabled);
end

return maid
