include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH


function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:Draw()
	self:DrawModel()
	
	if self:GetPos():Distance( LocalPlayer():GetPos() ) > 500 then return end
	
	local eye = LocalPlayer():EyeAngles()
	local Pos = self:LocalToWorld( self:OBBCenter() )+Vector( 0, 0, 50 )
	local Ang = Angle( 0, eye.y - 90, 90 )
	
	cam.Start3D2D(Pos + Vector( 0, 0, math.sin( CurTime() ) * 2 ), Ang, 0.2)
		draw.SimpleTextOutlined("Mystérieuse femme","Font",0,-20,Color(173, 188, 32),TEXT_ALIGN_CENTER,0,1.5,Color(0, 0, 0, 255) )	
	cam.End3D2D()
end
