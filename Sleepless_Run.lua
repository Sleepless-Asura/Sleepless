
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
    send_command('@input ;wait 25;input /lockstyleset '..sheet)
	add_to_chat (21, 'Your Lockstyle Looks like awesome, you are a bad man')
	add_to_chat (55, 'You are on '..('RUN '):color(6)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
--	add_to_chat (60, 'https://www.bg-wiki.com/bg/Out_of_the_BLU')
end

set_macros(1,4)
---Name the Lockstyle below after the default set number-- 
set_style(1) 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')1
end

function get_sets()
                --Idle Sets--
                sets.Idle = {               
				main={ name="Epeolatry", augments={'Path: A',}},
				ammo="Yamarang",
				head="Turms Cap +1",
				body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
				hands="Turms Mittens +1",
				legs="Eri. Leg Guards +1",
				feet="Turms Leggings +1",
				neck="Futhark Torque +2",
				waist="Gishdubar Sash",
				left_ear="Infused Earring",
				right_ear="Odnowa Earring +1",
				left_ring="Moonbeam Ring",
				right_ring="Defending Ring",
				back="Moonbeam Cape",
}
                                    
                --TP Sets--
                sets.TP = {}
                sets.TP.index = {'Standard', 'Accuracy', 'DT', 'MDTacc'}
                TP_ind = 1
                --offensive melee set
                sets.TP.Standard = {        
				sub="Utu Grip",
				ammo="Yamarang",
				head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
				body={ name="Herculean Vest", augments={'"Triple Atk."+3','DEX+7','Accuracy+7','Attack+13',}},
				hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
				legs="Meg. Chausses +2",
				feet="Turms Leggings +1",
				neck={ name="Futhark Torque +2", augments={'Path: A',}},
				waist="Kentarch Belt +1",
				left_ear="Telos Earring",
				right_ear="Sherida Earring",
				left_ring="Chirich Ring +1",
				right_ring="Niqmaddu Ring",
				back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
			}
										
                --high accuracy/DT hybrid set
                sets.TP.Accuracy = {        
				ammo="Yamarang",
				head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
				neck={ name="Futhark Torque +2", augments={'Path: A',}},
                body="Runeist's Coat +3", --body="Ashera Harness",
				hands="Turms Mittens +1",
				left_ear="Telos Earring",
				right_ear="Sherida Earring",
				left_ring="Chirich Ring +1",
				right_ring="Niqmaddu Ring",
                back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
				legs="Meg. Chausses +2",
				waist="Ioskeha Belt",
				feet="Turms Leggings +1",}
										
                sets.TP.DT = {              
				ammo="Yamarang",
				head="Turms Cap +1",
				body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
				hands="Turms Mittens +1",
				legs="Eri. Leg Guards +1",
				feet="Turms Leggings +1",
				neck={ name="Futhark Torque +2", augments={'Path: A',}},
				waist="Ioskeha Belt",
				left_ear="Cryptic Earring",
				right_ear="Odnowa Earring +1",
				left_ring="Moonbeam Ring",
				right_ring="Defending Ring",
				
}
                --MDT melee set
                sets.TP.MDTacc = {          
				ammo="Staunch Tathlum +1",          
                head="Turms Cap +1",
				neck={ name="Futhark Torque +2", augments={'Path: A',}},
				left_ear="Cryptic Earring",
				right_ear="Odnowa Earring +1",       
                body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}}, 
				hands="Turms Mittens +1",
				ring1="Moonbeam Ring",
				ring2="Defending Ring",  
                back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
				waist="Engraved Belt",
				legs="Eri. Leg Guards +1",--legs="Runeist's Trousers +3",
				feet="Turms Leggings +1"}         
                                      
                --Weaponskill Sets--
                sets.WS = {}     
                --multi, carries FTP
                sets.Resolution = {     
				ammo="Knobkierrie",
				head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
                body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
				hands="Meghanada Gloves +2",
				legs="Meghanada Chausses +2",
				feet={ name="Herculean Boots", augments={'Accuracy+30','Accuracy+8 Attack+8','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
				neck="Fotia Gorget",
				waist="Fotia Belt",
				left_ear="Moonshade Earring",
				right_ear="Sherida Earring",
				left_ring="Ilabrat Ring", --left_ring="Regal Ring",
				right_ring="Niqmaddu Ring",
				back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
				}
				
				--back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}}                                  
                --single, doesn't carry FTP
                --single hit, benefits from DA
				sets.Single = {            
				ammo="Knobkierrie",
				head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
				body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}, --body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}}, --body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
				hands="Meghanada Gloves +2",
				legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
				feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
				neck={ name="Futhark Torque +2", augments={'Path: A',}}, --neck="Caro Necklace", 
				waist="Grunfeld Rope",
				left_ear="Ishvara Earring",
				right_ear="Odr Earring",        
				left_ring="Ilabrat Ring", --left_ring="Regal Ring",
				right_ring="Niqmaddu Ring",
				back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}
                
                sets.Dimidiation = {  
				ammo="Knobkierrie", --ammo="C. Palug Stone",
				head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
				body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
				hands="Meghanada Gloves +2",
				legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
				feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
				neck={ name="Futhark Torque +2", augments={'Path: A',}}, --neck="Caro Necklace", 
				waist="Grunfeld Rope",
				left_ear="Ishvara Earring",
				right_ear="Odr Earring",        
				left_ring="Ilabrat Ring", --left_ring="Regal Ring",
				right_ring="Niqmaddu Ring",
				back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}
				
				sets.Cleave = {            
				--ammo="Seething Bomblet +1",
                head="Dampening Tam",
				neck="Fotia Gorget",
				neck={ name="Futhark Torque +2", augments={'Path: A',}},
				ear1="Moonshade Earring",
				right_ear="Mache Earring +1",--ear2="Brutal earring",
                body={ name="Herculean Vest", augments={'"Triple Atk."+3','DEX+7','Accuracy+7','Attack+13',}},--body="Rawhide Vest",
				hands="Meghanada Gloves +2",--hands="Rawhide Gloves",
				ring1="Epona's Ring",
				right_ring="Niqmaddu Ring",--ring2="Ramuh Ring +1",
				waist="Fotia Belt",
				legs="Lustratio Subligar +1",
				feet="Lustratio Leggings +1",
                back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}
				
				--added effect
                sets.Shockwave = {
				--ammo="Seething Bomblet +1",
				head="Ayanmo zucchetto +2",
				neck="Sanctity Necklace",
				right_ear="Odnowa Earring +1",
				left_ear="Digni. Earring",
				body="Runeist's Coat +3", 
				hands="Meghanada Gloves +2", 
				ring2="Ayanmo Ring",
				ring1="Moonbeam Ring",
				legs="Ayanmo Cosciales +2",
				waist="Eschan Stone",
				feet="Ayanmo gambieras +2",                               
				back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}
			   --Requiescat
                sets.Req = {               
				--ammo="Seething Bomblet +1",
                head="Dampening Tam",
				neck="Fotia Gorget",
				left_ear="Mache Earring +1",
				ear2="Moonshade Earring",
                body={ name="Herculean Vest", augments={'"Triple Atk."+3','DEX+7','Accuracy+7','Attack+13',}},
				hands="Meghanada Gloves +2",
				legs="Meghanada Chausses +2",
				ring1="Epona's Ring",
				right_ring="Niqmaddu Ring",
                back="Evasionist's Cape",
				waist="Fotia Belt",
				feet="Ayanmo gambieras +2",
				back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}                                           
                --crit based
                sets.Vorp = {}                           
				--ammo="Qirmiz Tathlum",
                --head="Dampening Tam",
				--neck="Fotia Gorget",
				--ear1="Brutal earring",
				--ear2="Moonshade Earring",
                --body="Rawhide Vest",
				--hands="Rawhide Gloves",
				--ring1="Epona's Ring",
				--ring2="Rajas Ring",
                --back="Evasionist's Cape",
				--waist="Fotia Belt",
				--legs="Lustratio Subligar +1",
				--feet="Lustratio Leggings +1"}
                --magic WS
                sets.HercSlash = {                      
				--ammo="Seething Bomblet +1",
                --head="Highwing Helm",
				--neck="Deviant Necklace",
				lear="Hecate's Earring",
				rear="Friomisi earring",
                body="Samnuha Coat",
				hands="Leyline Gloves",
				--ring1="Acumen Ring",
                --back="Argochampsa Mantle",
				waist="Eschan Stone",
				legs="Ayanmo Cosciales +2",
				feet="Ayanmo gambieras +2"}  
                  
                sets.Utility = {}   
                --full PDT set for when stunned, etc.
                sets.Utility.PDT = {        
				ammo="Staunch Tathlum +1",
				head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
				body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}}, --Ashera Harness,--body="Futhark Coat +3"
				hands="Turms Mittens +1",--hands="Regal Gauntlets",
				legs="Eri. Leg Guards +1",
				feet="Turms Leggings +1",
				neck="Loricate Torque +1",
				waist="Flume Belt +1",
				left_ear="Tuisto Earring",
				right_ear="Odnowa Earring +1",
				ring1="Moonbeam Ring",
				ring2="Defending Ring",
				back="Moonbeam Cape",}       
                --full MDT set for when stunned, etc
                sets.Utility.MDT = {        
				--ammo="Vanir Battery",
                ring2="Warden's Ring"}        
  
                sets.Utility.HP =  {       
				ammo="Staunch Tathlum +1",
				head="Turms Cap +1",
				body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
                hands="Turms Mittens +1", --hands="Regal Gauntlets",
				legs="Eri. Leg Guards +1",
				feet="Turms Leggings +1",
				neck="Futhark Torque +2", 
				waist="Kasiri Belt",
				left_ear="Tuisto Earring",
				right_ear="Odnowa Earring +1",
                ring1="Moonbeam Ring",
				ring2="Defending Ring",
				back="Moonbeam Cape"}
  
                --Job Ability Sets--
                sets.JA = {}
				sets.JA.Lunge = {
				--ammo="Seething Bomblet +1",
                head={ name="Herculean Helm", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','INT+6','Mag. Acc.+12','"Mag.Atk.Bns."+11',}},
				neck="Sanctity Necklace",
				lear="Hecate's Earring",
				rear="Friomisi earring",      
                body="Samnuha Coat",
				hands="Leyline Gloves",
				ring2="Locus Ring",
				back="Evasionist's cape",
				waist="Eschan Stone",                         
                legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','INT+10','"Mag.Atk.Bns."+2',}},
				feet={ name="Herculean Boots", augments={'Accuracy+30','Accuracy+8 Attack+8','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}}
                
				sets.JA.Vallation = {body="Runeist's Coat +3",legs="Futhark Trousers +3",back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},}       
                
				sets.JA.Gambit = {hands="Runeist's Mitons +2",}
                
				sets.JA.Rayke = {feet="Futhark boots +3"}  
                
				sets.JA.Battuta = {head="Futhark bandeau +3"}      
                
				sets.JA.Pflug = {feet="Runeist's Boots +2",}              
                
				sets.JA.Pulse = {
				ammo="Staunch Tathlum +1",
				head="Erilaz Galea +1",
				body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
				hands="Runeist's Mitons +2",
				legs="Rune. Trousers +2",
				feet="Erilaz Greaves +1",
				neck="Incanter's Torque",
				waist="Bishop's Sash",
				left_ear="Beatific Earring",
				right_ear="Odnowa Earring +1",
				ring2={name="Stikini Ring +1", bag="wardrobe2"},
				back="Moonbeam Cape"}
				
				sets.JA.Swordplay = {hands="Futhark Mitons +3"}
				
				sets.JA.Bash = {
				--ammo="Seething Bomblet +1",
				head="Ayanmo zucchetto +2",
				neck="Sanctity Necklace",
				right_ear="Odnowa Earring +1",
				left_ear="Mache Earring +1",
                body="Runeist's Coat +3",
				hands="Runeist's Mitons +2",
				ring2="Ayanmo Ring",
				ring1="Moonbeam Ring",
                back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
				legs="Ayanmo Cosciales +2",
				waist="Eschan Stone",
				feet="Ayanmo gambieras +2"}
				
				sets.JA.Waltz = {
				ammo="Yamarang",
				--ear1="Roundel Earring",
				ear2="Odnowa Earring +1",
				body="Futhark Coat +3",
				--hands="Buremte Gloves",
				ring1="Moonbeam Ring",
				ring2="Defending Ring",
				back="Moonbeam Cape",
				waist="Gishdubar Sash",
				--legs="Dashing Subligar",
				--feet="Rawhide Boots"
				}
				sets.JA.step = {ammo="Yamarang"}				
							
                --Precast Sets--
                --Fast Cast set  --60% Fastcast
                sets.precast = {
				ammo="Sapience Orb", --2
				head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
				body="Vrikodara Jupon", --5 Adhemar Jacket +1 path D
				legs="Ayanmo Cosciales +2", --6
				feet="Carmine Greaves +1", --8
				left_ear="Loquac. Earring", --2
				hands="Leyline Gloves", --8
				ring2="Kishar Ring", --4
				waist="Kasiri Belt",
				neck="Orunmila's torque", --5
                back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Damage taken-5%',}} --10
}		
                --473 Enhancing Magic -34 + Phalanx gear -18 = -52dmg
				sets.Phalanx = { 
				ammo="Staunch Tathlum +1",
				head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
				body={ name="Herculean Vest", augments={'Crit.hit rate+3','INT+1','Phalanx +4','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
				hands="Taeon Gloves", 
				legs={ name="Futhark Trousers +3", augments={'Enhances "Inspire" effect',}},
				feet="Taeon Boots",
				neck="Incanter's Torque",
				waist="Olympus Sash",
				left_ear="Andoaa Earring",
				right_ear="Mimir Earring",
				left_ring="Moonbeam Ring",
				right_ring={name="Stikini Ring +1", bag="wardrobe2"},
				back="Merciful Cape",
}
				sets.Refresh = {head="Erilaz galea +1",waist="Gishdubar sash"} 
                --Enmity set for high hate generating spells and JAs                
                sets.Enmity =  { --75 Enmity+Epeolatry(23) = 98
				ammo="Sapience Orb", 		--2
				head="Halitus Helm", 		--8
				left_ear="Cryptic Earring", --4
                waist="Kasiri Belt", 		--3
				body="Emet Harness +1", 	--10
				neck="Futhark Torque +2", 	--10
				--ring1="Eihwaz Ring", 		--5
                ring2="Supershear ring", 	--5
				hands="Kurys Gloves", 		--9
				legs="Erilaz Leg Guards +1",--7
				feet="Ahosi Leggings", 		--7
				back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},}  --10
                
				sets.precast.Stoneskin = {
				legs="Doyen Pants",
				waist="Siegel Sash",
				}
				sets.Stoneskin = {
				waist="Siegel Sash",
				left_ear="Earthcry Earring",
				}
				--Doom
				sets.Utility.Doom = {neck="Nicander's Necklace",waist="Gishdubar Sash",ring1="Purity Ring",ring2="Eshmun's Ring",
				} 
								
                --Toggle TP sets button, change if you want; currently ALT+F9 toggles forward, CTRL+F9 toggles backwards
                send_command('bind f9 gs c toggle TP set')
                send_command('bind ^f9 gs c reverse TP set')
                --other stuff, don't touch
                ShadowType = 'None'
end
  
--the following section looks at the weather/day to see if the Hachirin-no-Obi is worth using
--add the following line to a section to have it check the element and equip the obi:
-->>>  mid_obi(spell.element,spell.name)
function mid_obi(spelement,spellname)
    if spelement == nil then
    spelement = "Light"
    end
    if spellname == nil then
    spellname = "Cure"
    end   
    elements = {}
        elements.list = S{'Fire','Ice','Wind','Earth','Lightning','Water','Light','Dark'}
        elements.number = {[0]="Fire",[1]="Ice",[2]="Wind",[3]="Earth",[4]="Lightning",[5]="Water",[6]="Light",[7]="Dark"}
        elements.weak = {['Light']='Dark', ['Dark']='Light', ['Fire']='Water', ['Ice']='Fire', ['Wind']='Ice', ['Earth']='Wind',
    ['Lightning']='Earth', ['Water']='Lightning'}
        weather = world.weather_element
        intensity = 1 + (world.weather_id % 2)
        day = world.day
        boost = 0
        obi = nil
         
       for _,buff in pairs (windower.ffxi.get_player().buffs) do
            if buff > 177 and buff < 186 then
                weather = elements.number[(buff - 178)]
                intensity = 1
            elseif buff > 588 and buff < 597 then
                weather = elements.number[(buff - 589)]
                intensity = 2
            end
            if spellname == "Swipe" or spellname == "Lunge" or spellname == "Vivacious Pulse" then
                if buff > 522 and buff < 531 then
                spelement = elements.number[(buff - 523)]
                end
            end
        end
        if weather == spelement then
        boost = boost + intensity
        elseif weather == elements.weak[spelement] then
        boost = boost - intensity
        end
        if day == spelement then
        boost = boost + 1
        elseif day == elements.weak[spelement] then
        boost = boost - 1
        end
        if boost > 0 then
            if player.inventory["Hachirin-no-Obi"] or player.wardrobe["Hachirin-no-Obi"] then
                equip({waist="Hachirin-no-Obi"})
            end
        end
end
                 
function precast(spell,abil)
        --equips favorite weapon if disarmed
        if player.equipment.main == "empty" or player.equipment.sub == "empty" then
                equip({main="Epeolatry",sub="Utu Grip"})
        end
        if spell.action_type == 'Magic' then 
                equip(sets.Utility.PDT,sets.precast)            
        end  
        if spell.skill == 'Enhancing Magic' then
                equip({legs="Futhark Trousers +3",waist="Siegel Sash"})
        end
        if string.find(spell.name,'Utsusemi') then
                equip({neck="Magoraga Beads"})
        end  
        if spell.name == 'Lunge' or spell.name == 'Swipe' then
                equip(sets.JA.Lunge)
                mid_obi(spell.element,spell.name)
        end      
        --prevents Valiance/Vallation/Liement from being prevented by each other (cancels whichever is active)
        if spell.name == 'Valiance' or spell.name == 'Vallation' or spell.name == 'Liement' then
                if buffactive['Valiance'] then
                    cast_delay(0.2)
                    windower.ffxi.cancel_buff(535)
                elseif buffactive['Vallation'] then
                    cast_delay(0.2)
                    windower.ffxi.cancel_buff(531)
                elseif buffactive['Liement'] then
                    cast_delay(0.2)
                    windower.ffxi.cancel_buff(537)
                end
        end
        if spell.name == 'Vallation' or spell.name == 'Valiance' then
                equip(sets.Enmity,sets.JA.Vallation)
        end  
        if spell.name == 'Pflug' then
                equip(sets.Enmity,sets.JA.Pflug)
        end      
        if spell.name == 'Elemental Sforzo' or spell.name == 'Liement' then
                equip(sets.Enmity,{body="Futhark Coat +3"})
        end      
        if spell.name == 'Gambit' then
                equip(sets.Enmity,sets.JA.Gambit)
        end
        if spell.name == 'Rayke' then
                equip(sets.Enmity,sets.JA.Rayke)
        end
        if spell.name == 'Battuta' then
                equip(sets.Enmity,sets.JA.Battuta)
        end
		if spell.name == 'Weapon Bash' then
                equip(sets.JA.Bash)
        end
        if spell.name == 'Vivacious Pulse' then
                equip(sets.Enmity,sets.JA.Pulse)
                mid_obi(spell.element,spell.name)
        end
        if spell.name == 'Swordplay' then
                equip(sets.Enmity,sets.JA.Swordplay)
                mid_obi(spell.element,spell.name)
        end		
        if spell.name == 'One for All' or spell.name == 'Embolden' or spell.name == 'Odyllic Subterfuge' or spell.name == 'Warcry' 
        or spell.name == 'Last Resort' or spell.name == 'Souleater' or spell.name == 'Provoke' then    
                equip(sets.Enmity)
        end
        if spell.name == 'Healing Waltz' or spell.name == 'Divine Waltz' or spell.name == 'Curing Waltz' or spell.name == 'Curing Waltz II' 
        or spell.name == 'Curing Waltz III' then    
                equip(sets.JA.Waltz)
        end		
        if spell.name == 'Resolution' or spell.name == 'Ruinator'  then
                equip(sets.Resolution)
        end
        if spell.name == 'Spinning Slash' 
        or spell.name == 'Ground Strike'
        or spell.name == 'Fell Cleave'
        or spell.name == 'Upheaval'
		or spell.name == 'Full Break'		
        or spell.name == 'Dimidiation' 
        or spell.name == 'Steel Cyclone'    
        or spell.name == 'Savage Blade' then
                equip(sets.Single)
        end
        if spell.name == 'Shockwave' then
            equip(sets.Shockwave)
        end
        if spell.name == 'Fell Cleave' or spell.name == 'Circle Blade' then
                equip(sets.Cleave)
        end
        if spell.name == 'Requiescat' then
                equip(sets.Req)
        end
        if spell.name == 'Vorpal Blade' or spell.name == 'Rampage' then
                equip(sets.Vorp)
        end
        if spell.name == 'Herculean Slash' 
        or spell.name == 'Freezebite'  
        or spell.name == 'Sanguine Blade' 
        or spell.name == 'Red Lotus Blade'
        or spell.name == 'Seraph Blade' then
                equip(sets.HercSlash)
                mid_obi(spell.element,spell.name)
        end
        --prevents casting Utsusemi if you already have 3 or more shadows
        if spell.name == 'Utsusemi: Ichi' and ShadowType == 'Ni' and (buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) then
            cancel_spell()
        end
        if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
                if TP_ind == 4 then
                equip(sets.Utility.MDT) else
                equip(sets.Utility.PDT)
                end
        end
		if buffactive['doom'] then
                equip(sets.Utility.doom)
        end
        if buffactive.sleep and player.hp > 65 and player.status == "Engaged" then 
                equip({head="Frenzy Sallet"})
        end
end            
   
function midcast(spell,act,arg) 
        if spell.action_type == 'Magic' then 
                equip(sets.Utility.HP,{head="Runeist's bandeau +3"})         
        end  
        if spell.skill == 'Enhancing Magic' then
                equip({head="Erilaz Galea +1",legs="Futhark Trousers +3"})
                if spell.name == "Blink" or spell.name == "Stoneskin" or string.find(spell.name,'Utsusemi') then
                    equip(sets.Utility.PDT,{head="Runeist's bandeau +3"})
                elseif string.find(spell.name,'Bar') or spell.name=="Temper" then
                    equip({hands="Runeist's Mitons +2",neck="Enhancing Torque"})
                end
                if buffactive.embolden then
                    equip({back="Evasionist's Cape"})
                end 
        end
        if spell.name == 'Flash' or spell.name == "Stun" or spell.name == "Animated Flourish" then 
                equip(sets.Enmity)
        end
        if spell.name == 'Foil' then 
                equip(sets.Enmity,{head="Erilaz Galea +1",legs="Futhark Trousers +3"})
        end 		
        if spell.name == 'Phalanx' then
                equip(sets.Phalanx)
        end
        if spell.name == 'Refresh' then
                equip(sets.Refresh)
        end 		
        if string.find(spell.name,'Regen') then
                equip({head="Runeist's bandeau +3"})
        end
        if spell.skill == 'Elemental Magic' then
                equip(sets.JA.Lunge)
                mid_obi(spell.element,spell.name)
        end
        --cancels Ni shadows (if there are only 1 or 2) when casting Ichi
        if spell.name == 'Utsusemi: Ichi' and ShadowType == 'Ni' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
                send_command('cancel Copy Image')
                send_command('cancel Copy Image (2)')
        end
end
  
function aftercast(spell)
        equip_current()
        if string.find(spell.name,'Utsusemi') and not spell.interrupted then
            if spell.name == 'Utsusemi: Ichi' then
            ShadowType = 'Ichi'
            elseif spell.name == 'Utsusemi: Ni' then
            ShadowType = 'Ni'
            end
        end
end
  
function status_change(new,old)
    equip_current()
end 
   
function equip_TP()
    equip(sets.TP[sets.TP.index[TP_ind]])
        --equips offensive gear despite being on defensive set if you have shadows
        if TP_ind == 3 and ((buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) or buffactive['Third Eye'] or buffactive['Blink']) then
            equip(sets.TP.Standard)
        end
        --equips DW gear if using two weapons
        if player.equipment.sub == "Tramontane Axe" or player.equipment.sub == "Pukulatmuj" or player.equipment.sub == "Anahera Sword" then
            equip({ear2="Suppanomimi"})
        end
        --equips offensive gear and relic boots during Battuta
        if buffactive.battuta then

		--remains on defensive set if Avoidance Down is active
			if buffactive['Avoidance Down'] then
			else
				equip({hands="Turms Mittens +1"})
            end
        end
        --equip defensive gear when hit with terror/petrify/stun/sleep
        if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
                if TP_ind == 4 then
                equip(sets.Utility.MDT) else
                equip(sets.Utility.PDT)
                end
        end
        --equip Frenzy Sallet (will wake you up) if engaged, slept, and over 100 HP
        if buffactive.sleep and player.hp > 100 then 
            equip({head="Frenzy Sallet"})
        end
end
  
function equip_idle()
    equip(sets.Idle)
        --equips extra refresh gear when MP is below 50%
        if player.mpp < 50 then
            equip({body="Runeist's Coat +3"})
        end
        --auto-equip defensive gear when hit with terror/petrify/stun/sleep
        if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] then
                if TP_ind == 4 then
                equip(sets.Utility.MDT) else
                equip(sets.Utility.PDT)
                end
        end
end
  
function buff_change(buff,gain)
    local buff = string.lower(buff)
        if buff == "terror" or buff == "petrification" or buff == "stun" or buff == "sleep" then
            if gain then  
                if TP_ind == 4 then
                equip(sets.Utility.MDT) else
                equip(sets.Utility.PDT)
                end
                if buff == "sleep" and player.hp > 100 and player.status == "Engaged" then 
                equip({head="Frenzy Sallet"})
                end
            else 
            equip_current()
            end
        end
end
  
function equip_current()
        if player.status == 'Engaged' then
        equip_TP()
        else
        equip_idle()
        end
end
              
function self_command(command)
        if command == 'toggle TP set' then
                TP_ind = TP_ind +1
                if TP_ind > #sets.TP.index then TP_ind = 1 end
                send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
                equip_current()
        elseif command == 'reverse TP set' then
                TP_ind = TP_ind -1
                if TP_ind == 0 then TP_ind = #sets.TP.index end
                send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
                equip_current()
        end
end


