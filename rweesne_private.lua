
--====================================================
-- RWEESNE PRIVATE V5.0
-- Roblox Studio LocalScript
-- StarterPlayer > StarterPlayerScripts
--====================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local TextService = game:GetService("TextService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--====================================================
-- CLEANUP OLD VERSIONS
--====================================================

for _, name in ipairs({
    "DegradePrivateV41",
    "DegradePrivateV50",
    "DegradeESPV41",
    "DegradeESPV50"
}) do
    local old = playerGui:FindFirstChild(name)
    if old then
        old:Destroy()
    end
end

--====================================================
-- CONFIG
--====================================================

local C = {
    Background = Color3.fromRGB(8, 12, 18),
    Sidebar = Color3.fromRGB(12, 19, 29),
    Panel = Color3.fromRGB(18, 29, 42),
    Accent = Color3.fromRGB(35, 190, 255),
    White = Color3.fromRGB(235, 247, 255),
    Muted = Color3.fromRGB(135, 164, 184),
    Green = Color3.fromRGB(75, 205, 245),
    Off = Color3.fromRGB(42, 62, 78)
}

local cfg = {
    BoxESP = false,
    Highlight = false,
    Names = true,
    Distance = true,
    ESPHealth = true,
    ESPWeapon = true,
    ESPArrows = true,
    BackpackESP = false,
    DroppedWeaponESP = false,
    ESPMaxDistance = 500,
    DroppedMaxDistance = 500,
    ESPPlayerColor = Color3.fromRGB(35, 190, 255),
    ESPDroppedColor = Color3.fromRGB(35, 190, 255),
    PlayerChamsFillTransparency = 0.72,
    PlayerChamsOutlineTransparency = 0,
    ArmsChams = false,
    ArmsChamsColor = Color3.fromRGB(35, 190, 255),
    ArmsChamsFillTransparency = 0.25,
    ArmsChamsOutlineTransparency = 0,
    Glow = true,


    HUD = true,
    HUDSignature = true,
    HUDFPS = true,
    HUDPing = true,
    HUDPlayers = true,
    HUDScale = 1,
    HUDTransparency = 0.2,

    FOVEnabled = false,
    FOV = 70,
    SkyboxEnabled = false,
    SkyboxPreset = 1,
    ColorCorrectionEnabled = false,
    ColorSaturation = 0,
    ColorContrast = 0,
    ColorHue = 0,

    Crosshair = false,
    CrosshairStyle = "Cross",
    CrosshairSize = 8,
    CrosshairThickness = 2,
    CrosshairGap = 5,
    CrosshairTransparency = 0,
    CrosshairColor = Color3.fromRGB(255, 255, 255),
    CrosshairHue = 0,
    CrosshairSaturation = 0,
    CrosshairValue = 1,

    MenuTransparency = 0,
    MenuScale = 1,
    Language = "English",
    UISounds = true
}

local translations = {
    ["Search this page..."] = "Поиск по странице...",
    ["NAVIGATION"] = "НАВИГАЦИЯ",
    ["PLAYER VISUAL INTERFACE"] = "ВИЗУАЛЬНЫЙ ИНТЕРФЕЙС ИГРОКА",
    ["V5.0  •  CLIENT"] = "V5.0  •  КЛИЕНТ",
    ["VISUALS"] = "ВИЗУАЛЫ",
    ["SETTINGS"] = "НАСТРОЙКИ",
    ["HUD"] = "HUD",
    ["CROSSHAIR"] = "ПРИЦЕЛ",
    ["MISC"] = "ПРОЧЕЕ",
    ["Visuals"] = "Визуалы",
    ["Player ESP controls"] = "Настройки отображения игроков",
    ["Player and dropped-item ESP"] = "Настройки ESP игроков и предметов",
    ["Settings"] = "Настройки",
    ["Customize your interface"] = "Настройка интерфейса",
    ["Nearby player positions"] = "Позиции ближайших игроков",
    ["Performance HUD"] = "Информационный HUD",
    ["Live performance information"] = "Текущие показатели производительности",
    ["Crosshair"] = "Прицел",
    ["Crosshair Editor"] = "Настройка прицела",
    ["Customize your crosshair"] = "Настройка прицела",
    ["Misc"] = "Прочее",
    ["Camera field of view controls"] = "Настройки поля зрения камеры",
    ["Box ESP"] = "Рамки игроков",
    ["Draw boxes around characters"] = "Рисовать рамки вокруг персонажей",
    ["Highlight"] = "Подсветка игроков",
    ["Highlight player silhouettes"] = "Подсвечивать силуэты игроков",
    ["Player Chams"] = "Чамсы игроков",
    ["Player Chams Fill"] = "Прозрачность заливки чамсов",
    ["Player Chams Outline"] = "Прозрачность контура чамсов",
    ["Arms Chams"] = "Чамсы рук",
    ["Highlight your character's arms"] = "Подсвечивать руки вашего персонажа",
    ["Arms Chams Fill"] = "Прозрачность заливки рук",
    ["Arms Chams Outline"] = "Прозрачность контура рук",
    ["Choose the arms chams color"] = "Выберите цвет чамсов рук",
    ["Player chams fill transparency: 0–1"] = "Прозрачность заливки чамсов игроков: 0–1",
    ["Player chams outline transparency: 0–1"] = "Прозрачность контура чамсов игроков: 0–1",
    ["Arms chams fill transparency: 0–1"] = "Прозрачность заливки чамсов рук: 0–1",
    ["Arms chams outline transparency: 0–1"] = "Прозрачность контура чамсов рук: 0–1",
    ["Player Names"] = "Имена игроков",
    ["Display player names"] = "Показывать имена игроков",
    ["Distance"] = "Дистанция",
    ["Display distance in studs"] = "Показывать расстояние в студиях",
    ["studs"] = "студах",
    ["Player Health"] = "Здоровье игрока",
    ["Display current and maximum health"] = "Показывать текущее и максимальное здоровье",
    ["HP: "] = "Здоровье: ",
    ["Player Weapon"] = "Оружие игрока",
    ["Display the equipped Tool name"] = "Показывать название экипированного оружия",
    ["Weapon: "] = "Оружие: ",
    ["None"] = "Нет",
    ["Off-screen Arrows"] = "Стрелки за экраном",
    ["Point toward players outside the screen"] = "Указывать на игроков вне экрана",
    ["Dropped Backpack ESP"] = "Подсветка рюкзаков",
    ["Highlight dropped backpacks in the game world"] = "Подсвечивать рюкзаки, лежащие в игровом мире",
    ["Dropped Weapon ESP"] = "Подсветка оружия",
    ["Highlight dropped weapons and show their names"] = "Подсвечивать оружие на земле и показывать его название",
    ["Player ESP Max Distance"] = "Максимальная дистанция ESP игроков",
    ["Dropped Items Max Distance"] = "Максимальная дистанция предметов",
    ["Maximum player ESP range in studs"] = "Максимальная дальность ESP игроков в студиях",
    ["Maximum dropped-item ESP range in studs"] = "Максимальная дальность ESP предметов в студиях",
    ["Player ESP Color"] = "Цвет ESP игроков",
    ["Dropped Items ESP Color"] = "Цвет ESP предметов",
    ["Choose the player ESP color"] = "Выберите цвет ESP игроков",
    ["Choose the dropped-item ESP color"] = "Выберите цвет ESP предметов",
    ["ESP Preview"] = "Предпросмотр ESP",
    ["Current character skin with ESP styling"] = "Текущий скин персонажа с оформлением ESP",
    ["Loading current character..."] = "Загружаю текущего персонажа...",
    ["Character preview unavailable"] = "Не удалось показать персонажа",
    ["Players"] = "Игроки",
    ["Dropped Items"] = "Брошенные предметы",
    ["Interface Glow"] = "Свечение интерфейса",
    ["Accent outline around menu"] = "Цветная обводка меню",
    ["UI Sounds"] = "Звуки интерфейса",
    ["Play sounds on startup and when toggles change"] = "Звуки при запуске и переключении функций",
    ["Menu key"] = "Клавиша меню",
    ["Click to change opening key"] = "Нажмите, чтобы сменить клавишу открытия",
    ["PRESS KEY"] = "НАЖМИТЕ КЛАВИШУ",
    ["Accent Color"] = "Цвет акцента",
    ["Cycle through the accent color palette"] = "Переключать цвета интерфейса",
    ["CHANGE"] = "СМЕНИТЬ",
    ["Window Transparency"] = "Прозрачность окна",
    ["Adjust panel transparency (0–60%)"] = "Прозрачность панелей (0–60%)",
    ["Interface Scale"] = "Масштаб интерфейса",
    ["Adjust menu size (80–120%)"] = "Размер меню (80–120%)",
    ["Language"] = "Язык",
    ["Choose the menu language"] = "Выберите язык меню",
    ["ENGLISH"] = "АНГЛИЙСКИЙ",
    ["RUSSIAN"] = "РУССКИЙ",
    ["Show nearby player dots"] = "Показывать точки ближайших игроков",
    ["FPS: "] = "FPS: ",
    ["PING: "] = "ПИНГ: ",
    ["PLAYERS: "] = "ИГРОКИ: ",
    ["FPS: --     PING: --"] = "FPS: --     ПИНГ: --",
    ["FPS: -- | PING: --"] = "FPS: -- | ПИНГ: --",
    ["Live performance monitor"] = "Мониторинг производительности",
    ["HUD: ON"] = "HUD: ВКЛ.",
    ["N/A"] = "Н/Д",
    ["Enable HUD"] = "Включить HUD",
    ["Show or hide the on-screen HUD"] = "Показывать или скрывать HUD на экране",
    ["Show Session Tag"] = "Показывать подпись сессии",
    ["Show PrivateRweesne and elapsed runtime at the bottom-left"] = "Показывать PrivateRweesne и время работы внизу слева",
    ["Show FPS"] = "Показывать FPS",
    ["Display frames per second"] = "Отображать кадры в секунду",
    ["Show Ping"] = "Показывать пинг",
    ["Display network ping"] = "Отображать сетевую задержку",
    ["Show Player Count"] = "Показывать число игроков",
    ["Display current players in this server"] = "Число игроков на этом сервере",
    ["HUD Scale"] = "Масштаб HUD",
    ["Resize the on-screen HUD (75–150%)"] = "Размер HUD на экране (75–150%)",
    ["HUD Background Transparency"] = "Прозрачность фона HUD",
    ["Adjust background transparency (0–90%)"] = "Прозрачность фона (0–90%)",
    ["Enable Crosshair"] = "Включить прицел",
    ["Off by default; enable when you want it"] = "Выключен изначально; включите при необходимости",
    ["Size"] = "Размер",
    ["Arm length / dot diameter"] = "Длина линий / диаметр точки",
    ["Thickness"] = "Толщина",
    ["Line or ring thickness"] = "Толщина линий или круга",
    ["Gap"] = "Зазор",
    ["Center opening for cross style"] = "Расстояние между линиями прицела",
    ["Transparency"] = "Прозрачность",
    ["Crosshair visibility: 0–0.8"] = "Прозрачность прицела: 0–0.8",
    ["Crosshair Style"] = "Стиль прицела",
    ["Cycle Cross, Dot and Circle"] = "Переключать крест, точку и круг",
    ["Cross"] = "Крест",
    ["Dot"] = "Точка",
    ["Circle"] = "Круг",
    ["Color"] = "Цвет",
    ["Choose a crosshair color"] = "Выберите цвет прицела",
    ["Reset Crosshair"] = "Сбросить прицел",
    ["Hide the reticle and restore default style"] = "Скрыть прицел и вернуть стиль по умолчанию",
    ["FOV Changer"] = "Изменение FOV",
    ["Set camera field of view"] = "Настроить поле зрения камеры",
    ["FOV"] = "FOV",
    ["Field of view: 70–120"] = "Поле зрения: 70–120",
    ["Reset FOV"] = "Сбросить FOV",
    ["Disable the override and restore the default view"] = "Отключить настройку и вернуть исходный обзор",
    ["Custom Skybox"] = "Своя небесная коробка",
    ["Apply a local sky preset"] = "Применить локальный вариант неба",
    ["Skybox Preset"] = "Вариант неба",
    ["Choose Night or Space"] = "Выбрать ночь или космос",
    ["Night"] = "Ночь",
    ["Space"] = "Космос",
    ["Reset Skybox"] = "Сбросить небо",
    ["Restore the original game sky"] = "Вернуть исходное небо игры",
    ["Color Correction"] = "Цветокоррекция",
    ["Enable custom color grading"] = "Включить настройку цветопередачи",
    ["Saturation"] = "Насыщенность",
    ["Color intensity: -1 to 1"] = "Интенсивность цвета: от -1 до 1",
    ["Contrast"] = "Контраст",
    ["Image contrast: -1 to 1"] = "Контраст изображения: от -1 до 1",
    ["Hue Shift"] = "Сдвиг оттенка",
    ["Neutral at 0; tint grows toward either end"] = "0 — нейтрально; оттенок усиливается к краям",
    ["Reset Color Correction"] = "Сбросить цветокоррекцию",
    ["Turn off grading and restore neutral values"] = "Отключить цветокоррекцию и вернуть исходные значения",
    ["Configs"] = "Конфиги",
    ["Saved for this session"] = "Сохранены до конца сессии",
    ["NONE"] = "НЕТ",
    ["Config Name"] = "Название конфига",
    ["Type a config name..."] = "Введите название конфига...",
    ["Enter a name first..."] = "Сначала введите название...",
    ["Load Config"] = "Загрузить конфиг",
    ["Apply the selected config"] = "Применить выбранный конфиг",
    ["LOAD"] = "ЗАГРУЗИТЬ",
    ["Delete Config"] = "Удалить конфиг",
    ["Remove the selected config"] = "Удалить выбранный конфиг",
    ["DELETE"] = "УДАЛИТЬ",
    ["Save Config"] = "Сохранить конфиг",
    ["Save or overwrite the named config"] = "Сохранить конфиг с этим названием",
    ["SAVE"] = "СОХРАНИТЬ",
    ["Reset Settings"] = "Сбросить настройки",
    ["Restore default script settings"] = "Вернуть настройки по умолчанию",
    ["RESET"] = "СБРОС",
    ["Unload Script"] = "Выгрузить скрипт",
    ["Close the menu and remove its effects"] = "Закрыть меню и отключить его эффекты",
    ["UNLOAD"] = "ВЫГРУЗИТЬ"
}

local currentLanguage = cfg.Language
local localeEntries = {}
local menuKey = Enum.KeyCode.RightShift
local waitingForKey = false
local menuOpen = true
local accessGranted = false
local selectedProfileName
local skyboxPresets
local crossStyleButton
local skyboxPresetButton
local languageButton
local keyButton
local configSelectButton
local applyBackpackESP
local applyDroppedWeaponESP
local applyArmsChams
local refreshESPPreview

local function localize(value)
    if currentLanguage == "Russian" and translations[value] then
        return translations[value]
    end
    return value
end

local function registerLocale(obj, property, source)
    if type(source) ~= "string" or not translations[source] then return end
    table.insert(localeEntries, {Object = obj, Property = property, Source = source})
    obj[property] = localize(source)
end

local function setLanguage(language)
    currentLanguage = language == "Russian" and "Russian" or "English"
    cfg.Language = currentLanguage
    for _, entry in ipairs(localeEntries) do
        if entry.Object and entry.Object.Parent then
            entry.Object[entry.Property] = localize(entry.Source)
        end
    end
    if languageButton then
        languageButton.Text = currentLanguage == "Russian" and "РУССКИЙ" or "ENGLISH"
    end
    if keyButton and waitingForKey then
        keyButton.Text = localize("PRESS KEY")
    end
    if crossStyleButton then
        crossStyleButton.Text = localize(cfg.CrosshairStyle)
    end
    if skyboxPresetButton then
        skyboxPresetButton.Text = localize(skyboxPresets[math.clamp(cfg.SkyboxPreset, 1, #skyboxPresets)].Name)
    end
    if configSelectButton and not selectedProfileName then
        configSelectButton.Text = localize("NONE") .. "  ▾"
    end
end

local connections = {}
local accentObjects = {}
local transparencyObjects = {}

local startupSound = Instance.new("Sound")
startupSound.Name = "DegradeStartupSound"
startupSound.SoundId = "rbxassetid://9119802009"
startupSound.Volume = 0.28
startupSound.PlaybackSpeed = 0.9
startupSound.Parent = SoundService

local toggleSound = Instance.new("Sound")
toggleSound.Name = "DegradeToggleSound"
toggleSound.SoundId = "rbxassetid://18202483174"
toggleSound.Volume = 0.16
toggleSound.PlaybackSpeed = 1.1
toggleSound.Parent = SoundService

local function playUISound(sound)
    if not cfg.UISounds or not sound then return end
    pcall(function()
        if sound.IsPlaying then sound:Stop() end
        if sound.IsLoaded then sound.TimePosition = 0 end
        sound:Play()
    end)
end

local function track(connection)
    table.insert(connections, connection)
    return connection
end

--====================================================
-- HELPERS
--====================================================

local function make(class, props, parent)
    local obj = Instance.new(class)

    for key, value in pairs(props or {}) do
        obj[key] = value
    end

    if obj:IsA("TextBox") and props and props.PlaceholderText then
        registerLocale(obj, "PlaceholderText", props.PlaceholderText)
    end

    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function text(parent, value, size, pos, dim, color, font, localizeText)
    local label = make("TextLabel", {
        BackgroundTransparency = 1,
        Text = value,
        TextSize = size,
        Position = pos,
        Size = dim,
        TextColor3 = color or C.White,
        Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
    if localizeText ~= false then
        registerLocale(label, "Text", value)
    end
    return label
end

local function registerAccent(obj, property)
    table.insert(accentObjects, {
        Object = obj,
        Property = property
    })
end

local function registerTransparency(obj, property, base)
    table.insert(transparencyObjects, {
        Object = obj,
        Property = property,
        Base = base
    })
end

local function applyAccent()
    for _, item in ipairs(accentObjects) do
        if item.Object and item.Object.Parent then
            item.Object[item.Property] = C.Accent
        end
    end
end

local function applyTransparency()
    for _, item in ipairs(transparencyObjects) do
        if item.Object and item.Object.Parent then
            item.Object[item.Property] = math.clamp(
                item.Base + cfg.MenuTransparency,
                0,
                1
            )
        end
    end
end

--====================================================
-- GUI ROOT
--====================================================

local gui = make("ScreenGui", {
    Name = "DegradePrivateV50",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 100
}, playerGui)

local espGui = make("ScreenGui", {
    Name = "DegradeESPV50",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 50
}, playerGui)

--====================================================
-- ESP SYSTEM
--====================================================

local espData = {}

local function removeESP(plr)
    local data = espData[plr]
    if not data then return end

    if data.box then data.box:Destroy() end
    if data.info then data.info:Destroy() end
    if data.arrow then data.arrow:Destroy() end
    if data.highlight then data.highlight:Destroy() end

    espData[plr] = nil
end

local function attachCharacter(plr, character)
    local data = espData[plr]
    if not data then return end

    if data.highlight then
        data.highlight:Destroy()
        data.highlight = nil
    end

    data.character = character

    local highlight = make("Highlight", {
        Name = "DegradePlayerHighlight",
        Adornee = character,
        FillColor = cfg.ESPPlayerColor,
        OutlineColor = C.White,
        FillTransparency = cfg.PlayerChamsFillTransparency,
        OutlineTransparency = cfg.PlayerChamsOutlineTransparency,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        Enabled = cfg.Highlight
    }, character)

    data.highlight = highlight
end

local function createESP(plr)
    if plr == player or espData[plr] then return end

    local box = make("Frame", {
        Name = "PlayerBox",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Visible = false
    }, espGui)

    round(box, 2)

    local stroke = make("UIStroke", {
        Color = cfg.ESPPlayerColor,
        Thickness = 1.5,
        Transparency = 0
    }, box)

    local info = make("TextLabel", {
        Name = "PlayerInfo",
        BackgroundTransparency = 1,
        TextColor3 = C.White,
        TextStrokeTransparency = 0.2,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.fromOffset(360, 20),
        Visible = false
    }, espGui)

    local arrow = make("TextLabel", {
        Name = "OffscreenArrow",
        BackgroundTransparency = 1,
        Text = "▲",
        TextColor3 = cfg.ESPPlayerColor,
        TextStrokeColor3 = C.Background,
        TextStrokeTransparency = 0,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(32, 32),
        Visible = false
    }, espGui)
    espData[plr] = {
        box = box,
        info = info,
        arrow = arrow,
        stroke = stroke,
        character = nil,
        highlight = nil
    }

    track(plr.CharacterAdded:Connect(function(character)
        attachCharacter(plr, character)
    end))

    if plr.Character then
        attachCharacter(plr, plr.Character)
    end
end

for _, plr in ipairs(Players:GetPlayers()) do
    createESP(plr)
end

track(Players.PlayerAdded:Connect(createESP))
track(Players.PlayerRemoving:Connect(removeESP))

local armsChamsHighlights = {}
local armsCharacterConnection
local armsCameraConnection
local trackedArmsCamera

local armPartNames = {
    leftarm = true, rightarm = true,
    ["left arm"] = true, ["right arm"] = true,
    leftupperarm = true, rightupperarm = true,
    leftlowerarm = true, rightlowerarm = true,
    lefthand = true, righthand = true,
    larm = true, rarm = true, arml = true, armr = true,
    leftforearm = true, rightforearm = true,
    leftwrist = true, rightwrist = true
}

local function isArmPart(instance)
    if not instance:IsA("BasePart") then return false end
    local name = string.lower(instance.Name)
    if armPartNames[name] then return true end
    local compactName = string.gsub(name, "[%s_%-]", "")
    if armPartNames[compactName] then return true end
    local hasArm = string.find(compactName, "arm", 1, true) or string.find(compactName, "hand", 1, true)
    local hasSide = string.find(compactName, "left", 1, true) or string.find(compactName, "right", 1, true)
        or string.match(compactName, "^[lr]arm") or string.match(compactName, "arm[lr]$")
    return hasArm ~= nil and hasSide ~= nil
end

local function clearArmsChams()
    for part, highlight in pairs(armsChamsHighlights) do
        if highlight then highlight:Destroy() end
        armsChamsHighlights[part] = nil
    end
end

local function addArmsChamsPart(part, owner)
    if not cfg.ArmsChams or not isArmPart(part) or armsChamsHighlights[part] then return end
    if not owner or not part:IsDescendantOf(owner) then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "DegradeArmsChams"
    highlight.Adornee = part
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = cfg.ArmsChamsColor
    highlight.FillTransparency = cfg.ArmsChamsFillTransparency
    highlight.OutlineColor = cfg.ArmsChamsColor
    highlight.OutlineTransparency = cfg.ArmsChamsOutlineTransparency
    highlight.Parent = workspace
    armsChamsHighlights[part] = highlight
end

local function clearArmsChamsFor(owner)
    if not owner then return end
    for part, highlight in pairs(armsChamsHighlights) do
        if part == owner or part:IsDescendantOf(owner) then
            if highlight then highlight:Destroy() end
            armsChamsHighlights[part] = nil
        end
    end
end

local function bindArmsCharacter(character)
    if armsCharacterConnection then
        armsCharacterConnection:Disconnect()
        armsCharacterConnection = nil
    end
    armsCharacterConnection = track(character.DescendantAdded:Connect(function(instance)
        task.defer(addArmsChamsPart, instance, character)
    end))
    if cfg.ArmsChams then
        for _, instance in ipairs(character:GetDescendants()) do
            addArmsChamsPart(instance, character)
        end
    end
end

local function bindArmsCamera(camera)
    if trackedArmsCamera ~= camera then
        if armsCameraConnection then
            armsCameraConnection:Disconnect()
            armsCameraConnection = nil
        end
        clearArmsChamsFor(trackedArmsCamera)
        trackedArmsCamera = camera
    end
    if not camera then return end
    if not armsCameraConnection then
        armsCameraConnection = track(camera.DescendantAdded:Connect(function(instance)
            task.defer(addArmsChamsPart, instance, camera)
        end))
    end
    if cfg.ArmsChams then
        for _, instance in ipairs(camera:GetDescendants()) do
            addArmsChamsPart(instance, camera)
        end
    end
end

applyArmsChams = function()
    if not cfg.ArmsChams then
        clearArmsChams()
        return
    end
    local character = player.Character
    if character then
        for _, instance in ipairs(character:GetDescendants()) do
            addArmsChamsPart(instance, character)
        end
    end
    bindArmsCamera(workspace.CurrentCamera)
end

track(player.CharacterAdded:Connect(function(character)
    clearArmsChams()
    bindArmsCharacter(character)
    bindArmsCamera(workspace.CurrentCamera)
    if refreshESPPreview then task.defer(refreshESPPreview, true) end
end))
if player.Character then bindArmsCharacter(player.Character) end
bindArmsCamera(workspace.CurrentCamera)
track(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    bindArmsCamera(workspace.CurrentCamera)
end))

local backpackHighlights = {}
local backpackLabels = {}

local function hasBackpackName(instance)
    local name = string.lower(instance.Name)
    return string.find(name, "backpack", 1, true) ~= nil
        or string.find(name, "back pack", 1, true) ~= nil
        or string.find(name, "rucksack", 1, true) ~= nil
end

local function belongsToPlayerCharacter(instance)
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        local character = targetPlayer.Character
        if character and instance:IsDescendantOf(character) then
            return true
        end
    end
    return false
end

local function getBackpackAdornee(instance)
    if instance:IsA("Model") or instance:IsA("BasePart") then
        return instance
    elseif instance:IsA("Tool") then
        local handle = instance:FindFirstChild("Handle", true)
        if handle and handle:IsA("BasePart") then
            return handle
        end
        for _, descendant in ipairs(instance:GetDescendants()) do
            if descendant:IsA("BasePart") then return descendant end
        end
    end
    return nil
end

local function getBackpackLabelAdornee(instance)
    if instance:IsA("BasePart") then return instance end
    if instance:IsA("Model") then
        if instance.PrimaryPart then return instance.PrimaryPart end
        for _, descendant in ipairs(instance:GetDescendants()) do
            if descendant:IsA("BasePart") then return descendant end
        end
    elseif instance:IsA("Tool") then
        local handle = instance:FindFirstChild("Handle", true)
        if handle and handle:IsA("BasePart") then return handle end
        for _, descendant in ipairs(instance:GetDescendants()) do
            if descendant:IsA("BasePart") then return descendant end
        end
    end
    return nil
end

local function addBackpackHighlight(instance)
    if not cfg.BackpackESP or backpackHighlights[instance] then return end
    if not (instance:IsA("Model") or instance:IsA("BasePart") or instance:IsA("Tool")) then return end
    if not hasBackpackName(instance) or belongsToPlayerCharacter(instance) then return end

    if instance:IsA("BasePart") then
        local ancestor = instance.Parent
        while ancestor and ancestor ~= workspace do
            if ancestor:IsA("Model") and hasBackpackName(ancestor) then
                return
            end
            ancestor = ancestor.Parent
        end
    end

    local adornee = getBackpackAdornee(instance)
    if not adornee then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "DegradeDroppedBackpackHighlight"
    highlight.Adornee = adornee
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = cfg.ESPDroppedColor
    highlight.FillTransparency = 0.62
    highlight.OutlineColor = C.White
    highlight.OutlineTransparency = 0.05
    highlight.Parent = workspace
    backpackHighlights[instance] = highlight

    local labelAdornee = getBackpackLabelAdornee(instance)
    if labelAdornee then
        local billboard = make("BillboardGui", {
            Name = "DegradeDroppedBackpackName",
            Adornee = labelAdornee,
            Size = UDim2.fromOffset(190, 24),
            StudsOffset = Vector3.new(0, 2.3, 0),
            AlwaysOnTop = true,
            MaxDistance = 10000
        }, playerGui)
        make("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = instance.Name,
            TextColor3 = cfg.ESPDroppedColor,
            TextStrokeColor3 = C.Background,
            TextStrokeTransparency = 0.1,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextTruncate = Enum.TextTruncate.AtEnd
        }, billboard)
        backpackLabels[instance] = billboard
    end
end

local function clearBackpackHighlights()
    for instance, highlight in pairs(backpackHighlights) do
        if highlight then highlight:Destroy() end
        backpackHighlights[instance] = nil
    end
    for instance, billboard in pairs(backpackLabels) do
        if billboard then billboard:Destroy() end
        backpackLabels[instance] = nil
    end
end

applyBackpackESP = function()
    if cfg.BackpackESP then
        for _, instance in ipairs(workspace:GetDescendants()) do
            addBackpackHighlight(instance)
        end
    else
        clearBackpackHighlights()
    end
end

track(workspace.DescendantAdded:Connect(function(instance)
    task.defer(addBackpackHighlight, instance)
end))

track(workspace.DescendantRemoving:Connect(function(instance)
    local highlight = backpackHighlights[instance]
    if highlight then
        highlight:Destroy()
        backpackHighlights[instance] = nil
    end
    local billboard = backpackLabels[instance]
    if billboard then
        billboard:Destroy()
        backpackLabels[instance] = nil
    end
end))

local weaponHighlights = {}
local weaponLabels = {}

local weaponNameHints = {
    "weapon", "gun", "rifle", "pistol", "shotgun", "sniper", "revolver",
    "smg", "carbine", "sword", "blade", "bow", "crossbow", "ak-", "ak ",
    "m4", "mp5", "uzi", "deagle", "glock", "sawed-off", "sawed off"
}

local function hasWeaponName(instance)
    local name = string.lower(instance.Name)
    if hasBackpackName(instance) then return false end
    for _, hint in ipairs(weaponNameHints) do
        if string.find(name, hint, 1, true) then return true end
    end
    return false
end

local function getWeaponAdornee(instance)
    if instance:IsA("Model") or instance:IsA("BasePart") then return instance end
    if instance:IsA("Tool") then
        local handle = instance:FindFirstChild("Handle", true)
        if handle and handle:IsA("BasePart") then return handle end
        for _, descendant in ipairs(instance:GetDescendants()) do
            if descendant:IsA("BasePart") then return descendant end
        end
    end
    return nil
end

local function addWeaponHighlight(instance)
    if not cfg.DroppedWeaponESP or weaponHighlights[instance] then return end
    if not (instance:IsA("Model") or instance:IsA("BasePart") or instance:IsA("Tool")) then return end
    if belongsToPlayerCharacter(instance) then return end
    -- Dropped Tools are treated as weapons; named world models/parts use common weapon-name hints.
    if not instance:IsA("Tool") and not hasWeaponName(instance) then return end
    if instance:IsA("Tool") and hasBackpackName(instance) then return end

    if instance:IsA("BasePart") then
        local ancestor = instance.Parent
        while ancestor and ancestor ~= workspace do
            if ancestor:IsA("Model") and (hasWeaponName(ancestor) or ancestor:IsA("Tool")) then return end
            ancestor = ancestor.Parent
        end
    end

    local adornee = getWeaponAdornee(instance)
    if not adornee then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "DegradeDroppedWeaponHighlight"
    highlight.Adornee = adornee
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = cfg.ESPDroppedColor
    highlight.FillTransparency = 0.55
    highlight.OutlineColor = C.White
    highlight.OutlineTransparency = 0.05
    highlight.Parent = workspace
    weaponHighlights[instance] = highlight

    local labelPart = getBackpackLabelAdornee(instance)
    if labelPart then
        local billboard = make("BillboardGui", {
            Name = "DegradeDroppedWeaponName",
            Adornee = labelPart,
            Size = UDim2.fromOffset(190, 24),
            StudsOffset = Vector3.new(0, 2.3, 0),
            AlwaysOnTop = true,
            MaxDistance = 10000
        }, playerGui)
        make("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = instance.Name,
            TextColor3 = cfg.ESPDroppedColor,
            TextStrokeColor3 = C.Background,
            TextStrokeTransparency = 0.1,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextTruncate = Enum.TextTruncate.AtEnd
        }, billboard)
        weaponLabels[instance] = billboard
    end
end

local function clearWeaponHighlights()
    for instance, highlight in pairs(weaponHighlights) do
        if highlight then highlight:Destroy() end
        weaponHighlights[instance] = nil
    end
    for instance, billboard in pairs(weaponLabels) do
        if billboard then billboard:Destroy() end
        weaponLabels[instance] = nil
    end
end

applyDroppedWeaponESP = function()
    if cfg.DroppedWeaponESP then
        for _, instance in ipairs(workspace:GetDescendants()) do
            addWeaponHighlight(instance)
        end
    else
        clearWeaponHighlights()
    end
end

track(workspace.DescendantAdded:Connect(function(instance)
    task.defer(addWeaponHighlight, instance)
end))

track(workspace.DescendantRemoving:Connect(function(instance)
    local highlight = weaponHighlights[instance]
    if highlight then
        highlight:Destroy()
        weaponHighlights[instance] = nil
    end
    local billboard = weaponLabels[instance]
    if billboard then
        billboard:Destroy()
        weaponLabels[instance] = nil
    end
end))

local function droppedItemPosition(instance)
    if instance:IsA("BasePart") then return instance.Position end
    if instance:IsA("Model") then
        local ok, pivot = pcall(function() return instance:GetPivot() end)
        if ok then return pivot.Position end
    elseif instance:IsA("Tool") then
        local handle = instance:FindFirstChild("Handle", true)
        if handle and handle:IsA("BasePart") then return handle.Position end
    end
    return nil
end

local function updateDroppedItemDistances()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local cameraPosition = camera.CFrame.Position
    local function updateMap(highlights, labels, maxDistance)
        for instance, highlight in pairs(highlights) do
            local position = droppedItemPosition(instance)
            local visible = position ~= nil
                and (position - cameraPosition).Magnitude <= maxDistance
            if highlight and highlight.Parent then highlight.Enabled = visible end
            local label = labels[instance]
            if label and label.Parent then label.Enabled = visible end
        end
    end
    updateMap(backpackHighlights, backpackLabels, cfg.DroppedMaxDistance)
    updateMap(weaponHighlights, weaponLabels, cfg.DroppedMaxDistance)
end

local function updateESP()
    local camera = workspace.CurrentCamera
    if not camera then return end

    local myCharacter = player.Character
    local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")

    for plr, data in pairs(espData) do
        local character = plr.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")

        local distance = 0
        if myRoot and root then
            distance = (root.Position - myRoot.Position).Magnitude
        end
        local inRange = not myRoot or not root or distance <= cfg.ESPMaxDistance
        if data.highlight then
            data.highlight.Enabled = cfg.Highlight and inRange
            data.highlight.FillColor = cfg.ESPPlayerColor
            data.highlight.FillTransparency = cfg.PlayerChamsFillTransparency
            data.highlight.OutlineTransparency = cfg.PlayerChamsOutlineTransparency
        end

        if not character or not humanoid or not root or humanoid.Health <= 0 or not inRange then
            data.box.Visible = false
            data.info.Visible = false
            data.arrow.Visible = false
            continue
        end

        local projectedRoot = camera:WorldToViewportPoint(root.Position)
        local viewport = camera.ViewportSize
        local rootOnScreen = projectedRoot.Z > 0
            and projectedRoot.X >= 0 and projectedRoot.X <= viewport.X
            and projectedRoot.Y >= 0 and projectedRoot.Y <= viewport.Y

        data.arrow.Visible = false
        if cfg.ESPArrows and not rootOnScreen then
            local cameraSpace = camera.CFrame:PointToObjectSpace(root.Position)
            local direction = Vector2.new(cameraSpace.X, -cameraSpace.Y)
            if cameraSpace.Z > 0 then direction = -direction end
            if direction.Magnitude < 0.001 then direction = Vector2.new(0, -1) end

            local unitDirection = direction.Unit
            local center = viewport / 2
            local halfWidth = math.max(center.X - 28, 0)
            local halfHeight = math.max(center.Y - 28, 0)
            local distanceToEdge = math.huge
            if math.abs(unitDirection.X) > 0.001 then
                distanceToEdge = math.min(distanceToEdge, halfWidth / math.abs(unitDirection.X))
            end
            if math.abs(unitDirection.Y) > 0.001 then
                distanceToEdge = math.min(distanceToEdge, halfHeight / math.abs(unitDirection.Y))
            end
            local arrowPosition = center + unitDirection * distanceToEdge
            data.arrow.Position = UDim2.fromOffset(arrowPosition.X, arrowPosition.Y)
            data.arrow.Rotation = math.deg(math.atan2(unitDirection.Y, unitDirection.X)) + 90
            data.arrow.Visible = true
        end

        local success, cf, size = pcall(function()
            return character:GetBoundingBox()
        end)

        if not success or not cf or not size then
            data.box.Visible = false
            data.info.Visible = false
            continue
        end

        local half = size / 2
        local minX, minY = math.huge, math.huge
        local maxX, maxY = -math.huge, -math.huge
        local frontCount = 0

        for x = -1, 1, 2 do
            for y = -1, 1, 2 do
                for z = -1, 1, 2 do
                    local worldPoint = cf:PointToWorldSpace(Vector3.new(
                        half.X * x,
                        half.Y * y,
                        half.Z * z
                    ))

                    local point = camera:WorldToViewportPoint(worldPoint)

                    if point.Z > 0 then
                        frontCount += 1
                        minX = math.min(minX, point.X)
                        minY = math.min(minY, point.Y)
                        maxX = math.max(maxX, point.X)
                        maxY = math.max(maxY, point.Y)
                    end
                end
            end
        end

        if frontCount == 0 or maxX <= minX or maxY <= minY then
            data.box.Visible = false
            data.info.Visible = false
            continue
        end

        local width = maxX - minX
        local height = maxY - minY
        local centerX = (minX + maxX) / 2
        local centerY = (minY + maxY) / 2

        data.box.Position = UDim2.fromOffset(centerX, centerY)
        data.box.Size = UDim2.fromOffset(width, height)
        data.box.Visible = cfg.BoxESP

        distance = math.floor(distance)
        local infoText = ""
        if cfg.Names then infoText = plr.DisplayName end
        if cfg.Distance then
            if infoText ~= "" then infoText = infoText .. "  |  " end
            infoText = infoText .. distance .. " " .. localize("studs")
        end
        if cfg.ESPHealth then
            if infoText ~= "" then infoText = infoText .. "  |  " end
            infoText = infoText .. localize("HP: ")
                .. math.floor(humanoid.Health + 0.5)
                .. "/" .. math.floor(humanoid.MaxHealth + 0.5)
        end
        if cfg.ESPWeapon then
            if infoText ~= "" then infoText = infoText .. "  |  " end
            local equippedTool = character:FindFirstChildOfClass("Tool")
            infoText = infoText .. localize("Weapon: ")
                .. (equippedTool and equippedTool.Name or localize("None"))
        end
        data.info.Text = infoText
        data.info.TextColor3 = cfg.ESPPlayerColor
        data.info.Position = UDim2.fromOffset(centerX, minY - 3)
        data.info.Visible = infoText ~= ""

    end
end

--====================================================
-- MAIN WINDOW
--====================================================

local main = make("Frame", {
    Size = UDim2.fromOffset(760, 500),
    Position = UDim2.new(0.5, -380, 0.5, -250),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)

round(main, 14)
make("UIGradient", {
    Rotation = 35,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C.Background),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 25, 38))
    })
}, main)
registerTransparency(main, "BackgroundTransparency", 0.035)

