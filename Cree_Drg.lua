-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
	get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Stardiver', 'Impulse Drive', 'Geirskogul'}

	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Mid', 'Acc')
	state.HybridMode:options('Normal', 'Jumpy', 'Reraise')
	state.WeaponskillMode:options('Normal', 'Mid', 'Acc', 'Skillchain')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
	state.IdleMode:options('Normal', 'Pet', 'Regen')
	
	state.Polearm = M{['description']='Current Weapon', 'Trishula', 'Gungnir', 'Gozuki Mezuki'}
    
    war_sj = player.sub_job == 'WAR' or false

	select_default_macro_book(1, 14)
    send_command('bind != gs c toggle CapacityMode')
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind @e gs c cycle Polearm')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^[')
	send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
    Acro = {}
	Acro.AMHands = { name="Acro Gauntlets", augments={'Accuracy+9','"Dbl.Atk."+3',}}
	
	Brig = {}
    Brig.STP = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}--name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    Brig.STRDA = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
    Brig.WSD = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}--name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	Brig.CT = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10',}}--name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    Brig.FCMeva = {name = "Brigantia's Mantle", augments={ 'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}
	Brig.Crit = { name="Brigantia's Mantle", augments={'STR+10','Accuracy+20 Attack+20','Crit.hit rate+10',}}
	
	ValorHose = {}
	ValorHose.GSTP = { name="Valor. Hose", augments={'MND+10','INT+9','Quadruple Attack +2','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}--name="Valor. Hose", augments={'Attack+14','"Store TP"+8','Accuracy+6',}}
	ValorHose.GDA = { name="Valor. Hose", augments={'MND+10','INT+9','Quadruple Attack +2','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}--name="Valor. Hose", augments={'Accuracy+12 Attack+12','"Dbl.Atk."+5','DEX+9',}}
	ValorHose.QA = { name="Valor. Hose", augments={'MND+10','INT+9','Quadruple Attack +2','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
	ValorHose.SC = { name="Valor. Hose", augments={'MND+10','INT+9','Quadruple Attack +2','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}--name="Valor. Hose", augments={'Sklchn.dmg.+5%','VIT+5','Accuracy+1','Attack+12',}}
	
	ValorMask = {}
	ValorMask.DEX = { name="Valorous Mask", augments={'STR+7','DEX+2','Weapon skill damage +7%','Accuracy+18 Attack+18',}}--name="Valorous Mask", augments={'Weapon skill damage +1%','DEX+12','Accuracy+13','Attack+2',}}
	ValorMask.SC = {} --name="Valorous Mask", augments={'Attack+16','Sklchn.dmg.+5%','STR+14','Accuracy+6',}} 
	ValorMask.STR = { name="Valorous Mask", augments={'STR+7','DEX+2','Weapon skill damage +7%','Accuracy+18 Attack+18',}}--name="Valorous Mask", augments={'Attack+5','Weapon skill damage +2%','STR+13',}}
	
	ValorMitts = {}
	ValorMitts.SC = {} --name="Valorous Mitts", augments={'Attack+14','Sklchn.dmg.+4%','AGI+8',}}
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Ptero. Fin. G. +3",ear1="Dragoon's earring"}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    --sets.Berserker = {neck="Berserker's Torque"}
    sets.WSDayBonus     = { head="Gavialis Helm" }

    sets.Organizer = {
        --main="Gungnir",
        --sub="Utu Grip",
        --range="Exalted Staff",
        --back="Updraft Mantle",
        --legs="Taeon Gloves",
    }

	sets.precast.JA.Jump = { ammo="Ginsen",
			head="Flam. Zucchetto +2",neck="Anu Torque",ear1="Dedition Earring",ear2="Sherida Earring",
			body="Ptero. Mail +3",hands="Vis. Fng. Gaunt. +3",ring2="Niqmaddu Ring",ring1="Petrov Ring",
			back=Brig.STP,waist="Ioskeha Belt +1",legs="Ptero. Brais +3",feet="Ostro Greaves"
    }

	sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +2" }
	sets.TreasureHunter = {waist="Chaac Belt"}

	sets.precast.JA['High Jump'] = sets.precast.JA.Jump
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
        body="Vishap Mail +3",legs=ValorHose.GSTP
    })
	sets.precast.JA['Spirit Jump'] = sets.precast.JA.Jump
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {head="Vishap Armet +1",ear2="Pratik Earring",hands="Pel. Vambraces",feet="Ptero. Greaves +3"
    }
	sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +3"}
	sets.precast.JA['Deep Breathing'] = {head="Ptero. Armet +3"}
	sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +3"}
	
	-- Healing Breath sets
	sets.HB = {
        head="Ptero. Armet +3",neck="Dgn. Collar +1",ear2="Lancer's Earring",
		body="Acro Surcoat",hands="Despair Fin. Gaunt.",
		back="Updraft Mantle",waist="Glassblower's Belt",legs="Vishap Brais +2",feet="Ptero. Greaves +3"
    }
	sets.Elemental = {
		head="Ptero. armet +3",neck="Dgn. Collar +1",ear1="Enmerkar Earring",ear2="Lancer's Earring",
		body="Acro Surcoat",hands="Despair Fin. Gaunt.",
		back="Updraft Mantle",waist="Glassblower's Belt",legs="Acro Breeches",feet="Acro Leggings"
	}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
        head="Vishap Armet +1",neck="Voltsurge Torque",ear1="Etiolation Earring",
		hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",legs="Limbo Trousers"
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
    }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Vishap Armet +1" })
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	sets.precast.WS = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2", 
        neck="Fotia Gorget",
        ear2="Sherida Earring",
        ear1="Moonshade Earring",
		body="Lustr. Harness +1",
        hands="Ptero. Fin. G. +3",
        ring2="Niqmaddu Ring",
        ring1="Karieyh Ring",--ring2="Regal Ring",
		back=Brig.CT,
        waist="Fotia Belt",
        legs="Vishap Brais +2",
        feet="Sulev. Leggings +2"
    }
	
	sets.precast.WS.Skillchain = {
		head=ValorMask.SC,
		body="Sulevia's Plate. +2",
		ring1="Mujin Band",
		feet="Emicho Gambieras",
		}
		
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        back=Brig.STRDA,
    })
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		body="Valorous Mail",
		hands="Sulev. Gauntlets +2",
		feet="Flam. Gambieras +2",
		back=Brig.STRDA})
	
	sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {
		head="Ptero. Armet +3",
		feet="Ptero. Greaves +3",
		})
	
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'].Mid, {
		body="Ptero. Mail +3",
		})
	
	sets.precast.WS['Stardiver'].Skillchain = set_combine(sets.precast.WS['Stardiver'],
		sets.precast.WS.Skillchain
	)
	
    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
        --head="Lustratio Cap +1",
		ring2="Karieyh Ring",
		ear1="Thrud Earring",
		ear2="Ishvara Earring",
		back=Brig.CT
    })
	
	sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {
        neck="Shulmanu Collar",
	})
	
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {
	waist="Ioskeha Belt +1"
	})
	
	sets.precast.WS["Camlann's Torment"].Skillchain = set_combine(sets.precast.WS["Camlann's Torment"],
		sets.precast.WS.Skillchain
	)
	
	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
		body="Ptero. Mail +3",
		neck="Dgn. Collar +1",
		hands="Flam. Manopolas +2",
		legs="Vishap Brais +2", --legs="Peltast's Cuissots",
		feet="Valorous greaves",
		ring1="Begrudging Ring",
		ring2="Niqmaddu Ring",
		waist="Ioskeha Belt +1",
		back=Brig.Crit,
    })
	
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {
        neck="Shulmanu Collar",
    })
	
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {legs="Vishap Brais +3"})
	
	sets.precast.WS['Drakesbane'].Skillchain = set_combine(sets.precast.WS['Drakesbane'],
		sets.precast.WS.Skillchain
	)
	
    sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {
        head="Lustratio Cap +1",
    })
	sets.precast.WS['Sonic Thrust'].Mid = set_combine(sets.precast.WS['Sonic Thrust'], {
        neck="Shulmanu Collar",ear2="Digni. Earring"
    })
	sets.precast.WS['Sonic Thrust'].Acc = set_combine(sets.precast.WS['Sonic Thrust'].Mid, {waist="Ioskeha Belt +1"})
	
	sets.precast.WS['Sonic Thrust'].Skillchain = set_combine(sets.precast.WS['Sonic Thrust'],
		sets.precast.WS.Skillchain
	)
	
	sets.precast.WS['Geirskogul'] = set_combine(sets.precast.WS, {
        head=ValorMask.DEX,body="Ptero. Mail +3",ear1="Mache Earring +1",
		back=Brig.WSD
    })
	sets.precast.WS['Geirskogul'].Mid = set_combine(sets.precast.WS['Geirskogul'], {
        neck="Shulmanu Collar",
    })
	sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS['Geirskogul'].Mid, {waist="Ioskeha Belt +1"})
	
	sets.precast.WS['Geirskogul'].Skillchain = set_combine(sets.precast.WS['Geirskogul'],
		sets.precast.WS.Skillchain
	)
	
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
		head="Lustratio Cap +1",legs=ValorHose.QA,neck="Dgn. Collar +1",
		waist="Grunfeld Rope",back=Brig.CT
	})
	
	sets.precast.WS['Impulse Drive'].Mid = set_combine(sets.precast.WS['Impulse Drive'], {})
	sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'].Mid, {})
	sets.precast.WS['Impulse Drive'].Skillchain = set_combine(sets.precast.WS['Impulse Drive'], 
		sets.precast.WS.Skillchain
	)
	
	sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {ammo="Pemphredo Tathlum",
		head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2 ="Dignitary's Earring",
		body="Flamma Korazin +2",hands="Flamma Manopolas +2",ring1="Stikini Ring",ring2="Stikini Ring",
		back=Brig.STP,waist="Eschan stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"})
	sets.precast.WS['Leg Sweep'].Mid = set_combine(sets.precast.WS['Leg Sweep'], {})
	sets.precast.WS['Leg Sweep'].Acc = set_combine(sets.precast.WS['Leg Sweep'].Mid, {})
	sets.precast.WS['Leg Sweep'].Skillchain = set_combine(sets.precast.WS['Leg Sweep'], {})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
        head="Twilight Helm",
        neck="Twilight Torque",
        ear1="Cessance Earring",
        ear2="Tripudio Earring",
		body="Twilight Mail",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
        back="Impassive Mantle",
        legs="Carmine Cuisses +1",
        feet="Flamma Gambieras +1"
    }
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.idle.Normal = {
		ammo="Staunch Tathlum",
        head="Peltast's Mezail +1",
		neck="Twilight Torque",
		ear1="Odnowa Earring",
		ear2="Odnowa Earring +1",
		body="Ptero. Mail +3",
		hands="Sulev. Gauntlets +2",
		ring1="Defending Ring",
		ring2="Karieyh Ring",
		back=Brig.STP,
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Sulev. Leggings +2"
    }

    sets.idle.Regen = set_combine(sets.idle.Normal, {
        head="Valorous Mask",
		ear1="Infused Earring",
		body="Kumarbi's Akar",
        neck="Lissome Necklace",
    })
	
	sets.idle.Pet = set_combine(sets.idle.Normal, {
		neck="Dgn. Collar +1",
		ear1="Lancer's Earring",
		body="Emicho Haubert",
		hands="Despair Fin. Gaunt.",
		back="Updraft Mantle",
		legs="Vishap Brais +2",
		feet="Ptero. Greaves +3",
		left_ring="Dreki Ring",
	})

	sets.idle.Weak = set_combine(sets.idle.Normal, {
		head="Gavialis Helm",body="Arke Corazza",ring2="Moonbeam Ring",
		waist="Glassblower's Belt",legs="Flamma Dirs +2",feet="Amm Greaves", back="Moonbeam Cape"
    })
	
	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Peltast's Mezail +1",neck="Twilight Torque",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Arke Corazza",hands="Sulev. Gauntlets +2",ring2="Niqmaddu Ring",ring1="Defending Ring",
		back=Brig.STP,waist="Ioskeha Belt +1",legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2",
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.defense.MDT = {ammo="Staunch Tathlum",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		neck="Dgn. Collar +1",ear1="Hearty Earring",ear2="Sherida Earring",
		body="Tartarus Platemail",hands="Flam. Manopolas +2",ring2="Niqmaddu Ring",ring1="Purity Ring",
		back=Brig.STP,waist="Asklepian Belt",legs="Ptero. Brais +3",feet="Flam. Gambieras +2",
	}

	sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
    ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Sulev. Gauntlets +2",
    legs={ name="Valor. Hose", augments={'MND+10','INT+9','Quadruple Attack +2','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
    feet="Flam. Gambieras +2",
    neck={ name="Dgn. Collar +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    right_ear="Telos Earring",
    left_ear="Dedition Earring",
    left_ring="Flamma Ring", --left_ring="Dreki Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
}

	sets.engaged.Mid = set_combine(sets.engaged, {
		ear1="Telos Earring",
        ring2="Flamma Ring",
		legs="Sulev. Cuisses +2"
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        body="Vishap Mail +3",hands="Vis. Fng. Gaunt. +3",legs="Vishap Brais +2"
    })

    sets.engaged.PDT = set_combine(sets.engaged, {ammo="Staunch Tathlum",
		head="Peltast's Mezail +1",neck="Twilight Torque",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Arke Corazza",hands="Sulev. Gauntlets +2",ring2="Niqmaddu Ring",ring1="Defending Ring",
		back=Brig.STP,waist="Ioskeha Belt",legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2",
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {})

    sets.engaged.War = set_combine(sets.engaged, {})
    sets.engaged.War.Mid = set_combine(sets.engaged.Mid, {})
	
	sets.engaged.Reraise = set_combine(sets.engaged, {
		--head="Twilight Helm",
		--body="Twilight Mail"
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise
	
		sets.engaged.Jumpy = {
		ammo="Aurgelmir Orb", --ammo="Ginsen",
		head="Ptero. Armet +3",
		body="Emicho Haubert",
		hands="Despair Fin. Gaunt.",
		legs="Vishap Brais +3",
		feet="Ptero. Greaves +3",
		neck="Shulmanu Collar",
		waist="Ioskeha Belt +1",
		left_ear="Lancer's Earring",
		right_ear="Sherida Earring",
		right_ring="Niqmaddu Ring",
		left_ring="Dreki Ring",
		back="Updraft Mantle"
		}
	
	sets.engaged.Aftermath = { 
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",
		body="Flama Korazin +2", --body="Pelt. Plackart +1",
		neck="Dragoon's Collar +1", --neck="Anu Torque",
		ear2="Dedition Earring",
		ear1="Sherida Earring",
		ring1="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Brig.STP,
		waist="Ioskeha Belt +1",
		legs=ValorHose.QA,
		feet="Flam. Gambieras +2",
	}
	

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if player.hpp < 51 then
		classes.CustomClass = "Breath" 
	end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        elseif is_sc_element_today(spell) then
			if wsList: contains(spell.english) then
				equip(sets.WSDayBonus)
			end
		end
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
		    classes.CustomClass = "Breath" 
	    end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Smiting Breath' then
		equip(sets.HB)
	else
		equip(sets.Elemental)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Polearm.current == 'Trishula' then
        equip({main="Trishula"})
    elseif state.Polearm.current == 'Gungnir' then
        equip({main="Gungnir"})
	elseif state.Polearm.current == 'Gozuki Mezuki' then
		equip({main="Gozuki Mezuki"})
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
	if buffactive['Aftermath'] and player.equipment.main == "Gungnir"
		and state.HybridMode.value == 'None' then
			meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
	end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function job_update(cmdParams, eventArgs)
    war_sj = player.sub_job == 'WAR' or false
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
function self_command(command)

end
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	state.CombatForm:set('Adoulin')
	--end

    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if category == 2 or -- any ranged attack
		--category == 4 or -- any magic action
		(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
	end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(8, 1)
    elseif player.sub_job == 'WHM' then
    	set_macro_page(8, 2)
    else
    	set_macro_page(1, 1)
    end
end

function is_sc_element_today(spell)
    if spell.type ~= 'WeaponSkill' then
        return
    end
 
    local weaponskill_elements = S{}:
        union(skillchain_elements[spell.skillchain_a]):
        union(skillchain_elements[spell.skillchain_b]):
        union(skillchain_elements[spell.skillchain_c])
 
    if weaponskill_elements:contains(world.day_element) then
        return true
    else
        return false
    end
end