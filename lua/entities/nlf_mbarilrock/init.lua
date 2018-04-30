AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_borealis/bluebarrel001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self:SetNWInt("amount", 0)
	self:SetNWInt("distance", 512)
	self:SetNWEntity( "picker", nil )
	self:SetPos(self:GetPos() + Vector(0,0,20))
	self.jailWall = true
	self.CanUse = true
	self.RemovingTime = 60
end


function ENT:AcceptInput(name, activator, caller)	
     if self:Getowning_ent() == NULL then
	  self:Setowning_ent(caller)
	 end 
	 
	  if IsValid(activator) and activator:IsPlayer() then
        if self:IsPlayerHolding() then return end
        activator:PickupObject(self)
		end 
	 
	end;

function ENT:Touch(hitEnt)
end 

function ENT:OnRemove()
	if not IsValid(self) then return end
		if !self.CanUse and self.RemovingTime <= CurTime() then
		self:Remove()
	end
end
