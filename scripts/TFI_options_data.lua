local Mod = TFI
local SaveAndLoad = Mod.CuerLibAddon.SaveAndLoad;

----------初始化数据----------
-- 此处可新增永久数据
local function Data_Init()
	return {
		--杂项栏--

	}
end

-- 用于读取这里注册的数据
function Mod:GetTFIData()
	local data = SaveAndLoad:ReadPersistentData()
	data.TFI_Data = data.TFI_Data or Data_Init()
	return data.TFI_Data
end

-- 保存数据
function Mod:SaveTFIData()
	SaveAndLoad:WritePersistentData(SaveAndLoad:ReadPersistentData())
end

local TFI_Data = Mod:GetTFIData()
------------------

-- 保存
local SaveList = {
}
for key, _ in pairs(Data_Init()) do
	SaveList[key] = true
end
-- 退出游戏时
local function WhenExit(_, shouldSave)
	-- 清除保存名单外的数据
	if shouldSave then
		for k, _ in pairs(TFI_Data) do
			if not SaveList[k] then
				TFI_Data[k] = nil
			end
		end
		Mod:SaveTFIData()
	end
end
-- 游戏结束时
local function WhenEnd()
	-- 清除保存名单外的数据
	for k, _ in pairs(TFI_Data) do
		if not SaveList[k] then
			TFI_Data[k] = nil
		end
	end
	Mod:SaveTFIData()
end

Mod:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, 10 ^ 7, WhenExit)
Mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_END, 10 ^ 7, WhenEnd)
-- 加载
local function WhenSaveslotSelected() --选中存档槽时
	-- 如果有,加载新增的永久数据和设置
	local _Data = Data_Init()
	for k, _ in pairs(_Data) do
		if TFI_Data[k] == nil then
			TFI_Data[k] = _Data[k]
		end
	end
	Mod:SaveTFIData()
end
-- 开始游戏时
local function WhenStart(_, isContinued)
	-- 如果有,加载新增的永久数据和设置
	local _Data = Data_Init()
	for k, _ in pairs(_Data) do
		if TFI_Data[k] == nil then
			TFI_Data[k] = _Data[k]
		end
	end
	Mod:SaveTFIData()
end

Mod:AddPriorityCallback(ModCallbacks.MC_POST_SAVESLOT_LOAD, -10 ^ 7, WhenSaveslotSelected)
Mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, -10 ^ 7, WhenStart)
