--[[
	While default, it is easily disabled if you don't want to use this. Simply put --[[ the first line, like this; --[[local dbs...
	Type: Command
	Author: EngiAdurite
	Description: Desktop Experience. Heavily WiP.
	
	Sadly I have no current way of providing an auto updating module, so please download the modules manually. <3
	
	Credits;
		Pixabay
			DarkmoonArt_de - Forest River
			garageband - Abstract Paintings
		Roblox Images
			gabep08 - 1020120443
			

--]]																								local module = {}

local dbs = require(script.Parent.Parent.DataStorage)
local pdb = dbs:GetCategory("PluginStorage_RedefineA_Desktop")
local http = game:GetService("HttpService")

module.pName = "desktop"
module.pType = "Command"
module.Usage = "| Unfunctional yet!"
module.requiredLevel = 0
module.expectedParameters = 0
module.requiredParameters = 0
module.requiredLibs = {"Engis_Lib"}

function module:Fired(args,libs)	-- This function is activated whenever the command is fired. (args: Player (1), Other Strings (2+), libs: The expected libraries.)
	if not args then return {false,"An unknown error has occured."} end
	local plr = args[1] -- To make it easier, include this.
	local terminalcoms = script.TerminalCommands:Clone()
	local apps = script.Apps:Clone()
	local ops = script.RAos:Clone()
	apps.Parent = ops
	terminalcoms.Parent = ops
	ops.Enviroment.Prefix.Value = script.Parent.Parent.prefix.Value
	ops.Parent = plr.PlayerGui
	print("Loading FirstTimeDisplayed")
	local load = pdb:Load(plr.UserId.."s_desktop_FirstTimeDisplayed")
	load:wait()
	if load.Data then
		print("Data Exists: "..tostring(load.Data))
		if load.Data == true then
			ops.Enviroment.Login.Visible = true
			ops.Enviroment.FirstLogin.Visible = false
			ops.Enviroment.ImageLabel.Visible = true
			ops.Enviroment.Login.ImageLabel.LocalScript.Disabled = false
		else
			ops.Enviroment.FirstLogin.mainanimation.Disabled = false
		end
	else
		print("Data is nil.")
		ops.Enviroment.FirstLogin.mainanimation.Disabled = false
	end
	return {true,"Loading, please wait."}
end

function isHttpEnabled() -- Check if HTTP is enabled for the app store load.
	local s = pcall(function()
		http:GetAsync('http://www.google.com/')
	end)
	return s
end

storecache = {}

function Load() -- This function is activated when this plugin has been loaded. (No args.) (Returns the plugin itself.)
	local sfunc = Instance.new("RemoteFunction")
	sfunc.Parent = game:GetService("ReplicatedStorage")
	sfunc.Name = "RA_DesktopEvent"
	sfunc.OnServerInvoke = (function(plr,invoketype,args)
		if invoketype == "Save" then
			local save = pdb:Save(plr.UserId.."s_desktop_"..args[1],args[2])
			save:wait()
			return true
		elseif invoketype == "Load" then
			local load = pdb:Load(plr.UserId.."s_desktop_"..args[1])
			load:wait()
			if load.Completed == false then
				return "Cancel_TooLong"
			else
				return load.Data
			end
		elseif invoketype == "StoreLoad" then
			if isHttpEnabled() == true then
				if not storecache then
					local data = http:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
					storecache = http:JSONDecode(data)
				end
				return {true,storecache}
			else
				return {false,"http_disabled"}
			end
		end
	end)
end


-- 	Warning before concluding this example;
--	The Add-Ons load BEFORE the admin itself loads in order to prevent exploits or admin hijackings.
--	If you want the Add-On to load AFTER the admin, just wait until I come up with something..!
																																																															Load();module.ScriptName = script.Name;module.ScriptLoc = script -- No offense but I don't trust you enough to name all your plugins by the command itself.	Keep it here or the script will error. :)																						
return module --]]
