ENT.Base = "base_ai"
ENT.Type = "ai"

ENT.PrintName 	= "NPC licence"
ENT.Author 		= "Osmos"
ENT.Contact 	= ""
ENT.Category	= "MSystem"

ENT.AutomaticFrameAdvance = true;
   
ENT.Spawnable = true;
ENT.AdminSpawnable = true;

function ENT:PhysicsCollide(data, physobj)
end;

function ENT:PhysicsUpdate(physobj)
end;

function ENT:SetAutomaticFrameAdvance(bUsingAnim)
	self.AutomaticFrameAdvance = bUsingAnim;
end