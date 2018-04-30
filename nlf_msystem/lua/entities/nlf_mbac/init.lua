AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_washer001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self.JailWall = true
		local phys = self:GetPhysicsObject()
	phys:Wake()
end

function ENT:OnRemove()
	if not IsValid(self) then return end
end

