
surface.CreateFont( "nlf_msystem_panel", {
	font = "CloseCaption_Normal",
	size = 24,
	weight = 1000
} )

surface.CreateFont( "nlf_msystem_textprincipal", {
	font = "CloseCaption_BoldItalic",
	size = 22,
	weight = 1000
} )

surface.CreateFont( "MSystem_Use", { -- darkrp_modules/msystem/sh_addhud.lua
	font = "Coolvetica",
	size = 20,
	weight = 500,
	antialias = true,
} )

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

local function DrawPopUpFrame()
		local frame = vgui.Create("DFrame")
		frame:SetTitle("")
		frame:SetSize(ScrW()*0.3, ScrH() *0.4)
		frame:SetAlpha(0)
		frame:AlphaTo(255, 0.25)
		frame:Center()
		frame:ShowCloseButton(false)
		frame:MakePopup()
		frame.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255) )
			draw.RoundedBox(0, 0, 0, w, 30, Color(41, 128, 255, 250) )
		
			draw.DrawText(nameframepopup, "nlf_msystem_textprincipal", self:GetWide()/2, 4, Color(41, 128, 255, 250), TEXT_ALIGN_CENTER)
 
			surface.SetDrawColor( 0, 0, 0 )
			surface.DrawOutlinedRect( 0, 0, w, h )
		end
	
		local but = vgui.Create( "DButton", frame )
		but:SetColor(Color(44, 62, 80, 60))
		but:SetText("OK")
		but:SetTextColor(color_white)
		but:SetFont("nlf_msystem_textprincipal")
		but:SetSize(0, 37)
		but:Dock(BOTTOM)
		but.DoClick = function()
			frame:Close()            
		end
		but.Paint = function(self, w, h)
			local bcol
           
			if self.Hovered then
				bcol = Color(41, 128, 255, 100)
			else
			bcol = Color(44, 62, 80, 60)
			end
				draw.RoundedBox(0, 0, 0, w, h, bcol)
			
				surface.SetDrawColor( 0, 0, 0 )
				surface.DrawOutlinedRect( 0, 0, w, h )
			end
		
		local dl = vgui.Create( "RichText", frame )
		dl:Dock(FILL)
		dl:InsertColorChange( 255, 255, 255, 255 )
		dl:AppendText( TEXTFRAME )
		dl:SetFontInternal("nlf_msystem_textprincipal")
		dl:SetVerticalScrollbarEnabled( true )
		
		function dl:PerformLayout()

			self:SetFontInternal("nlf_msystem_textprincipal")

		end
		
	end		

