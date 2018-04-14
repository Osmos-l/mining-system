AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");
util.AddNetworkString( "MSystem:OpenPanelLicence" )
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Initialize()
	self:SetModel(nlf.msystem.config.skin);
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT);
	self:SetSolid(SOLID_BBOX);
	self:SetUseType(SIMPLE_USE);
	self:SetBloodColor(BLOOD_COLOR_RED);
	
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

function ENT:AcceptInput(name, activator, caller)	
	if (!self.nextUse or CurTime() >= self.nextUse) then
		if (name == "Use" and caller:IsPlayer()) then
		net.Start( "MSystem:OpenPanelLicence" )
		net.WriteEntity( self )
		net.Send(caller) 
					else
				self:EmitSound("vo/npc/male01/sorry0"..math.random(1, 3)..".wav", 70, 100);
			end;
		end;
		self.nextUse = CurTime() + 1;
	end;