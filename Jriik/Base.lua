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
