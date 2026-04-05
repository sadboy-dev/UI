-- Base & Header

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- =============================================
-- MEMBUAT GUI UTAMA
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Header = Instance.new("TextLabel")
local ContentArea = Instance.new("Frame")
local MinimizeBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local IconButton = Instance.new("TextButton")

-- SETTING SCREEN GUI
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- SETTING KOTAK UTAMA
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderColor3 = Color3.new(1, 1, 1)
MainFrame.BorderSizePixel = 1
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -140)
MainFrame.Size = UDim2.new(0, 350, 0, 280)
MainFrame.Visible = true

-- =============================================
-- HEADER / BAGIAN ATAS
-- =============================================
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Header.BorderColor3 = Color3.new(1, 1, 1)
Header.BorderSizePixel = 1
Header.Size = UDim2.new(1, 0, 0, 25)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.Font = Enum.Font.GothamBold
Header.Text = "  Jriik | UI"
Header.TextColor3 = Color3.new(1, 1, 1)
Header.TextSize = 12
Header.TextXAlignment = Enum.TextXAlignment.Left

-- =============================================
-- TOMBOL MINIMIZE
-- =============================================
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = Header
MinimizeBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MinimizeBtn.BorderColor3 = Color3.new(1, 1, 1)
MinimizeBtn.BorderSizePixel = 1
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -55, 0, 0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.TextSize = 12

-- =============================================
-- TOMBOL CLOSE
-- =============================================
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
CloseBtn.BorderColor3 = Color3.new(1, 1, 1)
CloseBtn.BorderSizePixel = 1
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -25, 0, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 12

-- =============================================
-- ICON KECIL (SAAT MINIMIZE)
-- =============================================
IconButton.Name = "IconButton"
IconButton.Parent = ScreenGui
IconButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
IconButton.BorderColor3 = Color3.new(1, 1, 1)
IconButton.BorderSizePixel = 1
IconButton.Size = UDim2.new(0, 50, 0, 50)
IconButton.Position = UDim2.new(0.1, 0, 0.1, 0)
IconButton.Font = Enum.Font.GothamBold
IconButton.Text = "J"
IconButton.TextColor3 = Color3.new(1, 1, 1)
IconButton.TextSize = 20
IconButton.Visible = false

-- Bikin jadi bulat
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1,0)
UICorner.Parent = IconButton

-- =============================================
-- AREA KONTEN
-- =============================================
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 5, 0, 50)
ContentArea.Size = UDim2.new(1, -10, 1, -55)

-- =============================================
-- FUNGSI BUAT FRAME BARU
-- =============================================
local function CreateFrame(name)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = ContentArea
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Visible = false
    return frame
end

-- MEMBUAT FRAME UNTUK SETIAP MENU
local MyselfFrame = CreateFrame("Myself")
local OnlineFrame = CreateFrame("Online")
local WeaponFrame = CreateFrame("Weapon")
local VehicleFrame = CreateFrame("Vehicle")
local VisualsFrame = CreateFrame("Visuals")
local LuaFrame = CreateFrame("Lua")
local ResourcesFrame = CreateFrame("Resources")
local ConfigFrame = CreateFrame("Config")

-- Bagian 2: Isi Menu & Tombol

-- =============================================
-- TAB MYSelf
-- =============================================
do
    local Title = Instance.new("TextLabel")
    Title.Parent = MyselfFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 20)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Player Settings"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 12

    local function MakeBtn(name, y, func)
        local btn = Instance.new("TextButton")
        btn.Parent = MyselfFrame
        btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        btn.BorderColor3 = Color3.new(1, 1, 1)
        btn.BorderSizePixel = 1
        btn.Position = UDim2.new(0, 10, 0, y)
        btn.Size = UDim2.new(0, 150, 0, 30)
        btn.Font = Enum.Font.GothamBold
        btn.Text = name
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.TextSize = 10
        btn.MouseButton1Click:Connect(func)
        return btn
    end

    -- TOMBOL FULL HEALTH
    MakeBtn("Full Health", 30, function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
        end
    end)

    -- TOMBOL SPEED 100
    MakeBtn("Speed 100", 70, function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 100
        end
    end)

    -- TOMBOL JUMP POWER
    MakeBtn("Super Jump", 110, function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 100
        end
    end)
