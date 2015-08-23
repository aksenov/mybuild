-- The MIT License (MIT)
-- Copyright (c) 2015 Eugene Aksenov
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

-- Get all necessary player information
--

MyBuild.Char = {}

-- Get full character info
function MyBuild.Char:UpdateInfo()
  local player = "player"
  self.name = GetUnitName(player)
  self.race = GetUnitRace(player)
  self.alliance = GetUnitAlliance(player)
  self.allianceText = GetAllianceName(self.alliance)
  self.class = GetUnitClass(player)
  self.classId = GetUnitClassId(player)
  self.level = GetUnitLevel(player)
  self.veteranRank = GetUnitVeteranRank(player)
  self.isVeteran = IsUnitVeteran(player)
  self.werewolf = IsWerewolf()
  MyBuild.Char:Stat()
  MyBuild.Char:Equipment()

  MyBuild.Char:ChampionPoints()
  MyBuild.Char:Effects() --untested


end

-- Get champion points information
function MyBuild.Char:ChampionPoints()
  self.totalChampionPoints = GetPlayerChampionPointsEarned()
  -- d(self.totalChampionPoints)
  self.championPoints = {}
  for disc=1, GetNumChampionDisciplines() do
      self.championPoints[disc] = {}
      self.championPoints[disc].name = GetChampionDisciplineName(disc)
      self.championPoints[disc].attribute = GetChampionDisciplineAttribute(disc)
      self.championPoints[disc].skills = {}
    for skill=1,GetNumChampionDisciplineSkills(disc) do
      self.championPoints[disc].skills[skill] = {}
      self.championPoints[disc].skills[skill].name = GetChampionSkillName(disc, skill)
      self.championPoints[disc].skills[skill].points = GetNumPointsSpentOnChampionSkill(disc, skill)
    end
  end
end

-- Get current effect information
function MyBuild.Char:Effects()
  self.effects = {}
  self.mundus = ""
  for i = 0, GetNumBuffs("player") do
    self.effects[i] = GetUnitBuffInfo("player", i)
    --string.sub(String,1,string.len(Start))==Start
    if string.sub(self.effects[i], 1, 5) == "Boon:" then
        -- if twice-born star set in effect
        if self.mundus ~= "" then
          self.mundus = self.mundus..", "
        end
        self.mundus = self.mundus..string.sub(self.effects[i], 6)
    end


    --check for lycanthropy
    if string.match(self.effects[i],  "Lycanthropy") then
      self.werewolf = true
    end

    --d(string.sub(self.effects[i], 8, 17))
    --check for vampirism
    if string.match(self.effects[i], "Vampirism") then
      self.vampire = true
    end

  end
end

