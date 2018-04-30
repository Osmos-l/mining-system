local loc =  nlf.msystem.config.langue.LocalLang

local blur = Material("pp/blurscreen")

local function blurPanel(HtmlPanel, amount)
    local x, y = HtmlPanel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 6 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

local function panellicence(nbr)
local name
if nbr == 1 then -- Search Licence
name =  nlf.msystem.config.langue[loc].txt40
elseif nbr == 2 then -- Delete licence
name = nlf.msystem.config.langue[loc].txt41
end 

local frame1 = vgui.Create("DFrame")
    frame1:SetTitle("")
    frame1:SetSize(300, 150)
    frame1:Center()
    frame1:ShowCloseButton(true)
    frame1:MakePopup()

    frame1.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(89, 89, 89, 255))
        draw.RoundedBox(0, 0, 0, w, 30, Color(226, 0, 0, 250))
        draw.DrawText(name, "nlf_msystem_textprincipal", self:GetWide() / 2, 4, color_white, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawOutlinedRect(0, 0, w, h)
    end
	local TextEntry = vgui.Create( "DTextEntry", frame1 )
	TextEntry:SetPos( frame1:GetWide()*0.2, 50 )
	TextEntry:SetSize( 200, 30 )
	TextEntry:SetText( nlf.msystem.config.langue[loc].txt42 )
	
	local BOK = vgui.Create("DButton", frame1)
	BOK:SetSize(130, 50)
	BOK:SetPos(frame1:GetWide()*0.5, 100)
	BOK:SetText(nlf.msystem.config.langue[loc].txt43)
	BOK:SetFont("ChatFont")
	BOK:SizeToContents()
	BOK:SetTextColor(Color(255, 255, 255, 255))
	BOK.Paint = function(self, w, h)
		local kcol

		if self.hover then
			kcol = Color(150, 0, 0)
		else
			kcol = Color(226, 0, 0)
		end

		draw.RoundedBoxEx(0, 0, 0, w, h, Color(226, 0, 0), false, false, true, true)
		draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
	end

	BOK.DoClick = function()
			surface.PlaySound( nlf.msystem.config.panel.soundonclick )
		if nbr == 1 then
		net.Start("M::CopCheckLicence")
		net.WriteString( TextEntry:GetValue() )
		net.SendToServer()
		elseif nbr == 2 then
		net.Start("M::CopDeleteLicence")
		net.WriteString( TextEntry:GetValue() )
		net.SendToServer()
		end 
				frame1:Close()
	end	

	BOK.OnCursorEntered = function(self)
		self.hover = true
		surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
	end

	BOK.OnCursorExited = function(self)
		self.hover = false
	end
end 

net.Receive("M::Jobspanel", function(len, pl)
local pl = LocalPlayer()
if pl.use == NILL or pl.use == NULL then pl.use = true end
local frame1 = vgui.Create("DFrame")
    frame1:SetTitle("")
    frame1:SetSize(900, 600)
    frame1:SetAlpha(0)
    frame1:AlphaTo(255, 0.25)
    frame1:Center()
    frame1:ShowCloseButton(true)
    frame1:MakePopup()

    frame1.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
        draw.RoundedBox(0, 0, 0, w, 30, Color(226, 0, 0, 250))
        draw.DrawText(nlf.msystem.config.langue[loc].txt44, "nlf_msystem_textprincipal", self:GetWide() / 2, 4, color_white, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawOutlinedRect(0, 0, w, h)
		
		        draw.DrawText(nlf.msystem.config.langue[loc].txt45, "nlf_msystem_textprincipal", self:GetWide()*0.4, 65, color_white, TEXT_ALIGN_CENTER)
				draw.DrawText(nlf.msystem.config.langue[loc].txt46.." " .. nlf.msystem.config.namebot, "ChatFont", self:GetWide()*0.4, 90, color_white, TEXT_ALIGN_CENTER)
				draw.DrawText(nlf.msystem.config.langue[loc].txt47.." " .. string.upper(nlf.msystem.config.amountlicence) .. nlf.msystem.config.langue[loc].money, "ChatFont", self:GetWide()*0.4, 105, color_white, TEXT_ALIGN_CENTER)
				draw.DrawText(nlf.msystem.config.langue[loc].txt48.." " .. string.upper(nlf.msystem.config.rockprice)..nlf.msystem.config.langue[loc].money, "ChatFont", self:GetWide()*0.4, 120, color_white, TEXT_ALIGN_CENTER)
				draw.DrawText(nlf.msystem.config.langue[loc].txt49.." " .. string.upper(nlf.msystem.config.processtime).."'s", "ChatFont", self:GetWide()*0.4, 135, color_white, TEXT_ALIGN_CENTER)
		
				
				draw.DrawText(nlf.msystem.config.langue[loc].txt50.." "..LocalPlayer():GetName().." ?", "nlf_msystem_textprincipal", self:GetWide()*0.5, 250, color_white, TEXT_ALIGN_CENTER)
    end

		
								local IconModel = vgui.Create("DModelPanel", frame1)
				IconModel:SetModel(nlf.msystem.config.skin)
				IconModel:SetPos(frame1:GetWide()*0.7, 30)
				IconModel:SetSize(100, 150)
				function IconModel:LayoutEntity(Entity)
					return
				end
				local headpos = IconModel.Entity:GetBonePosition(IconModel.Entity:LookupBone("ValveBiped.Bip01_Head1"))
				IconModel:SetLookAt(headpos)
				IconModel:SetCamPos(headpos - Vector(-15, 0, 0))
				
	local B1 = vgui.Create("DButton", frame1)
B1:SetSize(130, 50)
B1:SetPos(frame1:GetWide()*0.25, 300)
B1:SetText(nlf.msystem.config.langue[loc].txt51)
B1:SetFont("ChatFont")
B1:SizeToContents()
B1:SetTextColor(Color(255, 255, 255, 255))

B1.Paint = function(self, w, h)
    local kcol

    if self.hover then
        kcol = Color(150, 0, 0)
    else
        kcol = Color(226, 0, 0)
    end

    draw.RoundedBoxEx(0, 0, 0, w, h, Color(226, 0, 0), false, false, true, true)
    draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
end

B1.DoClick = function()
		if pl.use == true then
		pl.use = false
		surface.PlaySound( nlf.msystem.config.panel.soundonclick )
		for k, v in pairs( ents.FindByClass( "nlf_mlicence" ) ) do 
			hook.Add("HUDPaint", "MSystem::Prop", function()
				local Position = ( v:GetPos() + Vector( 0, 0, 80 ) ):ToScreen() // the author of this feature is not me but this developer https://slownls.fr/
				if math.Round ( LocalPlayer():GetPos():Distance( v:GetPos() ) ) >= 300 then
					draw.SimpleTextOutlined( "●","ChatFont", Position.x, Position.y - 15, Color( 255,50,50 ) ,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25,25,25 ) )
					draw.SimpleTextOutlined(  math.Round( LocalPlayer():GetPos():Distance( v:GetPos() ) / 10 ) .. "m", "ChatFont", Position.x, Position.y, Color( 230,230,230 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25,25,25 ) )
				end
			end)
		chat.AddText( Color( 255, 255, 255 ), nlf.msystem.config.langue[loc].txt55 )
		timer.Simple( 30, function() hook.Remove( "HUDPaint", "MSystem::Prop" ) pl.use = true end )
		end 
		else 
		chat.AddText( Color( 226, 0, 0 ), nlf.msystem.config.langue[loc].txt52 )
		end 
end

B1.OnCursorEntered = function(self)
    self.hover = true
	surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
end

B1.OnCursorExited = function(self)
    self.hover = false
end
	
	local B2 = vgui.Create("DButton", frame1)
B2:SetSize(130, 50)
B2:SetPos(frame1:GetWide()*0.60, 300)
B2:SetText(nlf.msystem.config.langue[loc].txt53)
B2:SetFont("ChatFont")
B2:SizeToContents()
B2:SetTextColor(Color(255, 255, 255, 255))

B2.Paint = function(self, w, h)
    local kcol

    if self.hover then
        kcol = Color(150, 0, 0)
    else
        kcol = Color(226, 0, 0)
    end

    draw.RoundedBoxEx(0, 0, 0, w, h, Color(226, 0, 0), false, false, true, true)
    draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
end

B2.DoClick = function()
		if pl.use == true then
		surface.PlaySound( nlf.msystem.config.panel.soundonclick )
			pl.use = false
		for k, v in pairs( ents.FindByClass( "nlf_mfonderie" ) ) do 
			hook.Add("HUDPaint", "MSystem::Process", function()
				local Position = ( v:GetPos() + Vector( 0, 0, 80 ) ):ToScreen()
				if math.Round ( LocalPlayer():GetPos():Distance( v:GetPos() ) ) >= 300 then // the author of this feature is not me but this developer https://slownls.fr/
					draw.SimpleTextOutlined( "●","ChatFont", Position.x, Position.y - 15, Color( 255,50,50 ) ,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25,25,25 ) )
					draw.SimpleTextOutlined(  math.Round( LocalPlayer():GetPos():Distance( v:GetPos() ) / 10 ) .. "m", "ChatFont", Position.x, Position.y, Color( 230,230,230 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25,25,25 ) )
				end
			end)
		chat.AddText( Color( 255, 255, 255 ), nlf.msystem.config.langue[loc].txt55 )
		timer.Simple( 30, function() hook.Remove( "HUDPaint", "MSystem::Process" ) pl.use = true end )
		end 
				else 
		chat.AddText( Color( 226, 0, 0 ), nlf.msystem.config.langue[loc].txt52 )
		end 
end

B2.OnCursorEntered = function(self)
    self.hover = true
	surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
end

B2.OnCursorExited = function(self)
    self.hover = false
end	

	local B3 = vgui.Create("DButton", frame1)
B3:SetSize(130, 50)
B3:SetPos(frame1:GetWide()*0.25, 350)
B3:SetText(nlf.msystem.config.langue[loc].txt54)
B3:SetFont("ChatFont")
B3:SizeToContents()
B3:SetTextColor(Color(255, 255, 255, 255))

B3.Paint = function(self, w, h)
    local kcol

    if self.hover then
        kcol = Color(150, 0, 0)
    else
        kcol = Color(226, 0, 0)
    end

    draw.RoundedBoxEx(0, 0, 0, w, h, Color(226, 0, 0), false, false, true, true)
    draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
end

B3.DoClick = function()
		if pl.use == true then
		pl.use = false
		surface.PlaySound( nlf.msystem.config.panel.soundonclick )
				for k, v in pairs( ents.FindByClass( "nlf_mbuyer" ) ) do 
			hook.Add("HUDPaint", "MSystem::Buyer", function()
				local Position = ( v:GetPos() + Vector( 0, 0, 80 ) ):ToScreen()
				if math.Round ( LocalPlayer():GetPos():Distance( v:GetPos() ) ) >= 300 then // the author of this feature is not me but this developer https://slownls.fr/
					draw.SimpleTextOutlined( "●","ChatFont", Position.x, Position.y - 15, Color( 255,50,50 ) ,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25,25,25 ) )
					draw.SimpleTextOutlined(  math.Round( LocalPlayer():GetPos():Distance( v:GetPos() ) / 10 ) .. "m", "ChatFont", Position.x, Position.y, Color( 230,230,230 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25,25,25 ) )
				end
			end)
				chat.AddText( Color( 255, 255, 255 ), nlf.msystem.config.langue[loc].txt55 )
		timer.Simple( 30, function() hook.Remove( "HUDPaint", "MSystem::Buyer" ) pl.use = true end )
		end 
				else 
		chat.AddText( Color( 226, 0, 0 ), nlf.msystem.config.langue[loc].txt52 )
		end
