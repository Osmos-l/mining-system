local loc =  nlf.msystem.config.langue.LocalLang

local function M_CreateTable()

	if (!sql.TableExists("player_mlicence"))then
	sql.Query( "CREATE TABLE player_mlicence( id INTEGER PRIMARY KEY AUTOINCREMENT ,SteamID64 bigint(20), name varchar(255),Licenceprix bigint(20), date varchar(255) )" )
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
			 if not file.IsDir("msystem/" .. string.lower(game.GetMap()) .. "/computer", "DATA") then
				file.CreateDir("msystem/" .. string.lower(game.GetMap()) .. "/computer", "DATA")
			 end 
end

hook.Add( "InitPostEntity", "M::InstalSQL", timer.Simple( 0.1, function() M_CreateTable() end ) );

concommand.Add("nlf_msystem_reloadtable", function(ply, cmd, args)
    if not nlf.msystem.config.adminpanel.access[ ply:GetUserGroup() ] then return end
       

	if (sql.TableExists("player_mlicence"))then
		sql.Query( "DROP TABLE player_mlicence" )
		sql.Query( "CREATE TABLE player_mlicence( id INTEGER PRIMARY KEY AUTOINCREMENT ,SteamID64 bigint(20), name varchar(255),Licenceprix bigint(20), date varchar(255) )" )
				DarkRP.notify(ply, 3, 4, "Table Reload" )
	end 
  
end)


function M_CheckMyLicence( ply )
	if sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. ply:SteamID64()) then
	return true
	else 	
	return false
	end
	
end 

concommand.Add("nlf_msystem_deletelicence", function(ply, cmd, args)
    if not nlf.msystem.config.adminpanel.access[ ply:GetUserGroup() ] then return end
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
	
		   timer.Simple(1, function()
	
        for _, v in pairs(ents.FindByClass("nlf_mcomputer")) do v:Remove() end

        for k, v in pairs(file.Find("msystem/" .. string.lower(game.GetMap()) .. "/computer/*.txt", "DATA")) do
            local vaultPosFile = file.Read("msystem/" .. string.lower(game.GetMap()) .. "/computer/" .. v, "DATA")
            local spawnNumber = string.Explode(" ", vaultPosFile)
            local NPCINFO = ents.Create("nlf_mcomputer")
            NPCINFO:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]))
            NPCINFO:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]))
            NPCINFO:Spawn()
        end
    end)
end
hook.Add("InitPostEntity", "M::SpawnENT", SpawnMsystemEnt)
hook.Add("PostCleanupMap", "M::SpawnENTCleanup", SpawnMsystemEnt)

local  function Msaveposs(ply)
	if not nlf.msystem.config.adminpanel.access[ ply:GetUserGroup() ]then return  end
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
	
		for _,	ent in pairs(ents.FindByClass("nlf_mcomputer")) do

		local pos, ang = ent:GetPos(), ent:GetAngles()
		file.Delete("msystem/" .. string.lower(game.GetMap()) .. "/computer/computer_" .. _ .. ".txt")
		file.Write("msystem/" .. string.lower(game.GetMap()) .. "/computer/computer_" .. _ .. ".txt", pos.x .. " " .. pos.y .. " " .. pos.z .. " " .. ang.p .. " " .. ang.y .. " " .. ang.r)
	end
	SpawnMsystemEnt()
end

hook.Add( "PlayerSay", "nlf_msystemcommand", function( ply, text )
	
	
	if  nlf.msystem.config.adminpanel.access[ ply:GetUserGroup() ] and text == nlf.msystem.config.commandforsave then
		Msaveposs(ply)
		 DarkRP.notify(ply, 3, 4, nlf.msystem.config.langue[loc].txt13 )
		return ""
		
	end
	
	if nlf.msystem.config.adminpanel.access[ ply:GetUserGroup() ] and text == nlf.msystem.config.commandforadminpanel then
	
		local result = sql.Query("SELECT * FROM player_mlicence")
		if result then
			net.Start( "M::OpenAdmin" )
			net.WriteTable( sql.Query("SELECT * FROM player_mlicence") )
			net.Send(ply)
			return ""
		else 
			result = {}
			net.Start( "M::OpenAdmin" )
			net.WriteTable( result )
			net.Send(ply)
			return ""
		end 
	end
	
	if nlf.msystem.config.usecommandforcop == true and text == nlf.msystem.config.commandcop then
	if not nlf.msystem.config.jobaccess[ team.GetName( ply:Team() ) ] then DarkRP.notify(ply, 3, 4, nlf.msystem.config.langue[loc].noacces )return end 
			net.Start( "M::Jobspanel" )
			net.Send(ply)
		return ""
	end
end)

net.Receive("M::OpenAdmin:cl", function(len, pl)
	if  not nlf.msystem.config.adminpanel.access[ pl:GetUserGroup() ] then return end
	
	local result = sql.Query("SELECT * FROM player_mlicence")
		if result then
			net.Start( "M::OpenAdmin" )
			net.WriteTable( sql.Query("SELECT * FROM player_mlicence") )
			net.Send(pl)
			return ""
		else 
			result = {}
			net.Start( "M::OpenAdmin" )
			net.WriteTable( result )
			net.Send(pl)
			return ""
		end 
end)