local scaleObject = make("UIScale", {
    Scale = cfg.MenuScale
}, main)

local outline = make("UIStroke", {
    Color = C.Accent,
    Thickness = 1.5,
    Transparency = 0.2
}, main)

registerAccent(outline, "Color")

local sidebar = make("Frame", {
    Size = UDim2.new(0, 184, 1, 0),
    BackgroundColor3 = C.Sidebar,
    BorderSizePixel = 0
}, main)
registerTransparency(sidebar, "BackgroundTransparency", 0)
make("UIGradient", {
    Rotation = 90,
    Color = ColorSequence.new(C.Sidebar, Color3.fromRGB(8, 15, 24))
}, sidebar)

local logo = make("Frame", {
    Size = UDim2.fromOffset(38, 38),
    Position = UDim2.fromOffset(16, 19),
    BackgroundColor3 = C.Accent
}, sidebar)

round(logo, 10)
registerAccent(logo, "BackgroundColor3")

local logoText = text(
    logo,
    "D",
    23,
    UDim2.fromScale(0, 0),
    UDim2.fromScale(1, 1),
    Color3.new(1, 1, 1),
    Enum.Font.GothamBold
)

logoText.TextXAlignment = Enum.TextXAlignment.Center

text(sidebar, "RWEESNE", 16,
    UDim2.fromOffset(66, 17),
    UDim2.fromOffset(108, 23),
    C.White,
    Enum.Font.GothamBold
)

