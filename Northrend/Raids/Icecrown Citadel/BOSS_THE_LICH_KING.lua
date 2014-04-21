local self = getfenv(1)

     --  The Lich King
local SPELL_PLAGUE_AVOIDANCE				= 72846     --  raging spirits also get it
local SPELL_EMOTE_SIT_NO_SHEATH				= 73220
local SPELL_BOSS_HITTIN_YA					= 73878
local SPELL_EMOTE_SHOUT_NO_SHEATH			= 73213
local SPELL_ICE_LOCK						= 71614

     --  Phase 1
local SPELL_SUMMON_SHAMBLING_HORROR			= 70372
local SPELL_RISEN_WITCH_DOCTOR_SPAWN		= 69639
local SPELL_SUMMON_DRUDGE_GHOULS			= 70358
local SPELL_INFEST							= 70541
local SPELL_NECROTIC_PLAGUE					= {70337, 73912, 73913, 73914}
local SPELL_NECROTIC_PLAGUE_JUMP			= {70338, 73785, 73786, 73787}
local SPELL_PLAGUE_SIPHON					= 74074
local SPELL_SHADOW_TRAP						= 73539
local SPELL_SHADOW_TRAP_AURA				= 73525
local SPELL_SHADOW_TRAP_KNOCKBACK			= 73529

     --  Phase Transition
local SPELL_REMORSELESS_WINTER_1			= {68981, 74270, 74271, 74272}
local SPELL_REMORSELESS_WINTER_2			= {72259, 74273, 74274, 74275}
local SPELL_PAIN_AND_SUFFERING				= 72133
local SPELL_SUMMON_ICE_SPHERE				= 69104
local SPELL_ICE_SPHERE						= 69090
local SPELL_ICE_BURST_TARGET_SEARCH			= 69109
local SPELL_ICE_PULSE						= 69091
local SPELL_ICE_BURST						= 69108
local SPELL_RAGING_SPIRIT					= 69200
local SPELL_RAGING_SPIRIT_VISUAL			= 69197
local SPELL_RAGING_SPIRIT_VISUAL_CLONE		= 69198
local SPELL_SOUL_SHRIEK						= 69242
local SPELL_QUAKE							= 72262

     --  Phase 2
local SPELL_DEFILE							= 72762
local SPELL_DEFILE_AURA						= 72743
local SPELL_DEFILE_GROW						= 72756
local SPELL_SUMMON_VALKYR					= {69037, 74361, 69037, 74361}
local SPELL_HARVEST_SOUL_VALKYR				= 68985     --  Val'kyr Shadowguard vehicle aura
local SPELL_SOUL_REAPER						= 69409
local SPELL_SOUL_REAPER_BUFF				= 69410
local SPELL_WINGS_OF_THE_DAMNED				= 74352
local SPELL_VALKYR_TARGET_SEARCH			= 69030
local SPELL_CHARGE							= 74399     --  cast on selected target
local SPELL_VALKYR_CARRY					= 74445     --  removes unselectable flag
local SPELL_LIFE_SIPHON						= 73488
local SPELL_LIFE_SIPHON_HEAL				= 73489
local SPELL_EJECT_ALL_PASSENGERS			= 68576

     --  Phase 3
local SPELL_VILE_SPIRITS					= 70498
local SPELL_VILE_SPIRIT_MOVE_SEARCH			= 70501
local SPELL_VILE_SPIRIT_DAMAGE_SEARCH		= 70502
local SPELL_SPIRIT_BURST					= 70503
local SPELL_HARVEST_SOUL					= {68980, 74325, 74296, 74297}
local SPELL_HARVEST_SOULS					= 73654     --  Heroic version weird because it has all 4 difficulties just like above spell
local SPELL_HARVEST_SOUL_VEHICLE			= 68984
local SPELL_HARVEST_SOUL_VISUAL				= 71372
local SPELL_HARVEST_SOUL_TELEPORT			= 72546
local SPELL_HARVEST_SOULS_TELEPORT			= 73655
local SPELL_HARVEST_SOUL_TELEPORT_BACK		= 72597
local SPELL_IN_FROSTMOURNE_ROOM				= 74276
local SPELL_KILL_FROSTMOURNE_PLAYERS		= 75127
local SPELL_HARVESTED_SOUL					= 72679
local SPELL_TRIGGER_VILE_SPIRIT_HEROIC		= 73582     -- / @todo Cast every 3 seconds during Frostmourne phase targets a Wicked Spirit amd activates it

     --  Frostmourne
local SPELL_LIGHTS_FAVOR					= 69382
local SPELL_RESTORE_SOUL					= 72595
local SPELL_RESTORE_SOULS					= 73650     --  Heroic
local SPELL_DARK_HUNGER						= 69383     --  Passive proc healing
local SPELL_DARK_HUNGER_HEAL				= 69384
local SPELL_DESTROY_SOUL					= 74086     --  Used when Terenas Menethil dies
local SPELL_SOUL_RIP						= 69397     --  Deals increasing damage
local SPELL_SOUL_RIP_DAMAGE					= 69398
local SPELL_TERENAS_LOSES_INSIDE			= 72572
local SPELL_SUMMON_SPIRIT_BOMB_1			= 73581     --  (Heroic)
local SPELL_SUMMON_SPIRIT_BOMB_2			= 74299     --  (Heroic)
local SPELL_EXPLOSION						= 73576     --  Spirit Bomb (Heroic)
local SPELL_HARVEST_SOUL_DAMAGE_AURA		= 73655

     --  Outro
