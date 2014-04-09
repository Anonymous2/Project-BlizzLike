 --[[ Scripted by DarkAngel39 ]]
local NPC_ADHERENTS						= 37949
local NPC_FANATIC						= 37890
local NPC_SHADE							= 38222
local BOSS_DEATHWHISPER					= 36855

local GO_DOOR_DW						= 201563
local GO_TELEPORTER						= 202243
 -- Boss
local SPELL_MANA_BARRIER				= 70842
local SPELL_SHADOW_BOLT					= {71254,72008,72503,72504}
local SPELL_DEATH_AND_DECAY				= {71001,72108,72109,72110}
local SPELL_DOMINATE_MIND_H				= 71289
local SPELL_FROSTBOLT					= 71420
local SPELL_FROSTBOLT_VOLLEY			= {72905,72906,72907,72908}
local SPELL_TOUCH_OF_INSIGNIFICANCE		= 71204
local SPELL_SUMMON_SHADE				= 71363
local SPELL_SHADOW_CHANNELING			= 43897 -- Prefight, during intro
local SPELL_DARK_TRANSFORMATION_T		= 70895
local SPELL_DARK_EMPOWERMENT_T			= 70896
local SPELL_DARK_MARTYRDOM_T			= 70897
local SPELL_BERSERK						= 47008
 -- Trash
local SPELL_MARTHYRDOM					= 70903 -- Shared
 -- Fanatics
local SPELL_DARK_TRANSFORM				= 70900
local SPELL_NECROTIC_STRIKE				= 70659
local SPELL_SHADOW_CLEAVE				= 70670
local SPELL_VAMPIRIC_MIGHT				= 70674
local SPELL_FANATIC_S_DETERMINATION		= 71235
local SPELL_DARK_MARTYRDOM_FANATIC		= 71236
 -- Adherents
local SPELL_EMPOWERMENT					= 70901
local SPELL_FROST_FEVER					= 67767
local SPELL_DEATHCHILL_BOLT				= 70594
local SPELL_DEATHCHILL_BLAST			= 70906
local SPELL_CURSE_OF_TORPOR				= 71237
local SPELL_SHORUD_OF_THE_OCCULT		= 70768
local SPELL_ADHERENT_S_DETERMINATION	= 71234
local SPELL_DARK_MARTYRDOM_ADHERENT		= 70903
 -- Vengeful Shade
local SPELL_VENGEFUL_BLAST				= {71544,72010,72011,72012}
local SPELL_VENGEFUL_BLAST_PASSIVE		= 71494
 -- Darnavan
local SPELL_BLADESTORM					= 65947
local SPELL_CHARGE						= 65927
local SPELL_INTIMIDATING_SHOUT			= 65930
local SPELL_MORTAL_STRIKE				= 65926
local SPELL_SHATTERING_THROW			= 65940
local SPELL_SUNDER_ARMOR				= 65936

local BOSS_HP_DATA					= {3346800,13387200,6693600,26774400}

local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B
local GAMEOBJECT_FLAGS		= 0x0006 + 0x0003

local self = getfenv(1)

function BossOnLoad(pUnit)
pUnit:SetUInt32Value(59,2)
local diff = pUnit:GetDungeonDifficulty()
pUnit:SetMaxHealth(BOSS_HP_DATA[diff+1])
pUnit:SetHealth(BOSS_HP_DATA[diff+1])
if(diff == 0 or diff == 2)then
	pUnit:SetMaxMana(3346800)
	pUnit:SetMana(3346800)
else
	pUnit:SetMaxMana(13992000)
	pUnit:SetMana(13992000)
