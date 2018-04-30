util.AddNetworkString("M::BuyLicence")
util.AddNetworkString("M::CheckLicence")
util.AddNetworkString("M::HaveLicence")
util.AddNetworkString("M::BuyInshop")
util.AddNetworkString("M::OpenAdmin")
util.AddNetworkString("M::OpenAdmin:cl")
util.AddNetworkString("M::AdminDeletelicence")
util.AddNetworkString("M::AdminDataOffline")
util.AddNetworkString("M::AdminFindData")  
util.AddNetworkString("M::AdminDataOnline")
util.AddNetworkString("M::Jobspanel")
util.AddNetworkString("M::CopCheckLicence")
util.AddNetworkString("M::CopDeleteLicence")
util.AddNetworkString("M::PanelBuyer")
util.AddNetworkString("M::IllegalSellrock")
local loc =  nlf.msystem.config.langue.LocalLang


net.Receive("M::BuyLicence", function(len, pl)
	local checkli = M_CheckMyLicence(pl)
	
	if pl:getDarkRPVar( "money" ) < nlf.msystem.config.amountlicence then
	DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt1) return
	end 
	
    if not checkli then
        pl:addMoney("-" .. nlf.msystem.config.amountlicence)
        DarkRP.notify(pl, 3, 4, nlf.msystem.config.langue[loc].txt2.." ".. nlf.msystem.config.amountlicence .. " "..nlf.msystem.config.langue[loc].money)
		sql.Query( "INSERT INTO player_mlicence VALUES( NULL, '"..pl:SteamID64().."','"..pl:GetName().."','"..nlf.msystem.config.amountlicence.."','"..os.date().."' )" ) return
    else
        DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt3) return
    end
end)

net.Receive("M::CheckLicence", function(len, pl)

	if M_CheckMyLicence(pl) then
		net.Start( "M::HaveLicence" )
		net.WriteEntity( net.ReadEntity() )
		net.Send(pl) return 
    else
		 DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt4) return
    end
	
end)

local function M_CheckItem(item, user)
	if item == "pioche" then
   		if user:HasWeapon("m_pickaxe") then 
   			return true
   		else 
   			return false
   		end 

	elseif item == "cart" then
		 local allcart = ents.FindByClass("nlf_mcart")
   		 if not allcart then print("no cart all") return false end

   			 for k, v in pairs( allcart ) do 
   		 		if v:Getowning_ent() == user then
   		 			return true end
   			 end 
   			 
   		return false 
	end 
end 

net.Receive("M::BuyInshop", function(len, pl)
	local k = net.ReadUInt(16)
	local npc = net.ReadEntity() 
	local cat = {}
	
	if  nlf.msystem.config.adminpanel.access[ pl:GetUserGroup() ] then
		 cat = nlf.msystem.config.button.admin[k] 
	elseif nlf.msystem.config.vipaccess[ pl:GetUserGroup() ] then
		cat = nlf.msystem.config.button.vip[k] 
	else 
		cat = nlf.msystem.config.button.basique[k] 
	end
	
	
	
	if not M_CheckMyLicence(pl) then DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt4) return end
	if not npc:GetClass() == "nlf_mlicence" then return end 
	if not npc:GetModel() == nlf.msystem.config.skin then return end 
	if pl:getDarkRPVar( "money" ) < cat.PRIX then DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt1) return end 
	if  cat.ENT == "M_Pioche" and M_CheckItem("pioche", pl) or  cat.ENT == "M_Charette" and M_CheckItem("cart", pl) then DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt5) return end 
	
	
	if pl:GetPos():DistToSqr(npc:GetPos())>200 then 
	pl:addMoney("-"..cat.PRIX)
	if  cat.ENT == "M_Pioche" then 
			pl:Give("m_pickaxe")
			DarkRP.notify(pl, 3, 4, nlf.msystem.config.langue[loc].txt6 ) return 
		elseif  cat.ENT == "M_Charette" then
			local prop1 = ents.Create("nlf_mcart")
			prop1:Setowning_ent( pl )
			prop1:PhysicsInit(SOLID_VPHYSICS)
			prop1:SetMoveType(MOVETYPE_VPHYSICS)
			prop1:SetSolid(SOLID_VPHYSICS)
			prop1:SetPos(pl:GetPos() + pl:GetAngles():Forward()*-53)
			prop1:SetAngles(pl:GetAngles())
			prop1:Spawn()
			prop1:Activate()
			DarkRP.notify(pl, 3, 4, nlf.msystem.config.langue[loc].txt7 ) return 
	end  
	end 
	
end)

local function M_BarilPick(ply, ent)
	if not IsValid( ent ) then return end
	if not ent:GetClass() == "nlf_mbarilrock" then return end
	ent:SetNWEntity( "picker", ply )
end 
hook.Add( "PhysgunPickup", "M_PhysgunSetPicker", M_BarilPick )
hook.Add( "PlayerUse", "M_UseSetPicker", M_BarilPick )
hook.Add( "GravGunOnPickedUp", "M_GravSetPicker", M_BarilPick )

net.Receive("M::IllegalSellrock", function(len, pl)
    local npc = net.ReadEntity()
    if not npc:GetClass() == "nlf_mbuyerillegal" then return end

    local ments = ents.FindByClass("nlf_mbarilrock")
    if not ments[1] then
     npc:EmitSound("vo/npc/alyx/al_car_crazy08.wav", 100, 100) return 
 	end

    for k, v in pairs(ments) do
        if pl:GetPos():DistToSqr(npc:GetPos()) > 200 and v:GetPos():DistToSqr(npc:GetPos()) > 200 then
            if v:GetNWEntity("picker") == pl then
            	v:EmitSound("vo/outland_07/barn/al_barn_therewego.wav", 100, 100)
                v.CanUse = false
                pl:addMoney(v:GetNWInt("amount"))
                v:Remove()
                DarkRP.notify(pl, 3 , 4, "Tu as reçu : " ..v:GetNWInt("amount").. " $" )
                if nlf.msystem.config.wantedonsell then
                    pl:wanted(pl, "Vente illégal de roche", nlf.msystem.config.wantedtime)
                end
             else 
             		npc:EmitSound("vo/outland_07/barn/al_barn_pulsewhat.wav", 100, 100) --al_barn_pulsewhat
            end
        end
    end
end)