net.Receive("MSystem:OpenPanelLicence", function(len, pl)

	if nlf.msystem.config.panel.usemusic then 
		if nlf.msystem.config.panel.usefilemusic then 
			sound.PlayFile( nlf.msystem.config.panel.filemusic, "", function( station )
				if ( IsValid( station ) ) then audio = station station:Play() end
			end )
		else 
			sound.PlayURL ( nlf.msystem.config.panel.filemusic, "", function( station )
				if ( IsValid( station ) ) then audio = station station:Play() end
			end )
			
		
		end 
	end 

local HtmlPanel = vgui.Create("DFrame")
HtmlPanel:SetSize(960, 560) 
HtmlPanel:Center()
HtmlPanel:SetTitle("")
HtmlPanel:SetVisible(true)
HtmlPanel:SetDraggable(true)
HtmlPanel:ShowCloseButton(false)
HtmlPanel:MakePopup()

HtmlPanel.Paint = function(self, w, h)
    blurPanel(self, 5)
    draw.RoundedBox(10, 0, 0, w, h, Color( 0, 0, 0, 200 ))
    draw.SimpleText(nlf.msystem.config.namebot, "nlf_msystem_panel", HtmlPanel:GetWide() - 550, 15, Color( 190, 190, 190 ))
    surface.SetDrawColor(Color(242, 242, 242, 255))
    surface.DrawLine(0, 43, HtmlPanel:GetWide(), 43)
end

local Icl = vgui.Create("DButton", HtmlPanel)
Icl:SetSize(50, 20)
Icl:SetPos(HtmlPanel:GetWide() - 50, 0)
Icl:SetText("X")
Icl:SetFont("fontclose")
Icl:SetTextColor(Color(255, 255, 255, 255))

Icl.Paint = function(self, w, h)
    local kcol

    if self.hover then
        kcol = Color(255, 150, 150, 255)
    else
        kcol = Color(175, 100, 100)
    end

    draw.RoundedBoxEx(0, 0, 0, w, h, Color(255, 150, 150, 255), false, false, true, true)
    draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
end

Icl.DoClick = function()
		surface.PlaySound( nlf.msystem.config.panel.soundonclick )
    HtmlPanel:Close()
	if nlf.msystem.config.panel.usemusic and audio then 
		audio:Stop()
   end 
end

Icl.OnCursorEntered = function(self)
    self.hover = true
	surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
end

Icl.OnCursorExited = function(self)
    self.hover = false
end

local DPanelO = vgui.Create("DPanel", HtmlPanel)
DPanelO:SetPos(0, 44)
DPanelO:SetSize(HtmlPanel:GetWide(), 525 - 57)

DPanelO.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, DPanelO:GetWide(), DPanelO:GetTall(), Color( 50, 50, 50, 250 ))
	

    if nlf.msystem.config.panel.useicon then
        local Rotating = math.sin(CurTime() * 3)
        local backwards = 0

        if Rotating < 0 then
            Rotating = 1 - (1 + Rotating)
            backwards = 0
        end

       surface.SetMaterial(Material(nlf.msystem.config.npclicenceicon))
        surface.SetDrawColor(Color(242, 242, 242, 255))

        if nlf.msystem.config.panel.iconrotating then
            surface.DrawTexturedRectRotated(DPanelO:GetWide() / 2, 30, Rotating * 65, 65, backwards)
 
        else
            surface.DrawTexturedRect(DPanelO:GetWide() / 2, 16, 65, 65)
        end
    end
end

	local DPanelB = vgui.Create("DPanel", HtmlPanel)
DPanelB:SetPos(0, 330)
DPanelB:SetSize(HtmlPanel:GetWide(), 225)
DPanelB.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, DPanelB:GetWide(), DPanelB:GetTall(),  Color( 50, 50, 50, 250 ))
	end 