text(sidebar, "PRIVATE V5.0", 10,
    UDim2.fromOffset(66, 38),
    UDim2.fromOffset(108, 18),
    C.Muted
)

local searchBox = make("TextBox", {
    Position = UDim2.fromOffset(12, 70),
    Size = UDim2.new(1, -24, 0, 30),
    BackgroundColor3 = C.Panel,
    Text = "",
    PlaceholderText = "Search this page...",
    PlaceholderColor3 = C.Muted,
    TextColor3 = C.White,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    BorderSizePixel = 0
}, sidebar)
round(searchBox, 8)
make("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 8)}, searchBox)

local nav = make("Frame", {
    Position = UDim2.fromOffset(10, 122),
    Size = UDim2.new(1, -20, 0, 280),
    BackgroundTransparency = 1
}, sidebar)

    make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, nav)

text(sidebar, "NAVIGATION", 9,
    UDim2.fromOffset(14, 105),
    UDim2.new(1, -28, 0, 14),
    C.Muted,
    Enum.Font.GothamSemibold
)

make("Frame", {
    Position = UDim2.new(0, 14, 1, -42),
    Size = UDim2.new(1, -28, 0, 1),
    BackgroundColor3 = C.Off,
    BorderSizePixel = 0
}, sidebar)

text(sidebar, "V5.0  •  CLIENT", 9,
    UDim2.new(0, 16, 1, -32),
    UDim2.new(1, -32, 0, 16),
    C.Muted,
    Enum.Font.GothamSemibold
)

--====================================================
-- HEADER
--====================================================

local header = make("Frame", {
    Position = UDim2.fromOffset(184, 0),
    Size = UDim2.new(1, -184, 0, 72),
    BackgroundTransparency = 1
}, main)

text(header, "RWEESNE PRIVATE", 20,
    UDim2.fromOffset(24, 11),
    UDim2.fromOffset(290, 29),
    C.White,
    Enum.Font.GothamBold
)

text(header, "PLAYER VISUAL INTERFACE", 9,
    UDim2.fromOffset(25, 41),
    UDim2.fromOffset(260, 16),
    C.Muted
)

local profileCard = make("Frame", {
    Name = "PlayerProfile",
    Position = UDim2.new(1, -194, 0, 12),
    Size = UDim2.fromOffset(180, 48),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0
}, header)
round(profileCard, 12)
registerTransparency(profileCard, "BackgroundTransparency", 0.08)
make("UIGradient", {
    Rotation = 0,
    Color = ColorSequence.new(C.Panel, Color3.fromRGB(14, 27, 39))
}, profileCard)
local profileStroke = make("UIStroke", {
    Color = C.Accent,
    Thickness = 1,
    Transparency = 0.78
}, profileCard)
registerAccent(profileStroke, "Color")

local onlineDot = make("Frame", {
    Name = "OnlineIndicator",
    Position = UDim2.fromOffset(34, 31),
    Size = UDim2.fromOffset(10, 10),
    BackgroundColor3 = Color3.fromRGB(70, 220, 165),
    BorderSizePixel = 0,
    ZIndex = 5
}, profileCard)
round(onlineDot, 5)
make("UIStroke", {Color = C.Panel, Thickness = 2}, onlineDot)

local profileAvatar = make("ImageLabel", {
    Name = "Avatar",
    Position = UDim2.fromOffset(7, 7),
    Size = UDim2.fromOffset(34, 34),
    BackgroundColor3 = C.Off,
    BorderSizePixel = 0,
    Image = "",
    ScaleType = Enum.ScaleType.Crop
}, profileCard)
round(profileAvatar, 17)

local profileDisplayName = text(profileCard, player.DisplayName, 11,
    UDim2.fromOffset(48, 6),
    UDim2.new(1, -54, 0, 19),
    C.White,
    Enum.Font.GothamBold,
    false
)
profileDisplayName.TextTruncate = Enum.TextTruncate.AtEnd

