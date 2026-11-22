
--====================================================
-- DEGRADE PRIVATE V5.0
-- Roblox Studio LocalScript
-- StarterPlayer > StarterPlayerScripts
--====================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")

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
    Background = Color3.fromRGB(14, 13, 21),
    Sidebar = Color3.fromRGB(20, 19, 30),
    Panel = Color3.fromRGB(28, 26, 40),
    Accent = Color3.fromRGB(145, 88, 255),
    White = Color3.fromRGB(245, 242, 255),
    Muted = Color3.fromRGB(155, 149, 174),
    Green = Color3.fromRGB(105, 225, 155),
    Off = Color3.fromRGB(58, 55, 70)
}

local cfg = {
    BoxESP = false,
    Highlight = false,
    Names = true,
    Distance = true,
    Glow = true,

    Radar = true,
    RadarRange = 500,

    HUD = true,
    HUDFPS = true,
    HUDPing = true,
    HUDSize = 2,

    Crosshair = true,
    CrosshairSize = 8,
    CrosshairThickness = 2,
    CrosshairGap = 5,
    CrosshairColor = Color3.fromRGB(255, 255, 255),

    MenuTransparency = 0,
    MenuScale = 1
}

local menuKey = Enum.KeyCode.RightShift
local waitingForKey = false
local menuOpen = true

