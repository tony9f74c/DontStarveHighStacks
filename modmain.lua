require = GLOBAL.require
require "components/stackable"
require "components/inventoryitem"

TUNING.STACK_SIZE_LARGEITEM = GetModConfigData("cfgChangeLargeStacksSize");
TUNING.STACK_SIZE_MEDITEM = GetModConfigData("cfgChangeMediumStacksSize");
TUNING.STACK_SIZE_SMALLITEM = GetModConfigData("cfgChangeSmallStacksSize"); 

local r_s = GLOBAL.require("components/stackable_replica") -- Credit: Jupiter: http://steamcommunity.com/profiles/76561198204009267
r_s._ctor = function(self, inst)
	self.inst = inst
	self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
	self._maxsize = GLOBAL.net_tinybyte(inst.GUID, "stackable._maxsize")
end

local function makeStackable(inst)
    if not inst.components.stackable and GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    end
end

local function unmakeFeedable(inst)
    if inst.components.perishable and GLOBAL.TheWorld.ismastersim then
        inst:RemoveComponent("perishable")
    end
    if inst.components.inventoryitem and GLOBAL.TheWorld.ismastersim then
        inst.components.inventoryitem:SetOnPutInInventoryFn(function(inst)
            if oninventory then
                oninventory(inst)
            end
        end)
        inst.components.inventoryitem:SetOnDroppedFn(function(inst)
            if ondropped then
                ondropped(inst)
            end
        end)
    end
end

local function removeMurder(inst)
    if inst.components.health and GLOBAL.TheWorld.ismastersim then
        inst.components.health.canmurder = false
    end
end
 
 -- make stackable
 AddPrefabPostInit("minotaurhorn", makeStackable)
 AddPrefabPostInit("tallbirdegg", makeStackable)
 if GetModConfigData("cfgRabbitsCanStackToggle") then
    AddPrefabPostInit("rabbit", makeStackable)
 end
 if GetModConfigData("cfgBirdsCanStackToggle")then
    AddPrefabPostInit("crow", makeStackable)
    AddPrefabPostInit("robin", makeStackable)
    AddPrefabPostInit("robin_winter", makeStackable)
    AddPrefabPostInit("canary", makeStackable)
 end
 if GetModConfigData("cfgMolesCanStackToggle") then
    AddPrefabPostInit("mole", makeStackable)
 end
 
 -- remove feedable
 if GetModConfigData("cfgMolesDontDieToggle") then
    AddPrefabPostInit("mole", unmakeFeedable)
 end
 if GetModConfigData("cfgRabbitsDontDieToggle") then
    AddPrefabPostInit("rabbit", unmakeFeedable)
 end
 if GetModConfigData("cfgBirdsDontDieToggle") then
    AddPrefabPostInit("crow", unmakeFeedable)
    AddPrefabPostInit("robin", unmakeFeedable)
    AddPrefabPostInit("robin_winter", unmakeFeedable)
    AddPrefabPostInit("canary", unmakeFeedable)
 end
 if GetModConfigData("cfgBeesDontDieToggle") then
    AddPrefabPostInit("bee", unmakeFeedable)
    AddPrefabPostInit("killerbee", unmakeFeedable)
 end
 if GetModConfigData("cfgButterfliesDontDieToggle") then
    AddPrefabPostInit("butterfly", unmakeFeedable)
 end
 if GetModConfigData("cfgMosquitosDontDieToggle") then
    AddPrefabPostInit("mosquito", unmakeFeedable)
 end

 -- remove murder
 if GetModConfigData("cfgMolesRemoveMurderToggle") then
    AddPrefabPostInit("mole", removeMurder)
 end
 if GetModConfigData("cfgBeesRemoveMurderToggle") then
    AddPrefabPostInit("bee", removeMurder)
    AddPrefabPostInit("killerbee", removeMurder)
 end
 if GetModConfigData("cfgButterfliesRemoveMurderToggle") then
    AddPrefabPostInit("butterfly", removeMurder)
 end
 if GetModConfigData("cfgRabbitsRemoveMurderToggle") then
    AddPrefabPostInit("rabbit", removeMurder)
 end
 if GetModConfigData("cfgBirdsRemoveMurderToggle") then
    AddPrefabPostInit("crow", removeMurder)
    AddPrefabPostInit("robin", removeMurder)
    AddPrefabPostInit("robin_winter", removeMurder)
    AddPrefabPostInit("canary", removeMurder)
 end
 if GetModConfigData("cfgMosquitosRemoveMurderToggle") then
    AddPrefabPostInit("mosquito", removeMurder)
 end

local function crsRemovePerish(inst)
    if inst.components.perishable and GLOBAL.TheWorld.ismastersim then
        inst:RemoveComponent("perishable")
    end
end

if GetModConfigData("cfgJerkyDoesntPerish") then
    AddPrefabPostInit("meat_dried", crsRemovePerish)
    AddPrefabPostInit("smallmeat_dried", crsRemovePerish)
    AddPrefabPostInit("monstermeat_dried", crsRemovePerish)
end

if GetModConfigData("cfgSeedsDontPerish") then
    AddPrefabPostInit("seeds", crsRemovePerish)
end

if GetModConfigData("cfgVegSeedsDontPerish") then
    AddPrefabPostInit("carrot_seeds", crsRemovePerish)
    AddPrefabPostInit("corn_seeds", crsRemovePerish)
    AddPrefabPostInit("dragonfruit_seeds", crsRemovePerish)
    AddPrefabPostInit("durian_seeds", crsRemovePerish)
    AddPrefabPostInit("eggplant_seeds", crsRemovePerish)
    AddPrefabPostInit("pomegranate_seeds", crsRemovePerish)
    AddPrefabPostInit("pumpkin_seeds", crsRemovePerish)
    AddPrefabPostInit("watermelon_seeds", crsRemovePerish)
    AddPrefabPostInit("garlic_seeds", crsRemovePerish)
    AddPrefabPostInit("onion_seeds", crsRemovePerish)
    AddPrefabPostInit("pepper_seeds", crsRemovePerish)
    AddPrefabPostInit("potato_seeds", crsRemovePerish)
    AddPrefabPostInit("tomato_seeds", crsRemovePerish)
    AddPrefabPostInit("asparagus_seeds", crsRemovePerish)
end