end
pUnit:FullCastSpell(SPELL_SHADOW_CHANNELING)
self[tostring(pUnit)] = {
event11 = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function BossOnCombat(pUnit, event)
if(pUnit:HasAura(SPELL_SHADOW_CHANNELING))then
	pUnit:RemoveAura(SPELL_SHADOW_CHANNELING)
end
pUnit:SendChatMessage(14, 0, "What is this disturbance?! You dare trespass upon this hallowed ground? This shall be your final resting place.")
pUnit:PlaySoundToSet(16868)
pUnit:Root()
pUnit:FullCastSpell(SPELL_MANA_BARRIER)
pUnit:DisableMelee(true)
self[tostring(pUnit)] = {
phase = 1,
diff = pUnit:GetDungeonDifficulty(),
deathdecay = 10,
berserk = 600,
 -- phase 1
p1wave = 5,
waveid = 0,
p1sbowt = math.random(5,6),
p1ecultist = math.random(20,30),
empower = math.random(20,30),
dominatemind = 27, -- 25 only
 -- phase 2
p2fbowt = math.random(10,12),
p2fbvolley = math.random(19,21),
p2touch = math.random(6,9),
p2shade = math.random(12,15)
}
pUnit:RegisterAIUpdateEvent(1000)
for k,v in pairs(pUnit:GetInRangeObjects())do
	if((v:GetEntry() == GO_DOOR_DW or v:GetEntry() == GO_TELEPORTER) and v:GetByte(GAMEOBJECT_BYTES_1,0) ~= 1)then
		v:Activate()
	end
end
end

function BossAI(pUnit)
local vars = self[tostring(pUnit)]
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
if(pUnit:IsInCombat())then
	if(pUnit:GetNextTarget() == nil)then
		pUnit:WipeThreatList()
		return
	end
	vars.berserk = vars.berserk - 1
	vars.deathdecay = vars.deathdecay - 1
	if(vars.deathdecay <= 0)then
		local plr = pUnit:GetRandomPlayer(0)
		pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(),SPELL_DEATH_AND_DECAY[vars.diff+1])
		vars.deathdecay = 10
	elseif(vars.berserk <= 0)then
		pUnit:SendChatMessage(14, 0, "This charade has gone on long enough.")
		pUnit:PlaySoundToSet(16872)
		pUnit:CastSpell(SPELL_BERSERK)
		vars.berserk = 600
	end
	if(pUnit:HasAura(SPELL_MANA_BARRIER) and vars.phase == 1)then
		vars.p1wave = vars.p1wave - 1
		vars.p1sbowt = vars.p1sbowt - 1
		vars.p1ecultist = vars.p1ecultist - 1
		if(vars.diff == 1 or vars.diff == 3)then
			vars.dominatemind = vars.dominatemind - 1
		end
		if(vars.p1sbowt <= 0)then
			pUnit:FullCastSpellOnTarget(SPELL_SHADOW_BOLT[vars.diff+1],pUnit:GetRandomPlayer(0))
			vars.p1sbowt = math.random(5,6)
		elseif(vars.dominatemind <= 0)then
			pUnit:FullCastSpellOnTarget(SPELL_DOMINATE_MIND_H,pUnit:GetRandomPlayer(0))
			pUnit:SendChatMessage(14, 0, "You are weak, powerless to resist my will!")
			pUnit:PlaySoundToSet(16876)
			vars.dominatemind = 27
		elseif(vars.p1wave <= 0)then
			vars.p1wave = 50
			if(vars.waveid == 0)then
				pUnit:SpawnCreature(NPC_FANATIC,-578.7066,2154.167,51.01529,1.692969,14,80000)
				pUnit:SpawnCreature(NPC_FANATIC,-598.9028,2155.005,51.01530,1.692969,14,80000)
				pUnit:SpawnCreature(NPC_ADHERENTS,-619.2864,2154.460,51.01530,1.692969,14,80000)
				pUnit:SendChatMessage(42, 0, "Two Cult Fanatics and a Cult Adherent join the fight!")
				vars.waveid = 1
			elseif(vars.waveid == 1)then
				pUnit:SpawnCreature(NPC_ADHERENTS,-578.6996,2269.856,51.01529,4.590216,14,80000)
				pUnit:SpawnCreature(NPC_FANATIC,-598.9688,2269.264,51.01529,4.590216,14,80000)
				pUnit:SpawnCreature(NPC_ADHERENTS,-619.4323,2268.523,51.01530,4.590216,14,80000)
				pUnit:SendChatMessage(42, 0, "Two Cult Adherents and a Cult Fanatic join the fight!")
				vars.waveid = 0
			end
		elseif(vars.empower <= 0)then
			local cancast = false
			vars.empower = math.random(20,30)
			local spellid = math.random(1,2)
			for k,v in pairs(pUnit:GetInRangeUnits())do
				if((v:GetEntry() == NPC_FANATIC or v:GetEntry() == NPC_ADHERENTS) and v:IsAlive())then
					cancast = true
				end
			end
			if(spellid == 1 and cancast == true)then
				pUnit:SendChatMessage(14, 0, "I release you from the curse of flesh!")
				pUnit:PlaySoundToSet(16874)
				pUnit:CastSpell(SPELL_DARK_TRANSFORMATION_T)
			elseif(spellid == 2 and cancast == true)then
				pUnit:SendChatMessage(14, 0, "Take this blessing and show these intruders a taste of our master's power.")
				pUnit:PlaySoundToSet(16873)
				pUnit:CastSpell(SPELL_DARK_EMPOWERMENT_T)
			end
		elseif(vars.p1ecultist <= 0)then
			pUnit:SendChatMessage(14, 0, "Arise and exult in your pure form!")
			pUnit:PlaySoundToSet(16875)
			pUnit:CastSpell(SPELL_DARK_MARTYRDOM_T)
			vars.p1ecultist = math.random(20,30)
		end
	elseif(pUnit:HasAura(SPELL_MANA_BARRIER) == false and vars.phase == 1 and pUnit:GetMana() < pUnit:GetMaxMana()/999)then
		pUnit:SendChatMessage(14, 0, "Enough! I see I must take matters into my own hands!")
		pUnit:PlaySoundToSet(16877)
		pUnit:SendChatMessage(42, 0, "Lady Deathwhisper's Mana Barrier shimmers and fades away!")
		pUnit:DisableMelee(false)
		pUnit:Unroot()
		vars.phase = 2
	elseif(vars.phase == 2)then
		vars.p2fbowt = vars.p2fbowt - 1
		vars.p2fbvolley = vars.p2fbvolley - 1
		vars.p2touch = vars.p2touch - 1
		vars.p2shade = vars.p2shade - 1
		if(vars.p2fbowt <= 0)then
			pUnit:FullCastSpellOnTarget(SPELL_FROSTBOLT,pUnit:GetMainTank())
			vars.p2fbowt = math.random(10,12)
		elseif(vars.p2fbvolley <= 0)then
			pUnit:FullCastSpellOnTarget(SPELL_FROSTBOLT_VOLLEY[vars.diff+1],pUnit:GetMainTank())
			vars.p2fbvolley = math.random(19,21)
		elseif(vars.p2touch <= 0)then
			vars.p2touch = math.random(6,9)
			pUnit:FullCastSpellOnTarget(SPELL_TOUCH_OF_INSIGNIFICANCE,pUnit:GetMainTank())
		elseif(vars.p2shade <= 0)then
			pUnit:FullCastSpellOnTarget(SPELL_SUMMON_SHADE,pUnit:GetRandomPlayer(0))
			vars.p2shade = math.random(12,15)
		end
	end
