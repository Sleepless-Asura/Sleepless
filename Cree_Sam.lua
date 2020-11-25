
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job. Generally should not be modified. --
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
--function get_sets()
--fixed_pos = ''
--fixed_ts = os.time()

--end

--windower.raw_register_event('outgoing chunk',function(id,original,modified,injected,blocked)
    --if not blocked then
        --if id == 0x15 then
            --if (gearswap.cued_packet or midaction()) and fixed_pos ~= '' and os.time()-fixed_ts < 10 then
               --return original:sub(1,4)..fixed_pos..original:sub(17)
            --else
               ---fixed_pos = original:sub(5,16)
               --fixed_ts = os.time()
           --end
       --end
    --end
--end)

-- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
---include('Include/AugmentedGear.lua') 
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job. Recommend that these be overridden in a sidecar file. --
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Doji', 'DijiMID', 'DojiACC', 'Masa','MasaMID', 'MasaACC')
    state.HybridMode:options ('Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('Hybrid','PDT')
    state.MagicalDefenseMode:options('MDT')

end
 
-- Elements for skillchain names
    skillchain_elements = {}
    skillchain_elements.Light = S{'Light','Fire','Wind','Lightning'}
    skillchain_elements.Darkness = S{'Dark','Ice','Earth','Water'}
    skillchain_elements.Fusion = S{'Light','Fire'}
    skillchain_elements.Fragmentation = S{'Wind','Lightning'}
    skillchain_elements.Distortion = S{'Ice','Water'}
    skillchain_elements.Gravitation = S{'Dark','Earth'}
    skillchain_elements.Transfixion = S{'Light'}
    skillchain_elements.Compression = S{'Dark'}
    skillchain_elements.Liquification = S{'Fire'}
    skillchain_elements.Induration = S{'Ice'}
    skillchain_elements.Detonation = S{'Wind'}
    skillchain_elements.Scission = S{'Earth'}
    skillchain_elements.Impaction = S{'Lightning'}
    skillchain_elements.Reverberation = S{'Water'}
 
-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------
-- Precast Sets --
    sets.WSDayBonus = {head="Gavialis Helm"}
 
-- add here to the ws list those you want moonshade on when less than 3000tp
    moonshade_WS = S{'Tachi: Fudo', 'Tachi: Shoha', 'Tachi: Ageha', 'Tachi: Kasha', 'Tachi: Jinpu', 'Tachi: Enpi', 'Tachi: Gekko', 'Tachi: Kagero'}
 
	--★ Job Ability ★--
	
    sets.precast.JA['Meditate'] = {head="Wakido Kabuto +3",hands={ name="Sakonji Kote +3", augments={'Enhances "Blade Bash" effect',}},back="Smertrios's Mantle"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Shikikoyo'] = {legs="Sakonji haidate +3"}
	sets.precast.JA['Provoke'] = {}
		--ammo="Paeapua",head="Loess Barbuta +1",body="Emet Harness",hands="Kurys Gloves",neck="Warder's Charm +1",ring2="Petrov Ring",ear1="Dignitary's Earring",ear2="Friomisi Earring",
    
 
    sets.buff.Doom = {waist="Gishdubar sash",neck="Malison Medallion", ring1="Saida Ring",ring2="Saida Ring"}

	--★ Fast Cast ★--
    sets.precast.FC = {
		ammo="Impatiens",	
        hands="Leyline Gloves",		--8
        legs="Arjuna Breeches",		--4
        neck="Voltsurge Torque", 	--4
        ear1="Loquacious Earring",	--2
        ear2="Etiolation Earring",	--1
        --ring1="Weatherspoon Ring",	--5	
		ring2="Lebeche Ring",		
	}
 
    sets.midcast.Utsusemi = set_combine(sets.precast.FC,{
        ammo="Staunch Tathlum",
        neck="Magoraga Beads",
		})

		
	---★ Weaponskill Sets ★---
-- FOR ANY WS NOT DEFINED WILL USE BELOW --
sets.precast.WS ={
	ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'STR+7','DEX+2','Weapon skill damage +7%','Accuracy+18 Attack+18',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +5%','Accuracy+11','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Accuracy+14',}},
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud Earring",
    left_ring="Karieyh Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
         
---	Deals double damage. Damage varies with TP.
-- 	Stat Modifier:	80% STR		★	 fTP:	3.75	5.75	8.0
    sets.precast.WS['Tachi: Fudo'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'STR+7','DEX+2','Weapon skill damage +7%','Accuracy+18 Attack+18',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +5%','Accuracy+11','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Accuracy+14',}},
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud Earring",
    left_ring="Karieyh Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
 
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'], {})
 
--	Delivers a twofold attack. Damage varies with TP.
-- 	Stat Modifier:	73~85% STR	★	fTP:	1.375	2.1875	2.6875
    sets.precast.WS['Tachi: Shoha'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'STR+7','DEX+2','Weapon skill damage +7%','Accuracy+18 Attack+18',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +5%','Accuracy+11','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Accuracy+14',}},
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud Earring",
    left_ring="Karieyh Ring",
    right_ring="Niqmaddu Ring",  --Niqmaddu Ring
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
		
 
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'], {})
 

-- 	Lowers target's defense. Chance of lowering target's defense varies with TP.
-- 	Stat Modifier:	40% STR 60% CHR		★	  fTP:	2.625
    sets.precast.WS['Tachi: Ageha'] = {
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Olseni Belt",
    left_ear="Telos Earring",
    right_ear="Zennaroi Earring",
    left_ring="Flamma Ring",
    right_ring="Cacoethic Ring +1",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
 
    sets.precast.WS['Tachi: Ageha'].Acc = set_combine(sets.precast.WS['Tachi: Ageha'], {})
         	 
--	Description:  Paralyzes target. Damage varies with TP.
--	Stat Modifier:	75% STR		★		fTP:	1.5625	2.6875	4.125
    sets.precast.WS['Tachi: Kasha'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'STR+7','DEX+2','Weapon skill damage +7%','Accuracy+18 Attack+18',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +5%','Accuracy+11','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Accuracy+14',}},
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud Earring",
    left_ring="Karieyh Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS['Tachi: Kasha'], {})

 
-- 	Delivers a two-fold attack that deals wind elemental damage. Damage varies with TP.
-- 	(Hybrid)Stat Modifier:	30% STR		★	fTP:	0.5	0.75	1.0
    sets.precast.WS['Tachi: Jinpu'] = {   
	ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'STR+7','DEX+2','Weapon skill damage +7%','Accuracy+18 Attack+18',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +5%','Accuracy+11','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Accuracy+14',}},
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud Earring",
    left_ring="Karieyh Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
        
	sets.precast.WS['Impulse Drive']	= {
	ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'STR+7','DEX+2','Weapon skill damage +7%','Accuracy+18 Attack+18',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +5%','Accuracy+11','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Accuracy+14',}},
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud Earring",
    left_ring="Karieyh Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
	--★ Idle Sets ★--

    sets.idle = {
	ammo="Staunch Tathlum",
    head="Ken. Jinpachi +1",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
	
	sets.enmity = {}
	sets.idle.Weak = set_combine(sets.PDT, {head="Twilight Helm", body="Twilight Mail",})
	
	sets.resting = set_combine(sets.idle, {
		body="Hizamaru Haramaki +2",
		ear1="Infused Earring",
---		ring1="Sheltered Ring",---		legs="Rao Haidate +1",
---		neck="Bathy Choker +1",
 })
     
	--★ Defense Sets ★--
	
    sets.defense.Hybrid = {
        ammo="Staunch Tathlum", --2
        head="Flamma Zucchetto +2",    
		body="Wakido Domaru +3", 
        hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
        neck="Sam. Nodowa +2",
		waist="Flume Belt +1", --4
		left_ear="Genmei Earring", --2
		right_ear="Dedition Earring",
        ring1="Gelatinous Ring +1", --7
		ring2="Defending Ring", --10
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}		--30pdt
	
  
    sets.defense.PDT = {
    ammo="Staunch Tathlum",
    head="Ken. Jinpachi +1",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
	
    sets.defense.Reraise = set_combine(sets.defense.PDT,{head="Twilight Helm",body="Twilight Mail",})
 
 
 --- PDT-47%  MDT-55%	-	1019 ACC 
    sets.defense.MDT = set_combine(sets.defense.PDT,{
	ammo="Staunch Tathlum",
    head="Ken. Jinpachi +1",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
})					
 
	-- Engaged Sets --

-- STP 58 4 hit/WS
-- DA 24 / TA 10 / QA 3
	sets.engaged.Doji = {
    ammo="Staunch Tathlum",
    head="Flam. Zucchetto +2",
    body="Kasuga Domaru +1",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Dedition Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
    sets.engaged.DojiMID = {
	ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Flam. Gambieras +2",
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Dedition Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
 
--1272 acc 73 stp, 
    sets.engaged.DojiACC = {

    ammo="Aurgelmir Orb",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Mache Earring +1",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
 
-- STP 52 4 hit/WS
-- DA 14 / TA 10 / QA 3
    sets.engaged.Masa = {
	ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Kentarch Belt +1",
    left_ear="Telos Earring",
    right_ear="Dedition Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
	sets.engaged.MasaMID = {
	ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Flam. Gambieras +2",
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Dedition Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

-- STP 42 5 hit/WS
-- DA 14 / TA 10 / QA 3
    sets.engaged.MasaACC = {
	ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Flam. Gambieras +2",
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Mache Earring +1",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
	
 
 function precast(spell,abil)
        --equips favorite weapon if disarmed
        if player.equipment.main == "empty" or player.equipment.sub == "empty" then
                equip({main="Masamune",sub="Utu Grip"})
        end
	end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.midcast['Elemental Magic'], {waist="Hachirin-no-Obi"})
        end
    end
    if S{"Torcleaver","Resolution","Catastrophe","Scourge","Cross Reaper"}:contains(spell.english) and (spell.element==world.day_element or spell.element==world.weather_element) then
        equip({head="Gavialis Helm"}) ---change ws above for job.
    end
    if S{"Drain","Drain II","Drain III", "Aspir", "Aspir II", "Aspir III"}:contains(spell.english) and (spell.element==world.day_element or spell.element==world.weather_element) then
        equip({waist="Hachirin-no-obi"})
    end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if world.time >= 17*60 or world.time < 7*60 then -- Dusk to Dawn time.
            equip({left_ear={ name="Lugra Earring +1", augments={'Path: A',}},})
        end
    end
    if spell.action_type=="Magic" and buffactive.Silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    end
    if spell.type=='WeaponSkill' then
        if moonshade_WS:contains(spell.english) and player.tp<2850 then
            equip({}) ear2="Moonshade Earring"
        end
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff:lower()=='terror' or buff:lower()=='petrification' or buff:lower()=='sleep' or buff:lower()=='stun' then
        if gain then
            equip(sets.defense.PDT)
        elseif not gain then 
            handle_equipping_gear(player.status)
        end
    end
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    if buff:lower()=='sleep' then
        if gain and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
            equip({neck="Berserker's Torque"})
        elseif not gain then -- Take Berserker's off
            handle_equipping_gear(player.status)
        end
    end
        if buff:lower()=='Reive Mark' then
        if gain then 
            equip({neck="Ygnas's Resolve +1"}) disable('neck')
        else 
            enable('neck') 
        end
    end
end
 
ninjaTools = {
        Utsusemi = S{"Shihei",},--"Shikanofuda" 
        Hojo = S{"Kaginawa",},--"Chonofuda"
        Migawari = S{"Mokujin",},
        Kakka = S{"Ryuno",},
        Tonko = S{"Shinobi-tabi",},
        Kurayami = S{"Sairui-Ran",},
        Raiton = S{"Hiraishin",},
        Hyoton = S{"Tsurara",},
        Monomi = S{"Sanjaku",},
    }
  
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type=="Ninjutsu" then check_tools(spell) end
end
function check_tools(spell)
    for prefix,tools in pairs(ninjaTools) do
        if spell.english:startswith(prefix) then
            for tool in tools:it() do
                if not player.inventory[tool] then
                    add_to_chat(100,'WARNING: You are out of '..tool..'.')
                elseif player.inventory[tool].count < 10 then
                    add_to_chat(100,'WARNING: You are low on '..tool..'. '..player.inventory[tool].count..' remaining.')
                end
            end
        end
    end
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Sleep and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
        meleeSet = set_combine(meleeSet,{neck="Berserker's Torque"})
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

function customize_idle_set(idleSet)
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if S{"Eastern Adoulin","Western Adoulin"}:contains(world.area) then
        idleSet = set_combine(idleSet,{body="Councilor's Garb"})
    end
    return idleSet
end
 
-- MACRO
function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end
   set_macros(1,12) 
-- Sheet, Book   <<<<<<<<<<<<<<<<<<<<<<<<<<<< MACRO auto set
end
