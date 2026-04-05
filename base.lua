-- =============================================
-- FILE: base
-- BAGIAN 1: DASAR UI
-- =============================================

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Variabel
local MenuOpen = false
local Dragging = false
local DragStart, StartPos
local CurrentTab = "Myself"

-- =============================================
-- MEMBUAT GUI UTAMA
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Header = Instance.new("TextLabel")
local ContentArea = Instance.new("Frame")

-- Properties
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderColor3 = Color3.new(1, 1, 1)
MainFrame.BorderSizePixel = 1
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 280)
MainFrame.Visible = false

-- HEADER / BAGIAN ATAS
-- Kotak tetap penuh, tulisan dikasih space
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Header.BorderColor3 = Color3.new(1, 1, 1)
Header.BorderSizePixel = 1
Header.Size = UDim2.new(1, 0, 0, 25)
Header.Font = Enum.Font.GothamBold
Header.Text = "  Jriik | UI"
Header.TextColor3 = Color3.new(1, 1, 1)
Header.TextSize = 12
Header.TextXAlignment = Enum.TextXAlignment.Left

-- AREA KONTEN (TEMPAT ISI MENU)
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

-- Buat Frame untuk setiap Tab
local MyselfFrame = CreateFrame("Myself")
local OnlineFrame = CreateFrame("Online")
local WeaponFrame = CreateFrame("Weapon")
local VehicleFrame = CreateFrame("Vehicle")
local VisualsFrame = CreateFrame("Visuals")
local LuaFrame = CreateFrame("Lua")
local ResourcesFrame = CreateFrame("Resources")
local ConfigFrame = CreateFrame("Config")