-- Get attributibe and derived information
function MyBuild.Char:Stat()
  local stat = function(s)
    return GetPlayerStat(s, STAT_BONUS_OPTION_APPLY_BONUS, STAT_SOFT_CAP_OPTION_APPLY_SOFT_CAP)
  end
  self.staminaPoints = GetAttributeSpentPoints(ATTRIBUTE_STAMINA)
  self.healthPoints = GetAttributeSpentPoints(ATTRIBUTE_HEALTH)
  self.magickaPoints = GetAttributeSpentPoints(ATTRIBUTE_MAGICKA)
  self.staminaMax = stat(STAT_STAMINA_MAX)
  self.magickaMax = stat(STAT_MAGICKA_MAX)
  self.healthMax = stat(STAT_HEALTH_MAX)
  self.healthRegen = stat(STAT_HEALTH_REGEN_IDLE)
  self.healthRegenCombat = stat(STAT_HEALTH_REGEN_COMBAT)
  self.staminaRegen = stat(STAT_STAMINA_REGEN_IDLE)
  self.staminaRegenCombat = stat(STAT_STAMINA_REGEN_COMBAT)
  self.magickaRegen = stat(STAT_MAGICKA_REGEN_IDLE)
  self.magickaRegenCombat = stat(STAT_MAGICKA_REGEN_COMBAT)
  self.weaponPower = stat(STAT_WEAPON_POWER)
  self.spellPower = stat(STAT_SPELL_POWER)
  self.block = stat(STAT_BLOCK)
  self.dodge = stat(STAT_DODGE)
  self.attackPower = stat(STAT_ATTACK_POWER)
  self.armorRating = stat(STAT_ARMOR_RATING)
  self.criticalResistance = stat(STAT_CRITICAL_RESISTANCE)
  self.criticalStrike = stat(STAT_CRITICAL_STRIKE)
  self.resistCold = stat(STAT_DAMAGE_RESIST_COLD)
  self.resistDisease = stat(STAT_DAMAGE_RESIST_DISEASE)
  self.resistDrown = stat(STAT_DAMAGE_RESIST_DROWN)
  self.resistEarth = stat(STAT_DAMAGE_RESIST_EARTH)
  self.resistFire = stat(STAT_DAMAGE_RESIST_FIRE)
  self.resistGeneric = stat(STAT_DAMAGE_RESIST_GENERIC)
  self.resistMagic = stat(STAT_DAMAGE_RESIST_MAGIC)
  self.resistOblivion = stat(STAT_DAMAGE_RESIST_OBLIVION)
  self.resistPhysical = stat(STAT_DAMAGE_RESIST_PHYSICAL)
  self.resistPoison = stat(STAT_DAMAGE_RESIST_POISON)
  self.resistShock = stat(STAT_DAMAGE_RESIST_SHOCK)
  self.resistStart = stat(STAT_DAMAGE_RESIST_START)
  self.healingTaken = stat(STAT_HEALING_TAKEN)
  self.miss = stat(STAT_MISS)
  self.mitigation = stat(STAT_MITIGATION)
  self.none = stat(STAT_NONE)
  self.parry = stat(STAT_PARRY)
  self.physicalPenetration = stat(STAT_PHYSICAL_PENETRATION)
  self.physicalResist = stat(STAT_PHYSICAL_RESIST)
  self.power = stat(STAT_POWER)
  self.spellCritical = stat(STAT_SPELL_CRITICAL)
  self.spellMitigation = stat(STAT_SPELL_MITIGATION)
  self.spellPenetration = stat(STAT_SPELL_PENETRATION)
  self.spellResist = stat(STAT_SPELL_RESIST)

  self.weaponCriticalChance = GetCriticalStrikeChance(self.criticalStrike, true)
  self.spellCriticalChance = GetCriticalStrikeChance(self.spellCritical, true)
end

-- Get worn equipment information
function MyBuild.Char:Equipment()
  local item = function (type)
    local a = {}
    a.itemlink = GetItemLink(BAG_WORN, type, LINK_STYLE_DEFAULT)
    a.name = GetItemName(BAG_WORN, type)
    a.quality = GetItemLinkQuality(a.itemlink)
    a.level = GetItemRequiredLevel(BAG_WORN, type)
    a.veteranRank = GetItemRequiredVeteranRank(BAG_WORN, type)
    a.type = GetItemType(BAG_WORN, type)
    a.icon = GetItemInfo(BAG_WORN, type)
    a.armortype = GetItemArmorType(BAG_WORN, type)
    a.weapontype = GetItemWeaponType(BAG_WORN, type)
    a.trait = GetItemTrait(BAG_WORN, type)
    local _,enchHeader,_ = GetItemLinkEnchantInfo(a.itemlink)
    a.enchantment = enchHeader
    a.armorrating = GetItemLinkArmorRating(a.itemlink, false)
    a.weaponpower = GetItemLinkWeaponPower(a.itemlink)
    return a
  end
  -- Armor
  self.head = item(EQUIP_SLOT_HEAD)
  self.shoulders=item(EQUIP_SLOT_SHOULDERS)
  self.chest=item(EQUIP_SLOT_CHEST)
  self.hand=item(EQUIP_SLOT_HAND)
  self.waist=item(EQUIP_SLOT_WAIST)
  self.legs=item(EQUIP_SLOT_LEGS)
  self.feet=item(EQUIP_SLOT_FEET)
  -- Jewelry
  self.costume=item(EQUIP_SLOT_COSTUME)
  self.neck=item(EQUIP_SLOT_NECK)
  self.ring1=item(EQUIP_SLOT_RING1)
  self.ring2=item(EQUIP_SLOT_RING2)
  -- Weapons
  self.backupMain=item(EQUIP_SLOT_BACKUP_MAIN)
  self.backupOff=item(EQUIP_SLOT_BACKUP_OFF)
  self.mainHand=item(EQUIP_SLOT_MAIN_HAND)
  self.offHand=item(EQUIP_SLOT_OFF_HAND)
  self.ranged=item(EQUIP_SLOT_RANGED)
end


-- Same verification on character level
-- TODO Replace with more generalized function
function MyBuild.Char.ItemLevelText(item)
  if item.level == 0 then return "" end
  if item.level < 50 then
   local level = tostring(item.level)
   return level
  else
   local level = "v"..tostring(item.veteranRank)
   return level
  end