end

-- =============================================
-- TAB ONLINE
-- =============================================
do
    -- LIST PLAYER (KOLOM KIRI)
    local PlayerList = Instance.new("Frame")
    PlayerList.Parent = OnlineFrame
    PlayerList.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    PlayerList.BackgroundTransparency = 0.5
    PlayerList.BorderColor3 = Color3.new(1, 1, 1)
    PlayerList.BorderSizePixel = 1
    PlayerList.Position = UDim2.new(0, 0, 0, 0)
    PlayerList.Size = UDim2.new(0, 100, 0, 220)

    local TitleList = Instance.new("TextLabel")
    TitleList.Parent = PlayerList
    TitleList.BackgroundTransparency = 1
    TitleList.Size = UDim2.new(1, 0, 0, 15)
    TitleList.Font = Enum.Font.GothamBold
    TitleList.Text = "Select Player"
    TitleList.TextColor3 = Color3.new(1, 1, 1)
    TitleList.TextSize = 9

    -- INFO BOX (TENGAH)
    local InfoFrame = Instance.new("Frame")
    InfoFrame.Parent = OnlineFrame
    InfoFrame.BackgroundTransparency = 1
    InfoFrame.Position = UDim2.new(0, 105, 0, 0)
    InfoFrame.Size = UDim2.new(0, 100, 0, 220)

    local InfoText = Instance.new("TextLabel")
    InfoText.Parent = InfoFrame
    InfoText.BackgroundTransparency = 1
    InfoText.Size = UDim2.new(1, 0, 1, 0)
    InfoText.Font = Enum.Font.Gotham
    InfoText.Text = "Select a player..."
    InfoText.TextColor3 = Color3.new(1, 1, 1)
    InfoText.TextSize = 9
    InfoText.TextWrapped = true
    InfoText.TextXAlignment = Enum.TextXAlignment.Left
    InfoText.TextYAlignment = Enum.TextYAlignment.Top

    -- TOMBOL ACTION (KANAN)
    local ButtonsFrame = Instance.new("Frame")
    ButtonsFrame.Parent = OnlineFrame
    ButtonsFrame.BackgroundTransparency = 1
    ButtonsFrame.Position = UDim2.new(0, 210, 0, 0)
    ButtonsFrame.Size = UDim2.new(0, 125, 0, 220)

    local SelectedPlayer = nil

    local function MakeActionBtn(name, yPos, func)
        local btn = Instance.new("TextButton")
        btn.Parent = ButtonsFrame
        btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        btn.BorderColor3 = Color3.new(1, 1, 1)
        btn.BorderSizePixel = 1
        btn.Position = UDim2.new(0, 0, 0, yPos)
        btn.Size = UDim2.new(0, 120, 0, 30)
        btn.Font = Enum.Font.GothamBold
        btn.Text = name
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.TextSize = 10
        btn.MouseButton1Click:Connect(function()
            if SelectedPlayer then
                func(SelectedPlayer)
            end
        end)
        return btn
    end

    -- TOMBOL HEAL
    MakeActionBtn("Heal", 10, function(ply)
        if ply.Character and ply.Character:FindFirstChild("Humanoid") then
            ply.Character.Humanoid.Health = ply.Character.Humanoid.MaxHealth
        end
    end)

    -- TOMBOL TELEPORT
    MakeActionBtn("Teleport", 45, function(ply)
        if LocalPlayer.Character and ply.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = ply.Character.HumanoidRootPart.CFrame
        end
    end)

    -- TOMBOL KILL
    MakeActionBtn("Kill", 80, function(ply)
        if ply.Character and ply.Character:FindFirstChild("Humanoid") then
            ply.Character.Humanoid.Health = 0
        end
    end)

    -- UPDATE LIST PLAYER
    local function RefreshPlayers()
        for _, child in pairs(PlayerList:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        local y = 20
        for _, ply in pairs(Players:GetPlayers()) do
            if ply ~= LocalPlayer then
                local btn = Instance.new("TextButton")
                btn.Parent = PlayerList
                btn.BackgroundTransparency = 1
                btn.Position = UDim2.new(0, 5, 0, y)
                btn.Size = UDim2.new(1, -10, 0, 18)
                btn.Font = Enum.Font.Gotham
                btn.Text = ply.Name
                btn.TextColor3 = Color3.new(1, 1, 1)
                btn.TextSize = 9
                btn.TextXAlignment = Enum.TextXAlignment.Left

                btn.MouseButton1Click:Connect(function()
                    SelectedPlayer = ply
                    InfoText.Text = "Selected:\nName: "..ply.Name.."\nID: "..ply.UserId
                end)
                y = y + 20
            end
        end
    end

    Players.PlayerAdded:Connect(RefreshPlayers)
    Players.PlayerRemoving:Connect(RefreshPlayers)
    RefreshPlayers()
end

-- =============================================
-- TAB LAINNYA (COMING SOON)
-- =============================================
do
    local lbl = Instance.new("TextLabel")
    lbl.Parent = WeaponFrame
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "Weapon Menu\n\nComing Soon..."
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextSize = 12
end
do
    local lbl = Instance.new("TextLabel")
    lbl.Parent = VehicleFrame
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "Vehicle Menu\n\nComing Soon..."
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextSize = 12
end
do
    local lbl = Instance.new("TextLabel")
    lbl.Parent = VisualsFrame
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "Visuals Menu\n\nComing Soon..."
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextSize = 12
end
do
    local lbl = Instance.new("TextLabel")
    lbl.Parent = LuaFrame
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "Lua Executor\n\nComing Soon..."
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextSize = 12
end
do
    local lbl = Instance.new("TextLabel")
    lbl.Parent = ResourcesFrame
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "Resources\n\nComing Soon..."
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextSize = 12
end
do
    local lbl = Instance.new("TextLabel")
    lbl.Parent = ConfigFrame
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "Settings\n\nComing Soon..."
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextSize = 12
end

-- Bagian 3: Tabs, Drag & Fungsi

-- =============================================
-- SISTEM TABS / MENU
-- =============================================
local Tabs = {
    {Name="Myself", Frame=MyselfFrame},
    {Name="Online", Frame=OnlineFrame},
    {Name="Weapon", Frame=WeaponFrame},
    {Name="Vehicle", Frame=VehicleFrame},
    {Name="Visuals", Frame=VisualsFrame},
    {Name="Lua", Frame=LuaFrame},
    {Name="Resources", Frame=ResourcesFrame},
    {Name="Config", Frame=ConfigFrame}
}

local TabX = 5
for i, data in pairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = MainFrame
    TabBtn.BackgroundTransparency = 1
    TabBtn.Position = UDim2.new(0, TabX, 0, 28)
    TabBtn.Size = UDim2.new(0, 40, 0, 18)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.Text = data.Name
    TabBtn.TextColor3 = Color3.new(1, 1, 1)
    TabBtn.TextSize = 9

    TabBtn.MouseButton1Click:Connect(function()
        for _, d in pairs(Tabs) do d.Frame.Visible = false end
        data.Frame.Visible = true
    end)

    TabX = TabX + 42
end

-- SET DEFAULT TAB
MyselfFrame.Visible = true

-- =============================================
-- FITUR DRAG / SERET (SUPPORT MOBILE)
-- =============================================
local Dragging = false
local DragStart = Vector2.new()
local StartPos = UDim2.new()

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Vector2.new(input.Position.X, input.Position.Y)
        StartPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local Delta = Vector2.new(input.Position.X, input.Position.Y) - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

-- =============================================
-- FUNGSI MINIMIZE & CLOSE
-- =============================================
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

IconButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    IconButton.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)


-- =============================================
-- FITUR DRAG ICON BULAT (FIXED)
-- =============================================
local DraggingIcon = false
local DragStartIcon, StartPosIcon

IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        DraggingIcon = true
        DragStartIcon = input.Position
        StartPosIcon = IconButton.Position
        input:Destroy() -- Hapus event biar tidak ganggu
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if DraggingIcon then
        local Delta = input.Position - DragStartIcon
        IconButton.Position = UDim2.new(
            StartPosIcon.X.Scale, 
            StartPosIcon.X.Offset + Delta.X, 
            StartPosIcon.Y.Scale, 
            StartPosIcon.Y.Offset + Delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        DraggingIcon = false
    end
end)
