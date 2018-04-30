AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Initialize()
	self:SetModel("models/props_lab/monitor02.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

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
     if not nlf.msystem.config.jobaccess[ team.GetName( caller:Team() ) ] then DarkRP.notify(caller, 3, 4, nlf.msystem.config.langue[loc].noacces ) return end 
			net.Start( "M::Jobspanel" )
			net.Send(caller)
		self:EmitSound("music/computerstart.wav", 70, 100 )
	end

function ENT:OnRemove()
	if not IsValid(self) then return end
end