end

B3.OnCursorEntered = function(self)
    self.hover = true
	surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
end

B3.OnCursorExited = function(self)
    self.hover = false
end

	local B4 = vgui.Create("DButton", frame1)
B4:SetSize(130, 50)
B4:SetPos(frame1:GetWide()*0.6, 350)
B4:SetText(nlf.msystem.config.langue[loc].txt40)
B4:SetFont("ChatFont")
B4:SizeToContents()
B4:SetTextColor(Color(255, 255, 255, 255))

B4.Paint = function(self, w, h)
    local kcol

    if self.hover then
        kcol = Color(150, 0, 0)
    else
        kcol = Color(226, 0, 0)
    end

    draw.RoundedBoxEx(0, 0, 0, w, h, Color(226, 0, 0), false, false, true, true)
    draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
end

B4.DoClick = function()
		surface.PlaySound( nlf.msystem.config.panel.soundonclick )
		panellicence(1)
	
end

B4.OnCursorEntered = function(self)
    self.hover = true
	surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
end

B4.OnCursorExited = function(self)
    self.hover = false
end

	local B5 = vgui.Create("DButton", frame1)
B5:SetSize(130, 50)
B5:SetPos(frame1:GetWide()*0.25, 400)
B5:SetText(nlf.msystem.config.langue[loc].txt41)
B5:SetFont("ChatFont")
B5:SizeToContents()
B5:SetTextColor(Color(255, 255, 255, 255))

