local INSTANCE_ICC = {}
local object_link = {
{-3,202242},
{36612,201910},
{36612,201911},
{36612,201563},
{36612,202245},
{36855,202243},
{36855,202244},
{37813,201825},
{37813,202235},
{36626,201613}, -- festergut
{36627,201614}, -- rotface
{-1,201612}, -- prof colision
{-1,201372}, -- prof door
{36678,202182},
{36678,201376},
{37970,201378},
{37970,201377},
{37955,201755},
{37955,202183},
{37955,201375},
{36789,201382},
{36789,201381},
{36789,201380},
{36789,201383},
{36789,201374},
{36789,201373},
{36853,201369},
{36853,202246},
{36853,201379},
{36853,202181},
{-2,202223}
}
local scourge_ports = {202246,202245,202244,202243,202242,202235,202223}
local tele_coords = {
{1,70781,-17.1928,2211.44,30.1158,0},
{2,70856,-503.62,2211.47,62.8235,0},
{3,70857,-615.145,2211.47,199.972,0},
{4,70858,-549.131,2211.29,539.291,0},
{5,70859,4198.42,2769.22,351.065,0},
{6,70861,4356.58,2565.75,220.4,0},
{7,70860,528.39,-2124.84,1040.86,0}
}

local SPELL_CHILL = 69127
local SPELL_FROZEN_THRONE_T = 70860
local MAP_ICC = 631
local SPELL_A_BUFF = 73828
local SPELL_H_BUFF = 73822

local AT_TRAP		= 5649
local AT_MARROW		= 5732
local AT_DEATH		= 5709
local AT_DB_PORT	= 5698
local AT_FROSTWING	= {5618,5617,5616}
local AT_BLOOD		= 5729
local AT_FROZEN_T	= 5718

local NPC_HIGHLORD_TIRION_FORDRING_LH			= 37119
local NPC_THE_LICH_KING_LH						= 37181
local NPC_HIGHLORD_BOLVAR_FORDRAGON_LH			= 37183
local NPC_KOR_KRON_GENERAL						= 37189
local NPC_ALLIANCE_COMMANDER					= 37190
local NPC_TORTUNOK								= 37992 -- Druid Armor H
local NPC_ALANA_MOONSTRIKE						= 37999 -- Druid Armor A
local NPC_GERARDO_THE_SUAVE						= 37993 -- Hunter Armor H
local NPC_TALAN_MOONSTRIKE						= 37998 -- Hunter Armor A
local NPC_UVLUS_BANEFIRE						= 38284 -- Mage Armor H
local NPC_MALFUS_GRIMFROST						= 38283 -- Mage Armor A
local NPC_IKFIRUS_THE_VILE						= 37991 -- Rogue Armor H
local NPC_YILI									= 37997 -- Rogue Armor A
local NPC_VOL_GUK								= 38841 -- Shaman Armor H
local NPC_JEDEBIA								= 38840 -- Shaman Armor A
local NPC_HARAGG_THE_UNSEEN						= 38181 -- Warlock Armor H
local NPC_NIBY_THE_ALMIGHTY						= 38182 -- Warlock Armor A
local NPC_GARROSH_HELLSCREAM					= 39372
local NPC_KING_VARIAN_WRYNN						= 39371
local NPC_DEATHBOUND_WARD						= 37007

local NPC_FROST_TRAP							= 37744
local NPC_SE_HIGH_OVERLORD_SAURFANG				= 37187 -- H
local NPC_SE_MURADIN_BRONZEBEARD				= 37200 -- A
local NPC_SE_KOR_KRON_REAVER					= 37920 -- H
local NPC_SE_SKYBREAKER_MARINE					= 37830 -- A