local profileUsername = text(profileCard, "@" .. player.Name, 9,
    UDim2.fromOffset(48, 25),
    UDim2.new(1, -54, 0, 16),
    C.Muted,
    nil,
    false
)
profileUsername.TextTruncate = Enum.TextTruncate.AtEnd

task.spawn(function()
    local success, image = pcall(function()
        local content, _ = Players:GetUserThumbnailAsync(
            player.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size100x100
        )
        return content
    end)
    if success and profileAvatar.Parent then
        profileAvatar.Image = image
    end
end)

make("Frame", {
    Position = UDim2.new(0, 20, 1, -1),
    Size = UDim2.new(1, -40, 0, 1),
    BackgroundColor3 = C.Off,
    BorderSizePixel = 0
}, header)

--====================================================
-- CONTENT / PAGES
--====================================================

local content = make("Frame", {
    Position = UDim2.fromOffset(206, 84),
    Size = UDim2.new(1, -226, 1, -102),
    BackgroundTransparency = 1
}, main)

local pages = {}
local navButtons = {}
local navIndicators = {}
local navLabels = {}
local navIcons = {}
local pageLists = {}

local function createPage(name, title, subtitle)
    local page = make("Frame", {
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Visible = false
    }, content)

    pages[name] = page

    text(page, title, 19,
        UDim2.fromOffset(0, 0),
        UDim2.new(1, 0, 0, 30),
        C.White,
        Enum.Font.GothamBold
    )

    text(page, subtitle, 11,
        UDim2.fromOffset(0, 31),
        UDim2.new(1, 0, 0, 23),
        C.Muted
    )

    local list = make("ScrollingFrame", {
        Position = UDim2.fromOffset(0, 68),
        Size = UDim2.new(1, 0, 1, -68),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = C.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, page)

    registerAccent(list, "ScrollBarImageColor3")

make("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, list)

    pageLists[name] = list
    return list
end

local visualList = createPage(
    "Visuals",
    "Visuals",
    "Player and dropped-item ESP"
)

visualList.Position = UDim2.fromOffset(0, 100)
visualList.Size = UDim2.new(1, -220, 1, -100)

local currentVisualGroup = "Players"
local visualCardGroups = {}
local visualTabButtons = {}
local visualTabStrokes = {}
local filterPage

local visualTabBar = make("Frame", {
    Position = UDim2.fromOffset(0, 61),
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundTransparency = 1
}, pages.Visuals)

local function updateVisualTabAppearance()
    for groupName, button in pairs(visualTabButtons) do
        local selected = currentVisualGroup == groupName
        button.BackgroundColor3 = selected and C.Panel or C.Sidebar
        button.BackgroundTransparency = selected and 0.05 or 0.65
        button.TextColor3 = selected and C.White or C.Muted
        visualTabStrokes[groupName].Transparency = selected and 0.35 or 0.9
    end
end

local function createVisualSubtab(groupName, position, size)
    local button = make("TextButton", {
        Position = position,
        Size = size,
        BackgroundColor3 = C.Sidebar,
        BackgroundTransparency = 0.65,
        Text = groupName,
        TextColor3 = C.Muted,
        TextSize = 10,
        Font = Enum.Font.GothamSemibold,
        AutoButtonColor = false,
        BorderSizePixel = 0
    }, visualTabBar)
    round(button, 8)
    registerLocale(button, "Text", groupName)
    local stroke = make("UIStroke", {
        Color = C.Accent,
        Thickness = 1,
        Transparency = 0.9
    }, button)
    registerAccent(stroke, "Color")
    visualTabButtons[groupName] = button
    visualTabStrokes[groupName] = stroke
    track(button.MouseButton1Click:Connect(function()
        currentVisualGroup = groupName
        updateVisualTabAppearance()
        if filterPage then filterPage("Visuals") end
    end))
end

createVisualSubtab("Players", UDim2.new(0, 0, 0, 0), UDim2.new(0.5, -4, 1, 0))
createVisualSubtab("Dropped Items", UDim2.new(0.5, 4, 0, 0), UDim2.new(0.5, -4, 1, 0))
updateVisualTabAppearance()

local settingsList = createPage(
    "Settings",
    "Settings",
    "Customize your interface"
)

local hudList = createPage(
    "HUD",
    "Performance HUD",
    "Live performance information"
)

local crosshairList = createPage(
    "Crosshair",
    "Crosshair Editor",
    "Customize your crosshair"
)

local miscList = createPage(
    "Misc",
    "Misc",
    "Camera field of view controls"
)

local currentPageName
local navStrokes = {}
filterPage = function(name)
    local list = pageLists[name]
    if not list then return end
    local query = string.lower(searchBox.Text)

    for _, card in ipairs(list:GetChildren()) do
        if card:IsA("Frame") then
            local cardText = {}
            for _, item in ipairs(card:GetDescendants()) do
                if item:IsA("TextLabel") or item:IsA("TextButton") then
                    table.insert(cardText, item.Text)
                end
            end
            local matches = query == "" or string.find(string.lower(table.concat(cardText, " ")), query, 1, true) ~= nil
            local group = name == "Visuals" and visualCardGroups[card] or nil
            local groupMatches = group == nil or group == currentVisualGroup
            card.Visible = matches and groupMatches
        end
    end
end

track(searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    if currentPageName then filterPage(currentPageName) end
end))

local function switchPage(name)
    if currentPageName ~= name then searchBox.Text = "" end
    currentPageName = name
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
        if pageName == name then
            page.Position = UDim2.fromOffset(0, 5)
            TweenService:Create(page, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromOffset(0, 0)
            }):Play()
        end
    end

    for pageName, button in pairs(navButtons) do
        local selected = pageName == name
        TweenService:Create(button, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = selected and C.Panel or C.Sidebar,
            BackgroundTransparency = selected and 0.08 or 1
        }):Play()
        navLabels[pageName].TextColor3 = selected and C.White or C.Muted
        navIcons[pageName].TextColor3 = selected and C.Accent or C.Muted
        navIndicators[pageName].Visible = selected
        if navStrokes[pageName] then
            TweenService:Create(navStrokes[pageName], TweenInfo.new(0.16), {
                Transparency = selected and 0.58 or 1
            }):Play()
        end
    end
    filterPage(name)
end

local function addNav(name, symbol)
    local button = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = C.Sidebar,
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0
    }, nav)

    round(button, 10)
    local navStroke = make("UIStroke", {
        Color = C.Accent,
        Thickness = 1,
        Transparency = 1
    }, button)
    registerAccent(navStroke, "Color")
    navStrokes[name] = navStroke

    local indicator = make("Frame", {
        Size = UDim2.fromOffset(3, 22),
        Position = UDim2.new(0, 0, 0.5, -11),
        BackgroundColor3 = C.Accent,
        BorderSizePixel = 0,
        Visible = false
    }, button)
    round(indicator, 4)
    registerAccent(indicator, "BackgroundColor3")

    local icon = text(button, symbol, 15,
        UDim2.fromOffset(12, 0),
        UDim2.fromOffset(22, 40),
        C.Muted,
        Enum.Font.GothamBold
    )
    icon.TextXAlignment = Enum.TextXAlignment.Center

    local label = text(button, string.upper(name), 11,
        UDim2.fromOffset(43, 0),
        UDim2.new(1, -50, 1, 0),
        C.Muted,
        Enum.Font.GothamSemibold
    )

    navIndicators[name] = indicator
    navLabels[name] = label
    navIcons[name] = icon

    navButtons[name] = button

    track(button.MouseEnter:Connect(function()
        if not pages[name].Visible then
            TweenService:Create(button, TweenInfo.new(0.12), {
                BackgroundTransparency = 0.45,
                BackgroundColor3 = C.Panel
            }):Play()
        end
    end))

    track(button.MouseLeave:Connect(function()
        if not pages[name].Visible then
            TweenService:Create(button, TweenInfo.new(0.12), {
                BackgroundTransparency = 1,
                BackgroundColor3 = C.Sidebar
            }):Play()
        end
    end))

    track(button.MouseButton1Click:Connect(function()
        switchPage(name)
    end))
end

addNav("Visuals", "◇")
addNav("Settings", "⚙")
addNav("HUD", "▦")
addNav("Crosshair", "＋")
addNav("Misc", "✦")

--====================================================
-- UI CARD HELPERS
--====================================================

local function createCard(parent, height)
    local card = make("Frame", {
        Size = UDim2.new(1, 0, 0, height or 66),
        BackgroundColor3 = C.Panel,
        BorderSizePixel = 0
    }, parent)

    round(card, 11)
    registerTransparency(card, "BackgroundTransparency", 0.06)
    make("UIGradient", {
        Rotation = 0,
        Color = ColorSequence.new(C.Panel, Color3.fromRGB(13, 23, 34))
    }, card)

    local stroke = make("UIStroke", {
        Color = C.Accent,
        Thickness = 1,
        Transparency = 0.94
    }, card)
    registerAccent(stroke, "Color")

    return card
end

local toggleControls = {}
local applyFOV
local applySkybox
local applyColorCorrection

local function refreshToggleControls()
    for key, controls in pairs(toggleControls) do
        local enabled = cfg[key]
        if controls.Toggle and controls.Toggle.Parent then
            controls.Toggle.BackgroundColor3 = enabled and C.Accent or C.Off
        end
        if controls.Knob and controls.Knob.Parent then
            controls.Knob.Position = enabled
                and UDim2.fromOffset(22, 3)
                or UDim2.fromOffset(3, 3)
        end
        if controls.Stroke and controls.Stroke.Parent then
            controls.Stroke.Transparency = enabled and 0.38 or 0.88
        end
    end
end

local function addToggle(parent, title, description, key)
    local card = createCard(parent, 62)

    text(card, title, 13,
        UDim2.fromOffset(14, 6),
        UDim2.new(1, -85, 0, 23),
        C.White,
        Enum.Font.GothamBold
    )

    text(card, description, 10,
        UDim2.fromOffset(14, 30),
        UDim2.new(1, -85, 0, 19),
        C.Muted
    )

    local toggle = make("TextButton", {
        Size = UDim2.fromOffset(43, 24),
        Position = UDim2.new(1, -58, 0.5, -12),
        BackgroundColor3 = cfg[key] and C.Accent or C.Off,
        Text = "",
        BorderSizePixel = 0
    }, card)

    round(toggle, 20)
    local toggleStroke = make("UIStroke", {
        Color = C.Accent,
        Thickness = 1,
        Transparency = cfg[key] and 0.38 or 0.88
    }, toggle)
    registerAccent(toggleStroke, "Color")

    local knob = make("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = cfg[key] and UDim2.fromOffset(22, 3) or UDim2.fromOffset(3, 3),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0
    }, toggle)

    round(knob, 20)

    toggleControls[key] = {
        Toggle = toggle,
        Knob = knob,
        Stroke = toggleStroke
    }

    track(toggle.MouseButton1Click:Connect(function()
        cfg[key] = not cfg[key]
        local enabled = cfg[key]

        TweenService:Create(toggle, TweenInfo.new(0.15), {
            BackgroundColor3 = enabled and C.Accent or C.Off
        }):Play()

        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = enabled
                and UDim2.fromOffset(22, 3)
                or UDim2.fromOffset(3, 3)
        }):Play()
        TweenService:Create(toggleStroke, TweenInfo.new(0.15), {
            Transparency = enabled and 0.38 or 0.88
        }):Play()

        if key == "Glow" then
            outline.Transparency = enabled and 0.35 or 1
        elseif key == "FOVEnabled" then
            applyFOV()
        elseif key == "SkyboxEnabled" then
            applySkybox()
        elseif key == "ColorCorrectionEnabled" then
            applyColorCorrection()
        elseif key == "BackpackESP" and applyBackpackESP then
            applyBackpackESP()
        elseif key == "DroppedWeaponESP" and applyDroppedWeaponESP then
            applyDroppedWeaponESP()
        elseif key == "ArmsChams" and applyArmsChams then
            applyArmsChams()
        end

        if cfg.UISounds then playUISound(toggleSound) end
        if refreshESPPreview then refreshESPPreview(false) end
    end))

    return toggle
end

local function addVisualToggle(title, description, key, group)
    local toggle = addToggle(visualList, title, description, key)
    visualCardGroups[toggle.Parent] = group
    return toggle
end

local function addAction(parent, title, description, buttonText, callback)
    local card = createCard(parent, 64)

    text(card, title, 13,
        UDim2.fromOffset(14, 5),
        UDim2.new(1, -145, 0, 23),
        C.White,
        Enum.Font.GothamBold
    )

    text(card, description, 10,
        UDim2.fromOffset(14, 31),
        UDim2.new(1, -145, 0, 18),
        C.Muted
    )

    local button = make("TextButton", {
        Size = UDim2.fromOffset(112, 34),
        Position = UDim2.new(1, -126, 0.5, -17),
        BackgroundColor3 = C.Accent,
        Text = buttonText,
        TextColor3 = C.White,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    }, card)
    registerLocale(button, "Text", buttonText)

    round(button, 7)
    registerAccent(button, "BackgroundColor3")
    local buttonStroke = make("UIStroke", {
        Color = C.Accent,
        Thickness = 1,
        Transparency = 0.68
    }, button)
    registerAccent(buttonStroke, "Color")

    track(button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.14), {
            BackgroundColor3 = C.Accent:Lerp(C.White, 0.12)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.14), {Transparency = 0.25}):Play()
    end))
    track(button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.14), {BackgroundColor3 = C.Accent}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.14), {Transparency = 0.68}):Play()
    end))

    track(button.MouseButton1Click:Connect(callback))
    return button
end

local function addSlider(parent, title, description, key, minValue, maxValue, step, onChanged, visualGroup)
    local card = createCard(parent, 82)
    if visualGroup then visualCardGroups[card] = visualGroup end
    text(card, title, 13, UDim2.fromOffset(14, 5), UDim2.new(1, -90, 0, 22), C.White, Enum.Font.GothamBold)
    text(card, description, 10, UDim2.fromOffset(14, 28), UDim2.new(1, -30, 0, 17), C.Muted)
    local valueLabel = text(card, tostring(cfg[key]), 11, UDim2.new(1, -62, 0, 5), UDim2.fromOffset(48, 22), C.White, Enum.Font.GothamBold)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    local rail = make("Frame", {Size = UDim2.new(1, -28, 0, 5), Position = UDim2.fromOffset(14, 62), BackgroundColor3 = C.Off, BorderSizePixel = 0}, card)
    round(rail, 5)
    local fill = make("Frame", {Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = C.Accent, BorderSizePixel = 0}, rail)
    round(fill, 5)
    local knob = make("TextButton", {Size = UDim2.fromOffset(14, 14), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0), BackgroundColor3 = C.White, Text = "", BorderSizePixel = 0}, rail)
    round(knob, 10)
    registerAccent(fill, "BackgroundColor3")
    local draggingSlider = false
    local function setValue(value)
        value = math.clamp(value, minValue, maxValue)
        value = minValue + math.floor((value - minValue) / step + 0.5) * step
        value = math.clamp(value, minValue, maxValue)
        cfg[key] = value
        local ratio = (value - minValue) / (maxValue - minValue)
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        knob.Position = UDim2.new(ratio, 0, 0.5, 0)
        if key == "MenuTransparency" or key == "HUDTransparency" or key == "HUDScale" then
            valueLabel.Text = string.format("%d%%", math.floor(value * 100 + 0.5))
        elseif key == "MenuScale" then
            valueLabel.Text = string.format("%d%%", math.floor(value * 100 + 0.5))
        else
            valueLabel.Text = step < 1 and string.format("%.2f", value) or tostring(value)
        end
        if onChanged then onChanged(value) end
    end
    local function setFromInput(input)
        local ratio = math.clamp((input.Position.X - rail.AbsolutePosition.X) / rail.AbsoluteSize.X, 0, 1)
        setValue(minValue + ratio * (maxValue - minValue))
    end
    track(rail.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
            setFromInput(input)
        end
    end))
    track(knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
            setFromInput(input)
        end
    end))
    track(UIS.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then setFromInput(input) end
    end))
    track(UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = false end
    end))
    setValue(cfg[key])
    return setValue
