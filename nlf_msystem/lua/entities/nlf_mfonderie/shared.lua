ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Fonderie"
ENT.Author = "Osmos"
ENT.Category	= "MSystem"
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"price")
	self:NetworkVar("Entity",1,"owning_ent")
end