local instance_spawn = {
{1,NPC_KOR_KRON_GENERAL,NPC_ALLIANCE_COMMANDER,-47.585,2208.98,27.986,3.12414,1735,1732},
{2,NPC_KOR_KRON_GENERAL,NPC_ALLIANCE_COMMANDER,-47.927,2216.32,27.986,3.12414,1735,1732},
{3,NPC_KOR_KRON_GENERAL,NPC_ALLIANCE_COMMANDER,-46.076,2212.61,27.986,3.12414,1735,1732},
{4,NPC_GARROSH_HELLSCREAM,NPC_KING_VARIAN_WRYNN,-49.004,2219.47,27.986,3.12414,1735,1732},
{5,NPC_TORTUNOK,NPC_ALANA_MOONSTRIKE,-75.84,2270.65,30.655,4.92493,2070,35},
{6,NPC_GERARDO_THE_SUAVE,NPC_TALAN_MOONSTRIKE,-70.963,2269.32,30.655,4.45763,2070,35},
{7,NPC_UVLUS_BANEFIRE,NPC_MALFUS_GRIMFROST,-75.798,2283.46,32.868,4.69305,2070,35},
{8,NPC_IKFIRUS_THE_VILE,NPC_YILI,-79.443,2269.37,30.655,5.30192,2070,35},
{9,NPC_VOL_GUK,NPC_JEDEBIA,-67.792,2270.71,30.654,4.90904,2070,35},
{10,NPC_HARAGG_THE_UNSEEN,NPC_NIBY_THE_ALMIGHTY,-63.367,2260.46,30.654,1.83418,2070,35},
{11,NPC_SE_HIGH_OVERLORD_SAURFANG,NPC_SE_MURADIN_BRONZEBEARD,-555.958,2211.4,539.369,6.26573,1735,1732},
{12,NPC_SE_KOR_KRON_REAVER,NPC_SE_SKYBREAKER_MARINE,-560.451,2212.86,539.368,6.17846,1735,1732},
{13,NPC_SE_KOR_KRON_REAVER,NPC_SE_SKYBREAKER_MARINE,-560.399,2209.30,539.368,6.23082,1735,1732},
{14,NPC_SE_KOR_KRON_REAVER,NPC_SE_SKYBREAKER_MARINE,-557.958,2207.16,539.368,6.26573,1735,1732},
{15,NPC_SE_KOR_KRON_REAVER,NPC_SE_SKYBREAKER_MARINE,-557.936,2214.46,539.368,6.26573,1735,1732}
}

local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B
local GAMEOBJECT_FLAGS		= 0x0006 + 0x0003
 --[[
function INSTANCE_ICC.InstanceOnCreate(id)
INSTANCE_ICC[id] = {}
INSTANCE_ICC[id].builddata = true
INSTANCE_ICC[id].buff = true
INSTANCE_ICC[id].marrowgar = false
INSTANCE_ICC[id].deathwhisper = false
INSTANCE_ICC[id].saurfang = false
INSTANCE_ICC[id].frtap = false
INSTANCE_ICC[id].festergut = false
INSTANCE_ICC[id].rotface = false
INSTANCE_ICC[id].prof = false
INSTANCE_ICC[id].prince = false
INSTANCE_ICC[id].bloodqueen = false
INSTANCE_ICC[id].dreamwalker = false
INSTANCE_ICC[id].sindragosa = false
INSTANCE_ICC[id].lichking = false
end
 ]]-- todo
function INSTANCE_ICC.DoorOnLoad(iid, pPlayer)
local id = pPlayer:GetInstanceID()
if(INSTANCE_ICC[id] == nil)then
	local string_data = {}
	INSTANCE_ICC[id] = {}
	INSTANCE_ICC[id].builddata = true
	INSTANCE_ICC[id].buff = true
	INSTANCE_ICC[id].marrowgar = false
	INSTANCE_ICC[id].deathwhisper = false
	INSTANCE_ICC[id].frtap = false
	INSTANCE_ICC[id].saurfang = false
	INSTANCE_ICC[id].festergut = false
	INSTANCE_ICC[id].rotface = false
	INSTANCE_ICC[id].prof = false
	INSTANCE_ICC[id].prince = false
	INSTANCE_ICC[id].bloodqueen = false
	INSTANCE_ICC[id].dreamwalker = false
	INSTANCE_ICC[id].sindragosa = false
	INSTANCE_ICC[id].lichking = false
	local result = CharDBQuery("SELECT killed_npc_guids FROM instances WHERE id="..id..";")
	if(result ~= nil)then
		local colcount = result:GetColumnCount();
		repeat
			for col = 0, colcount-1, 1 do
				string_data[col] = result:GetColumn( col ):GetString()
				local b1 = string.find(string_data[col], "36612")
				local b2 = string.find(string_data[col], "36855")
				local b3 = string.find(string_data[col], "37813")
				local b4 = string.find(string_data[col], "36626")
				local b5 = string.find(string_data[col], "36627")
				local b6 = string.find(string_data[col], "36678")
				local b7 = string.find(string_data[col], "37970")
				local b8 = string.find(string_data[col], "37955")
				local b9 = string.find(string_data[col], "36789")
				local b10 = string.find(string_data[col], "36853")
				local b11 = string.find(string_data[col], "36597")
				if(b1 ~= nil)then
					INSTANCE_ICC[id].marrowgar = true
				end
				if(b2 ~= nil)then
					INSTANCE_ICC[id].deathwhisper = true
				end
				if(b3 ~= nil)then
					INSTANCE_ICC[id].saurfang = true
				end
				if(b4 ~= nil)then
					INSTANCE_ICC[id].festergut = true
				end
				if(b5 ~= nil)then
					INSTANCE_ICC[id].rotface = true
				end
				if(b6 ~= nil)then
					INSTANCE_ICC[id].prof = true
				end
				if(b7 ~= nil)then
					INSTANCE_ICC[id].prince = true
				end
				if(b8 ~= nil)then
					INSTANCE_ICC[id].bloodqueen = true
				end
				if(b9 ~= nil)then
					INSTANCE_ICC[id].dreamwalker = true
				end
				if(b10 ~= nil)then
					INSTANCE_ICC[id].sindragosa = true
				end
				if(b11 ~= nil)then
					INSTANCE_ICC[id].lichking = true
					INSTANCE_ICC[id].buff = false
				end
			end
		until result:NextRow() ~= true;
	end
	for i = 1, #instance_spawn do
		if(pPlayer:GetTeam() == 1)then
			if(instance_spawn[i][1] == i)then
				PerformIngameSpawn(1,instance_spawn[i][2],MAP_ICC,instance_spawn[i][4],instance_spawn[i][5],instance_spawn[i][6],instance_spawn[i][7],instance_spawn[i][8],0,0,0,0,id,0)
			end
		elseif(pPlayer:GetTeam() == 0)then
			if(instance_spawn[i][1] == i)then
				PerformIngameSpawn(1,instance_spawn[i][3],MAP_ICC,instance_spawn[i][4],instance_spawn[i][5],instance_spawn[i][6],instance_spawn[i][7],instance_spawn[i][9],0,0,0,0,id,0)
			end
		end		
	end
