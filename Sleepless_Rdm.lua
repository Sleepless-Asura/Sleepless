--[[

8888888b.                888     888b     d888                            
888   Y88b               888     8888b   d8888                            
888    888               888     88888b.d88888                            
888   d88P  .d88b.   .d88888     888Y88888P888  8888b.   .d88b.   .d88b.  
8888888P"  d8P  Y8b d88" 888     888 Y888P 888     "88b d88P"88b d8P  Y8b 
888 T88b   88888888 888  888     888  Y8P  888 .d888888 888  888 88888888 
888  T88b  Y8b.     Y88b 888     888   "   888 888  888 Y88b 888 Y8b.     
888   T88b  "Y8888   "Y88888     888       888 "Y888888  "Y88888  "Y8888  
                                                             888          
                                                        Y8b d88P          
                                                         "Y88P"           
]]

windower.add_to_chat(123,[[Red Mage Lua Author: Byrne #7894 (Discord))]])
windower.add_to_chat(160,[[Movement speed by default will not equip when engaged, Press F1 to handle auto-kiting while engaged.]])
--windower.add_to_chat(123,[[   <> It is reccommended you use User-Global.lua at https://github.com/Byrne119/Gearswap ]]) --Right click and save link as...
--windower.add_to_chat(123,[[   <> if you have done this, put -- before lines 18 and 19. Remove -- before sharing!]])
--include('organizer-lib')


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

----------------------------------------------
--   Macro and Style Change on Job Change   --
----------------------------------------------
function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

function set_style(sheet)
    send_command('@input ;wait 25;input /lockstyleset'..sheet)
	add_to_chat (21, 'Your Lockstyle Looks like awesome, you are a bad man')
	add_to_chat (55, 'You are on '..('RDM '):color(6)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
--	add_to_chat (60, 'https://www.bg-wiki.com/bg/Out_of_the_BLU')
end

set_macros(1,10)
---Name the Lockstyle below after the default set number-- 
set_style(28) 


function get_sets()
fixed_pos = ''
fixed_ts = os.time()

end

windower.raw_register_event('outgoing chunk',function(id,original,modified,injected,blocked)
    if not blocked then
        if id == 0x15 then
            if (gearswap.cued_packet or midaction()) and fixed_pos ~= '' and os.time()-fixed_ts < 10 then
               return original:sub(1,4)..fixed_pos..original:sub(17)
            else
               fixed_pos = original:sub(5,16)
               fixed_ts = os.time()
           end
       end
    end
end)
    -- Load and initialize the include file.
    include('Mote-Include.lua')

end


--================================================--
--                                                --
--      |     |        ,---.     |                --
--      |,---.|---.    `---.,---.|--- .   .,---.  --
--      ||   ||   |        ||---'|    |   ||   |  --
--  `---'`---'`---'    `---'`---'`---'`---'|---'  --
--                                         |      --
--                                                --
--================================================--

function job_setup()
setupTextWindow(1400, 450)
--[[These numbers determine where your table will show update
This is affected both by your resolution and your scaling mode so
you may need to lower these numbers quite significantly depending
on your settings.  Start with 100,100, and reload the file to find
where the box moves as you edit it.  Unfortunately I am not certain
how to make this context box draggable.]]
end

--====================================================--
--	                                                  --
--	.   .                   ,---.     |               --
--	|   |,---.,---.,---.    `---.,---.|--- .   .,---. --
--	|   |`---.|---'|            ||---'|    |   ||   | --
--	`---'`---'`---'`        `---'`---'`---'`---'|---' --
--	                                            |     --
--                                                    --
--====================================================--

function user_setup()
	state.OffenseMode:options('Normal', 'DT')
    state.WeaponLockMode = M('Unlocked', 'Locked')
    state.IdleMode:options('Normal', 'Town')
	state.CastingMode:options('Normal', 'Burst')
	state.Enfeeb = M('Accuracy', 'Potency', 'Skill')
	state.ZoneRing = M('None','Warp', 'Holla', 'Dem', 'Mea')
	state.DynaMode = M('None', 'RP_Farm')
	state.EngagedMoving = M('Disabled','Enabled')
	state.DoomMode = M('OFF', 'Doom')
	state.SanguineBlade = M('None', 'MAB')
	state.Following = M('Follow','Stay')
    state.Moving = M('false', 'true')
    
    select_default_macro_book()

	send_command('bind f7 gs c cycle SanguineBlade')
	--send_command('bind f1 gs c cycle EngagedMoving')
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle CastingMode')
	send_command('bind f10 gs c cycle IdleMode')
	send_command('bind f11 gs c cycle Enfeeb')
	send_command('bind f12 gs c cycle WeaponLockMode')
	send_command('bind ^f10 gs c cycle ZoneRing')
	send_command('bind @f8 gs c set WeaponLockMode Unlocked;wait 0.2;input //gs equip sets.default_melee_weapons;wait 0.2;gs c set WeaponLockMode Locked')
	send_command('bind ^F8 gs c cycle Following')
	
    select_default_macro_book()
end

 

--=================================--
--  _  _ _  _ _    ____ ____ ___   --
--  |  | |\ | |    |  | |__| |  \  --
--  |__| | \| |___ |__| |  | |__/  --
--                                 --
--=================================--

function user_unload()

        send_command('unbind ^f9')
        send_command('unbind ^f10')
		send_command('unbind ^f11')
		send_command('unbind ^f12')
		send_command('unbind f8')
       
        send_command('unbind !f9')
        send_command('unbind !f10')
		send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
		send_command('unbind f5')
		send_command('unbind f1')
		
		send_command('unbind -')
		send_command('unbind =')
		enable('neck')
		enable('main')
		enable('sub')
		enable('range')
end

-- Define sets and vars used by this job file.


--=============================================--
--                                             --
--   ..|'''.|  '||''''|      |     '||''|.     --
--  .|'     '   ||  .       |||     ||   ||    --
--  ||    ....  ||''|      |  ||    ||''|'     --
--  '|.    ||   ||        .''''|.   ||   |.    --
--   ''|...'|  .||.....| .|.  .||. .||.  '|'   --
--                                             --
--=============================================--


function init_gear_sets()

--==================================================--
--  ____                                       _    --
-- |  _ \   _ __    ___    ___    __ _   ___  | |_  --
-- | |_) | | '__|  / _ \  / __|  / _` | / __| | __| --
-- |  __/  | |    |  __/ | (__  | (_| | \__ \ | |_  --
-- |_|     |_|     \___|  \___|  \__,_| |___/  \__| --
--==================================================--


    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}
    
    --Red Mage gets plenty of Fast Cast through traits and gear
	--So I would reccomend avoiding quick cast due to equipping errors.
	sets.precast.FC = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
        head="Carmine Mask +1",
		ear2="Loquacious Earring",
        body="Vitiation Tabard +3",
		neck="Orunmila's Torque",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
		waist="Embla Sash",
		legs="Aya. Cosciales +2", --6
		feet="Carmine Greaves +1"}
	
	--don't play with the name of this set, it breaks very easily. (Libraries problem)
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
		head=empty,
		body="Twilight Cloak",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2", --6
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Orunmila's Torque",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Kishar Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
})
		
	--[[this set needs to be a clone of sets.precast.FC.Impact
		I know this setup seems insane and unneccessary, but Impact requires
		the Twilight cloak to be equipped to begin casting unlike other spells
		and as such I must define sets.precast.FC.Impact to sets.precast.FC.ImpactQC
		to check for Chainspell or Spontaneity, then I must redefine it to
		This set when you cast it next without those buffs active.
		It's complicated, but I promise it's neccessary.
		Also, do not make this a setcombine with the previous Impact FC set
		or it will defeat it's purpose.]]
	
	sets.precast.FC.Impact2 = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
		head=empty,
		body="Twilight Cloak",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2", --6
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Orunmila's Torque",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Kishar Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
	sets.precast.FC.ImpactQC = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		range="Ullr",
		head=empty,
		body="Twilight Cloak",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Enmity-2','INT+6','Mag. Acc.+14','"Mag.Atk.Bns."+3',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck="Dls. Torque +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

--==================================================--
--   __  __   _       _                        _    --
--  |  \/  | (_)     | |                      | |   --
--  | \  / |  _    __| |   ___    __ _   ___  | |_  --
--  | |\/| | | |  / _` |  / __|  / _` | / __| | __| --
--  | |  | | | | | (_| | | (__  | (_| | \__ \ | |_  --
--  |_|  |_| |_|  \__,_|  \___|  \__,_| |___/  \__| --
--                                                  --
--==================================================--
		
		
    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
		main="Daybreak",
        sub="Sors Shield",
		head="Kaykaus Mitra",
		neck="Incanter's Torque",
		ear1="Mendicant's Earring",
		ear2="Loquacious Earring",
        body="Vrikodara Jupon",
		hands="Telchine Gloves",
		ring1="Haoma's Ring",
		ring2="Menelaus's Ring",
        back="Solemnity Cape",
		waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}}, --waist="Hachirin-no-Obi",
		legs="Atrophy Tights +1",
		feet="Medium's Sabots"}

    sets.midcast.Cursna = {
        head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Malison Medallion",
		ear1="Roundel Earring",
		ear2="Loquacious Earring",
        body="Vrikodara Jupon",
		hands="Leyline Gloves",
		ring1="Menelaus's Ring",
		ring2="Ephedra Ring",
        back="Ghostfyre Cape",
		waist="Witful Belt",
		legs="Atrophy Tights +2",
		feet="Vanya clogs"}
        
    sets.midcast.Curaga = sets.midcast.Cure
	
    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
		--ring1="Dark Ring",
		ring2="Kunaji Ring",
		hands="Buremte gloves",
		waist="Gishdubar Sash"})
		
    sets.midcast['Enhancing Magic'] = {
    main={ name="Colada", augments={'Enh. Mag. eff. dur. +4','Mag. Acc.+8','"Mag.Atk.Bns."+8',}},
    sub="Ammurapi Shield",
    ammo="Regal Gem",
    head="Befouled Crown",
    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
    hands="Atrophy Gloves +2",
    legs="Leth. Fuseau +1",
    feet="Leth. Houseaux +1",
    neck="Incanter's Torque",
    waist="Embla Sash", --waist="Olympus Sash",
    left_ear="Andoaa Earring",
    right_ear="Mimir Earring",
    ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
		
	sets.midcast['Enhancing Magic'].SelfDuration = {
	main="Pukulatmuj +1",
    sub="Arendsi Fleuret",
    ammo="Regal Gem",
    head="Befouled Crown",
    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
    hands={ name="Viti. Gloves +3", augments={'Enhancing Magic duration',}},
    legs="Atrophy Tights +2",
    feet="Leth. Houseaux +1",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Andoaa Earring",
    right_ear="Mimir Earring",
    ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +1','Mag. Acc.+7','Enh. Mag. eff. dur. +20',}},
}
	--main={ name="Colada", augments={'Enh. Mag. eff. dur. +4','Mag. Acc.+8','"Mag.Atk.Bns."+8',}},
    --sub="Ammurapi Shield",
    --ammo="Regal Gem",
    --head="Befouled Crown",
    --body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
    --hands="Atrophy Gloves +2",
    --legs="Leth. Fuseau +1",
    --feet="Leth. Houseaux +1",
    --neck="Incanter's Torque",
    --waist="Embla Sash", --waist="Olympus Sash",
    --left_ear="Andoaa Earring",
    --right_ear="Mimir Earring",
    --left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    --right_ring={name="Stikini Ring +1", bag="wardrobe4"},
    --back="Ghostfyre Cape",

	sets.midcast['Enhancing Magic'].Skill = {
	main="Pukulatmuj +1",
    sub="Arendsi Fleuret",
    ammo="Regal Gem",
    head="Befouled Crown",
    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
    hands={ name="Viti. Gloves +3", augments={'Enhancing Magic duration',}},
    legs="Atrophy Tights +2",
    feet="Leth. Houseaux +1",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Andoaa Earring",
    right_ear="Mimir Earring",
    ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +1','Mag. Acc.+7','Enh. Mag. eff. dur. +20',}},
}
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'].Skill, {})
	
	sets.midcast.PhalanxSelf = set_combine(sets.midcast.Phalanx, {
    ammo="Staunch Tathlum +1",
    head="Taeon Chapeau", 
    body="Taeon Tabard", 
    hands="Taeon Gloves", 
    legs="Taeon Tights",
    feet="Taeon Boots", 
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Andoaa Earring",
    right_ear="Mimir Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe4"},
    back="Ghostfyre Cape", 
})
		
	sets.midcast['Enhancing Magic'].GainSpell = set_combine(sets.midcast['Enhancing Magic'].SelfDuration, {hands="Vitiation Gloves +1"})
		
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'].SelfDuration, {
		body="Atrophy Tabard +2",
		--head="Amalric Coif",
		legs="Lethargy Fuseau +1",
		waist="Gishdubar sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
		neck="Nodens Gorget",
		hands="Stone Mufflers",
		legs="Shedir Seraweels", --legs="Haven hose",
		ear2="Earthcry Earring"
		})
	
	sets.midcast.Aquaveil = {
		main="Vadose Rod",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Chironic Hat",
		body="Vitiation Tabard +3",
		hands="Vitiation Gloves +2",
		legs="Shedir Seraweels", --legs="Atrophy Tights +1",
		feet="Leth. Houseaux +1",
		neck="Incanter's Torque",
		waist="Emphatikos Rope",
		left_ear="Andoaa Earring",
		right_ear="Mimir Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring={name="Stikini Ring +1", bag="wardrobe4"},
		back="Ghostfyre Cape",}
	
	--Repose for WHM sub; this spell is not enfeebling magic so use M.acc and divine skill.
	sets.midcast.Repose = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Atro. Chapeau +2",
		body="Atrophy Tabard +2",
		hands="Malignance Gloves",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','MND+3','"Mag.Atk.Bns."+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
	
	--set does not need gear; is not referenced.
	sets.midcast['Enfeebling Magic'] = {}
	--Enfeebling sets for Mnd and Int enfeebles will really only change which cape you are using	
	sets.midcast.IntEnfeebles = { --back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}}, 
	}
	
    sets.midcast['Enfeebling Magic'].Accuracy = {
	main={ name="Crocea Mors", augments={'Path: C',}},
    sub="Ammurapi Shield",
    ammo="Regal Gem",
    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="Atrophy Tabard +2",
    hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','MND+3','"Mag.Atk.Bns."+13',}},
    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
     waist="Luminary Sash",
    left_ear="Vor Earring",
    right_ear="Regal Earring",
    ring1={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring="Kishar Ring",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
	
	--Accuracy is the ONLY concern for this set, used for boolean spells such as silence. Silence either lands or it doesn't, there is no potency.
	--When using Kaja bow for m.acc, if the set you are combining with uses gem, you must specify empty ammo to prevent misequip.
	sets.midcast['Enfeebling Magic'].MaxAccuracy = {		
		main={ name="Crocea Mors", augments={'Path: C',}}, 
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +2",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','MND+3','"Mag.Atk.Bns."+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Vor Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring={name="Stikini Ring", bag="wardrobe4"}, 
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
	
	sets.midcast.Sleep = set_combine(sets.midcast['Enfeebling Magic'].MaxAccuracy, {right_ring="Kishar Ring"})
	
	sets.midcast['Enfeebling Magic'].Skill = {    
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +2",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','MND+3','"Mag.Atk.Bns."+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Vor Earring",
		right_ear="Snotra Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring={name="Stikini Ring", bag="wardrobe4"},
		--right_ring="Kishar Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}

	sets.midcast['Enfeebling Magic'].Potency = {    
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +2",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','MND+3','"Mag.Atk.Bns."+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Vor Earring",
		right_ear="Snotra Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring="Kishar Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
    
	sets.Saboteur = set_combine(sets.midcast['Enfeebling Magic'].Potency, {hands="Lethargy Gantherots +1"})
	
	sets.Dia = {head="Vitiation Chapeau +3"}
	
	sets.midcast['Enfeebling Magic'].ParalyzeDuration = {feet="Vitiation Boots +3"}
	
    sets.midcast['Elemental Magic'] = {
    --main="Crocea Mors", 
    --main="Daybreak",
    main="Maxentius",
	sub="Ammurapi Shield",
	ammo="Regal Gem",
    head="Jhakri Coronal +2",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+10','"Mag.Atk.Bns."+15',}},
    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
    neck="Incanter's Torque",
    waist="Eschan Stone",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
		
	sets.midcast['Elemental Magic'].Burst = {
    --main="Crocea Mors",
    --main="Daybreak",
    main="Maxentius",
	sub="Ammurapi Shield",
	ammo="Regal Gem",
    head="Ea Hat",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},--body="Ea Houppe.",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+5%','MND+9','Mag. Acc.+13',}},
    feet="Ea Pigaches",
    neck="Mizu. Kubikazari",
    waist="Eschan Stone",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Mujin Band",
    right_ring="Shiva Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
    
	
	sets.Obi = {waist="Hachirin-no-Obi",}
	
	--Impact is elemental magic that should STRONGLY favor magic accuracy.
	--The additional stat down effect is far more important than the damage it deals.
	--As elemental magic, it is INT based.
	--When using Kaja bow for m.acc, if the set you are combining with uses gem, you must specify empty ammo to prevent misequip.
    sets.midcast.Impact = {
		main="Daybreak",--main="Crocea Mors",
		sub="Ammurapi Shield",
		range="Ullr",
		ammo=empty,
		head=empty,
		body="Twilight Cloak",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Enmity-2','INT+6','Mag. Acc.+14','"Mag.Atk.Bns."+3',}},
		feet="Vitiation Boots +3",
		neck="Dls. Torque +2",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring={name="Stikini Ring +1", bag="wardrobe4"},
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}

    sets.midcast['Dark Magic'] = {
		main="Daybreak",--main="Crocea Mors",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		--head={ name="Chironic Hat", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Conserve MP"+2','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+2',}},
		body="Atrophy Tabard +2",
		hands="Jhakri Cuffs +2",
		--legs={ name="Chironic Hose", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','MND+6','Mag. Acc.+14',}},
		feet="Vitiation Boots +3",
		neck="Duelist's Torque +2",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring={name="Stikini Ring +1", bag="wardrobe4"},
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}


    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Evanescence ring",
		ring2="Archon Ring",
		waist="Fucho-no-Obi",
		head="Pixie Hairpin +1",
		neck="Erra Pendant",
		feet="Vitiation Boots +3", })

    sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Utsusemi = {
		ammo="Incantor Stone",
        head="Carmine Mask +1",
		ear2="Loquacious Earring",
        body="Vitiation Tabard +3",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
        back="Swith Cape +1",
		waist="Witful Belt",
		--legs="Psycloth Lappas",
		feet="Carmine Greaves +1"}	
		
		
--===============================================================================--		
-- __        __                                               _      _   _   _   --
-- \ \      / /   ___    __ _   _ __     ___    _ __    ___  | | __ (_) | | | |  --
--  \ \ /\ / /   / _ \  / _` | | '_ \   / _ \  | '_ \  / __| | |/ / | | | | | |  --
--   \ V  V /   |  __/ | (_| | | |_) | | (_) | | | | | \__ \ |   <  | | | | | |  --
--    \_/\_/     \___|  \__,_| | .__/   \___/  |_| |_| |___/ |_|\_\ |_| |_| |_|  --
--                             |_|                                               --
--===============================================================================--


    sets.precast.WS = {
		--ammo="Yetshila",
		head="Ayanmo Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Atrophy Gloves +3",
		legs={ name="Taeon Tights", augments={'Accuracy+22','"Triple Atk."+2','DEX+9',}},
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','TP Bonus +25',}},
		right_ear="Sherida Earring",
		left_ring="Begrudging Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
}

	--Stat Modifier: 	73~85% MND 	fTP: 	1.0
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--Attack Power: 	-20% 		-10% 		-0%
	--Skillchain: 	Darkness / Gravitation / Scission
    sets.precast.WS['Requiescat'] = {
		--ammo="Regal Gem",
		head="Viti. Chapeau +3", 
		body="Viti. Tabard +3",
		hands="Atrophy Gloves +2",
		legs="Atrophy Tights +1",
		feet="Vitiation Boots +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring", 
		right_ear="Regal Earring",
		--left_ring="Karieyh Ring",
		right_ring="Rufescent Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
	
	--Stat Modifier: 	50% MND / 30% STR 	fTP: 	2.75
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--HP Drained: 		50% 		100% 		160% 	
	sets.precast.WS['Sanguine Blade'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Jhakri Robe +2",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Sanctity Necklace",
		waist="Skrymir Cord",
		left_ear="Regal Earring",
		right_ear="Friomisi Earring",
		left_ring="Shiva Ring +1",
		right_ring="Archon Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
	--Stat Modifier: 	40% STR / 40% INT
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--fTP: 				1.0 		2.98 		3.75
	--Skillchain: 	Liquefaction / Detonation	
	sets.precast.WS['Red Lotus Blade'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+8%','Mag. Acc.+2','"Mag.Atk.Bns."+13',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Vitiation Boots +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		--left_ring="Karieyh Ring",
		right_ring="Shiva Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
	--Stat Modifier: 	40% STR / 40% MND
	--TP Modifier 	1000 TP 	2000 TP 	3000 TP
	--fTP: 			1.625 		3.0 		4.625
	--Skillchain: 	Impaction
	sets.precast.WS['Shining Strike'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+8%','Mag. Acc.+2','"Mag.Atk.Bns."+13',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Vitiation Boots +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		--left_ring="Karieyh Ring",
		right_ring="Shiva Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
	--Stat Modifier: 	40% STR / 40% MND
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--fTP: 				1.125 	2.625 	4.125
	--Skillchain: 	Scission
	sets.precast.WS['Seraph Blade'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Drain" and "Aspir" potency +7','MND+2','"Mag.Atk.Bns."+5',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Vitiation Boots +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		--left_ring="Karieyh Ring",
		right_ring="Shiva Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
	--Stat Modifier: 		50% STR / 50% MND
	--TP Modifier 			1000 TP 	2000 TP 	3000 TP
	--fTP: 					4.0 		10.25 		13.75
	--Skillchain: 	Fragmentation / Scission
    sets.precast.WS['Savage Blade'] = {
    --main="Naegling",
    --sub="Tauret",
    --range="Ullr",
    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Regal Earring",
    left_ring="Rufescent Ring",
    right_ring="Shukuyu Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
		
	--Stat Modifier: 	100% STR 	fTP: 	1.0
	--Attack Modifier: 	2.0
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--Accuracy: 	Large Penalty	
	sets.precast.WS['True Strike'] = {
		--main="Daybreak",
		--sub="Tauret",
		ammo="Yetshila",
		head="Viti. Chapeau +3", 
		body="Viti. Tabard +3", 
		hands="Atrophy Gloves +2",
		legs="Jhakri Slops +2",
		feet={ name="Chironic Slippers", augments={'"Conserve MP"+5','Rng.Atk.+10','Weapon skill damage +9%','Accuracy+6 Attack+6',}},
		neck="Caro Necklace",
		--waist="Prosilio Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Sherida Earring",
		--left_ring="Karieyh Ring",
		right_ring="Rufescent Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
	--Stat Modifier: 	70% MND / 30% STR
	--TP Modifier 	1000 TP 	2000 TP 	3000 TP
	--fTP: 			3.0 		7.25 		9.75
	--Skillchain: 	Fragmentation / Compression	
	sets.precast.WS['Black Halo'] = {
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
		body="Viti. Tabard +3",
		hands="Atrophy Gloves +2",
		legs="Atrophy Tights +1",
		feet="Vitiation boots +3",
		neck="Dls. Torque +2",
		waist="Luminary Sash",
		left_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','TP Bonus +250',}},
		right_ear="Regal Earring",
		--left_ring="Karieyh Ring",
		right_ring="Rufescent Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}	
	--Stat Modifier: 	40% DEX / 40% INT
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--fTP: 				2.0 		3.0 		4.5
	--Skillchain: 	Impaction / Scission / Detonation
	sets.precast.WS['Aeolian Edge']	= {
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+8%','Mag. Acc.+2','"Mag.Atk.Bns."+13',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Vitiation Boots +1",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Regal Earring",
		right_ear="Friomisi Earring",
		--left_ring="Karieyh Ring",
		right_ring="Shiva Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
	--Stat Modifier: 	50% MND / 30% STR 	fTP: 	4.0
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--Effect accuracy: 	Unknown
	--Skillchain: 	Fragmentation / Distortion	
	sets.precast.WS['Death Blossom'] = {
		head="Viti. Chapeau +3", 
		body="Viti. Tabard +3", 
		hands="Atrophy Gloves +2",
		legs="Atrophy Tights +1",
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','TP Bonus +250',}},
		right_ear="Regal Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring="Rufescent Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	--Stat Modifier: 	80% DEX 	fTP: 	1.6328125
	--TP Modifier 			1000 TP 	2000 TP 	3000 TP
	--Critical Hit Rate: 	+15% 		+25% 		+40%
	--Skillchain: 	Light / Distortion
	sets.precast.WS['Chant Du Cygne'] = {
		ammo="Yetshila",
		head="Ayanmo Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Atrophy Gloves +3",
		legs={ name="Taeon Tights", augments={'Accuracy+22','"Triple Atk."+2','DEX+9',}},
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','TP Bonus +25',}},
		right_ear="Sherida Earring",
		left_ring="Begrudging Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
		
	--Stat Modifier: 		50% DEX 	fTP: 			1.25
	--TP Modifier 			1000 TP 	2000 TP 		3000 TP
	--Critical Hit Rate: 	+10% 		+25% 			+50%
	--Skillchain: 	Gravitation / Transfixion
	sets.precast.WS['Evisceration'] = {
		main="Tauret",
		sub="Ternion Dagger +1",
		ammo="Yetshila",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Atrophy Gloves +2",
		legs={ name="Taeon Tights", augments={'Accuracy+22','"Triple Atk."+2','DEX+9',}},
		feet="Aya. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}

		
--------------------------------------------------------------------------------------------------------	
---- _____    ____    _   _   _____    _____   _______   _____    ____    _   _              _      ----
--  / ____|  / __ \  | \ | | |  __ \  |_   _| |__   __| |_   _|  / __ \  | \ | |     /\     | |       --
-- | |      | |  | | |  \| | | |  | |   | |      | |      | |   | |  | | |  \| |    /  \    | |       --
-- | |      | |  | | | . ` | | |  | |   | |      | |      | |   | |  | | | . ` |   / /\ \   | |       --
-- | |____  | |__| | | |\  | | |__| |  _| |_     | |     _| |_  | |__| | | |\  |  / ____ \  | |____   --
--  \_____|  \____/  |_| \_| |_____/  |_____|    |_|    |_____|  \____/  |_| \_| /_/    \_\ |______|  --
----																								----
--------------------------------------------------------------------------------------------------------
        
    sets.buff.ComposureOther = set_combine(sets.midcast['Enhancing Magic'].SelfDuration, {
	    main={ name="Colada", augments={'Enh. Mag. eff. dur. +4','Mag. Acc.+8','"Mag.Atk.Bns."+8',}},
		head="Lethargy Chappel +1",
		neck="Duelist's Torque +2",
        body="Vitiation Tabard +3",
		hands="Atrophy Gloves +2",
        legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1",
		waist="Embla Sash",
		back="Ghostfyre Cape",
		})
		
	sets.Adoulin = {body="Councilor's Garb",}

    sets.MoveSpeed = {legs="Carmine Cuisses +1",hands="Buremte Gloves",ammo="Staunch Tathlum +1"}
		
	sets.ConsMP = {body="Vedic Coat"}

	sets.Dyna_RP_Farm = {main={ name="Crocea Mors", augments={'Path: C',}},}
	
	--Fallback for Macc ammo when we have ranged slot locked (i.e. Meleeing)
	sets.MaccAmmo = {range=empty,ammo="Regal Gem"}
	
--=================================--
--      ___       _   _            --
--     |_ _|   __| | | |   ___     --
--      | |   / _` | | |  / _ \    --
--      | |  | (_| | | | |  __/    --
--     |___|  \__,_| |_|  \___|    --
--=================================--


    sets.idle.Normal = {    
		main="Mafic Cudgel",
		sub="Sacro Bulwark",
		ammo="Homiliary",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Jhakri Robe +2",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Gishdubar Sash",
		left_ear="Infused Earring",
		right_ear="Etiolation Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

    sets.idle.Town = {
		main="Mafic Cudgel",
		sub="Sacro Bulwark",
		ammo="Homiliary",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Jhakri Robe +2",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Gishdubar Sash",
		left_ear="Infused Earring",
		right_ear="Etiolation Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
}
		

    sets.latent_refresh = {waist="Fucho-no-obi"}

--====================================================--
--     _____   ____      ____           _             --
--    |_   _| |  _ \    / ___|    ___  | |_   ___     --
--      | |   | |_) |   \___ \   / _ \ | __| / __|    --
--      | |   |  __/     ___) | |  __/ | |_  \__ \    --
--      |_|   |_|       |____/   \___|  \__| |___/    --
--====================================================--
	
	sets.ClubTP = {main="Daybreak", sub="Machaera +3"}
	
	sets.default_melee_weapons = {main="Crocea Mors", sub="Daybreak",}
	
	sets.AlmaceTauret = {main="Almace",sub="Tauret"}
	
    sets.engaged = {
    --main="Aern Dagger",
    --sub="Qutrub Knife",
    --range="Ullr",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Aya. Manopolas +2",
    legs={ name="Viti. Tights +3", augments={'Enspell Damage','Accuracy',}},
    feet="Malignance Boots",
    neck="Sanctity Necklace", --neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Reiki Yotai", --waist="Orpheus's Sash",
    left_ear="Suppanomimi",
    right_ear="Telos Earring", --right_ear="Digni. Earring",
    left_ring={name="Chirich Ring +1", bag="wardrobe3"},
    right_ring={name="Chirich Ring +1", bag="wardrobe4"},
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
}
	--main="Crocea Mors",
    --sub="Tauret",
    --ammo="Ginsen",
    --head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    --body="Atrophy Tabard +2",
    --hands="Malignance Gloves",
    --legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    --feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
    --neck="Anu Torque",
    --waist="Reiki Yotai",
    --left_ear="Telos Earring",
    --right_ear="Sherida Earring",
    --left_ring="Ilabrat Ring",
    --right_ring="Hetairoi Ring",
    --back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},


		
	sets.engaged.DT = {
		--main="Crocea Mors",
		--sub={ name="Machaera +3", augments={'TP Bonus +1000',}},
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		neck="Loricate Torque +1",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Sherida Earring",
		left_ring="Dark Ring", 
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},}

	sets.engaged.HasteCap = {
    --main="Aern Dagger",
    --sub="Qutrub Knife",
	--range="Ullr",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Aya. Manopolas +2",
    legs={ name="Viti. Tights +3", augments={'Enspell Damage','Accuracy',}},
    feet="Malignance Boots",
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Reiki Yotai", --waist="Orpheus's Sash",
    left_ear="Suppanomimi",
    right_ear="Digni. Earring",
    left_ring={name="Chirich Ring +1", bag="wardrobe3"},
    right_ring={name="Chirich Ring +1", bag="wardrobe4"},
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
}
		
	sets.engaged.HasteCap.DT = {    
		--main="Crocea Mors",
		--sub="Tauret",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Aya. Manopolas +2",
		legs={ name="Viti. Tights +3", augments={'Enspell Damage','Accuracy',}},
		feet="Malignance Boots",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Reiki Yotai", --waist="Orpheus's Sash",
		left_ear="Suppanomimi",
		right_ear="Digni. Earring",
		left_ring={name="Chirich Ring +1", bag="wardrobe3"},
		right_ring={name="Chirich Ring +1", bag="wardrobe4"},
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},}
		

		
	--sets.engaged.Savage_TP_Cape = {back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},}

end


--=================================================================--
--  _____                          _     _                         --
-- |  ___|  _   _   _ __     ___  | |_  (_)   ___    _ __    ___   --
-- | |_    | | | | | '_ \   / __| | __| | |  / _ \  | '_ \  / __|  --
-- |  _|   | |_| | | | | | | (__  | |_  | | | (_) | | | | | \__ \  --
-- |_|      \__,_| |_| |_|  \___|  \__| |_|  \___/  |_| |_| |___/  --
--                                                                 --
--=================================================================--


function job_precast(spell, action, spellMap, eventArgs)
	if spell.english == 'Refresh' then
		equip(sets.midcast['Enhancing Magic'])
		
	end
	if spell.english == 'Aeolian Edge' then
		equip(sets.precast.WS['Aeolian Edge'])
	end
	
	if spell.english == 'Impact' then
		equip(sets.precast.FC.Impact)
    end
	
	if spell.english == 'Impact' and (buffactive['Spontaneity'] or buffactive['Chainspell']) then
		sets.precast.FC.Impact = sets.precast.FC.ImpactQC
    elseif spell.english == 'Impact' then
		sets.precast.FC.Impact = sets.precast.FC.Impact2
	end
		
	if (buffactive['Spontaneity'] or buffactive['Chainspell']) and spell.english ~= "Impact" then
		eventArgs.handled = true
	end
	
	return
	
end
	


function job_midcast(spell, action, spellMap, eventArgs)

	
	if spell.name == 'Utsusemi: Ichi' and ShadowType == 'Ni' then
		if buffactive['Copy Image'] then
				windower.ffxi.cancel_buff(66)
		elseif buffactive['Copy Image (2)'] then
				windower.ffxi.cancel_buff(444)
		elseif buffactive['Copy Image (3)'] then
				windower.ffxi.cancel_buff(445)
		end
	end
	
	if spell.english == 'Impact' then
		equip(sets.midcast.Impact)
	end
	
	--[[if spell.name == 'Dia III' then
		if player.equipment.main == 'Crocea Mors' then
			send_command('send Overhauleri ;wait1.5;send Overhauleri /ma "Geo-Malaise" <bt>;wait 0.5;send Overhauleri /ma "Frazzle" <bt>')
		end
	
		if player.equipment.main == 'Sequence' then
			send_command('send Overhauleri ;wait1.5;send Overhauleri /ma "Geo-Frailty" <bt>;wait 0.5;send Overhauleri /ma "Frazzle" <bt>')
		end
		
		if player.equipment.main == 'Almace' then
			send_command('send Overhauleri ;wait1.5;send Overhauleri /ma "Geo-Frailty" <bt>;wait 0.5;send Overhauleri /ma "Frazzle" <bt>')

		end
		
		if player.equipment.main == 'Kaja Sword' then
			send_command('send Overhauleri ;wait1.5;send Overhauleri /ma "Geo-Frailty" <bt>;wait 0.5;send Overhauleri /ma "Frazzle" <bt>')
		end
		
		if player.equipment.main == 'Kaja Rod' then
			send_command('send Overhauleri ;wait1.5;send Overhauleri /ma "Geo-Frailty" <bt>;wait 0.5;send Overhauleri /ma "Frazzle" <bt>')
		end
		
	end]]
end


function job_post_midcast(spell, action, spellMap, eventArgs)


	if spell.skill == 'Enfeebling Magic' and state.Enfeeb.Value == 'Accuracy' then
		equip(sets.midcast['Enfeebling Magic'].Accuracy)
	elseif spell.skill == 'Enfeebling Magic' and state.Enfeeb.Value == 'Potency' then
		equip(sets.midcast['Enfeebling Magic'].Potency)
	end
	
	if spell.english == "Dia III" then
		equip(set_combine(sets.midcast['Enfeebling Magic'].Potency, sets.Dia))
	end

	
	if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and (player.mp-spell.mp_cost) < 600 then
		equip(sets.ConsMP)
	end	
	
	if spell.english == 'Sanguine Blade' and state.SanguineBlade.Value == 'MAB' then
		equip(sets.precast.WS['Sanguine Blade'].MAB)
	end
	
	if spell.skill == 'Elemental Magic' or (spell.type:lower() == 'weaponskill' and (spell.english == 'Sanguine Blade' or spell.english == 'Red Lotus Blade')) 
		and (spell.element == world.weather_element or spell.element == world.day_element) then
			equip(sets.Obi)
	end
	
	if spell.skill == 'Healing Magic' and (spell.element == world.weather_element or spell.element == world.day_element) and spell.target.type == 'PLAYER' then
		equip(set_combine(sets.midcast.Cure, sets.Obi))
	end
	
	if spell.english == "Temper" or spell.english == "Temper II" or spell.english:startswith('Protect') or spell.english:startswith('Shell') then
		equip(sets.midcast['Enhancing Magic'].Skill)
	end
	
	if spell.english == "Frazzle II" or spell.english == "Distract II" or spell.english == "Distract" then
		equip(sets.midcast['Enfeebling Magic'].Accuracy)
	end
	
	if spell.english == "Frazzle" and state.WeaponLockMode.value ~= 'Locked' then
		equip(sets.midcast['Enfeebling Magic'].MaxAccuracy)
	elseif spell.english == "Frazzle" and state.WeaponLockMode.value == 'Locked' then
		equip(set_combine(sets.midcast['Enfeebling Magic'].MaxAccuracy, sets.MaccAmmo))
	end
	
	if spell.english == "Repose" then
		equip(sets.midcast.Repose)
	end
	
	if spell.english == "Frazzle III" or (spell.english == "Distract III" and (state.Enfeeb.Value == 'Accuracy' or state.Enfeeb.Value == 'Potency')) then
		equip(sets.midcast['Enfeebling Magic'].Potency)
	end
	
	if spell.english:startswith('En') then
		equip(sets.midcast['Enhancing Magic'].Skill)
	end
	
	if spell.english == "Invisible" or spell.english == "Sneak" then 
		equip(sets.midcast['Enhancing Magic'])
	end
	
	if spell.skill == 'Enhancing Magic' and buffactive['Composure'] and spell.target.type == 'PLAYER' then
		equip(sets.buff.ComposureOther)
	end	
	
	if spell.action_type == "Magic" and spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
	end
	
	if spell.english == "Phalanx" and spell.target.type == 'SELF' then
		equip(sets.midcast.PhalanxSelf)
	end
	
	if spell.skill == "Enhancing Magic" and 
		spell.english:startswith('Gain') then
		equip(sets.midcast['Enhancing Magic'].GainSpell)
	elseif ((spell.english:startswith('Haste') or spell.english:startswith("Flurry")
		or spell.english == 'Sneak' or spell.english == 'Invisible' or 
		spell.english == 'Deodorize' or spell.english:startswith('Regen')) and spell.target.type == 'SELF') then
        equip(sets.midcast['Enhancing Magic'].SelfDuration)
	end
	
	if spell.skill == 'Enfeebling Magic' and buffactive['Stymie'] then
		equip(sets.midcast['Enfeebling Magic'].Potency)
	end
	
	if (spell.english:startswith("Break") or spell.english == 'Bind' or spell.english == 'Dispel'
		or spell.english == 'Inundation' or spell.english == 'Silence' or spell.english == 'Stun') and state.WeaponLockMode.value ~= 'Locked' then
		equip(sets.midcast['Enfeebling Magic'].MaxAccuracy)
	elseif (spell.english:startswith("Break") or spell.english == 'Bind' or spell.english == 'Dispel'
		or spell.english == 'Inundation' or spell.english == 'Silence' or spell.english == 'Stun') and state.WeaponLockMode.value == 'Locked' then
		equip(set_combine(sets.midcast['Enfeebling Magic'].MaxAccuracy, sets.MaccAmmo))
	end
	
	if spell.english:startswith("Sleep") then
		equip(sets.midcast.Sleep)
	end
	
	if (spell.skill == 'Enfeebling Magic' and buffactive['Saboteur']) and not (spell.english:startswith("Break") 
		or spell.english:startswith("Break") or spell.english == 'Bind' or spell.english == 'Dispel'
		or spell.english == 'Inundation' or spell.english == 'Silence' or spell.english == 'Stun' or spell.english == "Frazzle II" or spell.english == "Distract II" or spell.english == "Distract") then
			equip(sets.Saboteur)
	end
		
	if spell.skill == 'Enfeebling Magic' or spell.skill == 'Dark Magic' then
		if spell.type ~= "WhiteMagic" and not (spell.english:startswith('Distract') or spell.english:startswith('Frazzle')) then
			equip(sets.midcast.IntEnfeebles)
		end
	end
	
	if spell.english == "Refresh" or spell.english == "Refresh II" or spell.english == "Refresh III" then
		equip(sets.midcast.Refresh)
	end
end


function job_aftercast(spell, action, spellMap, eventArgs)

	if not spell.interrupted then
		if spell.english == "Sleep II" or spell.english == "Sleepga II" then -- Sleep II Countdown --
			send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
			send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Break" or spell.english == "Breakga" then -- Break Countdown --
			send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Paralyze" then -- Paralyze Countdown --
			send_command('wait 115;input /echo Paralyze Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Slow" then -- Slow Countdown --
			send_command('wait 115;input /echo Slow Effect: [WEARING OFF IN 5 SEC.]')        
		end
	end
	
	--if spell.action_type == 'Item' then
     --   eventArgs.handled = false
   -- end
   
	if spell and spell.name == 'Utsusemi: Ni' then
		ShadowType = 'Ni'
	elseif spell and spell.name == 'Utsusemi: Ichi' then
		ShadowType = 'Ichi'
	end
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)

    if stateField == 'WeaponLockMode' then
        if newValue == 'Unlocked' then
            enable('main','sub','range','ammo')
        elseif newValue == 'Locked' and (player.equipment.range == 'Ullr' or player.equipment.range == 'Kaja Bow') then
            disable('main','sub','range','ammo')
		elseif newValue == 'Locked' then
            disable('main','sub','range')
        end
    end
	
	if stateField == 'DynaMode' then
		if newValue == 'RP_Farm' then
			equip(sets.Dyna_RP_Farm)
			if sets.Dyna_RP_Farm.neck and sets.Dyna_RP_Farm.main then
				disable('main','neck')
			elseif sets.Dyna_RP_Farm.main then
				disable('main')
			elseif sets.Dyna_RP_Farm.neck then
				disable('neck')
			end
		elseif newValue ~= 'RP_Farm' then
			enable('neck')
		end
	end

end

function job_get_spell_map(spell, default_spell_map)
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
	if (buff and gain) or (buff and not gain) then
		send_command('gs c update')
	end
	--[[if state.Moving.value == 'false' then
		if not buffactive[580] then
		send_command('send Overhauleri /ma "Indi-Haste" <me>')
		end
	end]]
end


function control_geo_mule()

end

function customize_melee_set(meleeSet)


    if (buffactive['Embrava'] or buffactive['March'] or buffactive[580] or buffactive['Mighty Guard']) and state.OffenseMode.Value == 'DT' then
		meleeSet = set_combine(meleeSet, sets.engaged.HasteCap, sets.engaged.HasteCap.DT)
	elseif (buffactive['Embrava'] or buffactive['March'] or buffactive[580] or buffactive['Mighty Guard']) then
        meleeSet = set_combine(meleeSet, sets.engaged.HasteCap)
    end
	
	if state.ZoneRing.value == 'Warp' then
		meleeSet = set_combine(meleeSet, {right_ring="Warp Ring"})
	elseif state.ZoneRing.value == 'Holla' then
		meleeSet = set_combine(meleeSet, {right_ring="Dimensional ring (Holla)"})
	elseif state.ZoneRing.value == 'Dem' then
		meleeSet = set_combine(meleeSet, {right_ring="Dimensional ring (Dem)"})
	elseif state.ZoneRing.value == 'Mea' then
		meleeSet = set_combine(meleeSet, {right_ring="Dimensional ring (Mea)"})	
		return meleeSet
	end
	
	if player.equipment.main == 'Sequence' or player.equipment.main == 'Kaja Sword' or player.equipment.main == "Naegling" then
		meleeSet = set_combine(meleeSet, sets.engaged.Savage_TP_Cape)
	end
		
	if buffactive['Doom'] then
        meleeSet = set_combine(meleeSet, sets.Doom)
    end
	
	return meleeSet
	
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    
	if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
	elseif state.IdleMode.value == 'PDT' then
		idleSet = sets.idle.PDT
	elseif state.IdleMode.value == 'MDT' then
		idleSet = sets.idle.MDT
	elseif state.IdleMode.value == 'Normal' then
		idleSet = sets.idle.Normal
    end
	
	if state.ZoneRing.value == 'Warp' then
		idleSet = set_combine(idleSet, {right_ring="Warp Ring"})
	elseif state.ZoneRing.value == 'Holla' then
		idleSet = set_combine(idleSet, {right_ring="Dimensional ring (Holla)"})
	elseif state.ZoneRing.value == 'Dem' then
		idleSet = set_combine(idleSet, {right_ring="Dimensional ring (Dem)"})
	elseif state.ZoneRing.value == 'Mea' then
		idleSet = set_combine(idleSet, {right_ring="Dimensional ring (Mea)"})	
		return idleSet
	end
	
	if buffactive['doom'] then
        idleSet = set_combine(idleSet, sets.Doom)
    end
	
    return idleSet
	
end

function equip_gear_by_status(status)

end

windower.register_event('zone change', function()

	if state.ZoneRing.Value ~= 'None' then
		send_command('gs c set ZoneRing None')
	end
	
	if world.area:contains("[D]") and state.DynaMode.Value == 'None' then
		send_command('gs c set DynaMode RP_Farm')
	elseif not world.area:contains("[D]") and state.DynaMode.Value == 'RP_Farm' then
		send_command('gs c set DynaMode None')
	end
	
end)

mov = {counter=0}
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
    mov.x = windower.ffxi.get_mob_by_index(player.index).x
    mov.y = windower.ffxi.get_mob_by_index(player.index).y
    mov.z = windower.ffxi.get_mob_by_index(player.index).z
end


moving = false
windower.raw_register_event('prerender',function()
    mov.counter = mov.counter + 1;
    if mov.counter>15 then
        local pl = windower.ffxi.get_mob_by_index(player.index)
        if pl and pl.x and mov.x and state.EngagedMoving.Value == 'Disabled' then
			--we want this to return a false value if these conditions were met, but we drew our weapons whilst moving.
			--we also want this value to become false if we Disable EngagedMovement while engaged.
			if state.Moving.value == 'true' and player.status == 'Engaged' then
				state.Moving.value = 'false'
			end
			if player.status ~= 'Engaged' then
				dist = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 )
				if dist > 1 and not moving then
					state.Moving.value = 'true'
					send_command('gs c update')
					if world.area:contains("Adoulin") then
						send_command('gs equip sets.Adoulin')
						--send_command('send Overhauleri /follow Byrne')
					elseif state.Following.value == 'Follow' then
						--send_command('send Overhauleri /follow Byrne')
						send_command('gs equip sets.MoveSpeed')
					else
						send_command('gs equip sets.MoveSpeed')
					end

					moving = true

				elseif dist < 1 and moving then
					state.Moving.value = 'false'
					send_command('gs c update')
					moving = false
				end
			end
        elseif pl and pl.x and mov.x and state.EngagedMoving.Value == 'Enabled' then
			dist = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 )
			if dist > 1 and not moving then
				state.Moving.value = 'true'
				send_command('gs c update')
				if world.area:contains("Adoulin") then
					send_command('gs equip sets.Adoulin')
				else
					send_command('gs equip sets.MoveSpeed')
				end

				moving = true

			elseif dist < 1 and moving then
				state.Moving.value = 'false'
				send_command('gs c update')
				moving = false
			end
		end
        if pl and pl.x then
            mov.x = pl.x
            mov.y = pl.y
            mov.z = pl.z
        end
        mov.counter = 0
    end
	
end)

-- Set eventArgs.handled to true if we don't want the automatic display to be run.

function display_current_job_state(eventArgs)
    local msg = ""

    handle_equipping_gear(player.status)

    add_to_chat(122, msg)
    eventArgs.handled = true
end

--this will disable all add_to_chat, reccomend using Echos.  Alternatively, you can disable this.
function add_to_chat(command)
	if handle_unset and command == 'add_to_chat' then
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'BLM' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 10)
    else
        set_macro_page(1, 10)
    end
end
---------------------------------------------------------------------------------------------------
--This is used to make sure we will attempt to refresh the window every second
--prerender is actually faster than 1 second as it is called every few milliseconds
time_start = os.time()
windower.register_event(
    "prerender",
    function()
        --Items we want to check every second
        if os.time() > time_start then
            --We want to keep this reset each time we enter so its called every second
            time_start = os.time()

            --Simply refreshes the window
            refreshWindow()
        end
    end
)

--Window
--Default To Set Up the Text Window

-- Place this in the job_function()
-- setupTextWindow(1400, 600)

-- You can toggle this with a command to turn the entire window on and off
-- visible = false
visible = true

function setupTextWindow(pos_x, pos_y)
    tb_name = "run_gs_helper"
    bg_visible = true
    textinbox = " "

    windower.text.create(tb_name)
    -- table_name, x, y
    windower.text.set_location(tb_name, pos_x, pos_y)
    -- transparency, rgb
    windower.text.set_bg_color(tb_name, 170, 30, 30, 40)
    windower.text.set_color(tb_name, 255, 255, 161, 61)
    windower.text.set_font(tb_name, "Trebuchet MS")
    windower.text.set_font_size(tb_name, 14)
    windower.text.set_bold(tb_name, true)
    windower.text.set_italic(tb_name, false)
    windower.text.set_text(tb_name, textinbox)
    windower.text.set_bg_visibility(tb_name, bg_visible)
    windower.text.set_visibility(tb_name, visible)
end

--Hanldles refreshing the current text window
-- refreshWindow() should be called anytime you perform an action that would change what is on the window
function refreshWindow()
    textinbox = " " -- This is what gets drawn on the screen at the end
    textColorNewLine = "\\cr \n" --Placed at the end of a line to end the color and make a new line after
    textColorEnd = " \\cr" -- Placed at the end of what you are displaying to end the given color
    textColor = "\\cs(125, 255, 125)" --RGB color setting

    if not visible then --If not 'true' then it will hide the window all together
        textinbox = ""
        windower.text.set_text(tb_name, textinbox)
        return
    end

    --If you want to Toggle this section uncomment the if and end
    --You'll need to use a variable like this in user_setup():
    --state.textHideMode = M(false, "Hide Mode")
    --then you can toggle it with Mote's
    -- //gs c toggle textHideMode
    
    -- if not state.textHideMode.value then
	
		textinbox = textinbox .. drawTitle("  Local Keybinds  ")
		textinbox = textinbox .. textColor .. "(WIN+F8) Equip & Lock Weapons" .. textColorNewLine
	
        textinbox = textinbox .. drawTitle("  Current Settings  ") --Draws the title and puts '=', example ====     Mode     ==== around the title passed in
		textinbox = textinbox .. textColor .. "TP Mode (F9) : " .. tostring(state.OffenseMode.current) .. textColorNewLine
		textinbox = textinbox .. textColor .. "Casting Mode (CTRL+F9) : " .. tostring(state.CastingMode.current) .. textColorNewLine
        textinbox = textinbox .. textColor .. "Idle Mode (F10) : " .. tostring(state.IdleMode.current) .. textColorNewLine
		
		if state.Enfeeb.value == 'Potency' then
			textinbox = textinbox .. textColor .. "Enfeebling Mode (F11) : " .. tostring(state.Enfeeb.current) .. textColorNewLine
		elseif state.Enfeeb.value == 'Accuracy' then
			textinbox = textinbox .. textColor .. "Enfeebling Mode (F11) : " .. tostring(state.Enfeeb.current) .. textColorNewLine
		elseif state.Enfeeb.value == 'Skill' then
			textinbox = textinbox .. textColor .. "Enfeebling Mode (F11) : " .. "\\cs(255, 75, 75)" .. tostring(state.Enfeeb.current) .. textColorNewLine
		end
		
		if state.WeaponLockMode.value == 'Locked' then
			textinbox = textinbox .. "\\cs(255, 255, 255)" .. "Lock Mode (F12) : " .. "\\cr" .. "\\cs(255, 75, 75)" .. tostring(state.WeaponLockMode.current) .. textColorNewLine
		elseif state.WeaponLockMode.value == 'Unlocked' then
			textinbox = textinbox .. "\\cs(255, 255, 255)" .. "Lock Mode (F12) : " .. "\\cr" .. "\\cs(255, 255, 255)" .. tostring(state.WeaponLockMode.current) .. textColorNewLine
		end
       
		if state.SanguineBlade.value == 'MAB' then
			textinbox = textinbox .. "\\cs(255, 255, 255)" .. "Sanguine Mode (F7) : " .. "\\cr" .. "\\cs(255, 75, 75)" .. tostring(state.SanguineBlade.current) .. textColorNewLine
		elseif state.SanguineBlade.value == 'None' then
			textinbox = textinbox .. "\\cs(255, 255, 255)" .. "Sanguine Mode (F7) : " .. "\\cr" .. "\\cs(255, 255, 255)" .. tostring(state.SanguineBlade.current) .. textColorNewLine
		end
		
		if state.ZoneRing.current == 'Warp' then
			textinbox = textinbox .. "Zone Ring (CTRL+F7) : " .. "\\cs(255, 75, 255)" .. tostring(state.ZoneRing.current) .. textColorNewLine
		elseif state.ZoneRing.current == 'Holla' then
			textinbox = textinbox .. "Zone Ring (CTRL+F7) : " .. "\\cs(255, 75, 75)" .. tostring(state.ZoneRing.current) .. textColorNewLine
		elseif state.ZoneRing.current == 'Dem' then
			textinbox = textinbox .. "Zone Ring (CTRL+F7) : " .. "\\cs(0, 175, 255)" .. tostring(state.ZoneRing.current) .. textColorNewLine
		elseif state.ZoneRing.current == 'Mea' then
			textinbox = textinbox .. "Zone Ring (CTRL+F7) : " .. "\\cs(255, 255, 75)" .. tostring(state.ZoneRing.current) .. textColorNewLine
		elseif state.ZoneRing.current == 'None' then
			textinbox = textinbox .. "Zone Ring (CTRL+F7) : " .. "\\cs(255, 255, 255)" .. tostring(state.ZoneRing.current) .. textColorNewLine
		end
		if state.Moving.value == 'false' then
			textinbox = textinbox .. "Player Moving (Auto) : " .. "\\cs(255, 100, 100)" .. tostring(state.Moving.value) .. "\\cr \n"
		else
			textinbox = textinbox .. "Player Moving (Auto) : " .. "\\cs(100, 255, 100)" .. tostring(state.Moving.value) .. "\\cr \n"
		end
			--textinbox = textinbox .. textColor .. "Engaged Movespeed (F1) : " .. tostring(state.EngagedMoving.current) .. textColorNewLine

			textinbox = textinbox .. textColor .. "Geo Follow (CTRL+F10) : " .. tostring(state.Following.current) .. textColorNewLine
			
		if state.DynaMode.value == 'RP_Farm' then
			textinbox = textinbox .. "\\cs(255, 255, 255)" .. "Divergence RP Farm (Auto) : " .. "\\cs(0, 175, 255)" .. "ON" .. textColorNewLine
		end

    windower.text.set_text(tb_name, textinbox)
end


--Creates the Title for a section in the Text Screen
function drawTitle(title)
    return "\\cs(200, 222, 255)" .. pad(tostring(title), 6, ":") .. "\\cr \n"
end

--Pads a given chara on both sides (centering with left justification)
function pad(s, l, c)
    local srep = string.rep
    local c = c or " "

    local res1 = srep(c, l) .. s -- pad to half-length s
    local res2 = res1 .. srep(c, l) -- right-pad our left-padded string to the full length

    return res2
end

--Takes a condition and returns a given value based on if it is true or false
function ternary(cond, T, F)
    if cond then
        return T
    else
        return F
    end
end


---------------------------------------------------------------------------------------------------
--organizer_items = {
	--echo="Echo Drops",
	--echo2="Echo Drops",
	--pana="Panacea",
	--pana2="Panacea",
	--reme="Remedy",
	--reme2="Remedy",
	--sush2="Sublime Sushi +1",
	--sush1="Sublime Sushi",
	--stew="Marine Stewpot",
	--hall="Hallowed Water",
	--shih="Shihei"}
