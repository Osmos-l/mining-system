include("shared.lua");
ENT.RenderGroup = RENDERGROUP_BOTH;


surface.CreateFont( "Font", {
	font = "Coolvetica",
	size = 50,
	weight = 1000,
} )

surface.CreateFont( "Font2", {
    font = "Roboto",
    size = 20,
    weight = 1000,
} )

function ENT:DrawTranslucent()
	self:Draw();
end;

local texture = Material(nlf.msystem.config.npclicenceicon)

function ENT:Draw()
	self:DrawModel()

	local eye = LocalPlayer():EyeAngles()
	local Pos = self:LocalToWorld( self:OBBCenter() )+Vector( 0, 0, 50 )
	local Ang = Angle( 0, eye.y - 90, 90 )
	local clr = HSVToColor(((CurTime()*10)%360), 0.5, 0.5)
	
	if self:GetPos():Distance( LocalPlayer():GetPos() ) > 500 then return end
	cam.Start3D2D(Pos + Vector( 0, 0, math.sin( CurTime() ) * 2 ), Ang, 0.2)
		draw.SimpleTextOutlined(nlf.msystem.config.namebot,"Font",0,-20,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,0,1.5,Color(0, 0, 0, 255) )
		draw.SimpleTextOutlined(nlf.msystem.config.namebot2,"Font2",0,25,Color(clr.r, clr.g, clr.b, 220),TEXT_ALIGN_CENTER,0,1,Color(0, 0, 0, 255) )
		
		
			surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(texture)
		surface.DrawTexturedRect(-10, -60, 32, 32)	
	cam.End3D2D()
end
