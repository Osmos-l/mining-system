include("shared.lua")
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local Ang2 = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")

	local TIMER;
	if (self:GetNWInt("rock") > 0) then
		TIMER = 1
	else 
		TIMER = 0
	end
	
	surface.SetFont("HUDNumber5")
	local text = nlf.msystem.config.langue[loc].txt19.." "..owner
	local text2 = nlf.msystem.config.langue[loc].txt20.." "..self:GetNWInt("rock")
	local TextWidth = surface.GetTextSize(text)
	local width = ((TextWidth+10)/100)*((100/10)*self:GetNWInt("rock"))

	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 90)
	
	Ang2:RotateAroundAxis(Ang2:Up(), 90)
	Ang2:RotateAroundAxis(Ang2:Forward(), 90)
	Ang2:RotateAroundAxis(Ang2:Right(), 270)
	
	local color
	if (TIMER > 0) then
		color = {150, 50}
	else
		color = {0, 150}
	end
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then
		cam.Start3D2D(Pos+Ang:Right()*-9.5+Ang:Up()*17+Ang:Forward()*-20, Ang, 0.11)
			draw.SimpleTextOutlined( nlf.msystem.config.langue[loc].txt21, "HUDNumber5", 24, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()
		
		cam.Start3D2D(Pos+Ang:Right()*-4+Ang:Up()*17+Ang:Forward()*-17, Ang, 0.1)
			draw.RoundedBox( 0, -5, -4, TextWidth+10, 45, Color(0,0,0,150) )
			draw.SimpleTextOutlined( text, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()

		cam.Start3D2D(Pos+Ang:Right()*1.5+Ang:Up()*17+Ang:Forward()*-17, Ang, 0.1)
			draw.RoundedBox( 0, -5, -4, TextWidth+10, 45, Color(0,0,0,150) )
			draw.RoundedBox( 0, -6, -5, width+2, 47, Color(0,255,0, color[1]) )
			draw.SimpleTextOutlined( text2, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0) )
		cam.End3D2D()
		
		cam.Start3D2D(Pos+Ang:Right()*-9.5+Ang:Up()*-17+Ang:Forward()*25, Ang2, 0.11)
			draw.SimpleTextOutlined( nlf.msystem.config.langue[loc].txt21, "HUDNumber5", 24, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()
		
		cam.Start3D2D(Pos+Ang:Right()*-4+Ang:Up()*-17+Ang:Forward()*22, Ang2, 0.1)
			draw.RoundedBox( 0, -5, -4, TextWidth+10, 45, Color(0,0,0,150) )
			draw.SimpleTextOutlined( text, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()

		cam.Start3D2D(Pos+Ang:Right()*1.5+Ang:Up()*-17+Ang:Forward()*22, Ang2, 0.1)
			draw.RoundedBox( 0, -5, -4, TextWidth+10, 45, Color(0,0,0,150) )
			draw.RoundedBox( 0, -6, -5, width+2, 47, Color(0,255,0, color[1]) )
			draw.SimpleTextOutlined( text2, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0) )
		cam.End3D2D()
		
	end
end