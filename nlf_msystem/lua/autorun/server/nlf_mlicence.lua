util.AddNetworkString("M::BuyLicence")
util.AddNetworkString("M::CheckLicence")
util.AddNetworkString("M::HaveLicence")
util.AddNetworkString("M::BuyInshop")
local loc =  nlf.msystem.config.langue.LocalLang


net.Receive("M::BuyLicence", function(len, pl)
	local checkli = M_CheckMyLicence(pl)
	
	if pl:getDarkRPVar( "money" ) < nlf.msystem.config.amountlicence then
	DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt1) return
	end 
	
    if not checkli then
        pl:addMoney("-" .. nlf.msystem.config.amountlicence)
        DarkRP.notify(pl, 3, 4, nlf.msystem.config.langue[loc].txt2.." ".. nlf.msystem.config.amountlicence .. " "..nlf.msystem.config.langue[loc].money)
		M_AddLicence(pl) return
    else
        DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt3) return
    end
end)

net.Receive("M::CheckLicence", function(len, pl)
	local Where = net.ReadString()

	if M_CheckMyLicence(pl) then
		net.Start( "M::HaveLicence" )
		net.WriteString( Where )
		net.WriteEntity( net.ReadEntity() )
		net.Send(pl) return 
    else
		 DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt4) return
    end
	
end)

net.Receive("M::BuyInshop", function(len, pl)
	local k = net.ReadUInt(16)
	local npc = net.ReadEntity() 
	local cat = {}
	
	if  table.HasValue(nlf.msystem.config.adminpanel.access, pl:GetUserGroup() ) then
		 cat = nlf.msystem.config.button.admin[k] 
	elseif table.HasValue(nlf.msystem.config.vipaccess, pl:GetUserGroup() ) then
		cat = nlf.msystem.config.button.vip[k] 
	else 
		cat = nlf.msystem.config.button.basique[k] 
	end
	
	
	
	if not M_CheckMyLicence(pl) then DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt4) return end
	if not npc:GetClass() == "nlf_mlicence" then return end 
	if not npc:GetModel() == nlf.msystem.config.skin then return end 
	if pl:getDarkRPVar( "money" ) < cat.PRIX then DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt1) return end 
	if  cat.ENT == "M_Pioche" and pl.pioche == 1 or  cat.ENT == "M_Charette" and pl.cart == 1 then DarkRP.notify(pl, 1, 4, nlf.msystem.config.langue[loc].txt5) return end 
	
	
	if pl:GetPos():DistToSqr(npc:GetPos())>200 then 
	pl:addMoney("-"..cat.PRIX)
	if  cat.ENT == "M_Pioche" then 
			pl:Give("m_pickaxe")
			pl.pioche = 1
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
			pl.cart = 1
			DarkRP.notify(pl, 3, 4, nlf.msystem.config.langue[loc].txt7 ) return 
	end  
	end 
	
end)