local SPELL_FURY_OF_FROSTMOURNE				= 72350
local SPELL_FURY_OF_FROSTMOURNE_NO_REZ		= 72351
local SPELL_EMOTE_QUESTION_NO_SHEATH		= 73330
local SPELL_RAISE_DEAD						= 71769
local SPELL_LIGHTS_BLESSING					= 71797
local SPELL_JUMP							= 71809
local SPELL_JUMP_TRIGGERED					= 71811
local SPELL_JUMP_2							= 72431
local SPELL_SUMMON_BROKEN_FROSTMOURNE		= 74081     --  visual
local SPELL_SUMMON_BROKEN_FROSTMOURNE_2		= 72406     --  animation
local SPELL_SUMMON_BROKEN_FROSTMOURNE_3		= 73017     --  real summon
local SPELL_BROKEN_FROSTMOURNE				= 72398
local SPELL_BROKEN_FROSTMOURNE_KNOCK		= 72405
local SPELL_SOUL_BARRAGE					= 72305
local SPELL_SUMMON_TERENAS					= 72420
local SPELL_MASS_RESURRECTION				= 72429
local SPELL_MASS_RESURRECTION_REAL			= 72423
local SPELL_PLAY_MOVIE						= 73159

     --  Shambling Horror
local SPELL_SHOCKWAVE						= 72149
local SPELL_ENRAGE							= 72143
local SPELL_FRENZY							= 28747

local BOSS_LK		= 36597
local NPC_TIRION	= 38995
local NPC_TERANAS	= {36823,38579,39217}
local NPC_HORROR	= 37698
local NPC_SPIRIT	= 36701
local NPC_VALKUR	= 36609
local NPC_STR_VEH	= 36598
local NPC_WARDEN	= 36824
local NPC_BOMB		= 39189
local NPC_FROSM		= 38584
--[[

Position const CenterPosition     = {503.6282f, -2124.655f, 840.8569f, 0.0f};
Position const TirionIntro        = {489.2970f, -2124.840f, 840.8569f, 0.0f};
Position const TirionCharge       = {482.9019f, -2124.479f, 840.8570f, 0.0f};
Position const LichKingIntro[3]   =
{
    {432.0851f, -2123.673f, 864.6582f, 0.0f},
    {457.8351f, -2123.423f, 841.1582f, 0.0f},
    {465.0730f, -2123.470f, 840.8569f, 0.0f},
};
Position const OutroPosition1     = {493.6286f, -2124.569f, 840.8569f, 0.0f};
Position const OutroFlying        = {508.9897f, -2124.561f, 845.3565f, 0.0f};
Position const TerenasSpawn       = {495.5542f, -2517.012f, 1050.000f, 4.6993f};
Position const TerenasSpawnHeroic = {495.7080f, -2523.760f, 1050.000f, 0.0f};
Position const SpiritWardenSpawn  = {495.3406f, -2529.983f, 1050.000f, 1.5592f};

]]--

function OnLoad(pUnit)
pUnit:CastSpell(SPELL_EMOTE_SIT_NO_SHEATH)
end

function OnGossip(pUnit, event, pPlayer)
pUnit:GossipCreateMenu(15290, pPlayer, 0)
local LK = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),BOSS_LK)
if(LK and LK:HasAura(SPELL_EMOTE_SIT_NO_SHEATH))then
	pUnit:GossipMenuAddItem(0, "We are prepared, Highlord. Let us battle for the fate of Azeroth! For the light of dawn!", 1, 0)
end
pUnit:GossipSendMenu(pPlayer)
end

function OnGossipSelect(pUnit, event, pPlayer, id, intid, code)
local LK = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),BOSS_LK)
if(intid == 1 and LK)then
	self[tostring(pUnit)] = {
	event = 0
	}
	if(LK:HasAura(SPELL_EMOTE_SIT_NO_SHEATH))then
		pUnit:RegisterAIUpdateEvent(1000)
		pPlayer:GossipComplete()
		LK:RemoveAura(SPELL_EMOTE_SIT_NO_SHEATH)
		LK:SetMovementFlags(0) 
	end
end
end

function TirionAI(pUnit)
local LK = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),BOSS_LK)
local vars = self[tostring(pUnit)]
if(LK)then
	vars.event = vars.event + 1
	if(vars.event == 3)then
		LK:MoveTo(432.0851,-2123.673,864.6582,0.0)
		LK:SendChatMessage(14, 0, "So the Light's vaunted justice has finally arrived? Shall I lay down Frostmourne and throw myself at your mercy, Fordring?")
		LK:PlaySoundToSet(17349)
	elseif(vars.event == 5)then
		LK:MoveTo(457.8351,-2123.423,841.1582,0.0)
	elseif(vars.event == 6)then
		LK:MoveTo(465.0730,-2123.470,840.8569,0.0)
	end
end
end

function BossCombat(pUnit)
pUnit:SendChatMessage(14, 0, "Come then champions, feed me your rage!")
self[tostring(pUnit)] = {
 -- phase 1
horror = 20,
ghoul = 10,
infest = 5,
necrotic = math.random(30,33),
strap = 16,
 -- all
berserk = 900,
transition = 60,
phase = 1
}
end
