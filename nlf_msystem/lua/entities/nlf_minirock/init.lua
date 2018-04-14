AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_mining/rock_caves01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	phys:SetMass(40)
	self:SetNWInt("rock", 1)
	self.Touched = false
	self.RemovingTime = CurTime() + 30
end

function ENT:Use(activator)
 if IsValid(activator) and activator:IsPlayer() then
        if self:IsPlayerHolding() then return end
        activator:PickupObject(self)
		end 
end

function ENT:OnRemove()
	if not IsValid(self) then return end
end

function ENT:Think()
	if !self.Touched and self.RemovingTime <= CurTime() then
		self:Remove()
	end
end
