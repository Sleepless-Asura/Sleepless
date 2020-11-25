--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Magic Burst Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Full Circle
--              [ CTRL+B ]          Blaze of Glory
--              [ CTRL+A ]          Ecliptic Attrition
--              [ CTRL+D ]          Dematerialize
--              [ CTRL+L ]          Life Cycle
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

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

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    
    -- Additional local binds
    --include('Global-Binds.lua')

    send_command('bind ^` input /ma "Stun" <t>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind ^insert gs c cycleback Element')
    send_command('bind ^delete gs c cycle Element')
    send_command('bind !w input /ma "Aspir III" <t>')
    send_command('bind ^, input /ma Sneak <stpc>')
    send_command('bind ^. input /ma Invisible <stpc>')
    send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^numpad7 input /ws "Black Halo" <t>')
    send_command('bind ^numpad8 input /ws "Hexa Strike" <t>')
    send_command('bind ^numpad9 input /ws "Realmrazer" <t>')
    send_command('bind ^numpad6 input /ws "Exudation" <t>')
    send_command('bind ^numpad1 input /ws "Flash Nova" <t>')

    send_command('bind #- input /follow <t>')


    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
	main="Xoanon",
    sub="Enki Strap",
    ammo="Impatiens",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+4',}},
    body="Shango Robe",
    hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+4','INT+13','Mag. Acc.+14',}},
    legs="Lengo Pants",
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+7','INT+1','Mag. Acc.+15',}},
    neck="Orunmila's Torque",
    waist="Witful Belt",
    left_ear="Loquac. Earring",
    right_ear="Malignance Earring",
    left_ring="Kishar Ring",
    right_ring="Lebeche Ring",
    back="Perimede Cape",
}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
    ear1="Loquacious Earring",body="Shango Robe",ring1="Prolix Ring",
       }

    sets.midcast.Cure = {}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        }
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {body="Spaekona's Coat +3"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {neck="Erra Pendant",waist="Fucho-no-Obi",feet={ name="Merlinic Crackows", augments={'Accuracy+23','"Drain" and "Aspir" potency +7','Mag. Acc.+10','"Mag.Atk.Bns."+13',}},head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Drain" and "Aspir" potency +8','INT+9','"Mag.Atk.Bns."+12',}},}

    sets.midcast.Drain = {neck="Erra Pendant",waist="Fucho-no-Obi",feet={ name="Merlinic Crackows", augments={'Accuracy+23','"Drain" and "Aspir" potency +7','Mag. Acc.+10','"Mag.Atk.Bns."+13',}},head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Drain" and "Aspir" potency +8','INT+9','"Mag.Atk.Bns."+12',}},}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {neck="Erra Pendant"}

    sets.midcast.BardSong = {}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
	main="Xoanon",
    sub="Khonsu",
    ammo="Pemphredo Tathlum",
    head="C. Palug Crown",
    body="Spaekona's Coat +3",
    hands="Spae. Gloves +2",
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Jhakri Ring",
    right_ring="Freke Ring",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
}

    sets.midcast['Elemental Magic'].Resistant = {
	main="Xoanon",
    sub="Khonsu",
    ammo="Pemphredo Tathlum",
    head="C. Palug Crown",
    body="Spaekona's Coat +3",
    hands="Spae. Gloves +2",
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Jhakri Ring",
    right_ring="Freke Ring",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
}
	sets.midcast['MagicBurst'] = {
	main="Xoanon",
    sub="Khonsu",
    ammo="Pemphredo Tathlum",
    head="Ea Hat",
    body="Spaekona's Coat +3",
    hands="Spae. Gloves +2",
    legs="Ea Slops",
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Mizu. Kubikazari",
    waist="Skrymir Cord",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Locus Ring",
    right_ring="Mujin Band",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
}
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Khonsu"})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Khonsu"})


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {}


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Contemplator"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {
	ammo="Staunch Tathlum +1",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Spae. Gloves +2",
    legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    feet="Coalrake Sabots",
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Infused Earring",
    right_ear="Regal Earring",
    left_ring={ name="Dark Ring", augments={'Magic dmg. taken -5%','Phys. dmg. taken -4%',}},
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {
    ammo="Staunch Tathlum +1",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Lengo pants",
    feet="Coalrake Sabots",
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Infused Earring",
    right_ear="Regal Earring",
    left_ring="Kishar Ring",
    right_ring="Persis Ring",
    back="Solemnity Cape",
}
    
    -- Town gear.
    sets.idle.Town = {
	main="Contemplator",
    sub="Enki Strap",
    ammo="Staunch Tathlum +1",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Lengo pants",
    feet="Coalrake Sabots",
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Infused Earring",
    right_ear="Regal Earring",
    left_ring="Kishar Ring",
    right_ring="Persis Ring",
    back="Solemnity Cape",
}
        
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {
    ammo="Staunch Tathlum +1",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Lengo pants",
    feet="Coalrake Sabots",
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Infused Earring",
    right_ear="Regal Earring",
    left_ring="Kishar Ring",
    right_ring="Persis Ring",
    back="Solemnity Cape",
}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.magic_burst = {neck="Mizukage-no-Kubikazari",left_ring="Locus Ring",
    right_ring="Mujin Band",}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Eschan stone"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 20)
	end