end

-- TODO Move this to language files

TraitType = {}
TraitType[ITEM_TRAIT_TYPE_ARMOR_DIVINES] = "Divines"
TraitType[ITEM_TRAIT_TYPE_ARMOR_EXPLORATION] = "Exploration"
TraitType[ITEM_TRAIT_TYPE_ARMOR_IMPENETRABLE] = "Impenetrable"
TraitType[ITEM_TRAIT_TYPE_ARMOR_INFUSED] = "Infused"
TraitType[ITEM_TRAIT_TYPE_ARMOR_INTRICATE] = "Intricate"
TraitType[ITEM_TRAIT_TYPE_ARMOR_NIRNHONED] = "Nirnhoned"
TraitType[ITEM_TRAIT_TYPE_ARMOR_ORNATE] = "Ornate"
TraitType[ITEM_TRAIT_TYPE_ARMOR_REINFORCED] = "Reinforced"
TraitType[ITEM_TRAIT_TYPE_ARMOR_STURDY] = "Sturdy"
TraitType[ITEM_TRAIT_TYPE_ARMOR_TRAINING] = "Training"
TraitType[ITEM_TRAIT_TYPE_ARMOR_WELL_FITTED] = "Well Fitted"
TraitType[ITEM_TRAIT_TYPE_JEWELRY_ARCANE] = "Arcane"
TraitType[ITEM_TRAIT_TYPE_JEWELRY_HEALTHY] = "Healthy"
TraitType[ITEM_TRAIT_TYPE_JEWELRY_ORNATE] = "Ornate"
TraitType[ITEM_TRAIT_TYPE_JEWELRY_ROBUST] = "Robust"
TraitType[ITEM_TRAIT_TYPE_NONE] = ""
TraitType[ITEM_TRAIT_TYPE_WEAPON_CHARGED] = "Charged"
TraitType[ITEM_TRAIT_TYPE_WEAPON_DEFENDING] = "Defending"
TraitType[ITEM_TRAIT_TYPE_WEAPON_INFUSED] = "Infused"
TraitType[ITEM_TRAIT_TYPE_WEAPON_INTRICATE] = "Intricate"
TraitType[ITEM_TRAIT_TYPE_WEAPON_NIRNHONED] = "Nirnhoned"
TraitType[ITEM_TRAIT_TYPE_WEAPON_ORNATE] = "Ornate"
TraitType[ITEM_TRAIT_TYPE_WEAPON_POWERED] = "Powered"
TraitType[ITEM_TRAIT_TYPE_WEAPON_PRECISE] = "Precise"
TraitType[ITEM_TRAIT_TYPE_WEAPON_SHARPENED] = "Sharpened"
TraitType[ITEM_TRAIT_TYPE_WEAPON_TRAINING] = "Training"
TraitType[ITEM_TRAIT_TYPE_WEAPON_WEIGHTED] = "Weighted"

ArmorType = {}
ArmorType[ARMORTYPE_HEAVY] = "Heavy"
ArmorType[ARMORTYPE_LIGHT] = "Light"
ArmorType[ARMORTYPE_MEDIUM] = "Medium"
ArmorType[ARMORTYPE_NONE] = ""

WeaponType = {}
WeaponType[WEAPONTYPE_AXE] = "Axe"
WeaponType[WEAPONTYPE_BOW] = "Bow"
WeaponType[WEAPONTYPE_DAGGER] = "Dagger"
WeaponType[WEAPONTYPE_FIRE_STAFF] = "Fire Staff"
WeaponType[WEAPONTYPE_FROST_STAFF] = "Frost Staff"
WeaponType[WEAPONTYPE_HAMMER] = "Hammer"
WeaponType[WEAPONTYPE_HEALING_STAFF] = "Healing Staff"
WeaponType[WEAPONTYPE_LIGHTNING_STAFF] = "Lighting Staff"
WeaponType[WEAPONTYPE_NONE] = ""
WeaponType[WEAPONTYPE_RUNE] = "Rune"
WeaponType[WEAPONTYPE_SHIELD] = "Shield"
WeaponType[WEAPONTYPE_SWORD] = "Sword"
WeaponType[WEAPONTYPE_TWO_HANDED_AXE] = "Two-handed Axe"
WeaponType[WEAPONTYPE_TWO_HANDED_HAMMER] = "Two-handed Hammer"
WeaponType[WEAPONTYPE_TWO_HANDED_SWORD] = "Two-handed Sword"
