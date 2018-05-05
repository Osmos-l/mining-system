
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DON'T TOUCH 
local loc =  nlf.msystem.config.langue.LocalLang

local MSystemPickup = {"nlf_mbarilrock", "nlf_mcart", "nlf_minirock" }

  hook.Add("HUDPaint", "MSystem::Use", function()
  local entity = LocalPlayer():GetEyeTrace().Entity
  if entity == nil then return end
		
   	if entity:GetPos():Distance( LocalPlayer():GetPos() ) > 90 then return end
	
		if table.HasValue( MSystemPickup, entity:GetClass()) then
		
			draw.RoundedBox( 0, ScrW()/1.25, ScrH()/2, 500, 28, Color(0,0,0,150) )
			draw.SimpleText(nlf.msystem.config.langue[loc].txt14, "MSystem_Use", ScrW()/1.1, ScrH()/2, Color(200, 200, 200), TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial(Material("msystem/keyede.png"))
		    surface.DrawTexturedRect(ScrW()/1.2, ScrH()/2, 20, 20)
		end 
   end)
