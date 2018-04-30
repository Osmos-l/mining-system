AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Initialize()
	self:SetModel("models/mark2580/dmc/dmc_kat_rebel.mdl") -- https://steamcommunity.com/sharedfiles/filedetails/?id=415879117
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:SetBloodColor(BLOOD_COLOR_RED)
	
end;

function ENT:SpawnFunction( ply, tr, ClassName )
	 if ( !tr.Hit ) then return end
	 DarkRP.notify(ply, 3, 4, nlf.msystem.config.langue[loc].save)

	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 180

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:Think()

    for _, v in pairs(ents.FindByClass("nlf_mbarilrock")) do
        if v:GetPos():Distance(self:GetPos()) <= 500 then
            if v:Getowning_ent() == NULL then return end
            if not v:IsPlayerHolding() then return end
			local pl = v:GetNWEntity( "picker" )
					
                if pl.delay == nil then
                    pl.delay = 0
                end

                if CurTime() > pl.delay then
                    pl:SendLua("chat.AddText( Color( 173, 188, 32), '[INCONNUE] :', Color(255, 255, 255) , nlf.msystem.config.buyerillegalsay[math.random(1, 3)] )")
                    pl.delay = CurTime() + 20
				end
        end
    end
end

function ENT:AcceptInput(name, activator, caller)	
	if (!self.nextUse or CurTime() >= self.nextUse) then
			if (name == "Use" and caller:IsPlayer()) then
				if not nlf.msystem.config.jobaccess[team.GetName(caller:Team())] then 
					net.Start( "M::PanelBuyer" )
					net.WriteEntity( self )
					net.Send( caller )
				else
					self:EmitSound("vo/outland_07/barn/al_barn_pulsewhat.wav", 70, 100)
				end 
			end
		end
		self.nextUse = CurTime() + 1
	end