local scroll = vgui.Create("DScrollPanel", DPanelB)
	scroll:SetSize(811, 464)	
	scroll:Dock(FILL)
	local scrollbar = scroll:GetVBar()     
       
    function scrollbar:Paint( w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
    end
   
    function scrollbar.btnGrip:Paint( w, h )
        draw.RoundedBox( 0, 4, 0, w, h, nlf.msystem.config.scrollbar )
    end
   
    function scrollbar.btnUp:Paint( w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
    end
   
    function scrollbar.btnDown:Paint( w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
    end

local IconModel = vgui.Create("DModelPanel", DPanelO)
IconModel:SetModel(nlf.msystem.config.skin)
IconModel:SetPos(50, 70)
IconModel:SetSize(200, 200)

function IconModel:LayoutEntity(Entity)
    return
end


if table.HasValue(nlf.msystem.config.adminpanel.access, LocalPlayer():GetUserGroup()) then 
local Acl = vgui.Create("DButton", HtmlPanel)
Acl:SetSize(50, 20)
Acl:SetPos( 0, 0)
Acl:SetText("Admin")
Acl:SetFont("fontclose")
Acl:SetTextColor(Color(255, 255, 255, 255))

Acl.Paint = function(self, w, h)
    local kcol

    if self.hover then
        kcol = Color(255, 150, 150, 255)
    else
        kcol = Color(175, 100, 100)
    end

    draw.RoundedBoxEx(0, 0, 0, w, h, Color(255, 150, 150, 255), false, false, true, true)
    draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
end

Acl.DoClick = function()
		surface.PlaySound( nlf.msystem.config.panel.soundonclick )
   		net.Start( "M::OpenAdmin:cl" )
		net.SendToServer() 
		
end

Acl.OnCursorEntered = function(self)
    self.hover = true
	surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
end

Acl.OnCursorExited = function(self)
    self.hover = false
end

end

local headpos = IconModel.Entity:GetBonePosition(IconModel.Entity:LookupBone("ValveBiped.Bip01_Head1"))
IconModel:SetLookAt(headpos)
IconModel:SetCamPos(headpos - Vector(-15, 0, 0))
IconModel.Entity:SetEyeTarget(headpos - Vector(-15, 0, 0))

local text_panel = vgui.Create("DLabel", DPanelO)
text_panel:SetPos(275, 70)
text_panel:SetSize(HtmlPanel:GetWide() - 275, 200)
text_panel:SetFont("nlf_msystem_textprincipal")
text_panel:SetText(nlf.msystem.config.panel.textprincipal)
text_panel:SetTextColor(Color( 255, 255, 255, 255 ))
text_panel:SetWrap(true)

local AddButoon = 0

for k, v in pairs(nlf.msystem.config.button) do
        if v.name == nil then return false end
        if v.action == nil then return false end
        local DermaR1Button = vgui.Create("DButton", scroll)
        DermaR1Button:SetText(v.name)
        DermaR1Button:SetFont("nlf_msystem_panel")
        DermaR1Button:SetTextColor(nlf.msystem.config.button.namecolor)
        DermaR1Button:SetPos(24, 0 + AddButoon)
        DermaR1Button:SetSize(HtmlPanel:GetWide() - 50, 30)

        DermaR1Button.Paint = function(self, w, h)
            draw.RoundedBox(4, 2, 2, w - 4, h - 4, nlf.msystem.config.button.buttonColor)

            if self.hover then
                draw.RoundedBox(4, 1, 1, w - 2, h - 2, nlf.msystem.config.button.cursorenteredColor)
            end
        end

        DermaR1Button.DoClick = function(panel, id)
		surface.PlaySound( nlf.msystem.config.panel.soundonclick )
            nameframepopup = DermaR1Button:GetText()
            if v.action == "txt" then
                TEXTFRAME = v.text
                DrawPopUpFrame()
            elseif v.action == "buylicence" then
           			net.Start( "M::BuyLicence" )
					net.SendToServer()	
            elseif v.action == "shop" then
					net.Start( "M::CheckLicence" )
					net.WriteString( "shop" )
					net.WriteEntity( net.ReadEntity() )
					net.SendToServer()					
            elseif v.action == "exit" then
                HtmlPanel:Close()
                if audio then 
					audio:Stop()
				end 
            end
        end

        DermaR1Button.OnCursorEntered = function(self)
            self.hover = true
			surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
        end

        DermaR1Button.OnCursorExited = function(self)
            self.hover = false
        end

        AddButoon = AddButoon + 30
end
end)

local function M_Dermashop( ent )

local HtmlPanel = vgui.Create("DFrame")
HtmlPanel:SetSize(960, 560) 
HtmlPanel:Center()
HtmlPanel:SetTitle("")
HtmlPanel:SetVisible(true)
HtmlPanel:SetDraggable(true)
HtmlPanel:ShowCloseButton(true)
HtmlPanel:MakePopup()

HtmlPanel.Paint = function(self, w, h)
    blurPanel(self, 5)
    draw.RoundedBox(10, 0, 0, w, h, Color( 0, 0, 0, 200 ))
    draw.SimpleText(nlf.msystem.config.langue[loc].txt8, "nlf_msystem_panel", HtmlPanel:GetWide() - 550, 15, nlf.msystem.config.panel.namebotcolor)
    surface.SetDrawColor(Color(242, 242, 242, 255))
    surface.DrawLine(0, 43, HtmlPanel:GetWide(), 43)
end

	local LIST = vgui.Create( "DPanelList", HtmlPanel )
	LIST:SetPos( 24, 54 )
	LIST:SetSize( HtmlPanel:GetWide() - 30, HtmlPanel:GetTall() - 54 )
	LIST:EnableVerticalScrollbar( true )
	LIST:SetSpacing( 2 )
	LIST:DockPadding( 0, 5, 10, 0 )
	LIST.VBar.Paint = function( s, w, h )
		draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70))
	end
	LIST.VBar.btnUp.Paint = function( s, w, h ) end
	LIST.VBar.btnDown.Paint = function( s, w, h ) end
	LIST.VBar.btnGrip.Paint = function( s, w, h )
		draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70))
	end