else
	vars.event11 = vars.event11 + 1
	if(vars.event11 == 2)then
		pUnit:SendChatMessage(14, 0, "You have found your way here, because you are among the few gifted with true vision in a world cursed with blindness.")
		pUnit:PlaySoundToSet(17272)
	elseif(vars.event11 == 12)then
		pUnit:SendChatMessage(14, 0, "You can see through the fog that hangs over this world like a shroud, and grasp where true power lies.")
		pUnit:PlaySoundToSet(17273)
	elseif(vars.event11 == 22)then
		pUnit:SendChatMessage(14, 0, "Fix your eyes upon your crude hands: the sinew, the soft meat, the dark blood coursing within.")
		pUnit:PlaySoundToSet(16878)
	elseif(vars.event11 == 31)then
		pUnit:SendChatMessage(14, 0, "It is a weakness; a crippling flaw.... A joke played by the Creators upon their own creations.")
		pUnit:PlaySoundToSet(17268)
	elseif(vars.event11 == 39)then
		pUnit:SendChatMessage(14, 0, "The sooner you come to accept your condition as a defect, the sooner you will find yourselves in a position to transcend it.")
		pUnit:PlaySoundToSet(17269)
	elseif(vars.event11 == 46)then
		pUnit:SendChatMessage(14, 0, "Through our Master, all things are possible. His power is without limit, and his will unbending.")
		pUnit:PlaySoundToSet(17270)
	elseif(vars.event11 == 56)then
		pUnit:SendChatMessage(14, 0, "Those who oppose him will be destroyed utterly, and those who serve -- who serve wholly, unquestioningly, with utter devotion of mind and soul -- elevated to heights beyond your ken.")
		pUnit:PlaySoundToSet(17271)
	elseif(vars.event11 == 73)then
		pUnit:SetUInt32Value(59,0)
		pUnit:RemoveAIUpdateEvent()
	end
end
end

function BossOnDamage(pUnit, event, pAttacker, pAmount) -- 23
if(pUnit:HasAura(SPELL_MANA_BARRIER) and pUnit:GetMana() > pAmount)then
	pUnit:SetHealthPct(100)
	pUnit:SetMana(pUnit:GetMana() - pAmount)
elseif(pUnit:HasAura(SPELL_MANA_BARRIER) and pUnit:GetMana() <= pAmount)then
	pUnit:Heal(pUnit,0,pUnit:GetMana())
	pUnit:SetMana(0)
	pUnit:RemoveAura(SPELL_MANA_BARRIER)
end
end

function BossOnKillPlr(pUnit, event, pDied)
local chance = math.random(1, 2)
if(chance == 1 and pDied:IsPlayer())then
	pUnit:SendChatMessage(14, 0, "Embrace the darkness... Darkness eternal!")
	pUnit:PlaySoundToSet(16870)
