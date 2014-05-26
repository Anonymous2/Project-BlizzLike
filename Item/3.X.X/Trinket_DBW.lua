 --[[
DK: Str, Haste, Crit
Druid: Str, Agi, ArP
Hunter: Agi, Crit, AP
Paladin: Str, Haste, Crit
Rogue: Agi, ArP, AP
Shaman: Agi, ArP, AP
Warrior: Str, Crit, ArP

 DELETE FROM `spell_proc` WHERE `spellID` IN(71519,71562);
 INSERT INTO `spell_proc` (`spellID`,`ProcOnNameHash`,`ProcFlag`,`TargetSelf`,`ProcChance`,`ProcCharges`,`ProcInterval`,`EffectTriggerSpell[0]`,`EffectTriggerSpell[1]`,`EffectTriggerSpell[2]`) VALUES
	(71519,0,0x8+0x40+0x100+0x1000+0x400000,0,10,-1,3000,-1,-1,-1),
	(71562,0,0x8+0x40+0x100+0x1000+0x400000,0,10,-1,3000,-1,-1,-1);
UPDATE `items` SET `spelltrigger_1`=3 WHERE `entry` IN(50363,50362);
 ]]--
local ITEM = {50362,50363}
local SPELL_DUMMY = {71519,71562}
local SPELL_HANDLING = {
{"Death Knight",71484,71561,71492,71560,71491,71559},
{"Druid",71485,71556,71487,71557,71484,71561},
{"Hunter",71485,71556,71491,71559,71486,71558},
{"Paladin",71491,71559,71492,71560,71484,71561},
{"Rogue",71485,71556,71487,71557,71486,71558},
{"Shaman",71485,71556,71487,71557,71486,71558},
{"Warrior",71484,71561,71487,71557,71491,71559}
}

function OnCast(spellIndex, pSpell)
local caster = pSpell:GetCaster()
if(caster:IsPlayer())then
	print("PLAYER")
else
	print("ITEM")
end
end

for i = 1,#SPELL_DUMMY do
RegisterDummySpell(SPELL_DUMMY[i],OnCast)
end