local Categories = {}
	
	if  table.HasValue(nlf.msystem.config.adminpanel.access, LocalPlayer():GetUserGroup() ) then
		table.insert( Categories, { Name = "ADMIN", Table = nlf.msystem.config.button.admin } )
	elseif table.HasValue(nlf.msystem.config.vipaccess, LocalPlayer():GetUserGroup() ) then
		table.insert( Categories, { Name = "VIP", Table = nlf.msystem.config.button.vip } )
	else 
		table.insert( Categories, { Name = "Basique", Table = nlf.msystem.config.button.basique } )
	end


for k, v in pairs( Categories ) do
		local ammoFrame = vgui.Create( "DCollapsibleCategory" )
		ammoFrame:SetSize( LIST:GetWide(), 100 )
		ammoFrame:SetExpanded( true )
		ammoFrame:SetLabel( "" )
		ammoFrame.Paint = function()
		
		end
		ammoFrame.PaintOver = function( self, w, h )
			draw.SimpleText( v.Name, "RP_SubFontThin", 10, 2, Color( 190, 190, 190, 255 ), TEXT_ALIGN_LEFT )
		end
		
		local liste = vgui.Create( "DPanelList", ammoFrame )
		liste:SetWide( LIST:GetWide() )
		liste:SetAutoSize( true )
		liste:SetSpacing( 2 )
		liste:SetPos( 0, 20 )
		liste:EnableVerticalScrollbar( false )
		liste.Paint = function( s, w, h )
			draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70))

			draw.RoundedBox( 0, 0, 0, w, h, Color(232,234,236,255))
		end
		for k, v in pairs( v.Table ) do
			local shopButton = vgui.Create( "DButton" )
			shopButton:SetSize( HtmlPanel:GetWide() - 50, 35 )
			shopButton:SetPos( 0, 0 )
			shopButton:SetText( v.NAME )
			shopButton:SetFont( "RP_ButtonFont" )
			shopButton:SetTextColor( Color( 255, 255, 255 ) )
			shopButton.Paint = function( self, w, h )
				draw.RoundedBox( 4, 0, 0, w, h, Color( 239, 239, 243 ) )
				draw.RoundedBox( 4, 1, 1, w - 2, h - 2, Color( 232, 76, 82 ) )
				draw.RoundedBox( 4, 2, 2, w - 4, h - 4, Color( 233, 84, 90 ) )
				draw.SimpleText( string.upper(v.PRIX).." "..nlf.msystem.config.langue[loc].money, "RP_SubFontThin", shopButton:GetWide()*0.55, shopButton:GetTall()*0.40, Color( 190, 190, 190, 255 ), TEXT_ALIGN_LEFT )
				if self.hover then
					draw.RoundedBox( 4, 1, 1, w - 2, h - 2, Color( 206, 68, 73 ) )
				end
			end
			shopButton.DoClick = function()
			surface.PlaySound( nlf.msystem.config.panel.soundonclick )
			net.Start( "M::BuyInshop" )
			net.WriteUInt(k , 16)
			net.WriteEntity( ent )
			net.SendToServer()
			end
			
			 shopButton.OnCursorEntered = function(self)
            self.hover = true
			surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
        end

        shopButton.OnCursorExited = function(self)
            self.hover = false
        end
			
			liste:AddItem( shopButton )
		end
		
		LIST:AddItem( ammoFrame )
		
	end
	
end 

net.Receive("M::HaveLicence", function(len, pl)
    if "shop" == net.ReadString() then
        M_Dermashop( net.ReadEntity() )
    end
end)