end

local espColorPalette = {
    Color3.fromRGB(35, 190, 255),
    Color3.fromRGB(45, 140, 255),
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(255, 75, 85),
    Color3.fromRGB(75, 230, 135),
    Color3.fromRGB(255, 215, 75),
    Color3.fromRGB(175, 110, 255),
    Color3.fromRGB(255, 155, 65),
    Color3.fromRGB(30, 220, 200)
}
local espColorButtons = {}

local function applyESPColorSettings()
    for _, data in pairs(espData) do
        if data.stroke then data.stroke.Color = cfg.ESPPlayerColor end
        if data.info then data.info.TextColor3 = cfg.ESPPlayerColor end
        if data.arrow then data.arrow.TextColor3 = cfg.ESPPlayerColor end
        if data.highlight then
            data.highlight.FillColor = cfg.ESPPlayerColor
            data.highlight.FillTransparency = cfg.PlayerChamsFillTransparency
            data.highlight.OutlineTransparency = cfg.PlayerChamsOutlineTransparency
        end
    end

    for _, highlight in pairs(armsChamsHighlights) do
        if highlight and highlight.Parent then
            highlight.FillColor = cfg.ArmsChamsColor
            highlight.OutlineColor = cfg.ArmsChamsColor
            highlight.FillTransparency = cfg.ArmsChamsFillTransparency
            highlight.OutlineTransparency = cfg.ArmsChamsOutlineTransparency
        end
    end

    local itemMaps = {
        {backpackHighlights, backpackLabels},
        {weaponHighlights, weaponLabels}
    }
    for _, itemMap in ipairs(itemMaps) do
        for _, highlight in pairs(itemMap[1]) do
            if highlight and highlight.Parent then highlight.FillColor = cfg.ESPDroppedColor end
        end
        for _, billboard in pairs(itemMap[2]) do
            local label = billboard and billboard:FindFirstChildWhichIsA("TextLabel")
            if label then label.TextColor3 = cfg.ESPDroppedColor end
        end
    end
    if refreshESPPreview then refreshESPPreview(false) end
end

local function refreshESPColorButtons()
    for colorKey, buttons in pairs(espColorButtons) do
        for _, entry in ipairs(buttons) do
            local color = cfg[colorKey]
            local selected = math.abs(color.R - entry.Color.R) < 0.002
                and math.abs(color.G - entry.Color.G) < 0.002
                and math.abs(color.B - entry.Color.B) < 0.002
            entry.Stroke.Transparency = selected and 0 or 0.78
            entry.Stroke.Thickness = selected and 2 or 1
        end
    end
end

local function addESPColorPicker(title, description, colorKey, group)
    local card = createCard(visualList, 78)
    visualCardGroups[card] = group
    text(card, title, 13, UDim2.fromOffset(14, 5), UDim2.new(1, -28, 0, 22), C.White, Enum.Font.GothamBold)
    text(card, description, 10, UDim2.fromOffset(14, 28), UDim2.new(1, -28, 0, 16), C.Muted)
    espColorButtons[colorKey] = {}

    for index, color in ipairs(espColorPalette) do
        local button = make("TextButton", {
            Position = UDim2.fromOffset(14 + (index - 1) * 31, 49),
            Size = UDim2.fromOffset(22, 22),
            BackgroundColor3 = color,
            Text = "",
            AutoButtonColor = false,
            BorderSizePixel = 0
        }, card)
        round(button, 12)
        local stroke = make("UIStroke", {
            Color = C.White,
            Thickness = 1,
            Transparency = 0.78
        }, button)
        table.insert(espColorButtons[colorKey], {Button = button, Stroke = stroke, Color = color})
        track(button.MouseButton1Click:Connect(function()
            cfg[colorKey] = color
            applyESPColorSettings()
            refreshESPColorButtons()
            if cfg.UISounds then playUISound(toggleSound) end
        end))
    end
end

--====================================================
-- VISUALS PAGE
--====================================================

addVisualToggle("Box ESP",
    "Draw boxes around characters", "BoxESP", "Players")

addVisualToggle("Player Chams",
    "Highlight player silhouettes", "Highlight", "Players")
addVisualToggle("Arms Chams",
    "Highlight your character's arms", "ArmsChams", "Players")

addVisualToggle("Player Names",
    "Display player names", "Names", "Players")

addVisualToggle("Distance",
    "Display distance in studs", "Distance", "Players")

addVisualToggle("Player Health",
    "Display current and maximum health", "ESPHealth", "Players")

addVisualToggle("Player Weapon",
    "Display the equipped Tool name", "ESPWeapon", "Players")

addVisualToggle("Off-screen Arrows",
    "Point toward players outside the screen", "ESPArrows", "Players")

addVisualToggle("Dropped Backpack ESP",
    "Highlight dropped backpacks in the game world", "BackpackESP", "Dropped Items")
addVisualToggle("Dropped Weapon ESP",
    "Highlight dropped weapons and show their names", "DroppedWeaponESP", "Dropped Items")
local playerDistanceRefresh = addSlider(visualList,
    "Player ESP Max Distance", "Maximum player ESP range in studs",
    "ESPMaxDistance", 50, 2000, 25, nil, "Players")

local droppedDistanceRefresh = addSlider(visualList,
    "Dropped Items Max Distance", "Maximum dropped-item ESP range in studs",
    "DroppedMaxDistance", 50, 2000, 25, nil, "Dropped Items")
addESPColorPicker("Player ESP Color", "Choose the player ESP color", "ESPPlayerColor", "Players")
addESPColorPicker("Arms Chams", "Choose the arms chams color", "ArmsChamsColor", "Players")
addESPColorPicker("Dropped Items ESP Color", "Choose the dropped-item ESP color", "ESPDroppedColor", "Dropped Items")
refreshESPColorButtons()

local chamsSliderRefreshers = {
    {addSlider(visualList, "Player Chams Fill", "Player chams fill transparency: 0–1",
        "PlayerChamsFillTransparency", 0, 1, 0.05, function() applyESPColorSettings() end, "Players"), "PlayerChamsFillTransparency"},
    {addSlider(visualList, "Player Chams Outline", "Player chams outline transparency: 0–1",
        "PlayerChamsOutlineTransparency", 0, 1, 0.05, function() applyESPColorSettings() end, "Players"), "PlayerChamsOutlineTransparency"},
    {addSlider(visualList, "Arms Chams Fill", "Arms chams fill transparency: 0–1",
        "ArmsChamsFillTransparency", 0, 1, 0.05, function() applyESPColorSettings() end, "Players"), "ArmsChamsFillTransparency"},
    {addSlider(visualList, "Arms Chams Outline", "Arms chams outline transparency: 0–1",
        "ArmsChamsOutlineTransparency", 0, 1, 0.05, function() applyESPColorSettings() end, "Players"), "ArmsChamsOutlineTransparency"}
}


local espPreviewCard = createCard(pages.Visuals, 292)
espPreviewCard.Position = UDim2.new(1, -200, 0, 100)
espPreviewCard.Size = UDim2.new(0, 200, 1, -100)
text(espPreviewCard, "ESP Preview", 13,
    UDim2.fromOffset(14, 5), UDim2.new(1, -28, 0, 22), C.White, Enum.Font.GothamBold)
text(espPreviewCard, "Current character skin with ESP styling", 10,
    UDim2.fromOffset(14, 28), UDim2.new(1, -28, 0, 16), C.Muted)

local espPreviewViewport = make("ViewportFrame", {
    Position = UDim2.fromOffset(12, 48),
    Size = UDim2.new(1, -24, 1, -60),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = 0.1,
    BorderSizePixel = 0,
    Ambient = Color3.fromRGB(175, 190, 205),
    LightColor = Color3.fromRGB(255, 255, 255),
    LightDirection = Vector3.new(-1, -1, -1),
    ClipsDescendants = true
}, espPreviewCard)
round(espPreviewViewport, 8)
local espPreviewWorld = make("WorldModel", {}, espPreviewViewport)
local espPreviewCamera = make("Camera", {FieldOfView = 32}, espPreviewViewport)
espPreviewViewport.CurrentCamera = espPreviewCamera

local espPreviewBox = make("Frame", {
    Position = UDim2.new(0.05, 0, 0.03, 0),
    Size = UDim2.new(0.9, 0, 0.89, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0
}, espPreviewViewport)
round(espPreviewBox, 5)
local espPreviewBoxStroke = make("UIStroke", {
    Color = cfg.ESPPlayerColor,
    Thickness = 1.5,
    Transparency = 0.05
}, espPreviewBox)

local espPreviewInfo = make("TextLabel", {
    Position = UDim2.new(0, 0, 1, -25),
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = 0.15,
    Text = "",
    TextColor3 = cfg.ESPPlayerColor,
    TextStrokeTransparency = 0.2,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    TextTruncate = Enum.TextTruncate.AtEnd,
    BorderSizePixel = 0
}, espPreviewViewport)

local espPreviewStatus = make("TextLabel", {
    Size = UDim2.new(1, -24, 0, 24),
    Position = UDim2.new(0, 12, 0.5, -12),
    BackgroundTransparency = 1,
    Text = localize("Loading current character..."),
    TextColor3 = C.Muted,
    TextSize = 11,
    Font = Enum.Font.GothamMedium,
    BorderSizePixel = 0
}, espPreviewViewport)

local espPreviewModel
local espPreviewHighlight
local espPreviewLoadId = 0

local function updateESPPreviewBox(model)
    if not model then return end
    local boundsCFrame, boundsSize = model:GetBoundingBox()
    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge
    local projectedCount = 0
    local viewportSize = espPreviewCamera.ViewportSize

    for x = -1, 1, 2 do
        for y = -1, 1, 2 do
            for z = -1, 1, 2 do
                local worldPoint = boundsCFrame:PointToWorldSpace(Vector3.new(
                    boundsSize.X * 0.5 * x,
                    boundsSize.Y * 0.5 * y,
                    boundsSize.Z * 0.5 * z
                ))
                local point = espPreviewCamera:WorldToViewportPoint(worldPoint)
                if point.Z > 0 then
                    local xScale = viewportSize.X > 1 and point.X / viewportSize.X or point.X
                    local yScale = viewportSize.Y > 1 and point.Y / viewportSize.Y or point.Y
                    minX = math.min(minX, xScale)
                    minY = math.min(minY, yScale)
                    maxX = math.max(maxX, xScale)
                    maxY = math.max(maxY, yScale)
                    projectedCount += 1
                end
            end
        end
    end

    if projectedCount == 0 or maxX <= minX or maxY <= minY then return end
    minX = math.clamp(minX - 0.025, 0, 1)
    minY = math.clamp(minY - 0.02, 0, 1)
    maxX = math.clamp(maxX + 0.025, 0, 1)
    maxY = math.clamp(maxY + 0.02, 0, 1)
    espPreviewBox.Position = UDim2.fromScale(minX, minY)
    espPreviewBox.Size = UDim2.fromScale(maxX - minX, maxY - minY)
end

local function rebuildESPPreview()
    espPreviewLoadId += 1
    local loadId = espPreviewLoadId
    espPreviewStatus.Visible = true
    espPreviewStatus.Text = localize("Loading current character...")
    task.spawn(function()
        local character = player.Character
        if not character then
            espPreviewStatus.Text = localize("Character preview unavailable")
            return
        end

        local oldArchivable = character.Archivable
        character.Archivable = true
        local success, clone = pcall(function() return character:Clone() end)
        character.Archivable = oldArchivable
        if not success or not clone then
            if loadId == espPreviewLoadId and espPreviewStatus.Parent then
                espPreviewStatus.Text = localize("Character preview unavailable")
            end
            return
        end

        for _, descendant in ipairs(clone:GetDescendants()) do
            if descendant:IsA("Script") or descendant:IsA("LocalScript")
                or descendant:IsA("ModuleScript") or descendant:IsA("Tool")
                or descendant:IsA("Highlight") or descendant:IsA("BillboardGui") then
                descendant:Destroy()
            elseif descendant:IsA("BasePart") then
                descendant.Anchored = true
                descendant.CanCollide = false
            end
        end

        local oldPivot = clone:GetPivot()
        clone:PivotTo(CFrame.new(0, 0, 0) * (oldPivot - oldPivot.Position))
        if loadId ~= espPreviewLoadId or not espPreviewViewport.Parent then
            clone:Destroy()
            return
        end

        if espPreviewModel then espPreviewModel:Destroy() end
        if espPreviewHighlight then espPreviewHighlight:Destroy() end
        clone.Parent = espPreviewWorld
        espPreviewModel = clone

        local boundsCFrame, boundsSize = clone:GetBoundingBox()
        local focus = boundsCFrame.Position + Vector3.new(0, boundsSize.Y * 0.04, 0)
        local root = clone:FindFirstChild("HumanoidRootPart")
        local forward = root and root.CFrame.LookVector or Vector3.new(0, 0, -1)
        local distance = math.max(boundsSize.Y * 2.05, 5)
        espPreviewCamera.CFrame = CFrame.lookAt(focus + forward * distance, focus)
        updateESPPreviewBox(clone)

        espPreviewHighlight = Instance.new("Highlight")
        espPreviewHighlight.Name = "DegradeESPPreviewHighlight"
        espPreviewHighlight.Adornee = clone
        espPreviewHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        espPreviewHighlight.Parent = espPreviewWorld
        espPreviewStatus.Visible = false
        if refreshESPPreview then refreshESPPreview(false) end
    end)
end

refreshESPPreview = function(rebuild)
    espPreviewBoxStroke.Color = cfg.ESPPlayerColor
    espPreviewBox.Visible = cfg.BoxESP
    espPreviewInfo.TextColor3 = cfg.ESPPlayerColor
    if espPreviewHighlight and espPreviewHighlight.Parent then
        espPreviewHighlight.Enabled = cfg.Highlight
        espPreviewHighlight.FillColor = cfg.ESPPlayerColor
        espPreviewHighlight.FillTransparency = cfg.PlayerChamsFillTransparency
        espPreviewHighlight.OutlineColor = C.White
        espPreviewHighlight.OutlineTransparency = cfg.PlayerChamsOutlineTransparency
    end
    local fields = {}
    if cfg.Names then table.insert(fields, player.DisplayName) end
    if cfg.Distance then table.insert(fields, "150 " .. localize("studs")) end
    if cfg.ESPHealth then
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        local health = humanoid and math.floor(humanoid.Health + 0.5) or 100
        local maxHealth = humanoid and math.floor(humanoid.MaxHealth + 0.5) or 100
        table.insert(fields, localize("HP: ") .. health .. "/" .. maxHealth)
    end
    if cfg.ESPWeapon then
        local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
        table.insert(fields, localize("Weapon: ") .. (tool and tool.Name or localize("None")))
    end
    espPreviewInfo.Text = table.concat(fields, "  |  ")
    if rebuild then rebuildESPPreview() end
end

refreshESPPreview(true)
track(player.CharacterAppearanceLoaded:Connect(function(character)
    if character == player.Character and refreshESPPreview then
        task.defer(refreshESPPreview, true)
    end
end))

addToggle(settingsList, "Interface Glow",
    "Accent outline around menu", "Glow")
addToggle(settingsList, "UI Sounds",
    "Play sounds on startup and when toggles change", "UISounds")

--====================================================
-- SETTINGS PAGE
--====================================================

local keyCard = createCard(settingsList, 70)

text(keyCard, "Menu key", 13,
    UDim2.fromOffset(14, 8),
    UDim2.fromOffset(160, 23),
    C.White,
    Enum.Font.GothamBold
)

text(keyCard, "Click to change opening key", 10,
    UDim2.fromOffset(14, 35),
    UDim2.fromOffset(220, 18),
    C.Muted
)

keyButton = make("TextButton", {
    Size = UDim2.fromOffset(105, 34),
    Position = UDim2.new(1, -120, 0.5, -17),
    BackgroundColor3 = C.Accent,
    Text = menuKey.Name,
    TextColor3 = C.White,
    TextSize = 11,
    Font = Enum.Font.GothamBold
}, keyCard)

round(keyButton, 7)
registerAccent(keyButton, "BackgroundColor3")

track(keyButton.MouseButton1Click:Connect(function()
    waitingForKey = true
    keyButton.Text = localize("PRESS KEY")
end))

languageButton = addAction(settingsList,
    "Language",
    "Choose the menu language",
    "ENGLISH",
    function()
        setLanguage(currentLanguage == "English" and "Russian" or "English")
    end
)

--====================================================
-- UI CUSTOMIZATION
--====================================================

local accentPresets = {
    Color3.fromRGB(35, 190, 255),
    Color3.fromRGB(45, 140, 255),
    Color3.fromRGB(90, 220, 255),
    Color3.fromRGB(20, 210, 205),
    Color3.fromRGB(70, 220, 165),
    Color3.fromRGB(155, 115, 255),
    Color3.fromRGB(245, 105, 190),
    Color3.fromRGB(255, 165, 75),
    Color3.fromRGB(180, 235, 255)
}

local accentIndex = 1

addAction(settingsList,
    "Accent Color",
    "Cycle through the accent color palette",
    "CHANGE",
    function()
        accentIndex += 1
        if accentIndex > #accentPresets then
            accentIndex = 1
        end

        C.Accent = accentPresets[accentIndex]
        applyAccent()
    end
)

addSlider(settingsList,
    "Window Transparency",
    "Adjust panel transparency (0–60%)",
    "MenuTransparency",
    0,
    0.6,
    0.05,
    function()
        applyTransparency()
    end
)

addSlider(settingsList,
    "Interface Scale",
    "Adjust menu size (80–120%)",
    "MenuScale",
    0.8,
    1.2,
    0.05,
    function(value)
        scaleObject.Scale = value
    end
)

--====================================================
-- PERFORMANCE HUD
--====================================================

local hudCard = createCard(hudList, 90)

local hudLabel = text(hudCard,
    "FPS: --     PING: --",
    15,
    UDim2.fromOffset(14, 10),
    UDim2.new(1, -28, 0, 28),
    C.Green,
    Enum.Font.GothamBold
)

local hudHint = text(hudCard,
    "Live performance monitor",
    10,
    UDim2.fromOffset(14, 43),
    UDim2.new(1, -28, 0, 20),
    C.Muted
)

local hudGui = make("ScreenGui", {
    Name = "DegradePerformanceHUD",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 60
}, playerGui)

local scriptStartedAt = os.clock()

local hudOverlay = make("TextLabel", {
    Name = "PerformanceOverlay",
    Size = UDim2.fromOffset(220, 28),
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -15, 0, 15),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = cfg.HUDTransparency,
    Text = "FPS: -- | PING: --",
    TextColor3 = C.Green,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    Active = true,
    Selectable = true,
    Visible = true
}, hudGui)

