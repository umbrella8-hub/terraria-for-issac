local Mod = TFI

local _Menu = Mod.Name .. '_' --主菜单

--创建主菜单
ImGui.CreateMenu(_Menu, '\u{f699} ' .. (Mod.NameStr))

--根据语言选择字符串
function Mod:ChooseLanguage(text_zh, text_en)
	return (Mod.Language == "zh" and text_zh) or text_en
end

--选择语言
local function Language(text_zh, text_en)
	return Mod:ChooseLanguage(text_zh, text_en)
end

--是否在主界面
local function IsInMainMenu(disableTip)
	local inMainMenu, menuType = pcall(MenuManager.GetActiveMenu)

	if not disableTip then
		ImGui.PushNotification(Language('请回到主界面', 'Please come back to main menu'), ImGuiNotificationType.ERROR, 2500)
		return false
	end

	return inMainMenu
end

--是否在对局中
local function IsInRun(disableTip)
	local inRun = Isaac.IsInGame()
	if not inRun and not disableTip then
		ImGui.PushNotification(Language('请先进入对局', 'Please start a run first'), ImGuiNotificationType.ERROR, 2500)
	end
	return inRun
end

--存档栏是否已加载
local function IsSaveslotLoaded(disableTip)
	local inMainMenu, menuType = pcall(MenuManager.GetActiveMenu)

	if not inMainMenu then
		return true
	end

	if menuType <= 2 and not disableTip then
		ImGui.PushNotification(Language('请先加载存档', 'Please select a saveslot first'), ImGuiNotificationType.ERROR, 2500)
		return false
	end

	return true
end

-- 创建勾线框
local function MakeCheckBox(parentId, KEY, name, help, paperView)
	local box = parentId .. '_' .. KEY
	ImGui.AddCheckbox(parentId, box, name)
	ImGui.AddCallback(box, ImGuiCallback.Render, function()
		ImGui.UpdateData(box, ImGuiData.Value, Mod:GetTFIData()[KEY])
	end)
	ImGui.AddCallback(box, ImGuiCallback.Edited, function(value)
		if not IsSaveslotLoaded() then return end
		Mod:GetTFIData()[KEY] = (value)
		Mod:SaveTFIData()
	end)

	if help then
		ImGui.SetHelpmarker(box, help)
	end
end

-- 创建收纳框
local function MakeComboBox(parentId, KEY, name, option, help, paperView)
	local box = parentId .. '_' .. KEY
	ImGui.AddElement(parentId, "", ImGuiElement.TextWrapped, name)

	ImGui.AddCombobox(parentId, box, "", function(index, val)
		Mod:GetTFIData()[KEY] = index
	end, option, Mod:GetTFIData()[KEY], false)
	ImGui.AddCallback(box, ImGuiCallback.Render, function()
		ImGui.UpdateData(box, ImGuiData.Value, Mod:GetTFIData()[KEY])
	end)
	ImGui.AddCallback(box, ImGuiCallback.Edited, function(value)
		if not IsSaveslotLoaded() then return end
		Mod:GetTFIData()[KEY] = (value)
		Mod:SaveTFIData()
	end)

	if help then
		ImGui.SetHelpmarker(box, help)
	end
end

-- 创建拖动框
local function AddNumSetting(parentId, KEY, name, min, max, note, help, paperView)
	local box = parentId .. '_' .. KEY
	ImGui.AddElement(parentId, "", ImGuiElement.TextWrapped, name)
	ImGui.AddSliderInteger(parentId, box, note, nil, Mod:GetTFIData()[KEY], min, max)
	ImGui.AddCallback(box, ImGuiCallback.Render, function()
		ImGui.UpdateData(box, ImGuiData.Value, Mod:GetTFIData()[KEY])
	end)
	ImGui.AddCallback(box, ImGuiCallback.Edited, function(value)
		if not IsSaveslotLoaded() then return end
		Mod:GetTFIData()[KEY] = (value)
		Mod:SaveTFIData()
	end)

	if help then
		ImGui.SetHelpmarker(box, help)
	end
end

--------↓设置板块↓--------
do
	-- 设置板块
	local _Setting = _Menu .. 'Setting'
	-- 设置窗口
	local _SettingWindow = _Menu .. 'SettingWindow'
	-- 设置点选框
	local _SettingTabBar = _Menu .. 'SettingTabBar'
	-- 功能栏
	local _SettingTabF = _Menu .. 'SettingTabF'
	-- 音效栏
	local _SettingTabS = _Menu .. 'SettingTabS'
	-- 特效栏
	local _SettingTabV = _Menu .. 'SettingTabV'
	-- 杂项栏
	local _SettingTabG = _Menu .. 'SettingTabG'

	ImGui.AddElement(_Menu, _Setting, ImGuiElement.MenuItem, '\u{f013}' .. (Language('设置', 'Settings')))
	ImGui.CreateWindow(_SettingWindow, '\u{f013}' .. (Language('泰拉瑞亚-设置', 'TFI - Settings')))
	ImGui.LinkWindowToElement(_SettingWindow, _Setting)

	ImGui.AddTabBar(_SettingWindow, _SettingTabBar)
	ImGui.AddTab(_SettingTabBar, _SettingTabF, Language('功能', 'Functions'))
	ImGui.AddTab(_SettingTabBar, _SettingTabS, Language('音效', 'Sound Effects'))
	ImGui.AddTab(_SettingTabBar, _SettingTabV, Language('特效', 'Visual Effects'))
	ImGui.AddTab(_SettingTabBar, _SettingTabG, Language('杂项', 'Groceries'))

	----↓功能栏相关↓----
	do

	end

	----↓音效栏相关↓----
	do

	end

	----↓特效栏相关↓----
	do

	end

	----↓杂项栏相关↓----
	do

	end
end