B5.Paint = function(self, w, h)
    local kcol

    if self.hover then
        kcol = Color(150, 0, 0)
    else
        kcol = Color(226, 0, 0)
    end

    draw.RoundedBoxEx(0, 0, 0, w, h, Color(226, 0, 0), false, false, true, true)
    draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
end

B5.DoClick = function()
		surface.PlaySound( nlf.msystem.config.panel.soundonclick )
		panellicence(2)	
end

B5.OnCursorEntered = function(self)
    self.hover = true
	surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
end

B5.OnCursorExited = function(self)
   self.hover = false
end
end)
net.Receive("M::PanelBuyer", function(len, ply)
    local frame1 = vgui.Create("DFrame")
    frame1:SetTitle("")
    frame1:SetSize(450, 220)
    frame1:SetAlpha(0)
    frame1:AlphaTo(255, 0.25)
    frame1:Center()
    frame1:ShowCloseButton(false)
    frame1:MakePopup()

    frame1.Paint = function(self, w, h)
        blurPanel(self, 2)
    draw.RoundedBox(10, 0, 0, w, h, Color( 0, 0, 0, 200 ))
    draw.RoundedBox(0, 0, 0, w, 30, Color(173, 188, 32))
        draw.DrawText("Mystérieuse femme !", "nlf_msystem_textprincipal", self:GetWide() / 2, 4, color_white, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local text_panel = vgui.Create("DLabel", frame1)
    text_panel:SetPos(10, 5)
    text_panel:SetSize(440, 175)
    text_panel:SetFont("ChatFont")
    text_panel:SetTextColor(Color(255, 255, 255, 255))
    text_panel:SetText("Salut,\nTu as quelque chose pour moi ?\nLa pierre m'intéresse beaucoup tu sais, alors si tu peux en trouver pour moi je pourrais surement  te remercier avec beaucoup d'argent, mais attention personne ne doit savoir que j'existe et encore moins où je suis !") 
    text_panel:SetWrap(true)

    local B1 = vgui.Create("DButton", frame1)
    B1:SetSize(130, 50)
    B1:SetPos(30, 170)
    B1:SetText("Voilà pour toi !")
    B1:SetFont("ChatFont")
    B1:SizeToContents()
    B1:SetTextColor(Color(255, 255, 255, 255))

    B1.Paint = function(self, w, h)
        local kcol

        if self.hover then
            kcol = Color(138, 150, 27)
        else
            kcol = Color(173, 188, 32)
        end

        draw.RoundedBoxEx(0, 0, 0, w, h, Color(173, 188, 32), false, false, true, true)
        draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
    end

    B1.DoClick = function()
        surface.PlaySound(nlf.msystem.config.panel.soundonclick)
        net.Start("M::IllegalSellrock")
        net.WriteEntity(net.ReadEntity())
        net.SendToServer()
        frame1:Remove()
    end

    B1.OnCursorEntered = function(self)
        self.hover = true
        surface.PlaySound(nlf.msystem.config.panel.soundoncursor)
    end

    B1.OnCursorExited = function(self)
        self.hover = false
    end

    local B2 = vgui.Create("DButton", frame1)
    B2:SetSize(130, 50)
    B2:SetPos(230, 170)
    B2:SetText("Je n'ai rien pour toi")
    B2:SetFont("ChatFont")
    B2:SizeToContents()
    B2:SetTextColor(Color(255, 255, 255, 255))

    B2.Paint = function(self, w, h)
        local kcol

        if self.hover then
            kcol = Color(138, 150, 27)
        else
            kcol = Color(173, 188, 32)
        end
        draw.RoundedBoxEx(0, 0, 0, w, h, Color(173, 188, 32), false, false, true, true)
        draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
    end

    B2.DoClick = function()
        surface.PlaySound(nlf.msystem.config.panel.soundonclick)
        frame1:Remove()
    end

    B2.OnCursorEntered = function(self)
        self.hover = true
        surface.PlaySound(nlf.msystem.config.panel.soundoncursor)
    end

    B2.OnCursorExited = function(self)
        self.hover = false
    end
end)
