local loc =  nlf.msystem.config.langue.LocalLang

local function M_CreateTable()

	if (!sql.TableExists("player_mlicence"))then
	sql.Query( "CREATE TABLE player_mlicence( id INTEGER PRIMARY KEY AUTOINCREMENT ,SteamID64 bigint(20), Licenceprix bigint(20), date varchar(255) )" )
	end 
	
	if not file.IsDir("msystem", "DATA") then
	 file.CreateDir("msystem", "DATA")
	end 
		if not file.IsDir("msystem/" .. string.lower(game.GetMap()) .. "", "DATA") then
			file.CreateDir("msystem/" .. string.lower(game.GetMap()) .. "", "DATA")
		end  
			if not file.IsDir("msystem/" .. string.lower(game.GetMap()) .. "/buyer", "DATA") then
				file.CreateDir("msystem/" .. string.lower(game.GetMap()) .. "/buyer", "DATA")
			 end 
			  if not file.IsDir("msystem/" .. string.lower(game.GetMap()) .. "/mlicence", "DATA") then
				file.CreateDir("msystem/" .. string.lower(game.GetMap()) .. "/mlicence", "DATA")
			 end 
			  if not file.IsDir("msystem/" .. string.lower(game.GetMap()) .. "/rock", "DATA") then
				file.CreateDir("msystem/" .. string.lower(game.GetMap()) .. "/rock", "DATA")
			 end 
			 if not file.IsDir("msystem/" .. string.lower(game.GetMap()) .. "/process", "DATA") then
				file.CreateDir("msystem/" .. string.lower(game.GetMap()) .. "/process", "DATA")
			 end 
end

hook.Add( "InitPostEntity", "M::InstalSQL", timer.Simple( 0.1, function() M_CreateTable() end ) );

function M_AddLicence( ply )

local whatdate = os.date()
	 sql.Query( "INSERT INTO player_mlicence VALUES( NULL, '"..ply:SteamID64().."','"..nlf.msystem.config.amountlicence.."','"..whatdate.."' )" )
end

function M_CheckMyLicence( ply )
	if sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. ply:SteamID64()) then
	return true
	else 	
	return false
	end
	
end 

concommand.Add("nlf_msystem_deletelicence", function(ply, cmd, args)
    if !table.HasValue(nlf.msystem.config.adminpanel.access, ply:GetUserGroup()) then return end
        local SteamIDX = args[1]

        if not SteamIDX then
            return
        end

        if sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. SteamIDX) then
		sql.Query("DELETE FROM player_mlicence WHERE SteamID64 =" ..SteamIDX)
		ply:ChatPrint(nlf.msystem.config.langue[loc].txt9.." " ..SteamIDX.. " "..nlf.msystem.config.langue[loc].txt10)
		else
		ply:ChatPrint(nlf.msystem.config.langue[loc].txt11.." " ..SteamIDX.. " "..nlf.msystem.config.langue[loc].txt12)
        end
  
end)

local function SpawnMsystemEnt()
     M_CreateTable()
    timer.Simple(0.2, function()
	
        for _, v in pairs(ents.FindByClass("nlf_mlicence")) do v:Remove() end
		
        for k, v in pairs(file.Find("msystem/" .. string.lower(game.GetMap()) .. "/mlicence/*.txt", "DATA")) do
            local vaultPosFile = file.Read("msystem/" .. string.lower(game.GetMap()) .. "/mlicence/" .. v, "DATA")
            local spawnNumber = string.Explode(" ", vaultPosFile)
            local NPCINFO = ents.Create("nlf_mlicence")
            NPCINFO:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]))
            NPCINFO:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]))
            NPCINFO:Spawn()
        end
    end)
	
	    timer.Simple(0.4, function()
	
        for _, v in pairs(ents.FindByClass("nlf_mbuyer")) do v:Remove() end

        for k, v in pairs(file.Find("msystem/" .. string.lower(game.GetMap()) .. "/buyer/*.txt", "DATA")) do
            local vaultPosFile = file.Read("msystem/" .. string.lower(game.GetMap()) .. "/buyer/" .. v, "DATA")
            local spawnNumber = string.Explode(" ", vaultPosFile)
            local NPCINFO = ents.Create("nlf_mbuyer")
            NPCINFO:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]))
            NPCINFO:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]))
            NPCINFO:Spawn()
        end
    end)
	
	    timer.Simple(0.6, function()
	
        for _, v in pairs(ents.FindByClass("nlf_rock")) do v:Remove() end

        for k, v in pairs(file.Find("msystem/" .. string.lower(game.GetMap()) .. "/rock/*.txt", "DATA")) do
            local vaultPosFile = file.Read("msystem/" .. string.lower(game.GetMap()) .. "/rock/" .. v, "DATA")
            local spawnNumber = string.Explode(" ", vaultPosFile)
            local NPCINFO = ents.Create("nlf_rock")
            NPCINFO:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]))
            NPCINFO:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]))
            NPCINFO:Spawn()
        end
    end)
	
	   timer.Simple(0.8, function()
	
        for _, v in pairs(ents.FindByClass("nlf_mfonderie")) do v:Remove() end

        for k, v in pairs(file.Find("msystem/" .. string.lower(game.GetMap()) .. "/process/*.txt", "DATA")) do
            local vaultPosFile = file.Read("msystem/" .. string.lower(game.GetMap()) .. "/process/" .. v, "DATA")
            local spawnNumber = string.Explode(" ", vaultPosFile)
            local NPCINFO = ents.Create("nlf_mfonderie")
            NPCINFO:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]))
            NPCINFO:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]))
            NPCINFO:Spawn()
        end
    end)
