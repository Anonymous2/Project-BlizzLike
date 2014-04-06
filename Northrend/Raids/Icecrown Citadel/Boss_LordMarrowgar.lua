--[[

Originally made by: ???
Edit by Mathix of ac-web.org
and Goten87 for doors
reweitten by DarkAngel39
]]
local BOSS_HP_DATA					= {6972500,23706500,10458750,31376250}
local BOSS_MARROWGAR				= 36612
local NPC_BONESPIKE_ID				= {36619,38712,38711}

local GO_DATA = {201910,201911,201563,202245}
local GO_MARROWGAR_ENTRANCE			= 201857

local SPELL_BONE_SLICE				= 69055
local SPELL_BONE_STORM				= 69076
local SPELL_BONESTORM_DAMAGE = {69075,70835,70835,70836}
local SPELL_BONE_SPIKE_GRAVEYARD	= 69057
local SPELL_COLDFLAME_NORMAL		= 69140
local SPELL_COLDFLAME_BONE_STORM	= 72705
local SPELL_BERSERK					= 47008
local SPELL_BONESPIKE_SUM_ID		= {69062, 72669, 72670}

    -- Bone Spike
local SPELL_IMPALED					= 69065
local SPELL_RIDE_VEHICLE			= 46598

    -- Coldflame
local SPELL_COLDFLAME_PASSIVE		= 69145
local SPELL_COLDFLAME_SUMMON		= 69147

local self = getfenv(1)

function BossOnLoad(pUnit)
pUnit:SetMaxHealth(BOSS_HP_DATA[pUnit:GetDungeonDifficulty()+1])
pUnit:SetHealth(BOSS_HP_DATA[pUnit:GetDungeonDifficulty()+1])
pUnit:SendChatMessage(14, 0, "This is the beginning AND the end, mortals. None may enter the master's sanctum!")
pUnit:PlaySoundToSet(16950)
end

function BossOnCombat(pUnit, event)
self[tostring(pUnit)] = {
bonestorm = math.random(45,50),
bonespike = 15,
boneslice = 10,
coldflame = 5,
enrage = 600,
flame1 = 4,
diff = pUnit:GetDungeonDifficulty(),
damagest = 2,
state = 0
}
pUnit:SendChatMessage(14, 0, "The Scourge will wash over this world as a swarm of death and destruction!")
pUnit:PlaySoundToSet(16941)
pUnit:RegisterAIUpdateEvent(1000)
for k,v in pairs(pUnit:GetInRangeObjects())do
	if(v:GetEntry() == GO_MARROWGAR_ENTRANCE)then
		v:Activate()
	end
end
end

function BossAI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
if(pUnit:GetNextTarget() == nil)then
	pUnit:WipeThreatList()
	return
end
local vars = self[tostring(pUnit)]
if not(pUnit:HasAura(SPELL_BONE_STORM))then
	vars.bonestorm = vars.bonestorm - 1
	vars.bonespike = vars.bonespike - 1
	vars.boneslice = vars.boneslice - 1
	vars.coldflame = vars.coldflame - 1
end
vars.enrage = vars.enrage - 1
if(vars.bonestorm <= 0)then
	pUnit:FullCastSpell(SPELL_BONE_STORM)
	pUnit:SendChatMessage(14, 0, "BONE STORM!")
	pUnit:SendChatMessage(42, 0, "Lord Marrowgar creates a whirling storm of bone!")
	pUnit:PlaySoundToSet(16946)
	pUnit:Root()
	vars.bonestorm = math.random(45,50)
elseif(vars.bonespike <= 0)then
	pUnit:FullCastSpell(SPELL_BONE_SPIKE_GRAVEYARD)
	local saytext = math.random(1,3)
	if(saytext == 1)then
		pUnit:SendChatMessage(14, 0, "Bound by bone!")
		pUnit:PlaySoundToSet(16947)
	elseif(saytext == 2)then
		pUnit:SendChatMessage(14, 0, "Stick Around!")
		pUnit:PlaySoundToSet(16948)
	elseif(saytext == 3)then
		pUnit:SendChatMessage(14, 0, "The only escape is death!")
		pUnit:PlaySoundToSet(16949)
	end
	vars.bonespike = 15
elseif(vars.boneslice <= 0)then
	pUnit:CastSpellOnTarget(SPELL_BONE_SLICE, pUnit:GetMainTank())
	vars.boneslice = 10
elseif(vars.coldflame <= 0)then
	pUnit:FullCastSpell(SPELL_COLDFLAME_NORMAL)
	vars.coldflame = 5
