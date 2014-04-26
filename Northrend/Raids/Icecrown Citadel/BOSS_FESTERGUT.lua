    -- Festergut
local SPELL_INHALE_BLIGHT		= 69165
local SPELL_PUNGENT_BLIGHT		= {69195,71219,73031,73032}
local SPELL_GASTRIC_BLOAT		= {72219,72551,72552,72553} -- 72214 is the proper way (with proc) but atm procs can't have cooldown for creatures
local SPELL_GASTRIC_EXPLOSION	= 72227
local SPELL_GAS_SPORE			= {69278,71221,69278,71221}
local SPELL_VILE_GAS			= {69240,71218,73019,73020}
local SPELL_INOCULATED			= {69291,72101,72102,72103}
local SPELL_ENRAGE				= 47008
    -- Stinky
local SPELL_MORTAL_WOUND		= 71127
local SPELL_DECIMATE			= 71123
local SPELL_PLAGUE_STENCH		= 71805

local SPELL_BLIGHT				= {69157,69162,69164}
local SPELL_BLIGHT_VISUAL		= {69154,69152,69126}

local BOSS_FESTERGUT			= 36626
local BOSS_PROF					= 36678

local GO_FESTER_DOOR			= 201613

local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B

function BossOnCombat(pUnit, event)
self[tostring(pUnit)] = {
inhale = math.random(25,30),
spore = math.random(20,25),
bloat = math.random(13,15),
inoculatedstack = 0,
inhalecount = 0,
gass = 8999,
enrage = 300,
diff = pUnit:GetDungeonDifficulty(),
state = 0
}
pUnit:SendChatMessage(14, 0, "Fun time!")
pUnit:PlaySoundToSet(16901)
pUnit:RegisterAIUpdateEvent(1000)
for k,v in pairs(pUnit:GetInRangeObjects())do
	if(v:GetEntry() == GO_FESTER_DOOR and v:GetByte(GAMEOBJECT_BYTES_1,0) ~= 1)then
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
vars.inhale = vars.inhale - 1
vars.spore = vars.spore - 1
vars.bloat = vars.bloat - 1
vars.enrage = vars.enrage - 1
vars.gass = vars.gass - 1
if(vars.inhale <= 0)then
	if(vars.inhalecount == 0)then
		pUnit:SendChatMessage(14, 0, "Gyah! Uhhh, I not feel so good...")
		pUnit:SendChatMessage(42, 0, "Festergut begins to cast |cFFFF7F00Pungent Blight!|r")
		pUnit:PlaySoundToSet(16906)
		pUnit:FullCastSpell(SPELL_PUNGENT_BLIGHT[vars.diff + 1])
		if(pUnit:HasAura(SPELL_INHALE_BLIGHT))then
			pUnit:RemoveAura(SPELL_INHALE_BLIGHT)
		end
		vars.inhalecount = 3
		vars.spore = math.random(20,25)
	elseif(vars.inhalecount > 0)then
		if(pUnit:HasAura(SPELL_BLIGHT[vars.inhalecount]))then
			pUnit:RemoveAura(SPELL_BLIGHT[vars.inhalecount])
		end
		vars.inhalecount = vars.inhalecount + 1
		pUnit:CastSpell(SPELL_BLIGHT[vars.inhalecount])
		pUnit:FullCastSpell(SPELL_INHALE_BLIGHT)
	end
	vars.inhale = math.random(25,30)
elseif(vars.spore <= 0)then
	local targ = 1
	if((vars.diff == 1 or vars.diff == 3) and pUnit:GetInRangePlayersCount() >= 3)then
		targ = 3
	elseif((vars.diff == 0 or vars.diff == 2) and pUnit:GetInRangePlayersCount() >= 2)then
		targ = 2
	end
	if(targ > 1)then
		repeat
		local pplayer = pUnit:GetRandomPlayer(0)
		if(pplayer)then
			if not(pplayer:HasAura(SPELL_GAS_SPORE[vars.diff+1]))then
				pUnit:CastSpellOnTarget(SPELL_GAS_SPORE[vars.diff+1],pplayer)
				targ = targ - 1
			end
		else
			return
		end
		until targ = 0
	end
	vars.spore = math.random(40,45)
	vars.gass = math.random(28,35)
elseif(vars.bloat <= 0)then
	pUnit:FullCastSpellOnTarget(SPELL_GASTRIC_BLOAT[vars.diff + 1],pUnit:GetMainTank())
	vars.bloat = math.random(15,18)
elseif(vars.gass <= 0)then
	pUnit:FullCastSpellOnTarget(SPELL_VILE_GAS[vars.diff + 1],pUnit:GetRandomPlayer())
	vars.gass = 8999
elseif(vars.enrage <= 0)then
	pUnit:CastSpell(SPELL_ENRAGE)
end
end

function BossOnKillPlr(pUnit, event, pDied)
local chance = math.random(1, 2)
if(chance == 1 and pDied:IsPlayer())then
	pUnit:SendChatMessage(14, 0, "Daddy, I did it!")
	pUnit:PlaySoundToSet(16902)
elseif(chance == 1 and pDied:IsPlayer())then
	pUnit:SendChatMessage(14, 0, "Dead, dead, dead!")
	pUnit:PlaySoundToSet(16903)
end
end
		
function BossOnDeath(pUnit, event)
pUnit:RemoveEvents()
pUnit:RemoveAllAuras()
pUnit:SendChatMessage(14, 0, "Da ... Ddy...")
pUnit:PlaySoundToSet(16904)
pUnit:RemoveAIUpdateEvent()
for k,v in pairs(pUnit:GetInRangeObjects())do
	if(v:GetEntry() == GO_FESTER_DOOR and v:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
		v:Activate()
	end
end
for k,l in pairs(pUnit:GetInRangeUnits())do
	if(l:GetEntry() == BOSS_PROF)then
		l:SendChatMessage(14, 0, "Oh, Festergut. You were always my favorite. Next to Rotface. The good news is you left behind so much gas, I can practically taste it!")
		l:PlaySoundToSet(17124)
	end
end
end

function BossOnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
pUnit:RemoveAllAuras()
pUnit:RemoveAIUpdateEvent()
for k,v in pairs(pUnit:GetInRangeObjects())do
	if(v:GetEntry() == GO_FESTER_DOOR and v:GetByte(GAMEOBJECT_BYTES_1,0) ~= 0)then
		v:Activate()
	end
end
end

RegisterUnitEvent(BOSS_FESTERGUT,1,BossOnCombat)
RegisterUnitEvent(BOSS_FESTERGUT,2,BossOnLeaveCombat)
RegisterUnitEvent(BOSS_FESTERGUT,3,BossOnKillPlr)
RegisterUnitEvent(BOSS_FESTERGUT,4,BossOnDeath)
RegisterUnitEvent(BOSS_FESTERGUT,21,BossAI)
