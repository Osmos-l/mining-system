AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Initialize()
	self:SetModel("models/props_lab/reciever_cart.mdl")
	timer.Simple(0.5, function()
		local prop1 = ents.Create("nlf_mbac")
		prop1:SetPos(self:GetPos() + self:GetAngles():Forward()*-53)
		prop1:SetAngles(self:GetAngles())
		prop1:Spawn()
		prop1:Activate()
		prop1:SetParent(self)
		prop1:SetSolid(SOLID_VPHYSICS)
		prop1:SetLocalAngles( Angle( 0, 260, 0 ) )
	end)
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetNWInt("rock", 0)
	self:SetNWInt("distance", 512);
	self:SetNWInt("width", 205)
	self:SetNWInt("getRock", 0)
	self:SetPos(self:GetPos())
	self.CanUse = true
	self.JailWall = true
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
	if not IsValid(hitEnt) then return end
	if hitEnt:IsPlayer() then return end
	if not hitEnt:GetClass() ==  "nlf_mcart" then return end
	
	if self.CanUse then
	if hitEnt:Getowning_ent() == NULL  then return end
	local ply = hitEnt:Getowning_ent()
	
	if ply.notif == NULL then ply.notif = true end 
	
	if M_CheckMyLicence( ply ) then
		if (hitEnt:GetNWInt("rock") > 0) and (!hitEnt:IsPlayerHolding()) then
			hitEnt:SetPos(self:GetPos() + self:GetAngles():Right()*40 + self:GetAngles():Up()*-15)
			hitEnt:SetAngles(self:GetAngles())
			hitEnt:SetParent(self)
			self.CanUse = false
			self.SumTime = nlf.msystem.config.processtime * hitEnt:GetNWInt("rock")
			self.Time = CurTime() + self.SumTime
			self.GiveAmount = hitEnt:GetNWInt("rock") * nlf.msystem.config.rockprice 
			self:SetNWInt("timer", self.Time)
			self:SetNWEntity("cart", hitEnt)
			self:SetNWInt("getRock", hitEnt:GetNWInt("rock"))
			self:EmitSound( "sound/music/processstart.wav" )
			self.EffectTime = CurTime() + 1
			hitEnt.CanUse = false
		end
	else 
	if ply.notif == true then DarkRP.notify( ply, 1, 4, nlf.msystem.config.langue[loc].txt4  ) 	ply.notif = false end 
	timer.Simple( 5, function() ply.notif = NULL end )
	end 
	end
end

function ENT:Think()

	if !self.CanUse then
		local width = ((100/self.SumTime)*(205/100))/10
		self:SetNWInt("width", self:GetNWInt("width") - width);
		self:NextThink(CurTime()+0.1)
				
		if self.Time <= CurTime() then
			self:SetNWInt("width", 205);
			local cart = self:GetNWEntity("cart")
			if (cart != NULL) then
				local selfAng = self:GetAngles()
				cart:SetNWInt("rock", 0)
				cart:SetParent()
				cart:SetPos(self:GetPos() + selfAng:Right()*40)
				cart.CanUse = true
				
				local rock1 = cart:GetNWEntity("rock1")
				local rock2 = cart:GetNWEntity("rock2")
				local rock3 = cart:GetNWEntity("rock3")
				local rock4 = cart:GetNWEntity("rock4")
				local rock5 = cart:GetNWEntity("rock5")
				if (rock1 != NULL) then rock1:Remove() end
				if (rock2 != NULL) then rock2:Remove() end
				if (rock3 != NULL) then rock3:Remove() end
				if (rock4 != NULL) then rock4:Remove() end
				if (rock5 != NULL) then rock5:Remove() end
				
				self.CanUse = true
				self:SetNWInt("getRock", 0)
				local owner = cart:Getowning_ent()
				local prop2 = ents.Create("nlf_mbarilrock")
				prop2:SetPos(self:GetPos() + self:GetAngles():Right()*-40 )
				prop2:SetAngles(self:GetAngles())
				prop2:Spawn()
				prop2:Activate()
				prop2:SetSolid(SOLID_VPHYSICS)
				prop2:Setowning_ent(owner)
				prop2:SetNWInt("amount", self.GiveAmount)
				
				self.GiveAmount = 0
			else
				self.CanUse = true
				self.GiveAmount = 0
			end
		end
		return true
	end
end

function ENT:OnRemove()
	if not IsValid(self) then return end
end