elseif(vars.enrage <= 0)then
	pUnit:CastSpell(SPELL_BERSERK)
	pUnit:SendChatMessage(14, 0, "THE MASTER'S RAGE COURSES THROUGH ME!")
	pUnit:PlaySoundToSet(16945)
	vars.enrage = 600
end
if(pUnit:HasAura(SPELL_BONE_STORM) and pUnit:GetAuraObjectById(SPELL_BONE_STORM):GetDuration() > 0 and pUnit:GetAuraObjectById(SPELL_BONE_STORM):GetDuration() < 500)then
	pUnit:ClearThreatList()
	vars.flame1 = vars.flame1 - 1
	vars.damagest = vars.damagest - 1
	if(pUnit:IsRooted())then
		pUnit:Unroot()
	end
	if(vars.damagest <= 0)then
		pUnit:CastSpell(SPELL_BONESTORM_DAMAGE[vars.diff+1])
		vars.damagest = 2
	end
	if(vars.flame1 <= 0)then
		local plr = pUnit:GetRandomPlayer(0)
		if(plr)then
			pUnit:MoveTo(plr:GetX(),plr:GetY(),plr:GetZ(),plr:GetO())
		end
		pUnit:CastSpell(SPELL_COLDFLAME_BONE_STORM)
	end
elseif(pUnit:HasAura(SPELL_BONE_STORM) and pUnit:GetAuraObjectById(SPELL_BONE_STORM):GetDuration() < 500)then
	pUnit:RemoveAura(SPELL_BONE_STORM)
	if(pUnit:IsRooted())then
		pUnit:Unroot()
	end
end
end

function BossOnKillPlr(pUnit, Event)
local chance = math.random(1,2)
if(chance == 1) then
	pUnit:SendChatMessage(14, 0, "More bones for the offering!")
	pUnit:PlaySoundToSet(16942)
else
	pUnit:PlaySoundToSet(16943)
	pUnit:SendChatMessage(14, 0, "Languish in damnation!")
end
end
 
function BossOnDeath(pUnit, Event)
pUnit:PlaySoundToSet(16944)
pUnit:SendChatMessage(12, 0, "I see... only darkness...")
for k,v in pairs(pUnit:GetInRangeObjects())do
	if(v:GetEntry() == GO_MARROWGAR_ENTRANCE)then
		v:Activate()
	end
	for i = 1, #GO_DATA do
		if(v:GetEntry() == GO_DATA[i])then
			v:Activate()
		end
	end
end
pUnit:RemoveEvents()
pUnit:RemoveAIUpdateEvent()
end
 
function BossOnLeaveCombat(pUnit, Event)
for k,v in pairs(pUnit:GetInRangeObjects())do
	if(v:GetEntry() == GO_MARROWGAR_ENTRANCE)then
		v:Activate()
	end
end
pUnit:RemoveEvents()
pUnit:RemoveAIUpdateEvent()
pUnit:RemoveAllAuras()
end

function BoneSpikeCast(spellIndex, pSpell)
local caster = pSpell:GetCaster()
if(caster:GetDungeonDifficulty() == 0 or caster:GetDungeonDifficulty() == 2)then
	local plr = caster:GetRandomPlayer(0)
	if(plr and not plr:IsFriendly())then
		plr:CastSpell(69062)
	end
else
	local targetnum = 3
	if(caster:GetInRangePlayersCount() >= 3)then
		local targetlist = {}
		repeat
		local plr = caster:GetRandomPlayer(0)
			for i = 1, #targetlist do
				if not(targetlist[i])then
					targetlist[i] = plr
				end
			end
		until targetnum == 0
		if(targetnum == 0)then
			for i = 1, #targetlist do
				if(targetlist[i])then
					targetlist[i]:CastSpell(69062)
				end
			end
		end
	else
		for k,v in pairs(caster:GetInRangePlayers())do
			v:CastSpell(69062)
		end
	end
end
end
 
RegisterUnitEvent(BOSS_MARROWGAR, 1,BossOnCombat)
RegisterUnitEvent(BOSS_MARROWGAR, 2,BossOnLeaveCombat)
RegisterUnitEvent(BOSS_MARROWGAR, 3,BossOnKillPlr)
RegisterUnitEvent(BOSS_MARROWGAR, 4,BossOnDeath)
RegisterUnitEvent(BOSS_MARROWGAR, 18,BossOnLoad)
RegisterUnitEvent(BOSS_MARROWGAR,21,BossAI)
RegisterDummySpell(SPELL_BONE_SPIKE_GRAVEYARD, BoneSpikeCast)
