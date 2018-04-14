ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName= "Cart"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "MSystem"
ENT.Author = "Osmos"


function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"price")
	self:NetworkVar("Entity",0,"owning_ent")
end