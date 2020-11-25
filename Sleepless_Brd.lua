-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
--]]
--function get_sets()
--fixed_pos = ''
--fixed_ts = os.time()

--end

--windower.raw_register_event('outgoing chunk',function(id,original,modified,injected,blocked)
    --if not blocked then
        --if id == 0x15 then
            --if (gearswap.cued_packet or midaction()) and fixed_pos ~= '' and os.time()-fixed_ts < 10 then
               --return original:sub(1,4)..fixed_pos..original:sub(17)
           -- else
               --fixed_pos = original:sub(5,16)
               --fixed_ts = os.time()
           --end
       --end
    --end
--end)

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('sleepless_custom_functions.lua')
	include('lullaby.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'FullLength', 'Dummy'}
	state.LullabyMode = M{['description']='Lullaby Mode','Gjallarhorn','Daurdabla'}
    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false
	state.IdleMode:options('Normal','PDT','MEVA')
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
	send_command('alias tp gs c cycle tpmode')
	send_command('bind f10 gs c cycle idlemode')
	send_command('bind f11 gs c cycle LullabyMode')
	send_command("alias buff gs equip sets.midcast.SongEffect")
    send_command("alias debuff gs equip sets.midcast.SongDebuff")
	send_command("alias macc gs equip sets.midcast.ResistantSongDebuff")
	send_command("alias lul gs equip sets.midcast.LullabyFull")
	send_command("alias fc gs equip sets.precast.FastCast.BardSong")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command("alias meva gs equip sets.meva")
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias wsset gs equip sets.precast.WS")
	    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
	
	send_command("alias g11_m2g16 input /ws Rudra's Storm")
	send_command("alias g11_m2g17 input /ws Mordant Rime")
	send_command("alias g11_m2g18 input /ws Exenterator")
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'DualWield')
    state.CastingMode:options('Normal', 'Resistant')
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    
	info.MaxSongs = 4
	
	-- If Max Job Points - adds alot of timers to the custom timers
	MaxJobPoints = 1
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomv = M(false, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')

    select_default_macro_book()
	send_command('@wait 25;input /lockstyleset 20')
	
	waittime = 2.7

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	weaponlock_main=""
	weaponlock_sub=""
	    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FastCast = {
    range="Sapience Orb", --2%
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Inyanga Jubbah +2", --14%
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8%
    legs="Aya. Cosciales +2", --5%
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    neck="Orunmila's Torque",  --5%
    waist="Embla Sash",  --5%
    left_ear="Enchntr. Earring +1", --2%
    right_ear="Loquac. Earring",  --2%
    left_ring="Rahab Ring", --left_ring="Prolix Ring",  -- 2% 
    right_ring="Kishar Ring", --4%
    back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}

    sets.precast.FastCast.Cure = set_combine(sets.precast.FastCast, {legs="Doyen Pants"})

    sets.precast.FastCast.Stoneskin = set_combine(sets.precast.FastCast, {head="Umuthi Hat",legs="Doyen Pants"})

    sets.precast.FastCast['Enhancing Magic'] = set_combine(sets.precast.FastCast, {waist="Witful Belt",back="Perimede Cape",left_ring="Lebeche Ring"})

    sets.precast.FastCast.BardSong = {
    range="Marsyas",
    head="Fili Calot +1",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','Song spellcasting time -5%',}},
    legs={ name="Gende. Spats +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','Song spellcasting time -4%',}},
    feet={ name="Telchine Pigaches", augments={'Song spellcasting time -6%','Enh. Mag. eff. dur. +10',}},
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Enchntr. Earring +1",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
	back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}

    sets.precast.FastCast.Daurdabla = set_combine(sets.precast.FastCast.BardSong, {range=info.ExtraSongInstrument})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
    sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
       
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
    range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet={ name="Chironic Slippers", augments={'Magic dmg. taken -2%','"Mag.Atk.Bns."+12','Quadruple Attack +3','Accuracy+17 Attack+17','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
    right_ear="Mache Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Hetairoi Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	--Stat Modifier: 	70% CHR / 30% DEX 	fTP: 	5.0
	--TP Modifier 			1000 TP 	2000 TP 	3000 TP
	--Effect accuracy: 	unknown
	--Skillchain: 	Fragmentation / Distortion
	sets.precast.WS['Mordant Rime'] = {
	range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head={ name="Lustratio Cap +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}}, --head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
	hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}}, --hands={ name="Chironic Gloves", augments={'Pet: Haste+2','Weapon skill damage +5%','Accuracy+5 Attack+5','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Bard's Charm +2",
    waist="Grunfeld Rope",
    left_ear="Regal Earring",
    right_ear="Mache Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
	--Stat Modifier: 	80% DEX
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--fTP: 				5.0 		10.19 		13
	--Skillchain: 	Darkness / Distortion	
	sets.precast.WS['Rudra Storm'] = {
	range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Chironic Gloves", augments={'Pet: Haste+2','Weapon skill damage +5%','Accuracy+5 Attack+5','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Bard's Charm +2",
    waist="Grunfeld Rope",
    left_ear="Kuwunga Earring",
    right_ear="Mache Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
	--Stat Modifier: 	40% DEX / 40% INT
	--TP Modifier 		1000 TP 	2000 TP 	3000 TP
	--fTP: 				2.0 		3.0 		4.5
	--Skillchain: 	Impaction / Scission / Detonation
	sets.precast.WS['Aeolian Edge'] = {
	range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Chironic Gloves", augments={'Pet: Haste+2','Weapon skill damage +5%','Accuracy+5 Attack+5','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Bard's Charm +2",
    waist="Grunfeld Rope",
    left_ear="Regal Earring",
    right_ear="Mache Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
    --Stat Modifier: 		50% DEX 	fTP: 			1.25
	--TP Modifier 			1000 TP 	2000 TP 		3000 TP
	--Critical Hit Rate: 	+10% 		+25% 			+50%
	--Skillchain: 	Gravitation / Transfixion
	sets.precast.WS['Evisceration'] = {
	range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Chironic Gloves", augments={'Pet: Haste+2','Weapon skill damage +5%','Accuracy+5 Attack+5','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Bard's Charm +2",
    waist="Grunfeld Rope",
    left_ear="Kuwunga Earring",
    right_ear="Mache Earring +1",
    left_ring="Begrudging Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
	--Stat Modifier: 		50% STR / 50% MND
	--TP Modifier 			1000 TP 	2000 TP 	3000 TP
	--fTP: 					4.0 		10.25 		13.75
	--Skillchain: 	Fragmentation / Scission
	sets.precast.WS['Savage Blade'] = {
	range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head={ name="Lustratio Cap +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},--head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
	--hands={ name="Chironic Gloves", augments={'Pet: Haste+2','Weapon skill damage +5%','Accuracy+5 Attack+5','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Bard's Charm +2",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}}, 
    left_ear="Telos Earring", 
	right_ear="Ishvara Earring",
    left_ring="Shukuyu Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
	sets.precast.WS['Circle Blade'] = {
	range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head={ name="Lustratio Cap +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},--head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
	--hands={ name="Chironic Gloves", augments={'Pet: Haste+2','Weapon skill damage +5%','Accuracy+5 Attack+5','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Bard's Charm +2",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}}, 
    left_ear="Telos Earring", 
	right_ear="Ishvara Earring",
    left_ring="Shukuyu Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
    
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {   
	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','Song spellcasting time -5%',}},
    legs="Aya. Cosciales +2",
    feet={ name="Telchine Pigaches", augments={'Song spellcasting time -6%','Enh. Mag. eff. dur. +10',}},
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Enchanter Earring",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}
        
    -- Gear to enhance certain classes of songs. 
    sets.midcast.Etude = {head="Mousai Turban"}
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
    sets.midcast.Lullaby = {range="Daurdabla",hands="Brioso Cuffs +3"}
    sets.midcast.Madrigal = {head="Fili Calot +1",back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
	sets.midcast.Prelude = {back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}}
    sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast.HonorMarch = {hands="Fili Manchettes +1",range="Marsyas"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Minne = {legs="Mousai Seraweels"}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.midcast.Carol = {hands="Mousai Gages"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
    sets.midcast['Magic Finale'] = {
	legs="Fili Rhingrave +1", --8 sec
	--hands="Bewegt cuffs", --6 sec
	feet="Coalrake Sabots"--5 sec     
}	
    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
   

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
    main="Carnwenhan",
	range="Gjallarhorn",
	head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Moonbow Whistle +1",
    waist="Witful Belt",
    left_ear="Darkside Earring",
	right_ear="Eabani Earring", 	
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
	head="Brioso Roundlet +3",
    body="Brioso Justau. +3",
    hands="Inyan. Dastanas +2",
    legs="Brioso Cannions +3", --Brioso Cannions +3 --Inyanga Shalwar +2
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Regal Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = {
	head="Brioso Roundlet +3",
    body="Brioso Justau. +3",
    hands="Inyan. Dastanas +2",
    legs="Brioso Cannions +3", -- Brioso Cannions +3 -- Inyanga Shalwar +2
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Regal Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}
	
		
	sets.midcast.LullabyFull = set_combine(sets.midcast.SongDebuff, sets.midcast.Lullaby)
	sets.midcast.LullabyFull.ResistantSongDebuff = set_combine(sets.midcast.ResistantSongDebuff, sets.midcast.Lullaby)

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear2="Loquacious Earring",ring1="Kishar Ring",legs="Fili Rhingrave +1"} --back="Harmony Cape",waist="Corvax Sash",

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = {
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
	left_ear="Loquac. Earring",
    right_ear="Loquac. Earring",
	body="Inyanga jubbah +2",
	hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	left_ring="Prolix Ring",
	right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	waist="Witful Belt",
	legs={ name="Gende. Spats +1", augments={'Phys. dmg. taken -1%','Song spellcasting time -3%',}},
	feet="Coalrake sabots"
	}

    -- Other general spells and classes.
    sets.midcast.Cure = {
    head={ name="Kaykaus Mitra", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
    body="Chironic Doublet",
    hands="Telchine Gloves", 
    legs="Doyen Pants",
    feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
    neck="Nodens Gorget",
    waist="Porous Rope",
    left_ear="Mendi. Earring",
    right_ear="Calamitous Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring="Lebeche Ring",
    back="Solemnity Cape",
	}
     
	sets.midcast.MndEnfeebles = {
	head="Brioso Roundlet +3",
    body="Brioso Justau. +3",
    hands="Brioso Cuffs +3",
    legs="Brioso Cannions +3",  --Inyanga Shalwar +2
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Regal Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe4"},
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}
    sets.midcast.Curaga = sets.midcast.Cure
        
        
    sets.midcast.Cursna = sets.midcast.Cure

    
	sets.midcast['Enhancing Magic'] = {
    head={ name="Telchine Cap", augments={'Pet: DEF+20','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Pet: Evasion+19','Pet: "Regen"+3','Enh. Mag. eff. dur. +9',}},
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Pet: Evasion+15','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Song spellcasting time -6%','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash", 
    left_ear="Mendi. Earring",
    right_ear="Calamitous Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring="Sheltered Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash",legs="Doyen Pants"})
    
	sets.midcast.RefreshRecieved = set_combine(sets.midcast['Enhancing Magic']) --{back="Grapevine Cape",waist="Gishdubar Sash"}
	
	sets.midcast.Cursna = {
    ammo="Impatiens",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    feet="Vanya Clogs",
    neck="Malison Medallion",
    waist="Bishop's Sash",
    --left_ear="Healing Earring",
    --right_ear="Beatific Earring",
    left_ring="Menelaus's Ring", --20
    right_ring="Haoma's Ring",
    back="Solemnity Cape",
}
	
	
	
    -- Sets to return to when not performing an action.
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.Idle = {}
	sets.Idle.Main = {
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
	hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},--hands="Shrieker's Cuffs",
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Etiolation Earring",
    right_ear="Eabani Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	sets.Idle.PDT = {
    sub="Genmei Shield",
    --ammo="Staunch Tathlum +1",
    head="Inyanga Tiara +2",
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},--hands="Shrieker's Cuffs",
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Etiolation Earring",
    right_ear="Eabani Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}
	sets.Idle.Current = sets.Idle.Main
    
    -- Defense sets

    sets.defense.PDT = {
    -- sub="Genmei Shield",
    --ammo="Staunch Tathlum +1",
    head="Inyanga Tiara +2",
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},--hands="Shrieker's Cuffs",
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Etiolation Earring",
    right_ear="Eabani Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}

    sets.defense.MDT = {
    --range={ name="Nibiru Harp", augments={'Mag. Evasion+20','Phys. dmg. taken -3','Magic dmg. taken -3',}},
    head="Inyanga Tiara +2",
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs="Inyanga Shalwar +2",
    feet="Inyan. Crackows +2",
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Etiolation Earring",
    right_ear="Eabani Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}

    sets.Kiting = {feet="Fili Cothurnes +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets
    sets.engaged = {
	range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet="Aya. Gambieras +2",
    neck="Bard's Charm +2",
    waist="Windbuffet Belt +1",
    left_ear="Digni. Earring",
    right_ear="Mache Earring +1",
    left_ring="Petrov Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
    
    sets.engaged.DualWield = {
    main="Carnwenhan",
	sub="Kali",
	--main="Naegling",
    --sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    range={ name="Linos", augments={'Attack+15','"Store TP"+4','Quadruple Attack +3',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet="Aya. Gambieras +2", --feet={ name="Chironic Slippers", augments={'Magic dmg. taken -2%','"Mag.Atk.Bns."+12','Quadruple Attack +3','Accuracy+17 Attack+17','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist="Reiki Yotai",
    left_ear="Digni. Earring",
    right_ear="Eabani Earring",
    left_ring="Ayanmo Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
    
	
	sets.meva = {
    --range={ name="Nibiru Harp", augments={'Mag. Evasion+20','Phys. dmg. taken -3','Magic dmg. taken -3',}},
    head="Inyanga Tiara +2",
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs="Inyanga Shalwar +2",
    feet="Inyan. Crackows +2",
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Etiolation Earring",
    right_ear="Eabani Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}
		--main="Terra's Staff",
        --sub="Irenic Strap +1",
        --ammo="Staunch Tathlum +1",
        --head="Volte Cap",
        --body={ name="Telchine Chas.", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +10',}},
        --hands="Volte Bracers",
        --legs={ name="Telchine Braconi", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +9',}},
        --feet="Volte Boots",
        --neck="Warder's Charm +1",
        --waist="Carrier's Sash",
        --left_ear="Eabani Earring",
        --right_ear="Flashward Earring",
        --left_ring="Purity Ring",
        --right_ring="Vengeful Ring",
        --back="Solemnity Cape",
	
	
	
	
	-- Relevant Obis. Add the ones you have.
    sets.obi = {}
    sets.obi.Wind = {waist='Hachirin-no-obi'}
    sets.obi.Ice = {waist='Hachirin-no-obi'}
    sets.obi.Lightning = {waist='Hachirin-no-obi'}
    sets.obi.Light = {waist='Hachirin-no-obi'}
    sets.obi.Dark = {waist='Hachirin-no-obi'}
    sets.obi.Water = {waist='Hachirin-no-obi'}
    sets.obi.Earth = {waist='Hachirin-no-obi'}
    sets.obi.Fire = {waist='Hachirin-no-obi'}
    
	

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_pretarget(spell)
checkblocking(spell)
	if spell.action_type == 'Magic' then
		if aftercast_start and os.clock() - aftercast_start < waittime then
			windower.add_to_chat(8,"Precast too early! Adding Delay:"..waittime - (os.clock() - aftercast_start))
			cast_delay(waittime - (os.clock() - aftercast_start))
		end
	end
end

function job_precast(spell, action, spellMap, eventArgs)
--windower.add_to_chat(2,'Party Buffs in range?')
checkblocking(spell)
--[[
	for i,v in pairs(buff) do
	   for i2,v2 in pairs(v) do
	      print(i2,v2)
		end
	end
    ]]
    -- handle_equipping_gear(player.status)
	precast_start = os.clock()
	handle_equipping_gear(player.status)
	if spell.type == 'BardSong' then
		if buffactive.Nightingale then
			local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
				windower.add_to_chat(8,'Equipping Midcast - Nightingale active.'..generalClass)
                equip(sets.midcast[generalClass])
             end
		else 
			equip(sets.precast.FastCast.BardSong)
		end
		if buffactive.Troubadour and string.find(spell.name,'Lullaby') then
			equip({range="Marsyas"})
			equip(sets.midcast.LullabyFull)
			windower.add_to_chat(8,'Marsyas Equipped - Troubadour / Lullaby active')
		end
	elseif string.find(spell.name,'Cur') and spell.name ~= 'Cursna' then
		equip(sets.precast.FastCast.Cure)
	elseif spell.name == 'Stoneskin' then 
		equip(sets.precast.FastCast.Stoneskin)
	else
		equip(sets.precast.FastCast)
	end
	-- Auto use Extra Song Instrument for Buffs if less than max # of songs
	
	-- Some thoughts:
	-- How to watch party buffs - can take from partybuffs lua and build a table.
	
	local bard_buff_ids = S{195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 218, 219, 220, 221, 222}
	
	num_bard_songs = 0
	local self = windower.ffxi.get_player()
	for i,v in pairs(self.buffs) do
		if bard_buff_ids:contains(v) then
		   num_bard_songs = num_bard_songs +1
		end
	end
	
	local generalClass = get_song_class(spell)
	
	if num_bard_songs >= 2 and num_bard_songs < info.MaxSongs and spell.name ~= 'Honor March' and generalClass == 'SongEffect' then
		windower.add_to_chat(10,"Swapping to "..info.ExtraSongInstrument.."! Number of bard buffs = "..num_bard_songs)
		equip({range=info.ExtraSongInstrument})
	end
	
	if spell.name == 'Honor March' then
        equip({range="Marsyas"})
	end
	
	if string.find(spell.name,'Horde') and state.LullabyMode == 'Daurdabla' then 
		equip({range="Daurdabla"})
	end
	
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	local generalClass = get_song_class(spell)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
	-- Auto use Extra Song Instrument for Buffs if less than max # of songs
	
	if spell.english == 'Refresh' and spell.target.type == 'SELF' then
	  equip(sets.midcast.RefreshRecieved)
	end
    
	
	if num_bard_songs >= 2 and num_bard_songs < info.MaxSongs and spell.name ~= 'Honor March' and generalClass == 'SongEffect' then
		equip({range=info.ExtraSongInstrument})
	end
	-- end -- 
	if spell.name == 'Honor March' then
        equip(sets.midcast.HonorMarch)
	end
	if buffactive.Troubadour and string.find(spell.name,'Lullaby') then
		equip(sets.midcast.LullabyFull)
		equip({range="Marsyas"})
	end
	weathercheck(spell.element)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end
    end
	weathercheck(spell.element)
end

function job_aftercast(spell, action, spellMap, eventArgs)
	aftercast_start = os.clock()
	
	local generalClass = get_song_class(spell)
    if spell.type == 'BardSong' and not spell.interrupted then
        -- if spell.target and spell.target.type == 'SELF' then
		-- if spell.target.type ~= 'SELF' and spell.name ~= "Magic Finale" then   -- (Only using Custom Timers for debuffs; no huge reason for buffs)
		if spell.name ~= "Magic Finale" and (generalClass == "SongDebuff" or generalClass == "ResistantSongDebuff") then   -- (Only using Custom Timers for debuffs; no huge reason for buffs)
            --adjust_timers(spell, spellMap)
			local dur = calculate_duration(spell, spellMap)
			send_command('timers create "'..spell.target.name..':'..spell.name..'" '..dur..' down')
        end
		state.ExtraSongsMode:reset()
    end
	if state.SpellDebug.value == "On" then 
      spelldebug(spell)
	end
    if spell.interrupted then
	  add_to_chat(8,'--------- Casting Interupted: '..spell.name..'---------')
	end 
	equip(sets.Idle.Current)    
	check_run_status()
	if precast_start and state.SpellDebug.value == "On" then 
		add_to_chat(8,"Spell: "..spell.name..string.format(" Casting Time: %.2f", aftercast_start - precast_start))
	end
	precast_start = nil

	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


function status_change(new,tab)
    handle_equipping_gear(player.status)
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.Idle.Current)
    end
end


-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
	if spell.skill == 'Singing' then 
		if set.contains(spell.targets, 'Enemy') then
			if state.CastingMode.value == 'Resistant' then
				return 'ResistantSongDebuff'
			else
				return 'SongDebuff'
			end
		elseif state.ExtraSongsMode.value == 'Dummy' then
			return 'DaurdablaDummy'
		else
			return 'SongEffect'
		end
	else
		return spell.skill
	end
end


function calculate_duration(spell, spellMap)
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
	if player.equipment.range == "Marsyas" then mult = mult + 0.5 end -- 
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
	if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.2 end
	if player.equipment.neck == "Mnbw. Whistle +1 +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
	if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
	if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
	if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
	if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +3" then mult = mult + 0.2 end
	if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +2" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Fili Calot +1" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Fili Manchettes +1' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Fili Rhingrave +1" then mult = mult + 0.1 end
	if spellMap == 'Lullaby' and player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
	if spellMap == 'Lullaby' and player.equipment.hands == 'Brioso Cuffs +2' then mult = mult + 0.1 end
	if spellMap == 'Lullaby' and player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end
    if spell.name == "Sentinel's Scherzo" and player.equipment.feet == "Fili Cothurnes +1" then mult = mult + 0.1 end
	if MaxJobPoints == 1 then
		mult = mult + 0.05
	end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spell.name == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
	
	local generalClass = get_song_class(spell)
	-- add_to_chat(8,'Info: Spell Name'..spell.name..' Spell Map:'..spellMap..' General Class:'..generalClass..' Multiplier:'..mult)
	if spell.name == "Foe Lullaby II" or spell.name == "Horde Lullaby II" then 
		base = 60
	elseif spell.name == "Foe Lullaby" or spell.name == "Horde Lullaby" then 
		base = 30
	elseif spell.name == "Carnage Elegy" then 
		base = 180
	elseif spell.name == "Battlefield Elegy" then
		base = 120
	elseif spell.name == "Pining Nocturne" then
		base = 120
	elseif spell.name == "Maiden's Virelai" then
		base = 20
		
	end
	
	if generalClass == 'SongEffect' then 
		base = 120
		totalDuration = math.floor(mult*base)		
	end
	
	totalDuration = math.floor(mult*base)		
	
	if MaxJobPoints == 1 then 
		if string.find(spell.name,'Lullaby') then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Lullaby Job Points')
			totalDuration = totalDuration + 20
		end
		if buffactive['Clarion Call'] then
			if buffactive.Troubadour then 
				-- Doubles Clarion Call Gain for 80 seconds
				totalDuration = totalDuration + 80
			else
				-- add_to_chat(8,'Adding 20 seconds to Timer for Clarion Call Job Points')
				totalDuration = totalDuration + 40
			end
		end
		if buffactive['Tenuto'] then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Tenuto Job Points')
			totalDuration = totalDuration + 20
		end
		if buffactive['Marcato'] then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Marcato Job Points')
			totalDuration = totalDuration + 20
		end
	end
	
	
	if buffactive.Troubadour then 
		totalDuration = totalDuration + 20  -- Assuming 20 seconds for capped Trobodour and you actually pre-cast with a Bihu Justaucorps.
	end
	add_to_chat(8,'Total Duration:'..totalDuration)
	
    return totalDuration
	
end



-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    	
	disable_specialgear()
	if state.TPMode.value == "WeaponLock" then
	  equip({main=weaponlock_main,sub=weaponlock_sub})
	  disable("main")
	  disable("sub")
	else
	  enable("main")
	  enable("sub")
	end
	
	if state.IdleMode.value == "PDT" then
	   sets.Idle.Current = sets.Idle.PDT
	elseif state.IdleMode.value == "MEVA" then
		sets.Idle.Current = sets.meva
	else
		sets.Idle.Current = sets.Idle.Main
	end
	if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1,18)
end


windower.raw_register_event('logout',reset_timers)