elseif(chance == 1 and pDied:IsPlayer())then
	pUnit:SendChatMessage(14, 0, "Do you yet grasp of the futility of your actions?")
	pUnit:PlaySoundToSet(16869)
end
end
		
function BossOnDeath(pUnit, event)
pUnit:RemoveEvents()
pUnit:RemoveAllAuras()
pUnit:SendChatMessage(14, 0, "All part of the masters plan! Your end is... inevitable!")
pUnit:PlaySoundToSet(16871)
pUnit:RemoveAIUpdateEvent()
for k,v in pairs(pUnit:GetInRangeObjects())do
	if((v:GetEntry() == GO_DOOR_DW or v:GetEntry() == GO_TELEPORTER) and v:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
		v:Activate()
	end
end
for k,l in pairs(pUnit:GetInRangeUnits())do
	if(l:GetEntry() == NPC_ADHERENTS or l:GetEntry() == NPC_FANATIC or l:GetEntry() == NPC_SHADE)then
		l:RemoveEvents()
		l:Despawn(1,0)
	end
end
end

function BossOnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
pUnit:RemoveAllAuras()
if(pUnit:GetDungeonDifficulty() == 0 or pUnit:GetDungeonDifficulty() == 2)then
	pUnit:SetMana(3346800)
else
	pUnit:SetMana(13992000)
end
pUnit:RemoveAIUpdateEvent()
for k,v in pairs(pUnit:GetInRangeObjects())do
	if((v:GetEntry() == GO_DOOR_DW or v:GetEntry() == GO_TELEPORTER) and v:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
		v:Activate()
	end
end
for k,l in pairs(pUnit:GetInRangeUnits())do
	if(l:GetEntry() == NPC_ADHERENTS or l:GetEntry() == NPC_FANATIC or l:GetEntry() == NPC_SHADE)then
		l:RemoveEvents()
		l:Despawn(1,0)
	end
end
end

function DummyHandler(spellIndex, pSpell)
local caster = pSpell:GetCaster()
if not(caster)then return end
if(pSpell == SPELL_DARK_TRANSFORMATION_T)then
	local casted1 = false
	for i,npc in pairs(caster:GetInRangeUnits())do
		if(npc:IsAlive() and casted1 == false)then
			if(npc:GetEntry() == NPC_FANATIC)then
				casted1 = true
				npc:FullCastSpell(SPELL_DARK_TRANSFORM)
			end
		end
	end
elseif(pSpell == SPELL_DARK_EMPOWERMENT_T)then
	local casted2 = false
	for i,npc in pairs(caster:GetInRangeUnits())do
		if(npc:IsAlive() and casted2 == false)then
			if(npc:GetEntry() == NPC_ADHERENTS)then
				casted2 = true
				npc:FullCastSpell(SPELL_EMPOWERMENT)
			end
		end
	end
elseif(pSpell == SPELL_DARK_MARTYRDOM_T)then
	local chance = math.random(1,2)
	local summon = 0
	if(chance == 1)then
		for k,v in pairs(caster:GetInRangeUnits())do
			if(v:GetEntry() == NPC_FANATIC and summon < 3 and v:IsDead())then
				v:FullCastSpell(SPELL_MARTHYRDOM)
				summon = summon + 1
			end
		end
	elseif(chance == 2)then
		for k,v in pairs(caster:GetInRangeUnits())do
			if(v:GetEntry() == NPC_ADHERENTS and summon < 3 and v:IsDead())then
				v:FullCastSpell(SPELL_MARTHYRDOM)
				summon = summon + 1
			end
		end
	end
elseif(pSpell == SPELL_SUMMON_SHADE)then
	caster:SpawnCreature(caster:GetX(),caster:GetY(),caster:GetZ(),NPC_SHADE)
end
end

RegisterUnitEvent(BOSS_DEATHWHISPER,1,BossOnCombat)
RegisterUnitEvent(BOSS_DEATHWHISPER,2,BossOnLeaveCombat)
RegisterUnitEvent(BOSS_DEATHWHISPER,3,BossOnKillPlr)
RegisterUnitEvent(BOSS_DEATHWHISPER,4,BossOnDeath)
RegisterUnitEvent(BOSS_DEATHWHISPER,18,BossOnLoad)
RegisterUnitEvent(BOSS_DEATHWHISPER,21,BossAI)
RegisterUnitEvent(BOSS_DEATHWHISPER,23,BossOnDamage)
RegisterDummySpell(SPELL_DARK_TRANSFORMATION_T,DummyHandler)
RegisterDummySpell(SPELL_DARK_EMPOWERMENT_T,DummyHandler)
RegisterDummySpell(SPELL_DARK_MARTYRDOM_T,DummyHandler)
RegisterDummySpell(SPELL_SUMMON_SHADE,DummyHandler)
