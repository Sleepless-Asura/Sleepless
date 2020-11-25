
--[[
        Custom commands:
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
		
        Casting functions:
        these are to set fewer macros (2 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle              	Cycles element type for nuking & SC
		gs c nuke cycledown				Cycles element type for nuking & SC	in reverse order
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke ra1                   Cast tier 1 -ra nuke of saved element 
        gs c nuke ra2                   Cast tier 2 -ra nuke of saved element 
        gs c nuke ra3                   Cast tier 3 -ra nuke of saved element 	
		
		gs c geo geocycle				Cycles Geomancy Spell
		gs c geo geocycledown			Cycles Geomancy Spell in reverse order
		gs c geo indicycle				Cycles IndiColure Spell
		gs c geo indicycledown			Cycles IndiColure Spell in reverse order
		gs c geo geo					Cast saved Geo Spell
		gs c geo indi					Cast saved Indi Spell
        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.
        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]


--include('organizer-lib') -- Remove if you dont use Organizer

--------------------------------------------------------------------------------------------------------------
res = require('resources')      -- leave this as is    
texts = require('texts')        -- leave this as is    
include('Modes.lua')            -- leave this as is      
--------------------------------------------------------------------------------------------------------------

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('normal', 'dt', 'mdt')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1400    --important to update these if you have a smaller screen
hud_y_pos = 200     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 128 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'

-- Setup your Key Bindings here:  
    windower.send_command('bind insert gs c nuke cycle')            -- insert Cycles Nuke element
    windower.send_command('bind delete gs c nuke cycledown')        -- delete Cycles Nuke element in reverse order   
    windower.send_command('bind home gs c geo geocycle') 			-- home Cycles Geomancy Spell
    windower.send_command('bind PAGEUP gs c geo geocycledown') 		-- end Cycles Geomancy Spell in reverse order	
    windower.send_command('bind PAGEDOWN gs c geo indicycle') 		-- PgUP Cycles IndiColure Spell
    windower.send_command('bind end gs c geo indicycledown') 	    -- PgDown Cycles IndiColure Spell in reverse order	
    windower.send_command('bind !f9 gs c toggle runspeed') 			-- Alt-F9 toggles locking on / off Herald's Gaiters
	windower.send_command('bind f10 gs c toggle mb')				-- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind !f10 gs c toggle nukemode')         -- Alt-F10 to change Nuking Mode
    windower.send_command('bind ^F10 gs c toggle matchsc')          -- CTRL-F10 to change Match SC Mode         
    windower.send_command('bind f12 gs c toggle melee')				-- F12 Toggle Melee mode on / off and locking of weapons
	windower.send_command('bind f9 gs c toggle idlemode')			-- F9 Toggles between MasterRefresh or MasterDT when no luopan is out
--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]																	-- or between Full Pet Regen+DT or Hybrid PetDT and MasterDT when a Luopan is out
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_geo_cycle'] = '(HOME + PgUP)'
keybinds_on['key_bind_indi_cycle'] = '(End + PgDOWN)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'


-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')
    send_command('unbind home')
    send_command('unbind PAGEUP')
    send_command('unbind PAGEDOWN')
    send_command('unbind end')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind f9')
    send_command('unbind !f9')
end

--------------------------------------------------------------------------------------------------------------
include('GEO_Lib.lua')          -- leave this as is     
--------------------------------------------------------------------------------------------------------------

geomancy:set('Geo-Frailty')     -- Geo Spell Default      (when you first load lua / change jobs the saved spells is this one)
indicolure:set('Indi-Haste')    -- Indi Spell Default     (when you first load lua / change jobs the saved spells is this one)
validateTextInformation()

-- Optional. Swap to your geo macro sheet / book
set_macros(1,20) -- Sheet, Book   
    
-- Setup your Gear Sets below:
--function get_sets()
--fixed_ts = os.time()

--end

--windower.raw_register_event('outgoing chunk',function(id,original,modified,injected,blocked)
    --if not blocked then
        --if id == 0x15 then
            --if (gearswap.cued_packet or midaction()) and fixed_pos ~= '' and os.time()-fixed_ts < 10 then
               --return original:sub(1,4)..fixed_pos..original:sub(17)
            --else
               --fixed_pos = original:sub(5,16)
               --fixed_ts = os.time()
           --end
       --end
    --end
--end)
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my.pan's behaviour or abilities are under .pan', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        -- leave this empty
    sets.pan = {}       -- leave this empty
	sets.me.idle = {}	-- leave this empty    
	sets.pan.idle = {}	-- leave this empty 

	-- sets starting with sets.me means you DONT have a luopan currently out.
	-- sets starting with sets.pan means you DO have a luopan currently out.

    -- Your idle set when you DON'T have a luopan out
    sets.me.idle.normal = {
	main="Bolelabunga",
	sub="Genmei Shield",
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	head="Befouled Crown",
	body="Jhakri Robe +2",
	hands="Bagua Mitaines +3",
	legs="Assid. Pants +1",
	feet="Geo. Sandals +3",
	neck="Bathy Choker +1",
	ear1="Lugalbanda Earring",
	ear2="Infused Earring",
	left_ring={name="Stikini Ring +1", bag="wardrobe2"},
	ring2="Sheltered Ring",
	waist="Gishdubar Sash", 
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}, --0/0/0/5
}
	
	-- This or herald gaiters or +1 +2 +3... geomancy sandals
	sets.me.movespeed = {feet="Geo. Sandals +3"}	
	
    -- Your idle MasterDT set (Notice the sets.me, means no Luopan is out)
    sets.me.idle.dt = set_combine(sets.me.idle.normal,{
	sub="Genmei Shield", --10/0
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	body="Mallquis Saio +2", --8/8
	hands="Geo. Mitaines +3", --3/0
	neck="Loricate Torque +1", --6/6
	ear1="Odnowa Earring +1", --2/0
	ear2="Etiolation Earring", --0/3
	left_ring={ name="Dark Ring", augments={'Magic dmg. taken -5%','Phys. dmg. taken -4%',}}, --4/3/0/0 --ring1="Gelatinous Ring +1", --7/(-1)
	ring2="Defending Ring", --10/10
})
    sets.me.idle.mdt = set_combine(sets.me.idle.normal,{

    })	
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
	
	sets.me.latent_refresh = {waist="Fucho-no-obi"}
	
	
    -----------------------
    -- Luopan Perpetuation
    -----------------------
      
    -- Luopan's Out --  notice sets.pan 
    -- This is the base for all perpetuation scenarios, as seen below
    -- PDT / MDT / Pet: -DT (37.5% to cap) / Pet: Regen
	sets.pan.idle.normal = {
	main="Idris", --0/0/25/0
    sub="Genmei Shield", --10/0/0/0
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
    body={ name="Telchine Chas.", augments={'Pet: Evasion+19','Pet: "Regen"+3','Enh. Mag. eff. dur. +9',}}, --0/0/0/3
    hands="Geo. Mitaines +3", --3/0/13/0
    legs={ name="Telchine Braconi", augments={'Pet: Evasion+15','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}}, --0/0/0/2
    feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},  --0/0/0/5
	neck={ name="Bagua Charm +2", augments={'Path: A',}}, 
    waist="Isa Belt", --0/0/0/1
    left_ear="Ethereal Earring",
    right_ear="Infused Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring="Defending Ring", --10/10/0/0
    back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}, --0/0/0/5
}
	
	-- This is when you have a Luopan out but want to sacrifice some slot for master DT, put those slots in.
    sets.pan.idle.dt = set_combine(sets.pan.idle.normal,{
 body="Mallquis Saio +2", --8/8
 legs="Bagua Pants +3",
 neck="Loricate Torque +1", --6/6/0/0
    })   
    sets.pan.idle.mdt = set_combine(sets.pan.idle.normal,{

    })   
    -- Combat Related Sets
      
    -- Melee
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
	-- No Luopan out
	-- they end in [idleMode] so it will derive from either the normal or the dt set depending in which mode you are then add the pieces filled in below.
    sets.me.melee = set_combine(sets.me.idle[idleMode],{

    })
	
    -- Luopan is out
	sets.pan.melee = set_combine(sets.pan.idle[idleMode],{

    }) 
    
    -- Weapon Skill sets
	-- Example:
    sets.me["Flash Nova"] = {

    }

    sets.me["Realmrazer"] = {

    }
	
    sets.me["Exudation"] = {

    } 
    -- Feel free to add new weapon skills, make sure you spell it the same as in game.
  
    ---------------
    -- Casting Sets
    ---------------
      
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty    
    sets.midcast.nuking = {}        -- leave this empty
    sets.midcast.MB = {}            -- leave this empty    
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
    main="Idris",
	sub="Chanter's Shield", --FC 3%
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}}, --FC 3%
	head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+4',}}, --FC 12%
    body="Shango Robe", --FC 8%
    hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+4','INT+13','Mag. Acc.+14',}}, --FC 4%
    legs="Geomancy Pants +3", --FC 15%
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+7','INT+1','Mag. Acc.+15',}}, --FC 12%
    neck="Orunmila's Torque", --FC 5%
    waist="Embla Sash", --FC 5%
    left_ear="Malignance earring", --FC 4%
    right_ear="Loquac. Earring", --FC 2%
    left_ring="Kishar Ring", --FC 4%
    right_ring="Rahab Ring", --FC +2%
	back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +19','Pet: Damage taken -1%',}}, --FC 7%
}   ---- FastCast 82%
      
	sets.precast.geomancy = set_combine(sets.precast.casting,{
    main="Idris",
    sub="Chanter's Shield", --FC 3%
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}}, --FC 3%
	head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+4',}}, --FC 12%
    body="Shango Robe", --FC 8%
    hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+4','INT+13','Mag. Acc.+14',}}, --FC 4%
    legs="Geomancy Pants +3", --FC 15%
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+7','INT+1','Mag. Acc.+15',}}, --FC 12%
    neck="Orunmila's Torque", --FC 5%
    waist="Embla Sash", --FC 5%
    left_ear="Malignance earring", --FC 4%
    right_ear="Loquac. Earring", --FC 2%
    left_ring="Kishar Ring", --FC 4%
    right_ring="Rahab Ring", --FC +2%
	back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +19','Pet: Damage taken -1%',}}, --FC 7%
})   ---- FastCast 82%
    
	-- Enhancing Magic -, eg. Siegal Sash
    sets.precast.enhancing = set_combine(sets.precast.casting,{
    waist="Siegal Sash", 
})
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
	head="Umuthi Hat", --15%
    hands="Carapacho Cuffs", --15%
	waist="Siegel Sash", --8%
	legs="Doyen Pants", --10%
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
	main="Idris",
    sub="Sors shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    body="Vrikodara Jupon",
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +9',}},
    legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
    neck="Nodens Gorget",
	waist="Hachirin-no-Obi",
    left_ear="Calamitous Earring",
    right_ear="Mendi. Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring="Lebeche Ring",
    back="Solemnity Cape",
})
    sets.precast.regen = set_combine(sets.precast.casting,{
	main="Bolelabunga",
    sub="Ammurapi Shield",
    })   
	sets.precast['Dispelga'] = set_combine(sets.precast.casting,{ main = "Daybreak" })
    ---------------------
    -- Ability Precasting
    ---------------------
	
	-- Fill up with your JSE! 
    sets.precast["Life Cycle"] = {body="Geomancy Tunic +3",back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},}
    sets.precast["Bolster"] = {body="Bagua Tunic +3"}
    sets.precast["Primeval Zeal"] = {head="Bagua Galero +3"}  
    sets.precast["Full Circle"] = {head="Azimuth Hood +1", legs="Bagua Mitaines +3"}  
    sets.precast["Mending Halation"] = {legs="Bagua Pants +3"}
    sets.precast["Radial Arcana"] = {feet="Bagua Sandals +3"}

    ----------
    -- Midcast
    ----------
            
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {

    }
	
	-- For Geo spells /
    sets.midcast.geo = set_combine(sets.midcast.casting,{
	main="Idris",
    sub="Chanter's Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
    body="Vedic Coat",
    hands="Geo. Mitaines +3",
    legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
    neck="Incanter's Torque",
    waist="Shinjutsu-no-Obi +1",
    left_ear="Eabani Earring",
    right_ear="Etiolation Earring",
    left_ring={ name="Dark Ring", augments={'Magic dmg. taken -5%','Phys. dmg. taken -4%',}},
    right_ring="Defending Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +19','Pet: Damage taken -1%',}},
})
	-- For Indi Spells
    sets.midcast.indi = set_combine(sets.midcast.geo,{

    })

	sets.midcast.Obi = {
	    waist="Shinjutsu-no-Obi +1",
	}
	
	-- Nuking
    sets.midcast.nuking.normal = set_combine(sets.midcast.casting,{
	main="Maxentius",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
    body="Bagua Tunic +3",--body="Amalric Doublet +1", 
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs="Amalric Slops +1", 
    feet="Bagua Sandals +3", 
    neck="Sanctity Necklace",
    waist="Sacro Cord",
    left_ear="Barkaro. Earring",
    right_ear="Regal Earring",
    left_ring="Shiva Ring +1",
    right_ring="Freke Ring",
	back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
})
	sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
	main="Daybreak",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
    neck="Mizu. Kubikazari",
    waist="Sacro Cord",
    right_ear="Regal Earring",
    left_ring="Mujin Band",
    right_ring="Freke Ring",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
})
    sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal,{
	main="Maxentius",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+10','Magic burst dmg.+9%',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+30','Magic burst dmg.+9%',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+4%',}},
    neck="Sanctity Necklace",
    waist="Hachirin-no-Obi", --waist="Eschan Stone",  waist="Hachirin-no-Obi", waist="Sacro Cord", 
    right_ear="Regal Earring",
    left_ring="Shiva Ring +1",
    right_ring="Freke Ring",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
})
    sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {
	main="Maxentius",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    right_ear="Regal Earring",
    left_ring="Mujin Band",
    right_ring="Freke Ring",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
})

	-- Enfeebling
	sets.midcast.IntEnfeebling = set_combine(sets.midcast.casting,{
	main="Daybreak",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
    body="Geomancy Tunic +3",
    hands="Geo. Mitaines +3",
    legs="Geomancy Pants +3",--legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
    feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
    neck="Incanter's Torque",
    waist="Sacro Cord",--waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Regal Earring",
    ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
})
	sets.midcast.MndEnfeebling = set_combine(sets.midcast.casting,{
	main="Daybreak",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
    body="Geomancy Tunic +3",
    hands="Geo. Mitaines +3",
    legs="Geomancy Pants +3", --legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
    feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Regal Earring",
    ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
})
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
	main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+19','"Mag.Atk.Bns."+6',}},
	sub="Ammurapi Shield",
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	head={ name="Telchine Cap", augments={'Pet: DEF+20','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Pet: Evasion+19','Pet: "Regen"+3','Enh. Mag. eff. dur. +9',}},
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Pet: Evasion+15','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Song spellcasting time -6%','Enh. Mag. eff. dur. +10',}},
	neck="Incanter's Torque",
	ear2="Andoaa Earring",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe4"},
	waist="Embla Sash",
})
	
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
	neck="Nodens Gorget",
    waist="Siegel Sash",
	ear1="Earthcry Earring",
	legs="Shedir Seraweels"
})
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
	back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots",
    })
    sets.midcast.aquaveil = set_combine(sets.midcast.enhancing,{
	main="Vadose Rod",
	waist="Emphatikos Rope",
	--head="Amalric Coif +1",
	legs="Shedir Seraweels"
})
	sets.midcast["Drain"] = set_combine(sets.midcast.IntEnfeebling,{
	head="Bagua Galero +3",
	ring1="Evanescence Ring",
	ring2="Archon Ring",
	waist="Fucho-no-Obi",
})

	sets.midcast["Aspir"] = sets.midcast["Drain"]
     
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
	main="Idris",
    sub="Sors shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    body="Vrikodara Jupon",
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +8',}},
    legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
    neck="Nodens Gorget",
	waist="Hachirin-no-Obi",
    left_ear="Calamitous Earring",
    right_ear="Mendi. Earring",
    left_ring={"Stikini Ring +1", bag="wardrobe2"},
    right_ring=="Lebeche Ring",
	back="Solemnity Cape",
})
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
	main="Idris",
    sub="Sors shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    body="Vrikodara Jupon",
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +8',}},
    legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
    neck="Nodens Gorget",
	waist="Hachirin-no-Obi",
    left_ear="Calamitous Earring",
    right_ear="Mendi. Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring="Lebeche Ring",
    back="Solemnity Cape",
})    
    sets.midcast.regen = set_combine(sets.midcast.enhancing,{

    }) 
   
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have a Luopan pan out?
  

