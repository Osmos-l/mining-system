-------------- Mining System By Osmos --------------
-- Don't touch here
local function MenuAddBASButton( n, e, f )
    table.insert(nlf.msystem.config.button.basique, { NAME = n, PRIX = e, ENT = f } )
end
 
local function MenuAddVIPButton( n, e, f )
    table.insert(nlf.msystem.config.button.vip, { NAME = n, PRIX = e, ENT = f } )
end

local function MenuAddADButton( n, e, f )
    table.insert(nlf.msystem.config.button.admin, { NAME = n, PRIX = e, ENT = f } )
end

nlf = nlf or {}

nlf.msystem = {}

nlf.msystem.config = {}

nlf.msystem.config.panel = {}

nlf.msystem.config.langue = {}

nlf.msystem.config.button = {}

	nlf.msystem.config.button.basique = {}
	
	nlf.msystem.config.button.vip = {}
	
	nlf.msystem.config.button.admin = {}

nlf.msystem.config.adminpanel = {}

nlf.msystem.version = "BETA"

---------------------------------------------------------------
-- You can touch here
nlf.msystem.config.langue.LocalLang = "FR" -- "FR" or "EN"

nlf.msystem.config.adminpanel.access = {"superadmin", "admin"} -- Player can have access in one group, the order is adminpanel > vipaccess > other 

nlf.msystem.config.vipaccess = { "VIP" }

nlf.msystem.config.amountlicence = 1500 -- the price for the licence mining 

nlf.msystem.config.rockprice = 40 -- the money give for one rock

nlf.msystem.config.processtime = 15 -- the process time for one rock

nlf.msystem.config.maxrock = 10 -- the max rock can have a cart
----------------------------------------------------
-- Licence npc config 

nlf.msystem.config.namebot = "Gérard le mineur"
nlf.msystem.config.colornamebot = Color(255, 255, 255, 255)
nlf.msystem.config.namebot2 = "Tu veux devenir mineur ?"
nlf.msystem.config.skin = "models/Humans/Group02/male_06.mdl"

---------------------------------------------------
-- Panel config (Licence npc )
nlf.msystem.config.panel.usemusic = true 
nlf.msystem.config.panel.usefilemusic = true -- If nlf.bot.config.panel.usefilemusic = false then nlf.bot.config.panel.filemusic = url music
nlf.msystem.config.panel.filemusic = "sound/music/nlftbotmainmusic.wav" 

nlf.msystem.config.panel.useicon = true  
nlf.msystem.config.panel.iconrotating = true

nlf.msystem.config.panel.textprincipal = "Salut, moi c'est gérard ! \nJe suis mineur depuis pas mal d'années, c'est vraiment un métier formidable qui rapporte bien. \nDepuis l'an dernier je suis devenu chef d'entreprise et je vend les licences de mineur alors si tu souhaite devenir mineur dit le moi !\nLa licence coûte seulement 1500$."

nlf.msystem.config.panel.soundonclick = "buttons/button14.wav"
nlf.msystem.config.panel.soundoncursor = "buttons/lightswitch2.wav"
---------------------------------------------------
-- Button config (Licence npc )

nlf.msystem.config.button[1] = {
name = "Pourquoi devenir mineur ?",
text = "Mineur est vraiment un métier formidable !",
action = "txt",
}

nlf.msystem.config.button[2] = {
name = "Devenir mineur",
action = "buylicence",
}

nlf.msystem.config.button[3] = {
name = "Shop des mineurs",
action = "shop",
}

nlf.msystem.config.button[4] = {
name = "Partir",
action = "exit",
}

---------------------------------------------------
-- Shop Licence

MenuAddBASButton( "Charette", 500, "M_Charette") -- For Basic player
MenuAddBASButton( "Pioche", 400, "M_Pioche") -- MenuAdd XXX Button( "NAME", PRICE, "M_Pioche" for pickaxe or "M_Charette" for cart)

MenuAddVIPButton( "Charette", 250, "M_Charette") -- For VIP player
MenuAddVIPButton( "Pioche", 200, "M_Pioche" )

MenuAddADButton( "Charette", 10, "M_Charette") -- For Admin player 
MenuAddADButton( "Pioche", 5, "M_Pioche")

nlf.msystem.config.button.namecolor = Color( 255, 255, 255 )
nlf.msystem.config.button.buttonColor = Color( 25, 25, 25, 250 )
nlf.msystem.config.button.cursorenteredColor =  Color( 100, 100, 100, 150 )
nlf.msystem.config.scrollbar =   Color(175, 100, 100, 255)

------------------------------------------------------
-- Icon 

nlf.msystem.config.npclicenceicon = "msystem/mineuricon.png"

nlf.msystem.config.searchicon = Material( "msystem/search.png" )