round(hudOverlay, 7)

local hudSignature = make("TextLabel", {
    Name = "SessionSignature",
    Size = UDim2.fromOffset(196, 28),
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 15, 1, -15),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = cfg.HUDTransparency,
    Text = "PrivateRweesne  |  00:00:00",
    TextColor3 = C.Green,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    Visible = true
}, hudGui)
round(hudSignature, 7)

local function fitHUDSignature()
    local textBounds = TextService:GetTextSize(
        hudSignature.Text,
        hudSignature.TextSize,
        hudSignature.Font,
        Vector2.new(10000, hudSignature.Size.Y.Offset)
    )
    local scale = cfg.HUDScale or 1
    hudSignature.Size = UDim2.fromOffset(
        math.ceil(textBounds.X + 28 * scale),
        math.floor(28 * scale + 0.5)
    )
end

local function fitHUDWidth()
    local textBounds = TextService:GetTextSize(
        hudOverlay.Text,
        hudOverlay.TextSize,
        hudOverlay.Font,
        Vector2.new(10000, hudOverlay.Size.Y.Offset)
    )
    local camera = workspace.CurrentCamera
    local viewportWidth = camera and camera.ViewportSize.X or 1280
    local maxWidth = math.max(100, viewportWidth - 30)
    local scale = cfg.HUDScale or 1
    local baseWidth = math.floor(220 * scale + 0.5)
    local desiredWidth = math.max(baseWidth, math.ceil(textBounds.X + 28 * scale))
    hudOverlay.Size = UDim2.fromOffset(
        math.clamp(desiredWidth, 100, maxWidth),
        hudOverlay.Size.Y.Offset
    )
end

local function applyHUDScale()
    local scale = cfg.HUDScale or 1
    hudOverlay.TextSize = math.floor(12 * scale + 0.5)
    hudOverlay.Size = UDim2.fromOffset(
        math.floor(220 * scale + 0.5),
        math.floor(28 * scale + 0.5)
    )
    fitHUDWidth()
    hudSignature.TextSize = math.floor(12 * scale + 0.5)
    fitHUDSignature()
end

local hudDragging = false
local hudDragInput = nil
local hudDragStart = nil
local hudStartPosition = nil

track(hudOverlay.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        hudDragging = true
        hudDragInput = input
        hudDragStart = input.Position
        hudStartPosition = hudOverlay.Position
    end
end))

track(UIS.InputChanged:Connect(function(input)
    if not hudDragging then return end

    local isMouseMove = input.UserInputType == Enum.UserInputType.MouseMovement
    local isTouchMove = input.UserInputType == Enum.UserInputType.Touch
        and input == hudDragInput

    if isMouseMove or isTouchMove then
        local delta = input.Position - hudDragStart
        hudOverlay.Position = UDim2.new(
            hudStartPosition.X.Scale,
            hudStartPosition.X.Offset + delta.X,
            hudStartPosition.Y.Scale,
            hudStartPosition.Y.Offset + delta.Y
        )
    end
end))

track(UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or (input.UserInputType == Enum.UserInputType.Touch and input == hudDragInput) then
        hudDragging = false
        hudDragInput = nil
    end
end))

applyHUDScale()

local function readPing()
    local success, result = pcall(function()
        local network = Stats:FindFirstChild("Network")
        local serverStats = network and network:FindFirstChild("ServerStatsItem")
        local ping = serverStats and serverStats:FindFirstChild("Data Ping")

        if ping then
            local value = tostring(ping:GetValueString())
            value = string.gsub(value, "%s*%(%s*[%d%.]+%%%s*[Cc][Vv]%s*%)", "")
            value = string.gsub(value, "^%s*(.-)%s*$", "%1")
            local numericValue = tonumber(string.match(value, "%d+%.?%d*"))
            if numericValue then
                return tostring(math.floor(numericValue + 0.5)) .. " ms"
            elseif not string.find(string.lower(value), "ms", 1, true) then
                value = value .. " ms"
            end
            return value
        end

        return localize("N/A")
    end)

    if success and result then
        return tostring(result)
    end

    return localize("N/A")
end

local fps = 0
local frameCounter = 0
local fpsTimer = 0
local hudTimer = 0

local function updateHUD(dt)
    frameCounter += 1
    fpsTimer += dt
    hudTimer += dt

    if fpsTimer >= 1 then
        fps = frameCounter
        frameCounter = 0
        fpsTimer = 0
    end

    if hudTimer >= 1 then
        hudTimer = 0

        local ping = readPing()
        local parts = {}

        if cfg.HUDFPS then
            table.insert(parts, localize("FPS: ") .. fps)
        end

        if cfg.HUDPing then
            if currentLanguage == "Russian" then
                ping = string.gsub(ping, " ms$", " мс")
            end
            table.insert(parts, localize("PING: ") .. ping)
        end

        if cfg.HUDPlayers then
            table.insert(parts, localize("PLAYERS: ") .. #Players:GetPlayers())
        end

        local value = #parts > 0 and table.concat(parts, "  |  ") or localize("HUD: ON")
        hudLabel.Text = value
        hudOverlay.Text = value
        fitHUDWidth()

        local elapsed = math.max(0, math.floor(os.clock() - scriptStartedAt))
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60
        hudSignature.Text = string.format("PrivateRweesne  |  %02d:%02d:%02d", hours, minutes, seconds)
        fitHUDSignature()
    end

    hudOverlay.Visible = cfg.HUD
    hudLabel.Visible = cfg.HUD
    hudSignature.Visible = cfg.HUD and cfg.HUDSignature
end

addToggle(hudList,
    "Enable HUD",
    "Show or hide the on-screen HUD",
    "HUD"
)

addToggle(hudList,
    "Show Session Tag",
    "Show PrivateRweesne and elapsed runtime at the bottom-left",
    "HUDSignature"
)

addToggle(hudList,
    "Show FPS",
    "Display frames per second",
    "HUDFPS"
)

addToggle(hudList,
    "Show Ping",
    "Display network ping",
    "HUDPing"
)

addToggle(hudList,
    "Show Player Count",
    "Display current players in this server",
    "HUDPlayers"
)

local hudScaleSliderRefresh = addSlider(hudList,
    "HUD Scale",
    "Resize the on-screen HUD (75–150%)",
    "HUDScale",
    0.75,
    1.5,
    0.05,
    function()
        applyHUDScale()
    end
)

local hudTransparencySliderRefresh = addSlider(hudList,
    "HUD Background Transparency",
    "Adjust background transparency (0–90%)",
    "HUDTransparency",
    0,
    0.9,
    0.05,
    function(value)
        hudOverlay.BackgroundTransparency = value
        hudSignature.BackgroundTransparency = value
    end
)

--====================================================
-- CROSSHAIR EDITOR
--====================================================

local crossGui = make("ScreenGui", {
    Name = "DegradeCrosshair",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 80
}, playerGui)

local crossContainer = make("Frame", {
    Size = UDim2.fromOffset(100, 100),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1
}, crossGui)

local crossParts = {}

local function makeCrossPart()
    local part = make("Frame", {
        BackgroundColor3 = cfg.CrosshairColor,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5)
    }, crossContainer)

    table.insert(crossParts, part)
    return part
end

local crossTop = makeCrossPart()
local crossBottom = makeCrossPart()
local crossLeft = makeCrossPart()
local crossRight = makeCrossPart()
local crossDot = makeCrossPart()
round(crossDot, 50)
local crossRing = make("Frame", {
    Size = UDim2.fromOffset(20, 20),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Visible = false
}, crossContainer)
make("UICorner", {CornerRadius = UDim.new(1, 0)}, crossRing)
local crossRingStroke = make("UIStroke", {
    Color = cfg.CrosshairColor,
    Thickness = cfg.CrosshairThickness,
    Transparency = cfg.CrosshairTransparency
}, crossRing)

local crossColors = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(35, 190, 255),
    Color3.fromRGB(90, 220, 255),
    Color3.fromRGB(255, 70, 70),
    Color3.fromRGB(70, 255, 150),
    Color3.fromRGB(255, 220, 70),
    Color3.fromRGB(200, 220, 235)
}

local crossColorIndex = 1
local crosshairStyles = {"Cross", "Dot", "Circle"}

local function updateCrosshair()
    local size = cfg.CrosshairSize
    local thickness = cfg.CrosshairThickness
    local gap = cfg.CrosshairGap

    crossTop.Size = UDim2.fromOffset(thickness, size)
    crossTop.Position = UDim2.new(0.5, 0, 0.5, -(gap + size / 2))

    crossBottom.Size = UDim2.fromOffset(thickness, size)
    crossBottom.Position = UDim2.new(0.5, 0, 0.5, gap + size / 2)

    crossLeft.Size = UDim2.fromOffset(size, thickness)
    crossLeft.Position = UDim2.new(0.5, -(gap + size / 2), 0.5, 0)

    crossRight.Size = UDim2.fromOffset(size, thickness)
    crossRight.Position = UDim2.new(0.5, gap + size / 2, 0.5, 0)

    crossDot.Size = UDim2.fromOffset(size, size)
    crossDot.Position = UDim2.fromScale(0.5, 0.5)
    crossRing.Size = UDim2.fromOffset(size * 2, size * 2)
    crossRing.Position = UDim2.fromScale(0.5, 0.5)
    crossRingStroke.Thickness = thickness
    crossRingStroke.Color = cfg.CrosshairColor
    crossRingStroke.Transparency = cfg.CrosshairTransparency

    for _, part in ipairs(crossParts) do
        part.BackgroundColor3 = cfg.CrosshairColor
        part.BackgroundTransparency = cfg.CrosshairTransparency
    end

    local style = cfg.CrosshairStyle
    crossTop.Visible = style == "Cross"
    crossBottom.Visible = style == "Cross"
    crossLeft.Visible = style == "Cross"
    crossRight.Visible = style == "Cross"
    crossDot.Visible = style == "Dot"
    crossRing.Visible = style == "Circle"

    crossGui.Enabled = cfg.Crosshair
end

addToggle(crosshairList,
    "Enable Crosshair",
    "Off by default; enable when you want it",
    "Crosshair"
)

