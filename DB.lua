local db = {}

local http = game:GetService("HttpService")
local DataStoreService = game:GetService("DataStoreService")

local secret = {
	Url = "", --Mettre le host ici ( EXEMPLE : "http://01.252.252.25:8081" ).
	PASS = "" --Mettre ici le mot de passe que vous avez choisi dans le fichier en node js ( EXEMPLE : rfeds5ze:Z/Za8a" ).
}

function db.get(a, username, userID, Callback)
	if pcall(function()
		local thinks = http:RequestAsync({
			Url = secret.Url.."/getDB",
			Method = "POST",
			Headers = {
				PASS = secret.PASS,
				userID = tostring(userID),
				username = username,
			},	
		})
		
		local validJson, Resp = pcall(function()
		
	if thinks ~= nil then
		return http:JSONDecode(thinks.Body);
	else
		if game.Players:FindFirstChild(username) then
			local gui = script.Parent.Catch:Clone()
			gui.Parent = game.Players:FindFirstChild(username).PlayerGui
		end
	end	
	
		end)
	if (validJson) then
		if (thinks.StatusCode == 200) then
			Callback(true, Resp);
		else
			Callback(false, Resp);
			warn(Resp.message)
		end
	else
		Callback(false, thinks.Body);
		if Resp.message then
		warn(Resp.message)
		end
	end
	end) then	
	else
		local gui = script.Parent.Catch:Clone()
		gui.Parent = game.Players:FindFirstChild(username).PlayerGui
	end
end

function db.post(a, username, userID, tabl, Callback)
	if pcall(function()
		local thinks = http:RequestAsync({
			Url = secret.Url.."/postDB",
			Method = "POST",
			Headers = {
				PASS = secret.PASS,
				userID = tostring(userID),
				username = username,
			},
			Body = http:JSONEncode(tabl)
		})
		
		local validJson, Resp = pcall(function()
		
	if thinks ~= nil then
		return http:JSONDecode(thinks.Body);
	else
		if game.Players:FindFirstChild(username) then
			local gui = script.Parent.Catch:Clone()
			gui.Parent = game.Players:FindFirstChild(username).PlayerGui
		end
	end	
	
	end)
	if (validJson) then
		if (thinks.StatusCode == 200) then
			Callback(true, Resp);
		else
			Callback(false, Resp);
			warn(Resp.message)
		end
	else
		Callback(false, thinks.Body);
		if Resp.message then
		warn(Resp.message)
		end
	end
	end) then	
	else
		local gui = script.Parent.Catch:Clone()
		gui.Parent = game.Players:FindFirstChild(username).PlayerGui
	end
end

function db.change(a, userID, tabl, Callback)
	if pcall(function()
		local thinks = http:RequestAsync({
			Url = secret.Url.."/changeDB",
			Method = "POST",
			Headers = {
				PASS = secret.PASS,
				userID = tostring(userID)
			},
			Body = http:JSONEncode(tabl)
		})
		
		local validJson, Resp = pcall(function()
		
	if thinks ~= nil then
		return http:JSONDecode(thinks.Body);
	end	
	
	end)
	if (validJson) then
		if (thinks.StatusCode == 200) then
			Callback(true, Resp);
		else
			Callback(false, Resp);
			warn(Resp.message)
		end
	else
		Callback(false, thinks.Body);
		if Resp.message then
		warn(Resp.message)
		end
	end
	end) then	
	else
		warn("An error as occured in the change function.")
	end
end

function db.delete(a, userID, Callback)
	if pcall(function()
		local thinks = http:RequestAsync({
			Url = secret.Url.."/deleteDB",
			Method = "POST",
			Headers = {
				PASS = secret.PASS,
				userID = tostring(userID)
			}
		})
		
		local validJson, Resp = pcall(function()
		
	if thinks ~= nil then
		return http:JSONDecode(thinks.Body);
	end	
	
	end)
	if (validJson) then
		if (thinks.StatusCode == 200) then
			Callback(true, Resp);
		else
			Callback(false, Resp);
			warn(Resp.message)
		end
	else
		Callback(false, thinks.Body);
		if Resp.message then
		warn(Resp.message)
		end
	end
	end) then	
	else
		warn("An error as occured in the delete function.")
	end
end

return db