net.Receive("M::OpenAdmin", function(len, pl)
local mtabe = net.ReadTable()
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
        draw.DrawText("Admin Panel", "nlf_msystem_textprincipal", self:GetWide() / 2, 4, color_white, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawOutlinedRect(0, 0, w, h)
		
		surface.SetMaterial( nlf.msystem.config.searchicon )
		surface.SetDrawColor( Color( 242, 242, 242, 255) )
		surface.DrawTexturedRect( 210, 55, 25, 25 )	
    end

    local DataList = vgui.Create("DListView", frame1)
    DataList:Dock(FILL)
    DataList:DockMargin(250, 5, 5, 5)
    DataList:SetWidth(565)
    DataList:SetMultiSelect(false)
    DataList:AddColumn("ID"):SetFixedWidth(30)
    DataList:AddColumn("SteamID64"):SetFixedWidth(120)
    DataList:AddColumn("Name"):SetFixedWidth(120)
	DataList:AddColumn("Prix"):SetFixedWidth(50)
	DataList:AddColumn("Date"):SetFixedWidth(120)
	DataList.OnRowRightClick = function(DataList, line)
        local DropDown = DermaMenu()

        DropDown:AddOption(nlf.msystem.config.langue[loc].txt28, function()
            net.Start("M::AdminDeletelicence")
            net.WriteString(tostring(DataList:GetLine(line):GetValue(2)))
			net.SendToServer()
            DataList:Clear()
        end)
		
        DropDown:AddOption(nlf.msystem.config.langue[loc].txt29, function()
            SetClipboardText( tostring(DataList:GetLine(line):GetValue(2)) )
        end)
		DropDown:AddOption(nlf.msystem.config.langue[loc].txt30, function()
            SetClipboardText( tostring(DataList:GetLine(line):GetValue(3)) )
        end)
		DropDown:AddOption(nlf.msystem.config.langue[loc].txt31, function()
            SetClipboardText( tostring(DataList:GetLine(line):GetValue(5)) )
        end)
        DropDown:AddSpacer()
        DropDown:Open()
    end
    local OFFEntry = vgui.Create("DTextEntry", frame1)
    OFFEntry:SetPos(235, 50)
    OFFEntry:SetSize(200, 30)
    OFFEntry:SetText(nlf.msystem.config.langue[loc].txt32)
	
    local Vcl = vgui.Create("DButton", frame1)
    Vcl:SetSize(200, 30)
    Vcl:SetPos(235, 90)
    Vcl:SetText(nlf.msystem.config.langue[loc].txt33)
    Vcl:SetFont("fontclose")
    Vcl:SetTextColor(Color(255, 255, 255, 255))
    Vcl.Paint = function(self, w, h)
        local kcol

        if self.hover then
            kcol = Color(255, 150, 150, 255)
        else
            kcol = Color(175, 100, 100)
        end

        draw.RoundedBoxEx(0, 0, 0, w, h, Color(255, 150, 150, 255), false, false, true, true)
        draw.RoundedBoxEx(0, 1, 0, w - 2, h - 1, kcol, false, false, true, true)
    end

    Vcl.DoClick = function()
			surface.PlaySound( nlf.msystem.config.panel.soundonclick )
        DataList:Clear()
			net.Start("M::AdminDataOffline")
    		net.WriteString( OFFEntry:GetText() )
    		net.SendToServer()
    end

    		
    Vcl.OnCursorEntered = function(self)
        self.hover = true
			surface.PlaySound( nlf.msystem.config.panel.soundoncursor )
    end

    Vcl.OnCursorExited = function(self)
        self.hover = false
    end

    local PlayerList = vgui.Create("DListView", frame1)
    PlayerList:Dock(LEFT)
    PlayerList:DockMargin(5, 5, 5, 5)
    PlayerList:SetWidth(200)
    PlayerList:SetMultiSelect(false)
    PlayerList:AddColumn(nlf.msystem.config.langue[loc].txt34)

    PlayerList.OnRowSelected = function(PlayerList, line)
        DataList:Clear()
        net.Start("M::AdminDataOnline")
        net.WriteString(tostring(PlayerList:GetLine(line):GetValue(1)))
        net.SendToServer()
    end
	
	net.Receive("M::AdminFindData", function(len, pl)
		for k, v in pairs(net.ReadTable()) do
			DataList:Clear()
			DataList:AddLine(v.id, v.SteamID64, v.name, v.Licenceprix, v.date)
		end
	end)
	
    for k, v in pairs(mtabe) do
    DataList:Clear()
    DataList:AddLine(v.id, v.SteamID64, v.name, v.Licenceprix, v.date)
    end
	
    for _, v in pairs(player.GetAll()) do
        PlayerList:AddLine(v:Nick())
    end
end)