local crosshairSliderRefreshers = {
    addSlider(crosshairList, "Size", "Arm length / dot diameter", "CrosshairSize", 4, 28, 1, function() updateCrosshair() end),
    addSlider(crosshairList, "Thickness", "Line or ring thickness", "CrosshairThickness", 1, 8, 1, function() updateCrosshair() end),
    addSlider(crosshairList, "Gap", "Center opening for cross style", "CrosshairGap", 0, 20, 1, function() updateCrosshair() end),
    addSlider(crosshairList, "Transparency", "Crosshair visibility: 0–0.8", "CrosshairTransparency", 0, 0.8, 0.05, function() updateCrosshair() end)
}
local crosshairColorSliderRefreshers = {}

crossStyleButton = addAction(crosshairList, "Crosshair Style", "Cycle Cross, Dot and Circle", cfg.CrosshairStyle, function()
    local styleIndex = table.find(crosshairStyles, cfg.CrosshairStyle) or 1
    styleIndex = styleIndex % #crosshairStyles + 1
    cfg.CrosshairStyle = crosshairStyles[styleIndex]
    crossStyleButton.Text = localize(cfg.CrosshairStyle)
    updateCrosshair()
end)

local crossColorCard = createCard(crosshairList, 62)
text(crossColorCard, "Color", 13,
    UDim2.fromOffset(14, 6),
    UDim2.fromOffset(95, 22),
    C.White,
    Enum.Font.GothamBold
)
text(crossColorCard, "Choose a crosshair color", 10,
    UDim2.fromOffset(14, 30),
    UDim2.fromOffset(130, 18),
    C.Muted
)
local crossColorButtons = {}
local crossColorRow = make("Frame", {
    Size = UDim2.new(1, -160, 0, 28),
    Position = UDim2.new(0, 150, 0.5, -14),
    BackgroundTransparency = 1
}, crossColorCard)
make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Padding = UDim.new(0, 5)
}, crossColorRow)

local function refreshCrossColorButtons()
    for index, button in ipairs(crossColorButtons) do
        local stroke = button:FindFirstChildOfClass("UIStroke")
        if stroke then
            stroke.Thickness = index == crossColorIndex and 2 or 1
            stroke.Transparency = index == crossColorIndex and 0 or 0.7
        end
    end
end

for index, color in ipairs(crossColors) do
    local button = make("TextButton", {
        Size = UDim2.fromOffset(24, 24),
        BackgroundColor3 = color,
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0
    }, crossColorRow)
    round(button, 12)
    make("UIStroke", {
        Color = C.White,
        Thickness = 1,
        Transparency = 0.7
    }, button)
    table.insert(crossColorButtons, button)
    track(button.MouseButton1Click:Connect(function()
        crossColorIndex = index
        cfg.CrosshairColor = color
        local hue, saturation, value = color:ToHSV()
        cfg.CrosshairHue = hue * 360
        cfg.CrosshairSaturation = saturation
        cfg.CrosshairValue = value
        for _, refresh in ipairs(crosshairColorSliderRefreshers) do refresh() end
        refreshCrossColorButtons()
        updateCrosshair()
    end))
end

local function applyCrosshairHSV()
    cfg.CrosshairColor = Color3.fromHSV(cfg.CrosshairHue / 360, cfg.CrosshairSaturation, cfg.CrosshairValue)
    crossColorIndex = 0
    for index, presetColor in ipairs(crossColors) do
        if math.abs(cfg.CrosshairColor.R - presetColor.R) < 0.002
            and math.abs(cfg.CrosshairColor.G - presetColor.G) < 0.002
            and math.abs(cfg.CrosshairColor.B - presetColor.B) < 0.002 then
            crossColorIndex = index
            break
        end
    end
    refreshCrossColorButtons()
    updateCrosshair()
end

for _, setting in ipairs({
    {"Hue", "Choose any color hue", "CrosshairHue", 0, 360, 1},
    {"Saturation", "Color intensity", "CrosshairSaturation", 0, 1, 0.01},
    {"Brightness", "Color brightness", "CrosshairValue", 0, 1, 0.01}
}) do
    table.insert(crosshairColorSliderRefreshers, addSlider(crosshairList, setting[1], setting[2], setting[3], setting[4], setting[5], setting[6], applyCrosshairHSV))
end

addAction(crosshairList, "Reset Crosshair", "Hide the reticle and restore default style", "RESET", function()
    cfg.Crosshair = false
    cfg.CrosshairStyle = "Cross"
    cfg.CrosshairSize = 8
    cfg.CrosshairThickness = 2
    cfg.CrosshairGap = 5
    cfg.CrosshairTransparency = 0
    crossColorIndex = 1
    cfg.CrosshairColor = crossColors[crossColorIndex]
    cfg.CrosshairHue = 0
    cfg.CrosshairSaturation = 0
    cfg.CrosshairValue = 1
    crossStyleButton.Text = localize(cfg.CrosshairStyle)
    for _, refresh in ipairs(crosshairSliderRefreshers) do refresh() end
    for _, refresh in ipairs(crosshairColorSliderRefreshers) do refresh() end
    refreshCrossColorButtons()
    refreshToggleControls()
    updateCrosshair()
end)

--====================================================
-- MISC: FOV
--====================================================

local cameraFOVDefaults = setmetatable({}, {__mode = "k"})

applyFOV = function()
    local camera = workspace.CurrentCamera
    if not camera then return end
    if cameraFOVDefaults[camera] == nil then cameraFOVDefaults[camera] = camera.FieldOfView end
    if cfg.FOVEnabled then
        camera.FieldOfView = cfg.FOV
    else
        camera.FieldOfView = cameraFOVDefaults[camera]
    end
end

skyboxPresets = {
    {
        Name = "Night",
        CelestialBodiesShown = false,
        StarCount = 0,
        SkyboxBk = "rbxassetid://12064107",
        SkyboxDn = "rbxassetid://12064152",
        SkyboxFt = "rbxassetid://12064121",
        SkyboxLf = "rbxassetid://12063984",
        SkyboxRt = "rbxassetid://12064115",
        SkyboxUp = "rbxassetid://12064131"
    },
    {
        Name = "Space",
        CelestialBodiesShown = false,
        StarCount = 3000,
        SkyboxBk = "rbxassetid://149397692",
        SkyboxDn = "rbxassetid://149397686",
        SkyboxFt = "rbxassetid://149397697",
        SkyboxLf = "rbxassetid://149397684",
        SkyboxRt = "rbxassetid://149397688",
        SkyboxUp = "rbxassetid://149397702"
    },
}

local skyboxBackup
local skyboxTarget
local skyboxBackupCaptured = false

local function restoreSkybox()
    if not skyboxBackupCaptured then return end
    if skyboxTarget and skyboxTarget.Parent then skyboxTarget:Destroy() end
    if skyboxBackup then
        skyboxBackup.Parent = Lighting
        skyboxBackup = nil
    end
    skyboxTarget = nil
    skyboxBackupCaptured = false
end