end
hook.Add("InitPostEntity", "M::SpawnENT", SpawnMsystemEnt)
hook.Add("PostCleanupMap", "M::SpawnENTCleanup", SpawnMsystemEnt)

local  function Msaveposs(ply)
	if !table.HasValue(nlf.msystem.config.adminpanel.access, ply:GetUserGroup()) then return  end
	if not file.IsDir("msystem/" .. string.lower(game.GetMap()), "DATA") then return end
	
	for _, ent in pairs(ents.FindByClass("nlf_mlicence")) do

		local pos, ang = ent:GetPos(), ent:GetAngles()
		file.Delete("msystem/" .. string.lower(game.GetMap()) .. "/mlicence/npc_" .. _ .. ".txt")
		file.Write("msystem/" .. string.lower(game.GetMap()) .. "/mlicence/npc_" .. _ .. ".txt", pos.x .. " " .. pos.y .. " " .. pos.z .. " " .. ang.p .. " " .. ang.y .. " " .. ang.r)
	end
	
	for _, ent in pairs(ents.FindByClass("nlf_mbuyer")) do

		local pos, ang = ent:GetPos(), ent:GetAngles()
		file.Delete("msystem/" .. string.lower(game.GetMap()) .. "/buyer/buyer_" .. _ .. ".txt")
		file.Write("msystem/" .. string.lower(game.GetMap()) .. "/buyer/buyer_" .. _ .. ".txt", pos.x .. " " .. pos.y .. " " .. pos.z .. " " .. ang.p .. " " .. ang.y .. " " .. ang.r)
	end
	
	for _,	ent in pairs(ents.FindByClass("nlf_rock")) do

		local pos, ang = ent:GetPos(), ent:GetAngles()
		file.Delete("msystem/" .. string.lower(game.GetMap()) .. "/rock/rock_" .. _ .. ".txt")
		file.Write("msystem/" .. string.lower(game.GetMap()) .. "/rock/rock_" .. _ .. ".txt", pos.x .. " " .. pos.y .. " " .. pos.z .. " " .. ang.p .. " " .. ang.y .. " " .. ang.r)
	end
	
		for _,	ent in pairs(ents.FindByClass("nlf_mfonderie")) do

		local pos, ang = ent:GetPos(), ent:GetAngles()
		file.Delete("msystem/" .. string.lower(game.GetMap()) .. "/process/process_" .. _ .. ".txt")
		file.Write("msystem/" .. string.lower(game.GetMap()) .. "/process/process_" .. _ .. ".txt", pos.x .. " " .. pos.y .. " " .. pos.z .. " " .. ang.p .. " " .. ang.y .. " " .. ang.r)
	end
	SpawnMsystemEnt()
end

hook.Add( "PlayerSay", "nlf_msystemcommand", function( ply, text, team )
	
	
	if  table.HasValue(nlf.msystem.config.adminpanel.access, ply:GetUserGroup()) and text == "!msystemsave" then
		Msaveposs(ply)
		 DarkRP.notify(ply, 3, 4, nlf.msystem.config.langue[loc].txt13 )
		return ""
		
	end
end)