net.Receive("M::AdminDeletelicence", function(len, pl)
	if  not nlf.msystem.config.adminpanel.access[ pl:GetUserGroup() ] then return end
	local SteamIDX = net.ReadString()
	
	  if sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. SteamIDX) then
		sql.Query("DELETE FROM player_mlicence WHERE SteamID64 =" ..SteamIDX)
		DarkRP.notify(pl, 3, 4, nlf.msystem.config.langue[loc].txt26 )
	else
		DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt27 )
    end
end)

function Msystem_ConvertSteamID( id ) -- --ALL CREDIT FOR THIS COMMAND GOES TO |G4P| Mr.President. https://www.gmodstore.com/users/view/76561197971242755
    id = string.upper(string.Trim( id ))
    if string.sub( id, 1, 6 ) == 'STEAM_' then
        local parts = string.Explode( ':', string.sub(id,7) )
        local id_64 = (1197960265728 + tonumber(parts[2])) + (tonumber(parts[3]) * 2)
        local str = string.format('%f',id_64)
        return '7656'..string.sub( str, 1, string.find(str,'.',1,true)-1 )
    else
        if tonumber( id ) ~= nil then
          local id_64 = tonumber( id:sub(2) )
          local a = id_64 % 2 == 0 and 0 or  1
          local b = math.abs(6561197960265728 - id_64 - a) / 2
          local sid = "STEAM_0:" .. a .. ":" .. (a == 1 and b -1 or b)
          return sid
        end
    end
end

--ALL CREDIT FOR THIS COMMAND GOES TO THE ULX TEAM. I PULLED THIS OUT SO THAT I COULD NOT HAVE TO RELY ON ULIB FOR A SINGLE FUNCTION.
function Msystem_getUser( target )
	if not target then return false end

	local players = player.GetAll()
	target = target:lower()

	local plyMatch

	-- First, do a full name match in case someone's trying to exploit our target system
	for _, player in ipairs( players ) do
		if target == player:Nick():lower() then
			if not plyMatch then
				return player
			else
				return false
			end
		end
	end

	for _, player in ipairs( players ) do
		local nameMatch
		if player:Nick():lower():find( target, 1, true ) then -- No patterns
			nameMatch = player
		end

		if plyMatch and nameMatch then -- Already have one
			return false
		end
		if nameMatch then
			plyMatch = nameMatch
		end
	end

	if not plyMatch then
		return false
	end

	return plyMatch
end

net.Receive("M::AdminDataOffline", function(len, pl)
	if  not nlf.msystem.config.adminpanel.access[ pl:GetUserGroup() ] then return end
	local SteamIDX = net.ReadString()
	
	if string.find(SteamIDX, "STEAM_") then
		local SteamIDZ = Msystem_ConvertSteamID( SteamIDX )
	
		local result = sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. SteamIDZ)
			if result then
				net.Start( "M::AdminFindData" )
				net.WriteTable( sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. SteamIDZ ) )
				net.Send(pl)
				return 
			else 
				DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].nodata .." " ..  SteamIDZ)
				return 
			end 
		
	else 
	
		local result = sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. SteamIDX)
			if result then
				net.Start( "M::AdminFindData" )
				net.WriteTable( sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. SteamIDX) )
				net.Send(pl)
				return 
			else 
				DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].nodata .. " " ..  SteamIDX)
				return
			end 
	end 
end)

net.Receive("M::AdminDataOnline", function(len, pl)
	if  not nlf.msystem.config.adminpanel.access[ pl:GetUserGroup() ] then return end
	local NameX = net.ReadString()
	
	local target_ply = Msystem_getUser( NameX )
	local SteamIDX = target_ply:SteamID64()
	
	local result = sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. SteamIDX)
			if result then
				net.Start( "M::AdminFindData" )
				net.WriteTable( sql.Query("SELECT * FROM player_mlicence WHERE SteamID64 =" .. SteamIDX ) )
				net.Send(pl)
				return 
			else 
				DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].nodata .. " " ..  SteamIDX)
				return 
			end 
	
end)

net.Receive("M::CopCheckLicence", function(len, pl)
    if not nlf.msystem.config.jobaccess[team.GetName(pl:Team())] then return end
    local namejoueur = net.ReadString()
    local user = Msystem_getUser(namejoueur)

    if user then
        if not M_CheckMyLicence(user) then
            DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt35.." " .. namejoueur)

            return
        else
            DarkRP.notify(pl, 0, 4, nlf.msystem.config.langue[loc].txt36.." " .. namejoueur)

            return
        end
    else
        DarkRP.notify(pl, 1, 4, namejoueur .. " "..nlf.msystem.config.langue[loc].txt37)

        return
    end
end)

net.Receive("M::CopDeleteLicence", function(len, pl)
    if not nlf.msystem.config.jobaccess[team.GetName(pl:Team())] then return end
    local namejoueur = net.ReadString()
    local user = Msystem_getUser(namejoueur)

    if not user then
        DarkRP.notify(pl, 1, 4, namejoueur .. " "..nlf.msystem.config.langue[loc].txt37)

        return
    end

    if not M_CheckMyLicence(user) then
        DarkRP.notify(pl, 1, 4, namejoueur .. " "..nlf.msystem.config.langue[loc].txt38)

        return
    end

    sql.Query("DELETE FROM player_mlicence WHERE SteamID64 =" .. user:SteamID64())
    DarkRP.notify(pl, 3, 4, nlf.msystem.config.langue[loc].txt26)
	DarkRP.notify(user, 1, 4, pl:Name() .. " "..nlf.msystem.config.langue[loc].txt39)
    return
end)
