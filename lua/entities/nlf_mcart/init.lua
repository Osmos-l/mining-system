AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_cart002.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self:SetNWInt("rock", 0)
	self:SetNWInt("distance", 512)
	self:SetPos(self:GetPos() + Vector(0,0,20))
	self.jailWall = true
	self.CanUse = true
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
	if not IsValid(hitEnt) then return end
		if (self.CanUse) then
		if (hitEnt:GetClass() == "nlf_minirock") and (self:GetNWInt("rock") < nlf.msystem.config.maxrock) then
			if (hitEnt:GetNWInt("rock") > 0) then
				if (self:GetNWInt("rock") >= nlf.msystem.config.maxrock) then
					hitEnt:Remove()
				else 
					local Ang = self:GetAngles()
					if (self:GetNWInt("rock") == 0) then 
						hitEnt:SetPos(self:GetPos() + Ang:Right() + Ang:Up()*3 + Ang:Forward()*-7)
						self:SetNWEntity("rock1", hitEnt)
					end;
					if (self:GetNWInt("rock") == 1) then
						hitEnt:SetPos(self:GetPos() + Ang:Right() + Ang:Up()*3 + Ang:Forward()*-2)
						self:SetNWEntity("rock2", hitEnt)
					end;
					if (self:GetNWInt("rock") == 2) then
						hitEnt:SetPos(self:GetPos() + Ang:Right() + Ang:Up()*3 + Ang:Forward()*3)
						self:SetNWEntity("rock3", hitEnt)
					end;
					if (self:GetNWInt("rock") == 3) then 
						hitEnt:SetPos(self:GetPos() + Ang:Right() + Ang:Up()*3 + Ang:Forward()*7)
						self:SetNWEntity("rock4", hitEnt)
					end;
					if (self:GetNWInt("rock") == 4) then
						hitEnt:SetPos(self:GetPos() + Ang:Right() + Ang:Up()*3 + Ang:Forward()*12)
						self:SetNWEntity("rock5", hitEnt)
					end;
					if (self:GetNWInt("rock") >= 5) then
						hitEnt:Remove()
					end;
					hitEnt:SetAngles(Angle(55, Ang.y, Ang.r))
					hitEnt:SetNWInt("rock", hitEnt:GetNWInt("rock")-1)
					hitEnt:SetCollisionGroup(4)
					hitEnt:SetParent(self)
				end;
				hitEnt.Touched = true
				self:SetNWInt("rock", 1+self:GetNWInt("rock"))
			end;
		end
	end
end 

function ENT:OnRemove()
	if not IsValid(self) then return end
	     if !self:Getowning_ent() == NULL then
	  self:Getowning_ent().cart = 0
	 end 
end