end
if(INSTANCE_ICC[id].lichking ~= true and pPlayer:HasAura(SPELL_CHILL) == false)then
	SetDBCSpellVar(SPELL_CHILL, "c_is_flags", 0x01000)
	pPlayer:CastSpell(SPELL_CHILL)
end
if(INSTANCE_ICC[id].buff == true)then
	if(pPlayer:GetTeam() == 0 and not pPlayer:HasAura(SPELL_A_BUFF))then
		pPlayer:CastSpell(SPELL_A_BUFF)
	elseif(pPlayer:GetTeam() == 1 and not pPlayer:HasAura(SPELL_H_BUFF))then
		pPlayer:CastSpell(SPELL_H_BUFF)
	end
end
end

function INSTANCE_ICC.OnGOpush(pGO)
local plr = pGO:GetClosestPlayer()
if(plr)then
	local id = plr:GetInstanceID()
	for b = 1,#object_link do
		if(pGO:GetEntry() == object_link[b][2] and object_link[b][1] == -3 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
		if(INSTANCE_ICC[id].marrowgar ~= nil)then
			if(INSTANCE_ICC[id].marrowgar == true and object_link[b][1] == 36612 and pGO:GetEntry() == object_link[b][2] and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
				pGO:Activate()
			end
		end
		if(INSTANCE_ICC[id].deathwhisper ~= nil)then
			if(INSTANCE_ICC[id].deathwhisper == true and object_link[b][1] == 36855 and pGO:GetEntry() == object_link[b][2] and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
			end
		end
		if(INSTANCE_ICC[id].saurfang ~= nil)then
			if(INSTANCE_ICC[id].saurfang == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 37813 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
				pGO:Activate()
			end
		end
		if(INSTANCE_ICC[id].festergut == true and INSTANCE_ICC[id].rotface == false and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 36626 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		elseif(INSTANCE_ICC[id].festergut == true and INSTANCE_ICC[id].rotface == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 36626 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
		if(INSTANCE_ICC[id].rotface == true and INSTANCE_ICC[id].festergut == false and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 36627 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		elseif(INSTANCE_ICC[id].rotface == true and INSTANCE_ICC[id].festergut == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 36627)then
			pGO:Despawn(1,0)
		end
		if(INSTANCE_ICC[id].rotface == true and INSTANCE_ICC[id].festergut == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == -1 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
		if(INSTANCE_ICC[id].prof == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 36678 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
		if(INSTANCE_ICC[id].prince == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 37970 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
		if(INSTANCE_ICC[id].bloodqueen == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 37955 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
		if(INSTANCE_ICC[id].dreamwalker == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 36789 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
		if(INSTANCE_ICC[id].sindragosa == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == 36853 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
		if(INSTANCE_ICC[id].sindragosa == true and INSTANCE_ICC[id].prof == true and INSTANCE_ICC[id].bloodqueen == true and pGO:GetEntry() == object_link[b][2] and object_link[b][1] == -2 and pGO:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
			pGO:Activate()
		end
	end
end
end

function INSTANCE_ICC.TeleportOnGossip(pGO, event, pPlayer)
local id = pPlayer:GetInstanceID()
pGO:GossipCreateMenu(15221, pPlayer, 0)
pGO:GossipMenuAddItem(0,"Teleport to the Light's Hammer.", 1, 0)
if(INSTANCE_ICC[id].marrowgar)then
	pGO:GossipMenuAddItem(0,"Teleport to the Oratory of the Damned.", 2, 0)
end
if(INSTANCE_ICC[id].deathwhisper)then
	pGO:GossipMenuAddItem(0,"Teleport to the Rampart of Skulls.", 3, 0)
	pGO:GossipMenuAddItem(0,"Teleport to the Deathbringer's Rise.", 4, 0) -- gunship battle needs core support.
end
if(INSTANCE_ICC[id].saurfang)then
	pGO:GossipMenuAddItem(0,"Teleport to the The Upper Spire.", 5, 0)
end
if(INSTANCE_ICC[id].sindragosa)then
	pGO:GossipMenuAddItem(0,"Teleport to the The Frost Queen's Lair.", 6, 0)
end
pGO:GossipSendMenu(pPlayer)
end

function INSTANCE_ICC.TeleporterOnSelect(pGO, event, pPlayer, id, intid, code)
for i = 1, #tele_coords do
	if(intid == tele_coords[i][1] and not pPlayer:IsInCombat())then
		pPlayer:CastSpell(tele_coords[i][2])
		pPlayer:Teleport(MAP_ICC,tele_coords[i][3],tele_coords[i][4],tele_coords[i][5],tele_coords[i][6])
		pPlayer:GossipComplete()
	elseif(intid == tele_coords[i][1] and pPlayer:IsInCombat())then
		pPlayer:SendAreaTriggerMessage("You are in combat!")
		pPlayer:GossipComplete()
	end
end
pPlayer:GossipComplete()
end

function INSTANCE_ICC.OnZoneOut(event, pPlayer, ZoneId, OldZoneId)
if(pPlayer:GetMapId() ~= MAP_ICC)then
	if(pPlayer:HasAura(SPELL_CHILL))then
		pPlayer:RemoveAura(SPELL_CHILL)
	end
	if(pPlayer:HasAura(SPELL_A_BUFF))then
		pPlayer:RemoveAura(SPELL_A_BUFF)
	end
	if(pPlayer:HasAura(SPELL_H_BUFF))then
		pPlayer:RemoveAura(SPELL_H_BUFF)
	end
end
end

function INSTANCE_ICC.KillBoss(id, pVictim, pKiller)
local id = pKiller:GetInstanceID()
if(pVictim:IsCreature() and pVictim:GetEntry() == 36612)then
	INSTANCE_ICC[id].marrowgar = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 36855)then
	INSTANCE_ICC[id].deathwhisper = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 37813)then
	INSTANCE_ICC[id].saurfang = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 36626)then
	INSTANCE_ICC[id].festergut = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 36627)then
	INSTANCE_ICC[id].rotface = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 36678)then
	INSTANCE_ICC[id].prof = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 37970)then
	INSTANCE_ICC[id].prince = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 37955)then
	INSTANCE_ICC[id].bloodqueen = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 36789)then
	INSTANCE_ICC[id].dreamwalker = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 36853)then
	INSTANCE_ICC[id].sindragosa = true
elseif(pVictim:IsCreature() and pVictim:GetEntry() == 36597)then
	INSTANCE_ICC[id].lichking = true
end
end

function INSTANCE_ICC.InstanceDestroy(id)
INSTANCE_ICC[id] = nil
end

function INSTANCE_ICC.OnAreaTrigger(iid, pPlayer, nAreaId)
local id = pPlayer:GetInstanceID()
if(nAreaId == AT_TRAP and INSTANCE_ICC[id].frtap ~= true)then
	INSTANCE_ICC[id].frtap = true
end
end

RegisterInstanceEvent(MAP_ICC,3,INSTANCE_ICC.OnAreaTrigger)
 -- RegisterInstanceEvent(MAP_ICC,9,INSTANCE_ICC.InstanceOnCreate)
RegisterInstanceEvent(MAP_ICC,10,INSTANCE_ICC.InstanceDestroy)
RegisterServerHook(15,INSTANCE_ICC.OnZoneOut)
RegisterInstanceEvent(MAP_ICC,2,INSTANCE_ICC.DoorOnLoad)
RegisterInstanceEvent(MAP_ICC,5,INSTANCE_ICC.KillBoss)
for i = 1, #object_link do
RegisterGameObjectEvent(object_link[i][2],2,INSTANCE_ICC.OnGOpush)
end
for i = 1, #scourge_ports do
RegisterGameObjectEvent(scourge_ports[i],4,INSTANCE_ICC.TeleportOnGossip)
end
for i = 1, #scourge_ports do
RegisterGOGossipEvent(scourge_ports[i],2,INSTANCE_ICC.TeleporterOnSelect)
end