local connections = {}
local accentObjects = {}
local transparencyObjects = {}

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

    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function text(parent, value, size, pos, dim, color, font)
    return make("TextLabel", {
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
        FillColor = C.Accent,
        OutlineColor = C.White,
        FillTransparency = 0.72,
        OutlineTransparency = 0,
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
        Color = C.Accent,
        Thickness = 1.5,
        Transparency = 0
    }, box)

    registerAccent(stroke, "Color")

    local info = make("TextLabel", {
        Name = "PlayerInfo",
        BackgroundTransparency = 1,
        TextColor3 = C.White,
        TextStrokeTransparency = 0.2,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.fromOffset(220, 20),
        Visible = false
    }, espGui)

    espData[plr] = {
        box = box,
        info = info,
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

local function updateESP()
    local camera = workspace.CurrentCamera
    if not camera then return end

    local myCharacter = player.Character
    local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")

    for plr, data in pairs(espData) do
        local character = plr.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")

        if data.highlight then
            data.highlight.Enabled = cfg.Highlight
            data.highlight.FillColor = C.Accent
        end

        if not character or not humanoid or not root or humanoid.Health <= 0 then
            data.box.Visible = false
            data.info.Visible = false
            continue
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

        local distance = 0

        if myRoot then
            distance = math.floor((root.Position - myRoot.Position).Magnitude)
        end

        local infoText = ""

        if cfg.Names then
            infoText = plr.DisplayName
        end

        if cfg.Distance then
            if infoText ~= "" then
                infoText = infoText .. "  |  "
            end

            infoText = infoText .. distance .. " studs"
        end

        data.info.Text = infoText
        data.info.Position = UDim2.fromOffset(centerX, minY - 3)
        data.info.Visible = infoText ~= ""
    end
end

--====================================================
-- MAIN WINDOW
--====================================================

local main = make("Frame", {
    Size = UDim2.fromOffset(680, 430),
    Position = UDim2.new(0.5, -340, 0.5, -215),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)

round(main, 15)

local scaleObject = make("UIScale", {
    Scale = cfg.MenuScale
}, main)

local outline = make("UIStroke", {
    Color = C.Accent,
    Thickness = 1.4,
    Transparency = 0.35
}, main)

registerAccent(outline, "Color")

local sidebar = make("Frame", {
    Size = UDim2.new(0, 180, 1, 0),
    BackgroundColor3 = C.Sidebar,
    BorderSizePixel = 0
}, main)

registerTransparency(sidebar, "BackgroundTransparency", 0)

local logo = make("Frame", {
    Size = UDim2.fromOffset(38, 38),
    Position = UDim2.fromOffset(17, 18),
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

text(sidebar, "DEGRADE", 16,
    UDim2.fromOffset(64, 17),
    UDim2.fromOffset(105, 23),
    C.White,
    Enum.Font.GothamBold
)

text(sidebar, "PRIVATE V5.0", 10,
    UDim2.fromOffset(64, 38),
    UDim2.fromOffset(105, 18),
    C.Muted
)

local nav = make("Frame", {
    Position = UDim2.fromOffset(12, 95),
    Size = UDim2.new(1, -24, 0, 260),
    BackgroundTransparency = 1
}, sidebar)

make("UIListLayout", {
    Padding = UDim.new(0, 9)
}, nav)

--====================================================
-- HEADER
--====================================================

local header = make("Frame", {
    Position = UDim2.fromOffset(180, 0),
    Size = UDim2.new(1, -180, 0, 65),
    BackgroundTransparency = 1
}, main)

text(header, "DEGRADE PRIVATE", 18,
    UDim2.fromOffset(22, 10),
    UDim2.fromOffset(260, 28),
    C.White,
    Enum.Font.GothamBold
)

text(header, "PLAYER VISUAL INTERFACE", 9,
    UDim2.fromOffset(23, 37),
    UDim2.fromOffset(250, 17),
    C.Muted
)

text(header, "● ONLINE", 10,
    UDim2.new(1, -105, 0, 18),
    UDim2.fromOffset(85, 20),
    C.Green,
    Enum.Font.GothamBold
)

--====================================================
-- CONTENT / PAGES
--====================================================

local content = make("Frame", {
    Position = UDim2.fromOffset(200, 75),
    Size = UDim2.new(1, -220, 1, -95),
    BackgroundTransparency = 1
}, main)

local pages = {}
local navButtons = {}
local pageLists = {}

local function createPage(name, title, subtitle)
    local page = make("Frame", {
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
        Padding = UDim.new(0, 11),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, list)

    pageLists[name] = list
    return list
end

local visualList = createPage(
    "Visuals",
    "Visuals",
    "Player ESP controls"
)

local settingsList = createPage(
    "Settings",
    "Settings",
    "Customize your interface"
)

local radarList = createPage(
    "Radar",
    "Player Radar",
    "Nearby player positions"
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

local function switchPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end

    for pageName, button in pairs(navButtons) do
        local selected = pageName == name
        button.BackgroundColor3 = selected and C.Panel or C.Sidebar
        button.TextColor3 = selected and C.White or C.Muted
    end
end

local function addNav(name, symbol)
    local button = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = C.Sidebar,
        Text = symbol .. "    " .. name,
        TextColor3 = C.Muted,
        TextSize = 12,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        BorderSizePixel = 0
    }, nav)

    round(button, 8)
    make("UIPadding", {
        PaddingLeft = UDim.new(0, 12)
    }, button)

    navButtons[name] = button

    track(button.MouseButton1Click:Connect(function()
        switchPage(name)
    end))
end

addNav("Visuals", "◈")
addNav("Settings", "⚙")
addNav("Radar", "◎")
addNav("HUD", "▤")
addNav("Crosshair", "＋")

--====================================================
-- UI CARD HELPERS
--====================================================

local function createCard(parent, height)
    local card = make("Frame", {
        Size = UDim2.new(1, 0, 0, height or 66),
        BackgroundColor3 = C.Panel,
        BorderSizePixel = 0
    }, parent)

    round(card, 9)
    registerTransparency(card, "BackgroundTransparency", 0)

    return card
end

local toggleControls = {}

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
    end
end

local function addToggle(parent, title, description, key)
    local card = createCard(parent, 66)

    text(card, title, 13,
        UDim2.fromOffset(14, 8),
        UDim2.new(1, -85, 0, 23),
        C.White,
        Enum.Font.GothamBold
    )

    text(card, description, 10,
        UDim2.fromOffset(14, 34),
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

    local knob = make("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = cfg[key] and UDim2.fromOffset(22, 3) or UDim2.fromOffset(3, 3),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0
    }, toggle)

    round(knob, 20)

    toggleControls[key] = {
        Toggle = toggle,
        Knob = knob
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

        if key == "Glow" then
            outline.Transparency = enabled and 0.35 or 1
        end
    end))

    return toggle
end

local function addAction(parent, title, description, buttonText, callback)
    local card = createCard(parent, 70)

    text(card, title, 13,
        UDim2.fromOffset(14, 7),
        UDim2.new(1, -145, 0, 23),
        C.White,
        Enum.Font.GothamBold
    )

    text(card, description, 10,
        UDim2.fromOffset(14, 35),
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

    round(button, 7)
    registerAccent(button, "BackgroundColor3")

    track(button.MouseButton1Click:Connect(callback))
    return button
end

--====================================================
-- VISUALS PAGE
--====================================================

addToggle(visualList, "Box ESP",
    "Draw boxes around characters", "BoxESP")

addToggle(visualList, "Highlight",
    "Highlight player silhouettes", "Highlight")

addToggle(visualList, "Player Names",
    "Display player names", "Names")

addToggle(visualList, "Distance",
    "Display distance in studs", "Distance")

addToggle(settingsList, "Interface Glow",
    "Accent outline around menu", "Glow")

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

local keyButton = make("TextButton", {
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
    keyButton.Text = "PRESS KEY"
end))

--====================================================
-- UI CUSTOMIZATION
--====================================================

local accentPresets = {
    Color3.fromRGB(145, 88, 255),
    Color3.fromRGB(70, 150, 255),
    Color3.fromRGB(255, 75, 125),
    Color3.fromRGB(50, 210, 160),
    Color3.fromRGB(255, 170, 60),
    Color3.fromRGB(235, 235, 245)
}

local accentIndex = 1

addAction(settingsList,
    "Accent Color",
    "Change interface accent color",
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

addAction(settingsList,
    "Window Transparency",
    "Cycle window transparency",
    "CHANGE",
    function()
        cfg.MenuTransparency += 0.15
        if cfg.MenuTransparency > 0.6 then
            cfg.MenuTransparency = 0
        end

        applyTransparency()
    end
)

addAction(settingsList,
    "Interface Scale",
    "Change menu size",
    "CHANGE",
    function()
        cfg.MenuScale += 0.1
        if cfg.MenuScale > 1.2 then
            cfg.MenuScale = 0.8
        end

        scaleObject.Scale = cfg.MenuScale
    end
)

--====================================================
-- PLAYER RADAR
--====================================================

local radarCard = createCard(radarList, 250)

local radar = make("Frame", {
    Size = UDim2.fromOffset(190, 190),
    Position = UDim2.new(0.5, -95, 0, 12),
    BackgroundColor3 = Color3.fromRGB(17, 17, 26),
    BorderSizePixel = 0,
    ClipsDescendants = true
}, radarCard)

round(radar, 95)

local radarStroke = make("UIStroke", {
    Color = C.Accent,
    Thickness = 1.5
}, radar)

registerAccent(radarStroke, "Color")

make("Frame", {
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 0.5, 0),
    BackgroundColor3 = C.Muted,
    BackgroundTransparency = 0.65,
    BorderSizePixel = 0
}, radar)

make("Frame", {
    Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(0.5, 0, 0, 0),
    BackgroundColor3 = C.Muted,
    BackgroundTransparency = 0.65,
    BorderSizePixel = 0
}, radar)

local radarCenter = make("Frame", {
    Size = UDim2.fromOffset(9, 9),
    Position = UDim2.new(0.5, -4.5, 0.5, -4.5),
    BackgroundColor3 = C.Green,
    BorderSizePixel = 0
}, radar)

round(radarCenter, 10)

local radarDots = {}

local function getRadarDot(plr)
    if radarDots[plr] then
        return radarDots[plr]
    end

    local dot = make("Frame", {
        Size = UDim2.fromOffset(7, 7),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = C.Accent,
        BorderSizePixel = 0
    }, radar)

    round(dot, 10)
    radarDots[plr] = dot

    return dot
end

local function updateRadar()
    local camera = workspace.CurrentCamera
    local myCharacter = player.Character
    local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")

    for plr, dot in pairs(radarDots) do
        if plr.Parent ~= Players then
            dot:Destroy()
            radarDots[plr] = nil
        else
            dot.Visible = false
        end
    end

    if not cfg.Radar or not myRoot or not camera then
        return
    end

    local radius = 82
    local range = math.max(cfg.RadarRange, 1)

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local character = plr.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")

            if root and humanoid and humanoid.Health > 0 then
                local offset = root.Position - myRoot.Position
                local localOffset = camera.CFrame:VectorToObjectSpace(offset)

                local horizontalDistance = Vector2.new(
                    localOffset.X,
                    localOffset.Z
                ).Magnitude

                if horizontalDistance <= range then
                    local dot = getRadarDot(plr)

                    local scale = math.min(horizontalDistance / range, 1)
                    local x = (localOffset.X / range) * radius
                    local y = (localOffset.Z / range) * radius

                    dot.Position = UDim2.new(
                        0.5,
                        x,
                        0.5,
                        y
                    )

                    dot.Visible = true
                end
            end
        end
    end
end

addToggle(radarList,
    "Enable Radar",
    "Show nearby player dots",
    "Radar"
)

addAction(radarList,
    "Radar Range",
    "Cycle radar distance",
    "CHANGE",
    function()
        if cfg.RadarRange == 500 then
            cfg.RadarRange = 250
        elseif cfg.RadarRange == 250 then
            cfg.RadarRange = 1000
        else
            cfg.RadarRange = 500
        end
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

local hudSizes = {
    {Width = 150, Height = 25, Text = 10},
    {Width = 220, Height = 28, Text = 12},
    {Width = 290, Height = 36, Text = 15}
}

local hudOverlay = make("TextLabel", {
    Name = "PerformanceOverlay",
    Size = UDim2.fromOffset(220, 28),
    Position = UDim2.fromOffset(15, 15),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = 0.2,
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

local function applyHUDSize()
    local size = hudSizes[cfg.HUDSize]
    hudOverlay.Size = UDim2.fromOffset(size.Width, size.Height)
    hudOverlay.TextSize = size.Text
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

applyHUDSize()

local function readPing()
    local success, result = pcall(function()
        local network = Stats:FindFirstChild("Network")
        local serverStats = network and network:FindFirstChild("ServerStatsItem")
        local ping = serverStats and serverStats:FindFirstChild("Data Ping")

        if ping then
            return ping:GetValueString()
        end

        return "N/A"
    end)

    if success and result then
        return tostring(result)
    end

    return "N/A"
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
            table.insert(parts, "FPS: " .. fps)
        end

        if cfg.HUDPing then
            table.insert(parts, "PING: " .. ping)
        end

        local value = #parts > 0 and table.concat(parts, "  |  ") or "HUD: ON"
        hudLabel.Text = value
        hudOverlay.Text = value
    end

    hudOverlay.Visible = cfg.HUD
    hudLabel.Visible = cfg.HUD
end

addToggle(hudList,
    "Enable HUD",
    "Show or hide the on-screen HUD",
    "HUD"
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

addAction(hudList,
    "HUD Size",
    "Cycle between small, medium and large",
    "CHANGE",
    function()
        cfg.HUDSize += 1
        if cfg.HUDSize > #hudSizes then
            cfg.HUDSize = 1
        end
        applyHUDSize()
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

local crossColors = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(145, 88, 255),
    Color3.fromRGB(255, 70, 70),
    Color3.fromRGB(70, 255, 150),
    Color3.fromRGB(70, 170, 255),
    Color3.fromRGB(255, 220, 70)
}

local crossColorIndex = 1

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

    for _, part in ipairs(crossParts) do
        part.BackgroundColor3 = cfg.CrosshairColor
    end

    crossGui.Enabled = cfg.Crosshair
end

addToggle(crosshairList,
    "Enable Crosshair",
    "Show custom screen crosshair",
    "Crosshair"
)

addAction(crosshairList,
    "Crosshair Size",
    "Current size: " .. cfg.CrosshairSize,
    "CHANGE",
    function()
        cfg.CrosshairSize += 2

        if cfg.CrosshairSize > 18 then
            cfg.CrosshairSize = 4
        end

        updateCrosshair()
    end
)

addAction(crosshairList,
    "Crosshair Thickness",
    "Current thickness: " .. cfg.CrosshairThickness,
    "CHANGE",
    function()
        cfg.CrosshairThickness += 1

        if cfg.CrosshairThickness > 5 then
            cfg.CrosshairThickness = 1
        end

        updateCrosshair()
    end
)

addAction(crosshairList,
    "Crosshair Gap",
    "Current gap: " .. cfg.CrosshairGap,
    "CHANGE",
    function()
        cfg.CrosshairGap += 2

        if cfg.CrosshairGap > 14 then
            cfg.CrosshairGap = 0
        end

        updateCrosshair()
    end
)

addAction(crosshairList,
    "Crosshair Color",
    "Cycle crosshair colors",
    "CHANGE",
    function()
        crossColorIndex += 1

        if crossColorIndex > #crossColors then
            crossColorIndex = 1
        end

        cfg.CrosshairColor = crossColors[crossColorIndex]
        updateCrosshair()
    end
)

--====================================================
-- SETTINGS PROFILES
--====================================================

-- Profiles are kept for the current play session.
local savedProfiles = {}
local profileKeys = {
    "BoxESP",
    "Highlight",
    "Names",
    "Distance",
    "Glow",
    "Radar",
    "RadarRange",
    "HUD",
    "HUDFPS",
    "HUDPing",
    "HUDSize",
    "Crosshair",
    "CrosshairSize",
    "CrosshairThickness",
    "CrosshairGap",
    "CrosshairColor",
    "MenuTransparency",
    "MenuScale"
}

local function saveProfile(slot)
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

    savedProfiles[slot] = snapshot
end

local function loadProfile(slot)
    local snapshot = savedProfiles[slot]
    if not snapshot then
        return
    end

    for _, key in ipairs(profileKeys) do
        if snapshot.Config[key] ~= nil then
            cfg[key] = snapshot.Config[key]
        end
    end

    C.Accent = snapshot.Accent
    menuKey = snapshot.MenuKey
    accentIndex = snapshot.AccentIndex
    crossColorIndex = snapshot.CrossColorIndex

    keyButton.Text = menuKey.Name
    scaleObject.Scale = cfg.MenuScale
    outline.Transparency = cfg.Glow and 0.35 or 1

    refreshToggleControls()
    applyAccent()
    applyTransparency()
    applyHUDSize()
    updateCrosshair()
end

for slot = 1, 3 do
    addAction(settingsList,
        "Profile " .. slot .. " — Save",
        "Save current settings to slot " .. slot .. " (session only)",
        "SAVE",
        function()
            saveProfile(slot)
        end
    )

    addAction(settingsList,
        "Profile " .. slot .. " — Load",
        "Load saved settings from slot " .. slot,
        "LOAD",
        function()
            loadProfile(slot)
        end
    )
end

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
            Glow = true,
            Radar = true,
            RadarRange = 500,
            HUD = true,
            HUDFPS = true,
            HUDPing = true,
            HUDSize = 2,
            Crosshair = true,
            CrosshairSize = 8,
            CrosshairThickness = 2,
            CrosshairGap = 5,
            CrosshairColor = Color3.fromRGB(255, 255, 255),
            MenuTransparency = 0,
            MenuScale = 1
        }

        for key, value in pairs(defaults) do
            cfg[key] = value
        end

        C.Accent = Color3.fromRGB(145, 88, 255)
        accentIndex = 1
        crossColorIndex = 1
        menuKey = Enum.KeyCode.RightShift

        keyButton.Text = menuKey.Name
        scaleObject.Scale = cfg.MenuScale
        outline.Transparency = 0.35

        refreshToggleControls()
        applyAccent()
        applyTransparency()
        applyHUDSize()
        updateCrosshair()
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
    end
end))

--====================================================
-- RENDER LOOP
--====================================================

track(RunService.RenderStepped:Connect(function(dt)
    updateESP()
    updateRadar()
    updateHUD(dt)
    updateCrosshair()
end))

--====================================================
-- CLEANUP
--====================================================

local function cleanup()
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
-- INITIALIZE
--====================================================

switchPage("Visuals")

outline.Transparency = cfg.Glow and 0.35 or 1

updateCrosshair()
applyAccent()
applyTransparency()

main.Visible = true

print("DEGRADE PRIVATE V5.0 loaded successfully")