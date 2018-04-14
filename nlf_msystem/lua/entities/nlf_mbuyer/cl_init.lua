include("shared.lua")
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Draw()
	self:DrawModel()

	surface.SetFont("HUDNumber5")

	local eye = LocalPlayer():EyeAngles()
	local Pos = self:LocalToWorld( self:OBBCenter() )+Vector( 0, 0, 50 )
	local Ang = Angle( 0, eye.y - 90, 90 )
	
	if self:GetPos():Distance( LocalPlayer():GetPos() ) > 1500 then return end
	cam.Start3D2D(Pos + Vector( 0, 0, math.sin( CurTime() ) * 2 ), Ang, 0.2)
		draw.SimpleTextOutlined(nlf.msystem.config.langue[loc].txt17,"Font",0,-20,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,0,1.5,Color(0, 0, 0, 255) )
		
	cam.End3D2D()
end