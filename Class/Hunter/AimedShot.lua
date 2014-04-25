-- Aimed Shot fix by Mathix of ac-web.org
 -- Script correction by darkangel39

local spell = {49050,49049,27065,20904,20903,20902,20901,20900,19434}

function AimedShotFix(event, plr, spellid)
for i = 1,#spell do
	if(spellid == spell[i])then
		local aimedtarget = plr:GetSelection()
		if(aimedtarget and plr:IsHostile(aimedtarget))then
			plr:CastSpellOnTarget(spell[i],aimedtarget)
		end
	end
end
end

RegisterServerHook(10, "AimedShotFix")
