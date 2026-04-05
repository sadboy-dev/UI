-- Core UI
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
-- HEADER
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
-- TOMBOL MINIMIZE & CLOSE
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
-- ICON BULAT (MINIMIZE)
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
-- FUNGSI BUAT FRAME
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

-- =============================================
-- DRAG SYSTEM (FIXED)
-- =============================================
local Dragging = false
local DragStart, StartPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

local DraggingIcon = false
local DragStartIcon, StartPosIcon

IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        DraggingIcon = true
        DragStartIcon = input.Position
        StartPosIcon = IconButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
    if DraggingIcon then
        local Delta = input.Position - DragStartIcon
        IconButton.Position = UDim2.new(StartPosIcon.X.Scale, StartPosIcon.X.Offset + Delta.X, StartPosIcon.Y.Scale, StartPosIcon.Y.Offset + Delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
        DraggingIcon = false
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
-- 🔍 SCAN & LOAD FITUR DARI VARIABLE "Features"
-- =============================================
-- Cek apakah variabel Features sudah ada di memory
if type(Features) == "table" then
    local Tabs = {}
    local TabX = 5

    for _, Category in pairs(Features) do
        local NewFrame = CreateFrame(Category.Name)
        table.insert(Tabs, {Name = Category.Name, Frame = NewFrame})
        
        -- BUAT TOMBOL TAB
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = MainFrame
        TabBtn.BackgroundTransparency = 1
        TabBtn.Position = UDim2.new(0, TabX, 0, 28)
        TabBtn.Size = UDim2.new(0, 40, 0, 18)
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.Text = Category.Name
        TabBtn.TextColor3 = Color3.new(1, 1, 1)
        TabBtn.TextSize = 9
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Frame.Visible = false end
            NewFrame.Visible = true
        end)
        
        TabX = TabX + 45

        -- BUAT ISI TOMBOL
        local YPos = 20
        local function MakeBtn(name, func)
            local btn = Instance.new("TextButton")
            btn.Parent = NewFrame
            btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            btn.BorderColor3 = Color3.new(1, 1, 1)
            btn.BorderSizePixel = 1
            btn.Position = UDim2.new(0, 10, 0, YPos)
            btn.Size = UDim2.new(0, 150, 0, 30)
            btn.Font = Enum.Font.GothamBold
            btn.Text = name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextSize = 10
            btn.MouseButton1Click:Connect(func)
            YPos = YPos + 40
            return btn
        end

        -- JUDUL
        local Title = Instance.new("TextLabel")
        Title.Parent = NewFrame
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1, 0, 0, 20)
        Title.Font = Enum.Font.GothamBold
        Title.Text = Category.Name .. " Settings"
        Title.TextColor3 = Color3.new(1, 1, 1)
        Title.TextSize = 12

        -- MASUKIN ITEM
        for _, Item in pairs(Category.Items) do
            MakeBtn(Item.Text, Item.Func)
        end
    end

    -- SET DEFAULT TAB
    if Tabs[1] then Tabs[1].Frame.Visible = true end
else
    warn("Variabel 'Features' tidak ditemukan atau kosong!")
end
