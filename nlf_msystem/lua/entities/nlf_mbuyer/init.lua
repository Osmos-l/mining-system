AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Initialize()
	self:SetModel("models/props_junk/PushCart01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self:SetNWInt("baril", 0)
	self:SetNWInt("distance", 512)
	self:SetPos(self:GetPos())
	self.jailWall = true
	self.CanUse = true
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

function ENT:Touch(hitEnt)
	if not IsValid(hitEnt) then print( hitEnt ) return end
		if (self.CanUse) then
		if (hitEnt:GetClass() == "nlf_mbarilrock") then
				if (self:GetNWInt("baril") >= 2) then
					hitEnt:Remove()
				timer.Simple( 60, function() self:SetNWInt("baril", self:GetNWInt("baril") - 1) end )
				else 
					local Ang = self:GetAngles()
					if (self:GetNWInt("baril") == 0) then 
						hitEnt:SetPos(self:GetPos() + Ang:Right() + Ang:Up()*10 + Ang:Forward()*-15)
						self:SetNWEntity("baril1", hitEnt)
					timer.Simple( 60, function() hitEnt:Remove() self:SetNWInt("baril", self:GetNWInt("baril") - 1) end )
					end;
					if (self:GetNWInt("baril") == 1) then
						hitEnt:SetPos(self:GetPos() + Ang:Right() + Ang:Up()*10 + Ang:Forward()*15)
						self:SetNWEntity("baril2", hitEnt)
					timer.Simple( 60, function() hitEnt:Remove() self:SetNWInt("baril", self:GetNWInt("baril") - 1) end )
					end;
					hitEnt:SetAngles(Angle(Ang.p, Ang.y, Ang.r))
					hitEnt:SetCollisionGroup(4)
					hitEnt:SetParent(self)
				end;
				hitEnt.CanUse = false 
				self:SetNWInt("baril", 1 + self:GetNWInt("baril"))
		local owner = hitEnt:Getowning_ent()
		if owner then owner:addMoney(hitEnt:GetNWInt("amount") or NULL) DarkRP.notify( owner, 3, 4, nlf.msystem.config.langue[loc].txt18.." ".. hitEnt:GetNWInt("amount") or 0 .. " "..nlf.msystem.config.langue[loc].money ) end 
		hitEnt:SetNWInt("amount", 0)
			end;
		end
end 

function ENT:OnRemove()
	if not IsValid(self) then return end
end
