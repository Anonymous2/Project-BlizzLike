    -- Festergut
local SPELL_INHALE_BLIGHT		= 69165
local SPELL_PUNGENT_BLIGHT		= {69195,71219,73031,73032}
local SPELL_GASTRIC_BLOAT		= {72219,72551,72552,72553} -- 72214 is the proper way (with proc) but atm procs can't have cooldown for creatures
local SPELL_GASTRIC_EXPLOSION	= 72227
local SPELL_GAS_SPORE			= {69278,71221,69278,71221}
local SPELL_VILE_GAS			= {69240,71218,73019,73020}
local SPELL_INOCULATED			= {69291,72101,72102,72103}

    -- Stinky
local SPELL_MORTAL_WOUND		= 71127
local SPELL_DECIMATE			= 71123
local SPELL_PLAGUE_STENCH		= 71805

local SPELL_BLIGHT				= {69157,69162,69164}
local SPELL_BLIGHT_VISUAL		= {69154,69152,69126}

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
	if(vars.inhalecount == 3)then
		pUnit:SendChatMessage(14, 0, "Gyah! Uhhh, I not feel so good...")
		pUnit:SendChatMessage(42, 0, "Festergut begins to cast |cFFFF7F00Pungent Blight!|r")
		pUnit:PlaySoundToSet(16906)
		pUnit:FullCastSpell(SPELL_PUNGENT_BLIGHT[vars.diff + 1])
		vars.inhalecount = 0
		vars.spore = math.random(20,25)
	elseif(vars.inhalecount < 3)then
		pUnit:FullCastSpell(SPELL_INHALE_BLIGHT)
		vars.inhalecount = vars.inhalecount + 1
		pUnit:FullCastSpell(SPELL_BLIGHT[vars.inhalecount])
	end
	vars.inhale = math.random(25,30)
elseif(vars.spore <= 0)then
	local targ = 2
	if(vars.diff == 1 or vars.diff == 3)then
		targ = 3
	end
	repeat
		local pplayer = pUnit:GetRandomPlayer(0)
		if(pplayer)then
			if(pplayer:HasAura())then
			end
		else
			return
		end
	until targ = 0
	vars.spore = math.random(40,45)
	vars.gass = math.random(28,35)
elseif(vars.bloat <= 0)then
	pUnit:FullCastSpell(SPELL_GASTRIC_BLOAT[vars.diff + 1])
	vars.bloat = math.random(15,18)
elseif(vars.gass <= 0)then
	vars.gass = 8999
elseif(vars.enrage <= 0)then
	
end
end

