AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Initialize()
self:SetModel( "models/props_wasteland/rockgranite02c.mdl" )
self:PhysicsInit( SOLID_VPHYSICS ) 
self:SetMoveType( MOVETYPE_NONE ) 
self:SetSolid( SOLID_VPHYSICS ) 
	self.Replace = false
	self:SetNWInt("rockhealth", 100)
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

function ENT:Think()

if (!self.Replace) and (self:GetNWInt("rockhealth") <= 0)  then
		self:EmitSound( "ambient/levels/dog_v_strider/dvs_rockslide.wav" )
		self.Replace = true
		self.ReplaceTime = CurTime() + 10
		self.Pos = self:GetPos()
		self:SetPos(self:GetPos() + Vector(0,0,-300))
		
		local rock = ents.Create('nlf_minirock')
		rock:SetPos(self.Pos + Vector(0,0,30))
		rock:Spawn()
		local rock2 = ents.Create('nlf_minirock')
		rock2:SetPos(self.Pos + Vector(0,0,87))
		rock2:Spawn()
		local rock3 = ents.Create('nlf_minirock')
		rock3:SetPos(self.Pos + Vector(0,0,144))
		rock3:Spawn()
		local rock4 = ents.Create('nlf_minirock')
		rock4:SetPos(self.Pos + Vector(0,0,201))
		rock4:Spawn()
		constraint.Weld(rock, rock2, 0, 0, 500, true, false)
		constraint.Weld(rock2, rock3, 0, 0, 500, true, false)
		constraint.Weld(rock3, rock4, 0, 0, 500, true, false)
	end 
	
	if (self.Replace) and (self.ReplaceTime < CurTime())  then
		self:SetNWInt("rockhealth", 100)
		self.Replace = false
		self:SetPos(self.Pos)
		end
end 

function ENT:OnTakeDamage(dmg)
	local ply = dmg:GetAttacker()
	if not ply:IsValid() then return end
	if (dmg:GetInflictor():GetClass() == "m_pickaxe") or (dmg:GetAttacker():GetActiveWeapon():GetClass() == "m_pickaxe") then

	self:SetNWInt("rockhealth", self:GetNWInt("rockhealth") -  math.random( 16, 21 ) )
	end
end


function ENT:OnRemove()
	if not IsValid(self) then return end
end