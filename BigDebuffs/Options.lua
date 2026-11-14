local BigDebuffs = LibStub("AceAddon-3.0"):GetAddon("BigDebuffs")
local L = LibStub("AceLocale-3.0"):GetLocale("BigDebuffs")

local order = {
	immunities = 1,
	immunities_spells = 2,
	cc = 3,
	buffs_defensive = 4,
	buffs_offensive = 5,
	buffs_other = 6,
	roots = 7,
}

local spellKeyId = {}

local function SpellID(info)
	return spellKeyId[info[3]]
end

local function Custom(spellID, create)
	local spells = BigDebuffs.db.profile.spells
	if create and not spells[spellID] then spells[spellID] = {} end
	return spells[spellID]
end

local SpellNames = {}
local SpellIcons = {}

local function SpellName(info)
	local spellID = SpellID(info)
	local name = SpellNames[spellID] or GetSpellInfo(spellID) or spellID
	SpellNames[spellID] = name
	return name
end

local function SpellIcon(info)
	local spellID = SpellID(info)
	local icon = SpellIcons[spellID] or select(3, GetSpellInfo(spellID))
	SpellIcons[spellID] = icon
	return icon
end

local function SpellGet(info)
	local c = Custom(SpellID(info))
	return c and c[info[#info]]
end

local function SpellSet(info, value)
	Custom(SpellID(info), true)[info[#info]] = value
	BigDebuffs:Refresh()
end

local spellArgs = {
	visibility = {
		order = 1,
		type = "group",
		name = L["Visibility"],
		inline = true,
		get = function(info)
			local spellID, name = SpellID(info), info[#info]
			local c = Custom(spellID)
			local value = (c and c[name]) or (not BigDebuffs.Spells[spellID]["no"..name] and 1)
			return value and value == 1
		end,
		set = function(info, value)
			local spellID, name = SpellID(info), info[#info]
			local c = Custom(spellID, true)
			value = value and 1 or 0
			c[name] = value

			local no = BigDebuffs.Spells[spellID]["no"..name]
			if (value == 1 and not no) or (value == 0 and no) then
				c[name] = nil
			end
			BigDebuffs:Refresh()
		end,
		args = {
			unitFrames = {
				type = "toggle",
				name = L["Unit Frames"],
				desc = L["Show this spell on the unit frames"],
				width = "full",
				order = 2
			},
		},
	},
	priority = {
		type = "group",
		inline = true,
		name = L["Priority"],
		args = {
			customPriority = {
				name = L["Custom Priority"],
				type = "toggle",
				order = 2,
				set = function(info, value)
					local c = Custom(SpellID(info), true)
					c.customPriority = value
					if not value then
						c.priority = nil
					end
					BigDebuffs:Refresh()
				end,
			},
			priority = {
				name = L["Priority"],
				desc = L["Higher priority spells will take precedence regardless of duration"],
				type = "range",
				min = 1,
				max = 100,
				step = 1,
				order = 3,
				disabled = function(info)
					local c = Custom(SpellID(info))
					return not c or not c.customPriority
				end,
				get = function(info)

					local spellID = SpellID(info)
					local c = Custom(spellID)
					return c and c.priority or BigDebuffs.db.profile.priority[BigDebuffs.Spells[spellID].type]
				end,
			},
		},
	},
}

local function BuildSpells()
	local Spells = {}
	for spellID, spell in pairs(BigDebuffs.Spells) do
		if not spell.parent then
			Spells[spell.type] = Spells[spell.type] or {
				name = L[spell.type],
				type = "group",
				order = order[spell.type],
				args = {},
			}
			local key = "spell"..spellID
			spellKeyId[key] = spellID
			Spells[spell.type].args[key] = {
				type = "group",
				get = SpellGet,
				set = SpellSet,
				name = SpellName,
				icon = SpellIcon,
				args = spellArgs,
			}
		end
	end
	return Spells
end

local function UnitGet(info)
	return BigDebuffs.db.profile.unitFrames[info[2]][info[#info]]
end

local function UnitSet(info, value)
	BigDebuffs.db.profile.unitFrames[info[2]][info[#info]] = value
	BigDebuffs:Refresh()
end

local function UnitDisabled(info)
	local uf = BigDebuffs.db.profile.unitFrames
	return not uf.enabled or (info[3] and not uf[info[2]].enabled)
end

local function SpellToggle(key, desc, order)
	return { type = "toggle", width = "normal", name = L[key], desc = L[desc], order = order }
end

local unitSpellToggles = {
	order = 20,
	name = L["Spells"],
	type = "group",
	inline = true,
	args = {
		cc = SpellToggle("cc", "Show Crowd Control on the unit frames", 1),
		immunities = SpellToggle("immunities", "Show Immunities on the unit frames", 2),
		interrupts = SpellToggle("interrupts", "Show Interrupts on the unit frames", 3),
		immunities_spells = SpellToggle("immunities_spells", "Show Spell Immunities on the unit frames", 4),
		buffs_defensive = SpellToggle("buffs_defensive", "Show Defensive Buffs on the unit frames", 5),
		buffs_offensive = SpellToggle("buffs_offensive", "Show Offensive Buffs on the unit frames", 6),
		buffs_other = SpellToggle("buffs_other", "Show Other Buffs on the unit frames", 7),
		roots = SpellToggle("roots", "Show Roots on the unit frames", 8),
	},
}

local function UnitGroup(name, desc, order, showDesc)
	return {
		type = "group",
		name = L[name],
		desc = showDesc and L[desc] or nil,
		order = order,
		disabled = UnitDisabled,
		get = UnitGet,
		set = UnitSet,
		args = {
			spells = unitSpellToggles,
			enabled = {
				type = "toggle",
				disabled = function() return not BigDebuffs.db.profile.unitFrames.enabled end,
				name = L["Enabled"],
				order = 1,
				width = "full",
				desc = L[desc],
			},
			anchor = {
				name = L["Anchor"],
				desc = L["Anchor to attach the BigDebuffs frames"],
				type = "select",
				values = {
					["auto"] = L["Automatic"],
					["manual"] = L["Manual"],
				},
				order = 2,
			},
			size = {
				type = "range",
				disabled = function(info) local c = BigDebuffs.db.profile.unitFrames[info[2]] return not c.enabled or c.anchor == "auto" end,
				name = L["Size"],
				desc = L["Set the size of the frame"],
				min = 8,
				max = 512,
				step = 1,
				order = 3,
			},
			cdMod = {
				type = "range",
				disabled = function(info) local c = BigDebuffs.db.profile.unitFrames[info[2]] return not c.enabled or c.anchor ~= "auto" end,
				name = L["Cooldown Size Modifier"],
				desc = L["Modifies the size of the cooldown spiral"],
				min = 0,
				max = 20,
				step = 1,
				order = 4,
			},
		},
	}
end

local function PriorityRange(key, order)
	return {
		type = "range",
		width = "double",
		name = L[key],
		desc = L["Higher priority spells will take precedence regardless of duration"],
		min = 1,
		max = 100,
		step = 1,
		order = order,
	}
end

function BigDebuffs:BuildOptions()
	local options = {
		name = "BigDebuffs",
		descStyle = "inline",
		type = "group",
		plugins = {},
		childGroups = "tab",
		args = {
			vers = {
				order = 1,
				type = "description",
				name = "|cffffd700"..L["Version"].."|r "..GetAddOnMetadata("BigDebuffs", "Version").."\n",
				cmdHidden = true
			},
			desc = {
				order = 2,
				type = "description",
				name = "|cffffd700 "..L["Author"].."|r Jordon (WoTLK backport by Konjunktur) \n",
				cmdHidden = true
			},
			test = {
				type = "execute",
				name = L["Toggle Test Mode"],
				order = 3,
				func = "Test",
				handler = BigDebuffs,
			},
			unitFrames = {
				name = L["Unit Frames"],
				type = "group",
				order = 20,
				disabled = function(info) return info[2] and not self.db.profile[info[1]].enabled end,
				childGroups = "tab",
				get = function(info) local name = info[#info] return self.db.profile.unitFrames[name] end,
				set = function(info, value) local name = info[#info] self.db.profile.unitFrames[name] = value self:Refresh() end,
				args = {
					general = {
						name = "General",
						type = "group",
						order = 10,
						inline = true,
						args = {
							enabled = {
								type = "toggle",
								disabled = false,
								width = "normal",
								name = L["Enabled"],
								desc = L["Enable BigDebuffs on unit frames"],
							},
							cooldownCount = {
								type = "toggle",
								width = "normal",
								name = L["Cooldown Count"],
								desc = L["Allow Blizzard and other addons to display countdown text on the icons"],
							},
							tooltips = {
								type = "toggle",
								width = "normal",
								name = "Tooltips",
								desc = "Show the spell tooltip when hovering the icon",
							},
						},
					},
					player = UnitGroup("Player Frame", "Enable BigDebuffs on the player frame", 1),
					target = UnitGroup("Target Frame", "Enable BigDebuffs on the target frame", 2, true),
					focus = UnitGroup("Focus Frame", "Enable BigDebuffs on the focus frame", 3, true),
					pet = UnitGroup("Pet Frame", "Enable BigDebuffs on the pet frame", 4, true),
					party = UnitGroup("Party Frames", "Enable BigDebuffs on the party frames", 5, true),
					arena = UnitGroup("Arena Frames", "Enable BigDebuffs on the arena frames", 6, true),
				},
			},
			spells = {
				name = L["Spells"],
				type = "group",
				childGroups = "tab",
				order = 40,
				args = BuildSpells(),
			},
			priority = {
				name = L["Priority"],
				type = "group",
				get = function(info) local name = info[#info] return self.db.profile.priority[name] end,
				set = function(info, value) local name = info[#info] self.db.profile.priority[name] = value self:Refresh() end,
				order = 30,
				args = {
					immunities = PriorityRange("immunities", 10),
					immunities_spells = PriorityRange("immunities_spells", 11),
					cc = PriorityRange("cc", 12),
					interrupts = PriorityRange("interrupts", 13),
					buffs_defensive = PriorityRange("buffs_defensive", 14),
					buffs_offensive = PriorityRange("buffs_offensive", 15),
					buffs_other = PriorityRange("buffs_other", 16),
					roots = PriorityRange("roots", 17),
				},
			},
		}
	}

	options.plugins.profiles = { profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db) }
	LibStub("LibDualSpec-1.0"):EnhanceOptions(options.plugins.profiles.profiles, self.db)

	return options
end

function BigDebuffs:SetupOptions()

	LibStub("LibDualSpec-1.0"):EnhanceDatabase(self.db, "BigDebuffsDB")

	LibStub("AceConfig-3.0"):RegisterOptionsTable("BigDebuffs", function()
		if not self.options then
			self.options = self:BuildOptions()
		end
		return self.options
	end)
end
