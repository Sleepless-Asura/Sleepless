--[[ 
     Custom commands: 
  
     gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes. 
      
     Treasure hunter modes: 
         None - Will never equip TH gear 
         Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE) 
         SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA 
         Fulltime - Will keep TH gear equipped fulltime 
  
 --]] 
 
 
 -- Initialization function for this job file. 
 function get_sets() 
     mote_include_version = 2 
      
     -- Load and initialize the include file. 
     include('Mote-Include.lua') 
 end 

 
 -- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked. 
 function job_setup() 
     state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false 
     state.Buff['Trick Attack'] = buffactive['trick attack'] or false 
     state.Buff['Feint'] = buffactive['feint'] or false 
      
     include('Mote-TreasureHunter') 
 
 
     -- For th_action_check(): 
     -- JA IDs for actions that always have TH: Provoke, Animated Flourish 
     info.default_ja_ids = S{35, 204} 
     -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish 
     info.default_u_ja_ids = S{201, 202, 203, 205, 207} 
 end 
 
 
 ------------------------------------------------------------------------------------------------------------------- 
 -- User setup functions for this job.  Recommend that these be overridden in a sidecar file. 
 ------------------------------------------------------------------------------------------------------------------- 
 
 
 -- Setup vars that are user-dependent.  Can override this function in a sidecar file. 
 function user_setup() 
     state.OffenseMode:options('Normal', 'Acc', 'Mod') 
     state.HybridMode:options('Normal', 'Evasion', 'PDT') 
     state.RangedMode:options('Normal', 'Acc') 
     state.WeaponskillMode:options('Normal', 'Acc', 'Mod', 'Mod2') 
     state.PhysicalDefenseMode:options('Evasion', 'PDT') 
 
 
 
 
     gear.default.weaponskill_neck = "Lissome Necklace" 
     gear.default.weaponskill_waist = "Caudata Belt" 
     gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}} 
 
 
     -- Additional local binds 
     send_command('bind ^` input /ja "Flee" <me>') 
     send_command('bind ^= gs c cycle treasuremode') 
     send_command('bind !- gs c cycle targetmode') 
 
 
     select_default_macro_book() 
 end 
 
 
 -- Called when this job file is unloaded (eg: job change) 
 function user_unload() 
     send_command('unbind ^`') 
     send_command('unbind !-') 
 end 
 
 
 -- Define sets and vars used by this job file. 
 function init_gear_sets() 
     -------------------------------------- 
     -- Special sets (required by rules) 
     -------------------------------------- 
 
 
     sets.TreasureHunter = {--head="volte cap",legs={ name="Herculean Trousers", augments={'Attack+22','Weapon skill damage +1%','"Treasure Hunter"+2','Accuracy+17 Attack+17','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},  
	 hands="Plunderer's Armlets +1", waist="Chaac Belt", feet="Skulker's Poulaines +1", body="Mummu Jacket +2", ring2="Mummu Ring",back="Toutatis's cape"} 
     sets.ExtraRegen = {head="Ocelomeh Headpiece +1"} 
     sets.Kiting = {feet="Turms Leggings +1"} 
 
 
    sets.buff['Sneak Attack'] = {
   main={ name="Aeneas", augments={'Path: A',}},
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Yetshila",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Abnoba Kaftan",
    hands="Skulk. Armlets +1",
    legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Caro Necklace",
    waist="Grunfeld Rope",
    left_ear="Mache Earring +1",
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
 
 
    sets.buff['Trick Attack'] = {
    ammo="Yetshila",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Abnoba Kaftan",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck="Combatant's Torque",
    waist="Grunfeld Rope",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Apate Ring",
    right_ring="Ilabrat Ring",
	left_ring="Gere Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
 
 
     -- Actions we want to use to tag TH. 
     sets.precast.Step = sets.TreasureHunter 
     sets.precast.Flourish1 = sets.TreasureHunter 
     sets.precast.JA.Provoke = sets.TreasureHunter 
 
 

 
     -------------------------------------- 
     -- Precast sets 
     -------------------------------------- 
 
 
     -- Precast sets to enhance JAs 
     sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"} 
     sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"} 
     sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"} 
     sets.precast.JA['Hide'] = {} 
     sets.precast.JA['Conspirator'] = {body="Skulker's Vest +1"} 
     sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"} 
     sets.precast.JA['Despoil'] = {legs="Skulker's Culottes +1",feet="Skulker's Poulaines +1"} 
     sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"} 
     sets.precast.JA['Feint'] = {legs="Plun. Culottes +1"} 
 
 
     sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack'] 
     sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack'] 
 
 
 
 
     -- Waltz set (chr and vit) 
     sets.precast.Waltz = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Sanctity Necklace",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Ashera Harness",hands="Buremte Gloves",ring1="Moonbeam Ring",ring2="Defending Ring",
        back="Moonbeam Cape",waist="Gishdubar Sash",legs="Dashing Subligar",feet="Rawhide Boots"} 
 
 
     -- Don't need any special gear for Healing Waltz. 
     sets.precast.Waltz['Healing Waltz'] = {ammo="Yamarang",ear1="Odnowa Earring +1",ear2="Odnowa Earring",ring1="Moonbeam Ring",ring2="Asklepian Ring",back="Moonbeam Cape",legs="Dashing Subligar"} 
 
     -- Fast cast sets for spells 
     sets.precast.FC = {
    ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','INT+6','Mag. Acc.+12','"Mag.Atk.Bns."+11',}},
    body="Passion Jacket",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Magoraga Beads",
    waist="Gishdubar Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Rahab Ring",
    right_ring="Prolix Ring",
    back={ name="Toutatis's Cape", augments={'"Fast Cast"+10',}},
}
 
     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket",neck="Magoraga Beads"}) 
 
 
 
 
     -- Ranged snapshot gear 
     sets.precast.RA = {hands="Mrigavyadha Gloves",waits="Yemeya Belt",feet="Meghanada Jambeaux +2"} 
 
 
 
 
     -- Weaponskill sets 
 
 
     -- Default set for any weaponskill that isn't any more specifically defined 
     sets.precast.WS = {
	 head="Adhemar Bonnet +1",
	 neck="Fotia Gorget",
	 ear1="Moonshade Earring",
	 ear2="Sherida Earring",
	 body="Adhemar Jacket +1",
	 hands="Adhemar Wristbands +1",
	 right_ring="Ilabrat Ring",
	 ring1="Apate Ring",
	 back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	 waist="Grunfeld Rope",
	 legs="Lustratio Subligar +1",
	 feet="Lustratio Leggings +1"} 
     sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Yamarang"}) 
 
 
     -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found. 
     sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {right_ring="Ilabrat Ring"}) 
     sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yamarang"}) 
     sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila"}) 
     sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila"}) 
     sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila"}) 
     sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila"}) 
 
 
     sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {}) 
     sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Yamarang"}) 
     sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila",body="Meghanada Cuirie +2"}) 
     sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila", body="Meghanada Cuirie +2"}) 
     sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila", body="Meghanada Cuirie +2"}) 
     sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila", body="Meghanada Cuirie +2"})
 
 
     sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila",body="Abnoba Kaftan",back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}})
     sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Yamarang"}) 
     sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila"}) 
     sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila"}) 
     sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila"}) 
     sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",ammo="Yetshila"}) 
 
 
     sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
    ammo="Yetshila",
    head="Mummu Bonnet +2",
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands="Meg. Gloves +2",
    legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Caro Necklace",
    waist="Grunfeld Rope",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
	left_ring="Gere Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%'}},}) 
     sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yamarang"}) 
     sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {waist=gear.ElementalBelt}) 
     sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Yetshila"}) 
     sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Yetshila"}) 
     sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Yetshila"}) 
 
 
     sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"}) 
     sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Yamarang"}) 
     sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {waist=gear.ElementalBelt}) 
     sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",body="Meghanada Cuirie +2"}) 
     sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",body="Meghanada Cuirie +2"}) 
     sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",body="Meghanada Cuirie +2"}) 
 
 
     sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {}) 
     sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {}) 
     sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {waist="Fotia Belt",neck="Fotia Gorget"}) 
     sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",}) 
     sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",}) 
     sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {waist="Fotia Belt",neck="Fotia Gorget",}) 
 
 
     sets.precast.WS['Aeolian Edge'] = {
	 ammo="Pemphrendo Tathlum",
	 head={ name="Herculean Helm",augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19', '"Mag.Atk.Bns."+7', 'Fast Cast +1%', '"Cure" spellcasting time -5%',}},neck="Sanctity Necklace",
	 ear1="Friomisi Earring",
	 ear2="Hecate's earring",
	 body="Samnuha Coat",
	 hands="Leyline Gloves",
	 back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	 waist="Eschan Stone",
	 legs={name="Herculean Trousers",augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Mag.Atk.Bns."+2','Crit. hit damage +4%','Crit.hit rate+2',}},
	 feet={name="Herculean Boots",augments={ 'Attack+6','"Refresh"+2', '"Magic burst dmg."+6%','Mag. Acc.+19 "Mag.Atk.Bns."+19' }}
	 } 
 
 
     sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter) 

     -------------------------------------- 
     -- Midcast sets 
     -------------------------------------- 
 
 
     sets.midcast.FastRecast = { 
         head="Whirlpool Mask",ear2="Loquacious Earring", 
         body="Meghanada Cuirie +2",hands="Pillager's Armlets +1", 
         back="Canny Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"} 
 
 
     -- Specific spells 
     sets.midcast.Utsusemi = { 
         } 
 
     -- Ranged gear 
     sets.midcast.RA = {     
		head="Meghanada Visor +2",
		body="Mummu Jacket +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Meghanada Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
		} 
 
 
     sets.midcast.RA.Acc = { 
        head="Meghanada Visor +2",
		body="Mummu Jacket +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Meghanada Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
		}  
 
     -------------------------------------- 
     -- Idle/resting/defense sets 
     -------------------------------------- 

     -- Resting sets 
     sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget", 
         ring1="Defending Ring",ring2="Paguroidea Ring"} 
 
 
     -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes) 
 
     sets.idle = {} 
 
 
     sets.idle.Town = {
	main="Aeneas",
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Staunch Tathlum +1",
    head="Turms Cap +1",
    body="Malignance Tabard",
    hands="Turms Mittens +1",
    legs="Malignance Tights",
    feet="Turms Leggings +1",
    neck="Sanctity Necklace",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
 
 
     sets.idle.Weak = {
	main="Aeneas",
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Staunch Tathlum +1",
    head="Turms Cap +1",
    body="Malignance Tabard",
    hands="Turms Mittens +1",
    legs="Malignance Tights",
    feet="Turms Leggings +1",
    neck="Sanctity Necklace",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
} 

		 -- Defense sets 
 
     sets.defense.Evasion = {
	main={ name="Aeneas", augments={'Path: A',}},
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Kasiri Belt",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
 
 
     sets.defense.PDT = {
	main={ name="Aeneas", augments={'Path: A',}},
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Kasiri Belt",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
 
 
     sets.defense.MDT = {
	main={ name="Aeneas", augments={'Path: A',}},
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Kasiri Belt",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
 
     -------------------------------------- 
     -- Melee sets 
     -------------------------------------- 
 
 
     -- Normal melee group 
    sets.engaged = {
	main="Aeneas",
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Yetshila",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Samnuha Tights",
    feet="Mummu Gamash. +2",
    neck="Sanctity Necklace",
    waist="Reiki Yotai",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    right_ring="Ilabrat Ring",
	left_ring="Gere Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
}
    
    sets.engaged.Acc = {
	main={ name="Aeneas", augments={'Path: A',}},
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Yetshila",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck="Anu Torque",
    waist="Reiki Yotai",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Hetairoi Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
}
    
    

          
     -- Mod set for trivial mobs (Skadi+1) 
    sets.engaged.Mod = {
	main="Aeneas",
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Mummu Gamash. +2",
    neck="Sanctity Necklace",
    waist="Reiki Yotai",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    right_ring="Ilabrat Ring",
	left_ring="Gere Ring",
    back="Moonbeam Cape",
 }
 
     -- Mod set for trivial mobs (Thaumas) 
    sets.engaged.Mod2 = {
	ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Kasiri Belt",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
 
    sets.engaged.Evasion = {
    ammo="Yamarang",
    head="Turms Cap +1",
    body="Meg. Cuirie +2",
    hands="Turms Mittens +1",
    legs="Meg. Chausses +2",
    feet="Turms Leggings +1",
    neck="Anu Torque",
    waist="Kasiri Belt",
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
		 
     sets.engaged.Acc.Evasion = {
	main="Aeneas",
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Yamarang",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Reiki Yotai",
    left_ear="Telos Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
}
 
 
     sets.engaged.PDT = {
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Kasiri Belt",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
		 
     sets.engaged.Acc.PDT = {
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Kasiri Belt",
    left_ear="Telos Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}

 end 
 ------------------------------------------------------------------------------------------------------------------- 
 -- Job-specific hooks for standard casting events. 
 ------------------------------------------------------------------------------------------------------------------- 
 
 -- Run after the general precast() is done. 
 function job_post_precast(spell, action, spellMap, eventArgs) 
     if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then 
         equip(sets.TreasureHunter) 
     elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then 
         if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then 
             equip(sets.TreasureHunter) 
         end 
     end 
 end 
 
 
 -- Run after the general midcast() set is constructed. 
 function job_post_midcast(spell, action, spellMap, eventArgs) 
     if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then 
         equip(sets.TreasureHunter) 
     end 
 end 
 
 
 -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done. 
 function job_aftercast(spell, action, spellMap, eventArgs) 
     -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted. 
     if spell.type == 'WeaponSkill' and not spell.interrupted then 
         state.Buff['Sneak Attack'] = false 
         state.Buff['Trick Attack'] = false 
         state.Buff['Feint'] = false 
     end 
 end 
 
 
 -- Called after the default aftercast handling is complete. 
 function job_post_aftercast(spell, action, spellMap, eventArgs) 
     -- If Feint is active, put that gear set on on top of regular gear. 
     -- This includes overlaying SATA gear. 
     check_buff('Feint', eventArgs) 
 end 
 
 
 ------------------------------------------------------------------------------------------------------------------- 
 -- Job-specific hooks for non-casting events. 
 ------------------------------------------------------------------------------------------------------------------- 
 
 
 -- Called when a player gains or loses a buff. 
 -- buff == buff gained or lost 
 -- gain == true if the buff was gained, false if it was lost. 
 function job_buff_change(buff, gain) 
     if state.Buff[buff] ~= nil then 
         if not midaction() then 
             handle_equipping_gear(player.status) 
         end 
     end 
 end 

 ------------------------------------------------------------------------------------------------------------------- 
 -- User code that supplements standard library decisions. 
 ------------------------------------------------------------------------------------------------------------------- 
 
 function get_custom_wsmode(spell, spellMap, defaut_wsmode) 
     local wsmode 
 
     if state.Buff['Sneak Attack'] then 
         wsmode = 'SA' 
     end 
     if state.Buff['Trick Attack'] then 
         wsmode = (wsmode or '') .. 'TA' 
     end 
 
     return wsmode 
 end 
 
 -- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear). 
 function job_handle_equipping_gear(playerStatus, eventArgs) 
     -- Check that ranged slot is locked, if necessary 
     check_range_lock() 
 
     -- Check for SATA when equipping gear.  If either is active, equip 
     -- that gear specifically, and block equipping default gear. 
     check_buff('Sneak Attack', eventArgs) 
     check_buff('Trick Attack', eventArgs) 
 end 
 
 function customize_idle_set(idleSet) 
     if player.hpp < 80 then 
         idleSet = set_combine(idleSet, sets.ExtraRegen) 
     end 
 
     return idleSet 
 end 
 
 function customize_melee_set(meleeSet) 
     if state.TreasureMode.value == 'Fulltime' then 
         meleeSet = set_combine(meleeSet, sets.TreasureHunter) 
     end 
 
     return meleeSet 
 end 
 
 -- Called by the 'update' self-command. 
 function job_update(cmdParams, eventArgs) 
     th_update(cmdParams, eventArgs) 
 end 
 
 -- Function to display the current relevant user state when doing an update. 
 -- Return true if display was handled, and you don't want the default info shown. 
 function display_current_job_state(eventArgs) 
     local msg = 'Melee' 
      
     if state.CombatForm.has_value then 
         msg = msg .. ' (' .. state.CombatForm.value .. ')' 
     end 
      
     msg = msg .. ': ' 
      
     msg = msg .. state.OffenseMode.value 
     if state.HybridMode.value ~= 'Normal' then 
         msg = msg .. '/' .. state.HybridMode.value 
     end 
     msg = msg .. ', WS: ' .. state.WeaponskillMode.value 
      
     if state.DefenseMode.value ~= 'None' then 
         msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')' 
     end 
      
     if state.Kiting.value == true then 
         msg = msg .. ', Kiting' 
     end 
 
 
     if state.PCTargetMode.value ~= 'default' then 
         msg = msg .. ', Target PC: '..state.PCTargetMode.value 
     end 
 
 
     if state.SelectNPCTargets.value == true then 
         msg = msg .. ', Target NPCs' 
     end 
      
     msg = msg .. ', TH: ' .. state.TreasureMode.value 
 
 
     add_to_chat(122, msg) 
 
 
     eventArgs.handled = true 
 end 
 
 function job_buff_change(buff, gain)

    if buff:lower()=='sleep' then
        if gain and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
            equip({head="Frenzy Sallet"})
        elseif not gain then -- Take Berserker's off
            handle_equipping_gear(player.status)
        end
    end
        if buff:lower()=='Reive Mark' then
        if gain then 
            equip({neck="Adoulin's Refuge +1"}) disable('neck')
        else 
            enable('neck') 
        end
    end
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
 
 -- Function to lock the ranged slot if we have a ranged weapon equipped. 
 function check_range_lock() 
     if player.equipment.range ~= 'empty' then 
         disable('range', 'ammo') 
     else 
         enable('range', 'ammo') 
     end 
 end 
 
 -- Select default macro book on initial load or subjob change. 
 function select_default_macro_book() 
     -- Default macro set/book 
     if player.sub_job == 'DNC' then 
         set_macro_page(4, 1) 
     elseif player.sub_job == 'WAR' then 
         set_macro_page(1, 1) 
     elseif player.sub_job == 'NIN' then 
         set_macro_page(1, 1) 
     elseif player.sub_job == 'RUN' then 
         set_macro_page(2, 1) 
	 else 
         set_macro_page(1, 1) 
     end 
 end 
