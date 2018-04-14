include("shared.lua")
local loc =  nlf.msystem.config.langue.LocalLang
function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local Ang2 = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")

	surface.SetFont("HUDNumber5")
	local text = owner
	local text2 = nlf.msystem.config.langue[loc].txt15.." "..self:GetNWInt("amount") .. " "..nlf.msystem.config.langue[loc].money
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(text2)
	local width = TextWidth2 --((TextWidth+10)/100)*((100/8)*self:GetNWInt("amount"))

	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 90)
	
	Ang2:RotateAroundAxis(Ang2:Up(), 90)
	Ang2:RotateAroundAxis(Ang2:Forward(), 90)
	Ang2:RotateAroundAxis(Ang2:Right(), 270)
	
		local color = {0 ,150}
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then
		cam.Start3D2D(Pos+Ang:Right()*-9+Ang:Up()*17+Ang:Forward()*-10, Ang, 0.11)
			draw.SimpleTextOutlined( nlf.msystem.config.langue[loc].txt16, "HUDNumber5", 24, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()
		
		cam.Start3D2D(Pos+Ang:Right()*-4+Ang:Up()*17+Ang:Forward()*-10, Ang, 0.1)
			draw.RoundedBox( 0, -5, -4, TextWidth+10, 45, Color(0,0,0,150) )
			draw.SimpleTextOutlined( text, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()

		cam.Start3D2D(Pos+Ang:Right()*1.5+Ang:Up()*17+Ang:Forward()*-10, Ang, 0.1)
			draw.RoundedBox( 0, -5, -4, TextWidth2+10, 45, Color(0,0,0,150) )
			draw.RoundedBox( 0, -6, -5, width+2, 47, Color(0,255,0, color[1]) )
			draw.SimpleTextOutlined( text2, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0) )
		cam.End3D2D()
		
		cam.Start3D2D(Pos+Ang:Right()*-9+Ang:Up()*-17+Ang:Forward()*10, Ang2, 0.11)
			draw.SimpleTextOutlined( nlf.msystem.config.langue[loc].txt16, "HUDNumber5", 24, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()
		
		cam.Start3D2D(Pos+Ang:Right()*-4+Ang:Up()*-17+Ang:Forward()*10, Ang2, 0.1)
			draw.RoundedBox( 0, -5, -4, TextWidth+10, 45, Color(0,0,0,150) )
			draw.SimpleTextOutlined( text, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,150) )
		cam.End3D2D()

		cam.Start3D2D(Pos+Ang:Right()*1.5+Ang:Up()*-17+Ang:Forward()*10, Ang2, 0.1)
			draw.RoundedBox( 0, -5, -4, TextWidth2+10, 45, Color(0,0,0,150) )
			draw.RoundedBox( 0, -6, -5, width+2, 47, Color(0,255,0, color[1]) )
			draw.SimpleTextOutlined( text2, "HUDNumber5", 0, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0) )
		cam.End3D2D()
		
	end
end