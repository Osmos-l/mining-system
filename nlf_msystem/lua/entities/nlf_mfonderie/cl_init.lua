include("shared.lua")
local price = nlf.msystem.config.rockprice 
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")

	local TIMER;
	local width = self:GetNWInt("width");
	if (self:GetNWInt('timer') < CurTime()) then
		TIMER = 0
	else 
		TIMER = self:GetNWInt('timer')-CurTime()
	end
	
	surface.SetFont("HUDNumber5")

	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	local TextAng = Ang
	local eye = LocalPlayer():EyeAngles()

	local process = nlf.msystem.config.langue[loc].txt22.." "..string.ToMinutesSeconds(TIMER)
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then
		cam.Start3D2D(Pos+Ang:Right()*-20+Ang:Up()*13+Ang:Forward()*-3.5, Ang, 0.15)
			draw.SimpleTextOutlined( nlf.msystem.config.langue[loc].txt23, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()
		

	
	cam.Start3D2D(self:LocalToWorld( self:OBBCenter() )+Vector( 0, 0, 50 ) + Vector( 0, 0, math.sin( CurTime() ) * 2 ), Angle( 0, eye.y - 90, 90 ), 0.2)
		draw.SimpleTextOutlined(process,"Font",0,-20,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,0,1.5,Color(0, 0, 0, 255) )
		draw.SimpleTextOutlined( nlf.msystem.config.langue[loc].txt24.." "..(self:GetNWInt("getRock")*price ).." "..nlf.msystem.config.langue[loc].money,"Font2",0,25,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,0,1,Color(0, 0, 0, 255) )	
	cam.End3D2D()
		
	
	end
end