BigDebuffs = LibStub("AceAddon-3.0"):NewAddon("BigDebuffs", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local Masque = LibStub("Masque", true)

local defaults = {
	profile = {
		unitFrames = {
			enabled = true,
			cooldownCount = true,
			tooltips = false,
			player = {
				enabled = true,
				anchor = "auto",
				size = 50,
				cdMod = 9,
                cc = true,
                interrupts = false,
                immunities = false,
                immunities_spells = false,
                buffs_defensive = false,
                buffs_offensive = false,
                buffs_other = false,
                roots = true,
			},
			focus = {
				enabled = true,
				anchor = "auto",
				size = 50,
				cdMod = 9,
                cc = true,
                interrupts = true,
                immunities = true,
                immunities_spells = true,
                buffs_defensive = true,
                buffs_offensive = true,
                buffs_other = true,
                roots = true,
			},
			target = {
				enabled = true,
				anchor = "auto",
				size = 50,
				cdMod = 9,
                cc = true,
                interrupts = true,
                immunities = true,
                immunities_spells = true,
                buffs_defensive = true,
                buffs_offensive = true,
                buffs_other = true,
                roots = true,
			},
			pet = {
				enabled = true,
				anchor = "auto",
				size = 50,
				cdMod = 9,
                cc = true,
                interrupts = true,
                immunities = true,
                immunities_spells = true,
                buffs_defensive = true,
                buffs_offensive = true,
                buffs_other = true,
                roots = true,
			},
			party = {
				enabled = true,
				anchor = "auto",
				size = 50,
				cdMod = 9,
                cc = true,
                interrupts = true,
                immunities = true,
                immunities_spells = true,
                buffs_defensive = true,
                buffs_offensive = true,
                buffs_other = true,
                roots = true,
			},
			arena = {
				enabled = true,
				anchor = "auto",
				size = 50,
				cdMod = 9,
                cc = true,
                interrupts = true,
                immunities = true,
                immunities_spells = true,
                buffs_defensive = true,
                buffs_offensive = true,
                buffs_other = true,
                roots = true,
			},

		},
		priority = {
			immunities = 90,
			immunities_spells = 80,
			cc = 70,
			interrupts = 60,
			buffs_defensive = 50,
			buffs_offensive = 40,
			buffs_other = 30,
			roots = 20,
		},
		spells = {},
	}
}

local T = {}
for _, k in ipairs({ "cc", "roots", "immunities", "immunities_spells", "buffs_defensive", "buffs_offensive", "buffs_other" }) do
	T[k] = { type = k }
end

BigDebuffs.Spells = {

	[48792] = T.buffs_defensive,
	[50461] = T.buffs_defensive,
	[47484] = T.buffs_defensive,
	[49028] = T.buffs_offensive,
	[47476] = T.cc,
	[47481] = T.cc,
	[49203] = T.cc,
	[48707] = T.immunities_spells,
	[49039] = T.immunities_spells,
	[47528] = { type = "interrupts", duration = 4, },

	[22842] = T.buffs_defensive,
	[17116] = T.buffs_defensive,
	[61336] = T.buffs_defensive,
	[22812] = T.buffs_defensive,
	[29166] = T.buffs_offensive,
	[50334] = T.buffs_offensive,
	[69369] = T.buffs_offensive,
	[53201] = T.buffs_offensive,
	[53312] = T.buffs_other,
	[33357] = T.buffs_other,
	[768] = T.buffs_other,
	[9634] = T.buffs_other,
	[783] = T.buffs_other,
	[24858] = T.buffs_other,
	[33891] = T.buffs_other,
	[49802] = T.cc,
	[8983] = T.cc,
	[18658] = T.cc,
		[2637] = T.cc,
		[18657] = T.cc,
	[49803] = T.cc,
	[33786] = T.immunities,
	[45334] = T.roots,
	[53308] = T.roots,
	[53313] = T.roots,
	[19675] = { type = "interrupts", duration = 4, },

	[3045] = T.buffs_offensive,
	[53480] = T.buffs_defensive,
	[5384] = T.buffs_defensive,
	[53271] = T.buffs_defensive,
	[53476] = T.buffs_defensive,
	[1742] = T.buffs_defensive,
	[26064] = T.buffs_defensive,
	[34471] = T.immunities,
	[19263] = T.immunities,
	[19574] = T.immunities,
	[3034] = T.buffs_other,
	[24394] = T.cc,
		[19577] = T.buffs_offensive,
	[49012] = T.cc,
	[19503] = T.cc,
	[14309] = T.cc,
	[60210] = T.cc,
	[14327] = T.cc,
	[53359] = T.cc,
	[53562] = T.cc,
	[53543] = T.cc,
	[34490] = T.cc,
	[48999] = T.roots,
	[19185] = T.roots,
		[64803] = T.roots,
		[64804] = T.roots,
	[53548] = T.roots,
	[4167] = T.roots,
	[26090] = { type = "interrupts", duration = 2, },

	[43039] = T.buffs_other,
	[12472] = T.buffs_offensive,
	[54748] = T.buffs_offensive,
	[12042] = T.buffs_offensive,
	[12043] = T.buffs_offensive,
	[12051] = T.buffs_offensive,
	[44544] = T.buffs_offensive,
	[66] = T.buffs_offensive,
	[118] = T.cc,
		[12826] = T.cc,
		[71319] = T.cc,
		[28271] = T.cc,
		[28272] = T.cc,
		[61305] = T.cc,
		[61721] = T.cc,
	[42950] = T.cc,
	[44572] = T.cc,
	[12355] = T.cc,
	[55021] = T.cc,
	[64346] = T.cc,
	[45438] = T.immunities,
	[12494] = T.roots,
	[122] = T.roots,
	[2139] = { type = "interrupts", duration = 6, },

	[54428] = T.buffs_other,
	[58597] = T.buffs_other,
	[59578] = T.buffs_other,
	[10278] = T.buffs_defensive,
		[5599] = T.buffs_defensive,
		[1022] = T.buffs_defensive,
	[31852] = T.buffs_defensive,
	[31821] = T.buffs_defensive,
	[498] = T.buffs_defensive,
	[6940] = T.buffs_defensive,
	[1044] = T.buffs_defensive,
	[64205] = T.buffs_defensive,
	[31884] = T.buffs_offensive,
	[20066] = T.cc,
	[10308] = T.cc,
	[63529] = T.cc,
	[10326] = T.cc,
	[48817] = T.cc,
	[20170] = T.cc,
	[642] = T.immunities,

	[47585] = T.buffs_defensive,
	[20711] = T.buffs_defensive,
	[47788] = T.buffs_defensive,
	[14751] = T.buffs_defensive,
	[33206] = T.buffs_defensive,
	[64843] = T.buffs_defensive,
	[64901] = T.buffs_defensive,
	[10060] = T.buffs_offensive,
	[6346] = T.buffs_other,
	[48066] = T.buffs_other,
	[64044] = T.cc,
	[64058] = T.cc,
	[10890] = T.cc,
	[15487] = T.cc,
	[605] = T.cc,
	[10955] = T.cc,

	[51713] = T.buffs_offensive,
	[13750] = T.buffs_offensive,
	[51690] = T.buffs_offensive,
	[14177] = T.buffs_offensive,
	[11305] = T.buffs_other,
	[26669] = T.buffs_defensive,
	[1776] = T.cc,
	[51722] = T.cc,
	[2094] = T.cc,
	[8643] = T.cc,
	[51724] = T.cc,
	[1330] = T.cc,
	[1833] = T.cc,
	[18425] = T.cc,
	[31224] = T.immunities_spells,
	[1766] = { type = "interrupts", duration = 5, },

	[16166] = T.buffs_offensive,
	[2825] = T.buffs_offensive,
	[32182] = T.buffs_offensive,
	[16191] = T.buffs_offensive,
	[30823] = T.buffs_defensive,
	[16188] = T.buffs_defensive,
	[58861] = T.cc,
	[51514] = T.cc,
	[39796] = T.cc,
	[8178] = T.immunities_spells,
	[63685] = T.roots,
	[64695] = T.roots,
	[58875] = T.buffs_other,
	[55277] = T.buffs_other,
	[57994] = { type = "interrupts", duration = 2, },

	[47241] = T.buffs_offensive,
	[18708] = T.buffs_other,
	[47986] = T.buffs_other,
	[60995] = T.cc,
	[47847] = T.cc,
		[30283] = T.cc,
	[31117] = T.cc,
	[18647] = T.cc,
	[47860] = T.cc,
	[6358] = T.cc,
	[6215] = T.cc,
	[17928] = T.cc,
	[24259] = T.cc,
	[47995] = T.cc,
	[19647] = { type = "interrupts", duration = 6, },

	[12975] = T.buffs_defensive,
	[55694] = T.buffs_defensive,
	[871] = T.buffs_defensive,
	[3411] = T.buffs_defensive,
	[2565] = T.buffs_defensive,
	[20230] = T.buffs_defensive,
	[60503] = T.buffs_offensive,
	[64849] = T.buffs_offensive,
	[65925] = T.buffs_offensive,
	[1719] = T.buffs_offensive,
	[12292] = T.buffs_offensive,
	[18499] = T.buffs_other,
	[2457] = T.buffs_other,
	[2458] = T.buffs_other,
	[71] = T.buffs_other,
	[12809] = T.cc,
	[12798] = T.cc,
	[676] = T.cc,
	[46968] = T.cc,
	[5246] = T.cc,
	[20511] = T.cc,
	[7922] = T.cc,
	[20253] = T.cc,
	[18498] = T.cc,
	[46924] = T.immunities,
	[23920] = T.immunities_spells,
	[6552] = { type = "interrupts", duration = 4, },
	[72] = { type = "interrupts", duration = 5, },

	[43183] = T.buffs_other,
		[57073] = T.buffs_other,
	[20549] = T.cc,
	[28730] = T.cc,
	[25046] = T.cc,
	[50613] = T.cc,
}

local units = {
	"player",
	"pet",
	"target",
	"focus",
	"party1",
	"party2",
	"party3",
	"party4",
	"arena1",
	"arena2",
	"arena3",
	"arena4",
	"arena5",
}

local unitType = {}
for i = 1, #units do
	unitType[units[i]] = (units[i]:gsub("%d", ""))
end

local UnitDebuff, UnitBuff, UnitGUID, GetTime, GetSpellInfo = UnitDebuff, UnitBuff, UnitGUID, GetTime, GetSpellInfo

local GetAnchor = {
	ShadowedUnitFrames = function(anchor)
		local frame = _G[anchor]
		if not frame then return end
		if frame.portrait and frame.portrait:IsShown() then
			return frame.portrait, frame
		else
			return frame, frame, true
		end
	end,
	ZPerl = function(anchor)
		local frame = _G[anchor]
		if not frame then return end
		if frame:IsShown() then
			return frame, frame
		else
			frame = frame:GetParent()
			return frame, frame, true
		end
	end,
}

local anchors = {
	["ElvUI"] = {
		noPortrait = true,
		units = {
			player = "ElvUF_Player",
			pet = "ElvUF_Pet",
			target = "ElvUF_Target",
			focus = "ElvUF_Focus",
			party1 = "ElvUF_PartyGroup1UnitButton1",
			party2 = "ElvUF_PartyGroup1UnitButton2",
			party3 = "ElvUF_PartyGroup1UnitButton3",
			party4 = "ElvUF_PartyGroup1UnitButton4",
		},
	},
	["bUnitFrames"] = {
		noPortrait = true,
		alignLeft = true,
		units = {
			player = "bplayerUnitFrame",
			pet = "bpetUnitFrame",
			target = "btargetUnitFrame",
			focus = "bfocusUnitFrame",
			arena1 = "barena1UnitFrame",
			arena2 = "barena2UnitFrame",
			arena3 = "barena3UnitFrame",
			arena4 = "barena4UnitFrame",
		},
	},
	["Shadowed Unit Frames"] = {
		func = GetAnchor.ShadowedUnitFrames,
		units = {
			player = "SUFUnitplayer",
			pet = "SUFUnitpet",
			target = "SUFUnittarget",
			focus = "SUFUnitfocus",
			party1 = "SUFHeaderpartyUnitButton1",
			party2 = "SUFHeaderpartyUnitButton2",
			party3 = "SUFHeaderpartyUnitButton3",
			party4 = "SUFHeaderpartyUnitButton4",
		},
	},
	["ZPerl"] = {
		func = GetAnchor.ZPerl,
		units = {
			player = "XPerl_PlayerportraitFrame",
			pet = "XPerl_Player_PetportraitFrame",
			target = "XPerl_TargetportraitFrame",
			focus = "XPerl_FocusportraitFrame",
			party1 = "XPerl_party1portraitFrame",
			party2 = "XPerl_party2portraitFrame",
			party3 = "XPerl_party3portraitFrame",
			party4 = "XPerl_party4portraitFrame",
		},
	},
	["Blizzard"] = {
		units = {
			player = "PlayerPortrait",
			pet = "PetPortrait",
			target = "TargetFramePortrait",
			focus = "FocusFramePortrait",
			party1 = "PartyMemberFrame1Portrait",
			party2 = "PartyMemberFrame2Portrait",
			party3 = "PartyMemberFrame3Portrait",
			party4 = "PartyMemberFrame4Portrait",
			arena1 = "ArenaEnemyFrame1ClassPortrait",
			arena2 = "ArenaEnemyFrame2ClassPortrait",
			arena3 = "ArenaEnemyFrame3ClassPortrait",
			arena4 = "ArenaEnemyFrame4ClassPortrait",
			arena5 = "ArenaEnemyFrame5ClassPortrait",
		},
	},
}

function BigDebuffs:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BigDebuffsDB", defaults, true)

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")
	self.frames = {}
	self.UnitFrames = {}
	self.interrupts = {}
	self.stances = {}
	self:SetupOptions()
end

local function HideFrame(frame)

	if frame.anchor and frame.blizzard and Adapt and Adapt.portraits[frame.anchor] then
		Adapt.portraits[frame.anchor].modelLayer:SetFrameStrata("LOW")
	end
	frame:Hide()
	frame.current = nil
	frame.cdStart, frame.cdDuration, frame.cdGuid = nil, nil, nil
	frame.auraFilter, frame.auraIndex, frame.spellId = nil, nil, nil
end

local function TooltipOnUpdate(self, elapsed)
	self.ttElapsed = (self.ttElapsed or 0) + elapsed
	if self.ttElapsed < 0.2 then return end
	self.ttElapsed = 0

	if self:IsMouseOver() and (self.auraFilter or self.spellId) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if self.auraFilter == "buff" then
			GameTooltip:SetUnitBuff(self.unit, self.auraIndex)
		elseif self.auraFilter == "debuff" then
			GameTooltip:SetUnitDebuff(self.unit, self.auraIndex)
		else
			GameTooltip:SetHyperlink("spell:" .. self.spellId)
		end
	elseif GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end

local unitTypes = { "player", "pet", "target", "focus", "party", "arena" }

function BigDebuffs:UpdateEvents()
	local uf = self.db.profile.unitFrames
	local any, kicks, stances = false, false, false
	if uf.enabled then
		for i = 1, #unitTypes do
			local cfg = uf[unitTypes[i]]
			if cfg and cfg.enabled then
				any = true
				if cfg.interrupts then kicks = true end
				if cfg.buffs_other then stances = true end
			end
		end
	end

	if any then
		self:RegisterEvent("UNIT_AURA")
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("PLAYER_FOCUS_CHANGED")
		self:RegisterEvent("UNIT_PET")
		self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	else
		self:UnregisterEvent("UNIT_AURA")
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
		self:UnregisterEvent("PLAYER_FOCUS_CHANGED")
		self:UnregisterEvent("UNIT_PET")
		self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	end

	if kicks or stances then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	else
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end

	if kicks then
		self:RegisterEvent("UNIT_SPELLCAST_FAILED")
	else
		self:UnregisterEvent("UNIT_SPELLCAST_FAILED")
	end
end

function BigDebuffs:Refresh()
	self:UpdateEvents()
	for unit, frame in pairs(self.UnitFrames) do
		HideFrame(frame)
		frame.cooldown.noCooldownCount = not self.db.profile.unitFrames.cooldownCount
		self:AttachUnitFrame(unit)
		self:UNIT_AURA(nil, unit)
	end
end

local unitsToUpdate = {}

function BigDebuffs:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	for unit in pairs(unitsToUpdate) do
		self:AttachUnitFrame(unit)
	end
	wipe(unitsToUpdate)
end

function BigDebuffs:AttachUnitFrame(unit)
	if InCombatLockdown() then
		unitsToUpdate[unit] = true
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	local frame = self.UnitFrames[unit]
	local frameName = "BigDebuffs" .. unit .. "UnitFrame"

	if not frame then
		frame = CreateFrame("Button", frameName, UIParent, "BigDebuffsUnitFrameTemplate")
		frame.icon = _G[frameName.."Icon"]
		frame.cooldownContainer = CreateFrame("Button", frameName.."CooldownContainer", frame)
		self.UnitFrames[unit] = frame
		frame.icon:SetDrawLayer("BORDER")
		frame.cooldownContainer:SetPoint("CENTER")
		frame.cooldown:SetParent(frame.cooldownContainer)
		frame.cooldown:SetAllPoints()
		frame.cooldown:SetAlpha(0.9)

		frame:RegisterForDrag("LeftButton")
		frame:SetMovable(true)
		frame.unit = unit

		if Masque then
			if not frame.masqueGroup then
				local group = Masque:Group("BigDebuffs", unit:gsub('%d',''))
				frame.masqueGroup = group
				frame.masqueGroup:AddButton(frame,
					{
						Cooldown = frame.cooldown,
						Gloss = frame.icon,
						Icon = frame.icon,
					},
				nil, true)
			end
		end
	end

	frame:EnableMouse(self.test)

	frame:SetScript("OnUpdate", self.db.profile.unitFrames.tooltips and TooltipOnUpdate or nil)

	_G[frameName.."Name"]:SetText(self.test and not frame.anchor and unit or "")

	frame.anchor = nil
	frame.blizzard = nil

	local config = self.db.profile.unitFrames[unitType[unit]]

	if config.anchor == "auto" then

		for k,v in pairs(anchors) do
			local anchor, parent, noPortrait
			if v.units[unit] then
				if v.func then
					anchor, parent, noPortrait = v.func(v.units[unit])
				else
					anchor = _G[v.units[unit]]
				end

				if anchor then
					frame.anchor, frame.parent, frame.noPortrait = anchor, parent, noPortrait
					if v.noPortrait then frame.noPortrait = true end
					frame.alignLeft = v.alignLeft
					frame.blizzard = k == "Blizzard"
					if not frame.blizzard then break end
				end
			end
		end
	end

	if frame.anchor then
		if frame.blizzard then

			frame:SetParent(frame.anchor:GetParent())
			frame:SetFrameLevel(frame.anchor:GetParent():GetFrameLevel())
			frame.cooldownContainer:SetFrameLevel(frame.anchor:GetParent():GetFrameLevel()-1)
			frame.cooldownContainer:SetSize(frame.anchor:GetWidth() - config.cdMod, frame.anchor:GetHeight() - config.cdMod)
			frame.anchor:SetDrawLayer("BACKGROUND")
		else
			frame:SetParent(frame.parent and frame.parent or frame.anchor)
			frame:SetFrameLevel(99)
			frame.cooldownContainer:SetSize(frame.anchor:GetWidth(), frame.anchor:GetHeight())
		end

		frame:ClearAllPoints()

		if frame.noPortrait then

			if frame.alignLeft then
				frame:SetPoint("TOPRIGHT", frame.anchor, "TOPLEFT")
			else
				frame:SetPoint("TOPLEFT", frame.anchor, "TOPRIGHT")
			end
			local height = frame.anchor:GetHeight()
			frame:SetSize(height, height)
		else
			frame:SetAllPoints(frame.anchor)
		end
		if Masque then
			frame.masqueGroup:ReSkin()
		end
	else

		frame:SetParent(UIParent)
		frame:ClearAllPoints()

		frame:SetFrameLevel(frame:GetParent():GetFrameLevel()+1)
		frame.cooldownContainer:SetFrameLevel(frame:GetParent():GetFrameLevel())

		if not self.db.profile.unitFrames[unit] then self.db.profile.unitFrames[unit] = {} end

		if self.db.profile.unitFrames[unit].position then
			frame:SetPoint(unpack(self.db.profile.unitFrames[unit].position))
		else

			LoadAddOn("Blizzard_ArenaUI")
			local relativeFrame = _G[anchors.Blizzard.units[unit]] or UIParent
			frame:SetPoint("CENTER", relativeFrame, "CENTER")
		end

		frame:SetSize(config.size, config.size)

		frame.cooldownContainer:SetSize(config.size, config.size)
		if Masque then
			frame.masqueGroup:ReSkin()
		end
	end
end

function BigDebuffs:SaveUnitFramePosition(frame)
	self.db.profile.unitFrames[frame.unit].position = { frame:GetPoint() }
end

function BigDebuffs:Test()
	self.test = not self.test
	self:Refresh()
end

local TestDebuffs = {}

function BigDebuffs:InsertTestDebuff(spellID)
	local texture = select(3, GetSpellInfo(spellID))
	table.insert(TestDebuffs, {spellID, texture})
end

local function UnitDebuffTest(unit, index)
	local debuff = TestDebuffs[index]
	if not debuff then return end

	local duration = random(4, 50)

	return GetSpellInfo(debuff[1]), nil, debuff[2], 0, "Magic", duration, GetTime()+duration, nil, nil, nil, debuff[1]
end

function BigDebuffs:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:UpdateEvents()

	if OmniCC then
		self:RawHook(OmniCC, "TriggerEffect", function(object, cooldown)
			local name = cooldown:GetName()
			if name and name:find("BigDebuffs") then return end
			self.hooks[OmniCC].TriggerEffect(object, cooldown)
		end, true)
	end

	self:InsertTestDebuff(69369)
	self:InsertTestDebuff(8643)
	self:InsertTestDebuff(1766)
end

function BigDebuffs:PLAYER_ENTERING_WORLD()
	for i = 1, #units do
		self:AttachUnitFrame(units[i])
	end
	self.stances = {}
end

function BigDebuffs:GetAuraPriority(unit, name, id)
	local Spells = self.Spells
	if not unit or (not Spells[id] and not Spells[name]) then return end

	id = Spells[id] and id or name
	local spell = Spells[id]
	local profile = self.db.profile

	local cfg = profile.unitFrames[unitType[unit]]
	if not cfg or not cfg[spell.type] then return end

	local custom = profile.spells[id]
	if custom then
		if custom.unitFrames and custom.unitFrames == 0 then return end
		if custom.priority then return custom.priority end
	end

	if spell.nounitFrames and (not custom or not custom.unitFrames) then
		return
	end

	return profile.priority[spell.type] or 0
end

function BigDebuffs:GetUnitFromGUID(guid)
	for i = 1, #units do
		if UnitGUID(units[i]) == guid then
			return units[i]
		end
	end
	return nil
end

function BigDebuffs:UNIT_SPELLCAST_FAILED(_, unit)

	if not unitType[unit] then return end
	local guid = UnitGUID(unit)
	if not guid then return end
	local data = self.interrupts[guid]
	if data == nil then
		data = {}
		self.interrupts[guid] = data
		data.timer = self:ScheduleTimer(self.ClearInterruptGUID, 30, self, guid)
	end
	data.failed = GetTime()
end

function BigDebuffs:COMBAT_LOG_EVENT_UNFILTERED(_, _, subEvent, sourceGUID, _, _, destGUID, _, _, spellid)

	if subEvent ~= "SPELL_CAST_SUCCESS" and subEvent ~= "SPELL_INTERRUPT" then return end

	if subEvent == "SPELL_CAST_SUCCESS" and (spellid == 2457 or spellid == 2458 or spellid == 71) then
		self:UpdateStance(sourceGUID, spellid)
		return
	end

	local spelldata = self.Spells[spellid]
	if spelldata == nil or spelldata.type ~= "interrupts" then return end
	local duration = spelldata.duration
	if not duration then return end

	if subEvent == "SPELL_CAST_SUCCESS" then
		local data = self.interrupts[destGUID]
		if not (data and data.failed and GetTime() - data.failed < 0.01) then return end
	end

	self:UpdateInterrupt(nil, destGUID, spellid, duration)
end

function BigDebuffs:UpdateStance(guid, spellid)
	local s = self.stances[guid]
	if s == nil then
		s = {}
		self.stances[guid] = s
	else
		self:CancelTimer(s.timer, true)
	end

	s.stance = spellid
	s.timer = self:ScheduleTimer(self.ClearStanceGUID, 180, self, guid)

	local unit = self:GetUnitFromGUID(guid)
	if unit then
		self:UNIT_AURA(nil, unit)
	end
end

function BigDebuffs:ClearStanceGUID(guid)
	local unit = self:GetUnitFromGUID(guid)
	if unit == nil then
		self.stances[guid] = nil
	else

		local s = self.stances[guid]
		if s then
			s.timer = self:ScheduleTimer(self.ClearStanceGUID, 180, self, guid)
		end
	end
end

function BigDebuffs:UpdateInterrupt(unit, guid, spellid, duration)
	local t = GetTime()

	if spellid and duration ~= nil then
		local data = self.interrupts[guid]
		if data == nil then
			data = {}
			self.interrupts[guid] = data
		else
			self:CancelTimer(data.timer, true)
		end
		data.timer = self:ScheduleTimer(self.ClearInterruptGUID, 30, self, guid)
		data[spellid] = {started = t, duration = duration}

	elseif spellid and duration == nil then
		local data = self.interrupts[guid]
		local kick = data and data[spellid]
		if kick and t > kick.started + kick.duration then
			data[spellid] = nil
		end
	end

	unit = unit or self:GetUnitFromGUID(guid)

	if unit then
		self:UNIT_AURA(nil, unit)
	end

	if duration then
		self:ScheduleTimer(self.UpdateInterrupt, duration+0.1, self, unit, guid, spellid)
	end
end

function BigDebuffs:ClearInterruptGUID(guid)
	self.interrupts[guid] = nil
end

function BigDebuffs:GetInterruptFor(unit)
	local guid = UnitGUID(unit)

	local interrupts = guid and self.interrupts[guid]
	if interrupts == nil then return end

	local now = GetTime()
	local spellid, duration, endsAt

	for ispellid, intdata in pairs(interrupts) do
		if type(ispellid) == "number" then
			local tmpendsAt = intdata.started + intdata.duration
			if now > tmpendsAt then
				interrupts[ispellid] = nil
			elseif endsAt == nil or tmpendsAt > endsAt then
				endsAt = tmpendsAt
				duration = intdata.duration
				spellid = ispellid
			end
		end
	end

	if spellid then
		local name, _, icon = GetSpellInfo(spellid)
		return name, spellid, icon, duration, endsAt
	end
end

local function Wins(p, e, priority, expires)
	if p > priority then return true end
	return p == priority and expires and expires > 0 and e and e > expires
end

function BigDebuffs:UNIT_AURA(event, unit)

	local frame = unit and self.UnitFrames[unit]
	if not frame then return end

	local uf = self.db.profile.unitFrames
	local config = uf[unitType[unit]]
	if not uf.enabled or not config or not config.enabled then
		if frame:IsShown() then HideFrame(frame) end
		return
	end

	local Spells = self.Spells
	local Debuff = self.test and UnitDebuffTest or UnitDebuff

	local priority, duration, expires, icon, filter, index, spellId = 0

	for i = 1, 40 do

		local n, _, ico, _, _, d, e, _, _, _, id = Debuff(unit, i)
		if not n then break end
		if Spells[id] or Spells[n] then
			local p = self:GetAuraPriority(unit, n, id)
			if p and Wins(p, e, priority, expires) then
				priority, duration, expires, icon = p, d, e, ico
				filter, index, spellId = "debuff", i, id
			end
		end
	end

	for i = 1, 40 do

		local n, _, ico, _, _, d, e, _, _, _, id = UnitBuff(unit, i)
		if not n then break end
		if Spells[id] then
			local p = self:GetAuraPriority(unit, n, id)
			if p and Wins(p, e, priority, expires) then
				priority, duration, expires, icon = p, d, e, ico
				filter, index, spellId = "buff", i, id
			end
		end
	end

	local n, id, ico, d, e = self:GetInterruptFor(unit)
	if n then
		local p = self:GetAuraPriority(unit, n, id)
		if p and Wins(p, e, priority, expires) then
			priority, duration, expires, icon = p, d, e, ico
			filter, index, spellId = nil, nil, id
		end
	end

	local guid = UnitGUID(unit)
	local stance = guid and self.stances[guid]
	if stance then
		local stanceId = stance.stance
		if stanceId and Spells[stanceId] then
			local sn, _, sico = GetSpellInfo(stanceId)
			local p = self:GetAuraPriority(unit, sn, stanceId)
			if p and p >= priority then
				priority, duration, expires, icon = p, 0, 0, sico
				filter, index, spellId = nil, nil, stanceId
			end
		end
	end

	if not icon then
		if frame:IsShown() or frame.current then HideFrame(frame) end
		return
	end

	if self.test then filter, index = nil, nil end
	frame.auraFilter, frame.auraIndex, frame.spellId = filter, index, spellId

	if frame.current ~= icon then
		if frame.blizzard then

			SetPortraitToTexture(frame.icon, icon)

			if frame.anchor and Adapt and Adapt.portraits[frame.anchor] then
				Adapt.portraits[frame.anchor].modelLayer:SetFrameStrata("BACKGROUND")
			end
		else
			frame.icon:SetTexture(icon)
		end
		frame.current = icon
	end

	if duration and duration > 1 then
		local start = expires - duration
		if frame.cdStart ~= start or frame.cdDuration ~= duration or frame.cdGuid ~= guid then
			frame.cooldown:SetCooldown(start, duration)
			frame.cdStart, frame.cdDuration, frame.cdGuid = start, duration, guid
			frame.cooldownContainer:Show()
		end
	elseif frame.cdDuration ~= 0 then
		frame.cooldown:SetCooldown(0, 0)
		frame.cdStart, frame.cdDuration, frame.cdGuid = 0, 0, guid
		frame.cooldownContainer:Hide()
	end

	frame:Show()
end

function BigDebuffs:PLAYER_FOCUS_CHANGED()
	self:UNIT_AURA(nil, "focus")
end

function BigDebuffs:PLAYER_TARGET_CHANGED()
	self:UNIT_AURA(nil, "target")
end

function BigDebuffs:UNIT_PET()
	self:UNIT_AURA(nil, "pet")
end

function BigDebuffs:PARTY_MEMBERS_CHANGED()
	for i = 1, 4 do
		self:UNIT_AURA(nil, "party" .. i)
	end
end

SLASH_BigDebuffs1 = "/bd"
SLASH_BigDebuffs2 = "/bigdebuffs"
SlashCmdList.BigDebuffs = function(msg)
	LibStub("AceConfigDialog-3.0"):Open("BigDebuffs")
end