applySkybox = function()
    if not cfg.SkyboxEnabled then
        restoreSkybox()
        return
    end

    if not skyboxBackupCaptured then
        local currentSky = Lighting:FindFirstChildOfClass("Sky")
        skyboxBackup = currentSky and currentSky:Clone() or nil
        skyboxTarget = currentSky
        skyboxBackupCaptured = true
    end

    if not skyboxTarget or not skyboxTarget.Parent then
        skyboxTarget = Instance.new("Sky")
        skyboxTarget.Name = "DegradeLocalSkybox"
        skyboxTarget.Parent = Lighting
    end

    local preset = skyboxPresets[math.clamp(cfg.SkyboxPreset, 1, #skyboxPresets)]
    for property, value in pairs(preset) do
        if property ~= "Name" then skyboxTarget[property] = value end
    end
end

local colorCorrection = Instance.new("ColorCorrectionEffect")
colorCorrection.Name = "DegradeLocalColorCorrection"
colorCorrection.Enabled = false
colorCorrection.Parent = Lighting

applyColorCorrection = function()
    colorCorrection.Enabled = cfg.ColorCorrectionEnabled
    colorCorrection.Saturation = cfg.ColorSaturation
    colorCorrection.Contrast = cfg.ColorContrast
    local hueShift = cfg.ColorHue
    local tintSaturation = math.abs(hueShift) / 180 * 0.35
    colorCorrection.TintColor = Color3.fromHSV((hueShift % 360) / 360, tintSaturation, 1)
end

local fovToggle = addToggle(miscList, "FOV Changer", "Set camera field of view", "FOVEnabled")
local setFOVSlider = addSlider(miscList, "FOV", "Field of view: 70–120", "FOV", 70, 120, 1, function() applyFOV() end)
addAction(miscList, "Reset FOV", "Disable the override and restore the default view", "RESET", function()
    cfg.FOVEnabled = false
    setFOVSlider(70)
    refreshToggleControls()
end)

addToggle(miscList, "Custom Skybox", "Apply a local sky preset", "SkyboxEnabled")
skyboxPresetButton = addAction(miscList, "Skybox Preset", "Choose Night or Space", skyboxPresets[cfg.SkyboxPreset].Name, function()
    cfg.SkyboxPreset += 1
    if cfg.SkyboxPreset > #skyboxPresets then cfg.SkyboxPreset = 1 end
    skyboxPresetButton.Text = localize(skyboxPresets[cfg.SkyboxPreset].Name)
    if cfg.SkyboxEnabled then applySkybox() end
end)
addAction(miscList, "Reset Skybox", "Restore the original game sky", "RESET", function()
    cfg.SkyboxEnabled = false
    cfg.SkyboxPreset = 1
    skyboxPresetButton.Text = localize(skyboxPresets[cfg.SkyboxPreset].Name)
    applySkybox()
    refreshToggleControls()
end)
addToggle(miscList, "Color Correction", "Enable custom color grading", "ColorCorrectionEnabled")
local colorCorrectionSliderRefreshers = {
    addSlider(miscList, "Saturation", "Color intensity: -1 to 1", "ColorSaturation", -1, 1, 0.05, function() applyColorCorrection() end),
    addSlider(miscList, "Contrast", "Image contrast: -1 to 1", "ColorContrast", -1, 1, 0.05, function() applyColorCorrection() end),
    addSlider(miscList, "Hue Shift", "Neutral at 0; tint grows toward either end", "ColorHue", -180, 180, 1, function() applyColorCorrection() end)
}
addAction(miscList, "Reset Color Correction", "Turn off grading and restore neutral values", "RESET", function()
    cfg.ColorCorrectionEnabled = false
    cfg.ColorSaturation = 0
    cfg.ColorContrast = 0
    cfg.ColorHue = 0
    for _, refresh in ipairs(colorCorrectionSliderRefreshers) do refresh() end
    applyColorCorrection()
    refreshToggleControls()
end)

--====================================================
-- SETTINGS PROFILES
--====================================================

-- Profiles are kept for the current play session.
local savedProfiles = {}
local savedProfileNames = {}
local refreshConfigDropdown
local configNameInput
local profileKeys = {
    "BoxESP",
    "Highlight",
    "Names",
    "Distance",
    "ESPHealth",
    "ESPWeapon",
    "ESPArrows",
    "BackpackESP",
    "DroppedWeaponESP",
    "ESPMaxDistance",
    "DroppedMaxDistance",
    "ESPPlayerColor",
    "ESPDroppedColor",
    "PlayerChamsFillTransparency",
    "PlayerChamsOutlineTransparency",
    "ArmsChams",
    "ArmsChamsColor",
    "ArmsChamsFillTransparency",
    "ArmsChamsOutlineTransparency",
    "Glow",
    "HUD",
    "HUDSignature",
    "HUDFPS",
    "HUDPing",
    "HUDPlayers",
    "HUDScale",
    "HUDTransparency",
    "FOVEnabled",
    "FOV",
    "SkyboxEnabled",
    "SkyboxPreset",
    "ColorCorrectionEnabled",
    "ColorSaturation",
    "ColorContrast",
    "ColorHue",
    "Language",
    "Crosshair",
    "CrosshairStyle",
    "CrosshairSize",
    "CrosshairThickness",
    "CrosshairGap",
    "CrosshairTransparency",
    "CrosshairColor",
    "CrosshairHue",
    "CrosshairSaturation",
    "CrosshairValue",
    "MenuTransparency",
    "MenuScale",
    "UISounds"
}

local function saveProfile(name)
    local snapshot = {
        Config = {},
        Accent = C.Accent,
        MenuKey = menuKey,
        AccentIndex = accentIndex,
        CrossColorIndex = crossColorIndex
    }

    for _, key in ipairs(profileKeys) do
        snapshot.Config[key] = cfg[key]
    end

    if not savedProfiles[name] then
        table.insert(savedProfileNames, name)
    end
    savedProfiles[name] = snapshot
    selectedProfileName = name
    refreshConfigDropdown()
end

local function loadProfile(name)
    local snapshot = savedProfiles[name]
    if not snapshot then
        return
    end

    for _, key in ipairs(profileKeys) do
        if snapshot.Config[key] ~= nil then
            cfg[key] = snapshot.Config[key]
        end
    end

    setLanguage(cfg.Language)

    C.Accent = snapshot.Accent
    menuKey = snapshot.MenuKey
    accentIndex = snapshot.AccentIndex
    crossColorIndex = snapshot.CrossColorIndex

    keyButton.Text = menuKey.Name
    scaleObject.Scale = cfg.MenuScale
    outline.Transparency = cfg.Glow and 0.35 or 1

    refreshToggleControls()
    playerDistanceRefresh(cfg.ESPMaxDistance)
    droppedDistanceRefresh(cfg.DroppedMaxDistance)
    for _, entry in ipairs(chamsSliderRefreshers) do entry[1](cfg[entry[2]]) end
    applyESPColorSettings()
    refreshESPColorButtons()
    applyArmsChams()
    applyBackpackESP()
    applyDroppedWeaponESP()
    applyFOV()
    setFOVSlider(cfg.FOV)
    for _, refresh in ipairs(crosshairSliderRefreshers) do refresh() end
    for _, refresh in ipairs(crosshairColorSliderRefreshers) do refresh() end
    crossStyleButton.Text = localize(cfg.CrosshairStyle)
    refreshCrossColorButtons()
    skyboxPresetButton.Text = localize(skyboxPresets[math.clamp(cfg.SkyboxPreset, 1, #skyboxPresets)].Name)
    applySkybox()
    for _, refresh in ipairs(colorCorrectionSliderRefreshers) do refresh() end
    applyColorCorrection()
    applyAccent()
    applyTransparency()
    hudScaleSliderRefresh(cfg.HUDScale)
    hudTransparencySliderRefresh(cfg.HUDTransparency)
    hudSignature.BackgroundTransparency = cfg.HUDTransparency
    hudSignature.AnchorPoint = Vector2.new(0, 1)
    hudSignature.Position = UDim2.new(0, 15, 1, -15)
    fitHUDSignature()
    updateCrosshair()
end

local configSelectCard = createCard(settingsList, 64)
configSelectCard.ZIndex = 10
text(configSelectCard, "Configs", 13,
    UDim2.fromOffset(14, 5),
    UDim2.new(1, -145, 0, 22),
    C.White,
    Enum.Font.GothamBold
).ZIndex = 11
text(configSelectCard, "Saved for this session", 10,
    UDim2.fromOffset(14, 31),
    UDim2.new(1, -145, 0, 18),
    C.Muted
).ZIndex = 11

configSelectButton = make("TextButton", {
    Size = UDim2.fromOffset(112, 34),
    Position = UDim2.new(1, -126, 0.5, -17),
    BackgroundColor3 = C.Accent,
    Text = "NONE  ▾",
    TextColor3 = C.White,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    ZIndex = 11
}, configSelectCard)
round(configSelectButton, 7)
registerAccent(configSelectButton, "BackgroundColor3")

local configDropdown = make("ScrollingFrame", {
    Position = UDim2.fromOffset(14, 58),
    Size = UDim2.new(1, -28, 0, 116),
    BackgroundColor3 = C.Sidebar,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    Visible = false,
    ZIndex = 20
}, configSelectCard)
round(configDropdown, 8)
make("UIListLayout", {
    Padding = UDim.new(0, 3),
    SortOrder = Enum.SortOrder.LayoutOrder
}, configDropdown)
make("UIPadding", {
    PaddingTop = UDim.new(0, 5),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 5)
}, configDropdown)

local configDropdownOpen = false
local function truncateUTF8(value, maxCharacters)
    local length = utf8.len(value)
    if length and length > maxCharacters then
        return string.sub(value, 1, utf8.offset(value, maxCharacters + 1) - 1) .. "…"
    end
    return value
end

local function updateConfigSelectLabel()
    local label = selectedProfileName and truncateUTF8(selectedProfileName, 11) or localize("NONE")
    configSelectButton.Text = label .. "  ▾"
end

refreshConfigDropdown = function()
    for _, child in ipairs(configDropdown:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    for index, name in ipairs(savedProfileNames) do
        local option = make("TextButton", {
            Size = UDim2.new(1, -4, 0, 27),
            BackgroundColor3 = name == selectedProfileName and C.Panel or C.Sidebar,
            Text = name,
            TextColor3 = name == selectedProfileName and C.White or C.Muted,
            TextSize = 10,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            LayoutOrder = index,
            ZIndex = 21
        }, configDropdown)
        round(option, 6)
        make("UIPadding", {PaddingLeft = UDim.new(0, 8)}, option)
        track(option.MouseButton1Click:Connect(function()
            selectedProfileName = name
            configNameInput.Text = name
            configDropdownOpen = false
            configDropdown.Visible = false
            updateConfigSelectLabel()
            refreshConfigDropdown()
        end))
    end

    configDropdown.Visible = configDropdownOpen and #savedProfileNames > 0
    updateConfigSelectLabel()
end

track(configSelectButton.MouseButton1Click:Connect(function()
    configDropdownOpen = not configDropdownOpen
    refreshConfigDropdown()
end))

local configNameCard = createCard(settingsList, 64)
text(configNameCard, "Config Name", 13,
    UDim2.fromOffset(14, 5),
    UDim2.new(1, -28, 0, 20),
    C.White,
    Enum.Font.GothamBold
)
configNameInput = make("TextBox", {
    Position = UDim2.fromOffset(14, 29),
    Size = UDim2.new(1, -28, 0, 26),
    BackgroundColor3 = C.Background,
    Text = "",
    PlaceholderText = "Type a config name...",
    PlaceholderColor3 = C.Muted,
    TextColor3 = C.White,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    BorderSizePixel = 0
}, configNameCard)
round(configNameInput, 6)
make("UIPadding", {PaddingLeft = UDim.new(0, 8)}, configNameInput)

addAction(settingsList, "Load Config", "Apply the selected config", "LOAD", function()
    if selectedProfileName then loadProfile(selectedProfileName) end
end)

addAction(settingsList, "Delete Config", "Remove the selected config", "DELETE", function()
    if not selectedProfileName or not savedProfiles[selectedProfileName] then return end
    savedProfiles[selectedProfileName] = nil
    for index, name in ipairs(savedProfileNames) do
        if name == selectedProfileName then
            table.remove(savedProfileNames, index)
            break
        end
    end
    selectedProfileName = savedProfileNames[1]
    configDropdownOpen = false
    refreshConfigDropdown()
end)

addAction(settingsList, "Save Config", "Save or overwrite the named config", "SAVE", function()
    local name = string.gsub(configNameInput.Text, "^%s*(.-)%s*$", "%1")
    name = truncateUTF8(name, 24)
    if name == "" then
        configNameInput.PlaceholderText = localize("Enter a name first...")
        return
    end
    configNameInput.PlaceholderText = localize("Type a config name...")
    saveProfile(name)
    configDropdownOpen = false
end)

addAction(settingsList,
    "Reset Settings",
    "Restore default script settings",
    "RESET",
    function()
        local defaults = {
            BoxESP = false,
            Highlight = false,
            Names = true,
            Distance = true,
            ESPHealth = true,
            ESPWeapon = true,
            ESPArrows = true,
            BackpackESP = false,
            DroppedWeaponESP = false,
            ESPMaxDistance = 500,
            DroppedMaxDistance = 500,
            ESPPlayerColor = Color3.fromRGB(35, 190, 255),
            ESPDroppedColor = Color3.fromRGB(35, 190, 255),
            PlayerChamsFillTransparency = 0.72,
            PlayerChamsOutlineTransparency = 0,
            ArmsChams = false,
            ArmsChamsColor = Color3.fromRGB(35, 190, 255),
            ArmsChamsFillTransparency = 0.25,
            ArmsChamsOutlineTransparency = 0,
            Glow = true,
            HUD = true,
            HUDSignature = true,
            HUDFPS = true,
            HUDPing = true,
            HUDPlayers = true,
            HUDScale = 1,
            HUDTransparency = 0.2,
            FOVEnabled = false,
            FOV = 70,
            SkyboxEnabled = false,
            SkyboxPreset = 1,
            ColorCorrectionEnabled = false,
            ColorSaturation = 0,
            ColorContrast = 0,
            ColorHue = 0,
            Crosshair = false,
            CrosshairStyle = "Cross",
            CrosshairSize = 8,
            CrosshairThickness = 2,
            CrosshairGap = 5,
            CrosshairTransparency = 0,
            CrosshairColor = Color3.fromRGB(255, 255, 255),
            CrosshairHue = 0,
            CrosshairSaturation = 0,
            CrosshairValue = 1,
            MenuTransparency = 0,
            MenuScale = 1,
            Language = "English",
            UISounds = true
        }

        for key, value in pairs(defaults) do
            cfg[key] = value
        end

        setLanguage(cfg.Language)


        C.Accent = Color3.fromRGB(35, 190, 255)
        accentIndex = 1
        crossColorIndex = 1
        menuKey = Enum.KeyCode.RightShift

        keyButton.Text = menuKey.Name
        scaleObject.Scale = cfg.MenuScale
        outline.Transparency = 0.35

        refreshToggleControls()
        playerDistanceRefresh(cfg.ESPMaxDistance)
        droppedDistanceRefresh(cfg.DroppedMaxDistance)
        for _, entry in ipairs(chamsSliderRefreshers) do entry[1](cfg[entry[2]]) end
        applyESPColorSettings()
        refreshESPColorButtons()
        applyArmsChams()
        applyBackpackESP()
        applyDroppedWeaponESP()
        applyFOV()
        setFOVSlider(cfg.FOV)
        for _, refresh in ipairs(crosshairSliderRefreshers) do refresh() end
        for _, refresh in ipairs(crosshairColorSliderRefreshers) do refresh() end
        crossStyleButton.Text = localize(cfg.CrosshairStyle)
        refreshCrossColorButtons()
        skyboxPresetButton.Text = localize(skyboxPresets[cfg.SkyboxPreset].Name)
        applySkybox()
        for _, refresh in ipairs(colorCorrectionSliderRefreshers) do refresh() end
        applyColorCorrection()
        applyAccent()
        applyTransparency()
        hudScaleSliderRefresh(cfg.HUDScale)
        hudTransparencySliderRefresh(cfg.HUDTransparency)
        hudSignature.BackgroundTransparency = cfg.HUDTransparency
        hudOverlay.AnchorPoint = Vector2.new(1, 0)
        hudOverlay.Position = UDim2.new(1, -15, 0, 15)
        hudSignature.AnchorPoint = Vector2.new(0, 1)
        hudSignature.Position = UDim2.new(0, 15, 1, -15)
        fitHUDSignature()
        updateCrosshair()
    end
)

addAction(settingsList,
    "Unload Script",
    "Close the menu and remove its effects",
    "UNLOAD",
    function()
        gui:Destroy()
    end
)

--====================================================
-- DRAG WINDOW
--====================================================

local dragging = false
local dragStart
local startPosition

track(header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end))

track(UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end))

track(UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end))

--====================================================
-- KEY HANDLER
--====================================================

track(UIS.InputBegan:Connect(function(input, processed)
    if not accessGranted then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then
        return
    end

    if waitingForKey then
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            menuKey = input.KeyCode
            keyButton.Text = menuKey.Name
            waitingForKey = false
        end

        return
    end

    if processed then return end

    if input.KeyCode == menuKey then
        menuOpen = not menuOpen
        main.Visible = menuOpen
        playUISound(toggleSound)
    end
end))

--====================================================
-- RENDER LOOP
--====================================================

track(RunService.RenderStepped:Connect(function(dt)
    if not accessGranted then return end
    applyFOV()
    updateESP()
    updateDroppedItemDistances()
    updateHUD(dt)
    updateCrosshair()
end))

--====================================================
-- CLEANUP
--====================================================

local function cleanup()
    cfg.BackpackESP = false
    cfg.DroppedWeaponESP = false
    cfg.ArmsChams = false
    applyArmsChams()
    applyBackpackESP()
    applyDroppedWeaponESP()
    cfg.FOVEnabled = false
    applyFOV()
    cfg.SkyboxEnabled = false
    applySkybox()
    cfg.ColorCorrectionEnabled = false
    applyColorCorrection()
    if colorCorrection then colorCorrection:Destroy() end
    if startupSound then startupSound:Destroy() end
    if toggleSound then toggleSound:Destroy() end

    for _, connection in ipairs(connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    for plr in pairs(espData) do
        removeESP(plr)
    end

    if espGui then
        espGui:Destroy()
    end

    if hudGui then
        hudGui:Destroy()
    end

    if crossGui then
        crossGui:Destroy()
    end
end

track(gui.Destroying:Connect(cleanup))

--====================================================
-- ACCESS KEY SCREEN
--====================================================

local accessOverlay = make("Frame", {
    Name = "AccessKeyScreen",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ZIndex = 10
}, gui)

local accessCard = make("Frame", {
    Size = UDim2.fromOffset(360, 270),
    Position = UDim2.new(0.5, -180, 0.5, -135),
    BackgroundColor3 = C.Sidebar,
    BorderSizePixel = 0,
    ZIndex = 10
}, accessOverlay)
round(accessCard, 14)
make("UIStroke", {Color = C.Accent, Thickness = 1.5, Transparency = 0.25}, accessCard)

text(accessCard, "RWEESNE PRIVATE V5.0", 17,
    UDim2.fromOffset(24, 20), UDim2.new(1, -48, 0, 28), C.White, Enum.Font.GothamBold).ZIndex = 10
text(accessCard, "Enter the access key to continue", 12,
    UDim2.fromOffset(24, 54), UDim2.new(1, -48, 0, 22), C.Muted).ZIndex = 10
local accessInput = make("TextBox", {
    Position = UDim2.fromOffset(24, 92),
    Size = UDim2.new(1, -48, 0, 42),
    BackgroundColor3 = C.Panel,
    TextColor3 = C.White,
    PlaceholderText = "Enter key...",
    PlaceholderColor3 = C.Muted,
    Text = "",
    TextSize = 14,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    BorderSizePixel = 0,
    ZIndex = 10
}, accessCard)
round(accessInput, 8)

local accessStatus = text(accessCard, "", 11,
    UDim2.fromOffset(24, 138), UDim2.new(1, -48, 0, 20), Color3.fromRGB(255, 115, 115))
accessStatus.ZIndex = 10
accessStatus.TextXAlignment = Enum.TextXAlignment.Center

local getKeyButton = make("TextButton", {
    Position = UDim2.fromOffset(24, 164),
    Size = UDim2.fromOffset(120, 34),
    BackgroundColor3 = C.Panel,
    Text = "GetKey",
    TextColor3 = C.Accent,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = true,
    BorderSizePixel = 0,
    ZIndex = 10
}, accessCard)
round(getKeyButton, 8)

local accessButton = make("TextButton", {
    Position = UDim2.fromOffset(152, 164),
    Size = UDim2.fromOffset(184, 34),
    BackgroundColor3 = C.Accent,
    Text = "UNLOCK",
    TextColor3 = C.Background,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = true,
    BorderSizePixel = 0,
    ZIndex = 10
}, accessCard)
round(accessButton, 8)

local accessLinkBox = make("TextBox", {
    Position = UDim2.fromOffset(24, 210),
    Size = UDim2.new(1, -48, 0, 38),
    BackgroundColor3 = C.Panel,
    TextColor3 = C.White,
    PlaceholderText = "",
    Text = "",
    TextSize = 10,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    BorderSizePixel = 0,
    TextXAlignment = Enum.TextXAlignment.Center,
    Visible = false,
    ZIndex = 10
}, accessCard)
round(accessLinkBox, 8)

track(getKeyButton.MouseButton1Click:Connect(function()
    accessLinkBox.Text = "https://t.me/+l4cBhm51XLphYzUy"
    accessLinkBox.Visible = true
    accessStatus.TextColor3 = C.Muted
    accessStatus.Text = "Select the link and press Ctrl+C to copy."
    accessLinkBox:CaptureFocus()
    task.defer(function()
        if accessLinkBox.Parent then
            accessLinkBox.CursorPosition = #accessLinkBox.Text + 1
            accessLinkBox.SelectionStart = 1
        end
    end)
end))

local function submitAccessKey()
    if accessInput.Text ~= "1488" then
        accessStatus.Text = "Incorrect key. Try again."
        accessInput:CaptureFocus()
        return
    end

    accessGranted = true
    accessOverlay:Destroy()
    espGui.Enabled = true
    hudGui.Enabled = true
    crossGui.Enabled = cfg.Crosshair
    main.Visible = true
    playUISound(startupSound)
end

track(accessButton.MouseButton1Click:Connect(submitAccessKey))
track(accessInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then submitAccessKey() end
end))

main.Visible = false
espGui.Enabled = false
hudGui.Enabled = false
crossGui.Enabled = false

--====================================================
-- INITIALIZE
--====================================================

switchPage("Visuals")

outline.Transparency = cfg.Glow and 0.35 or 1

updateCrosshair()
applyAccent()
applyTransparency()

main.Visible = false

print("RWEESNE PRIVATE V5.0 loaded successfully")
