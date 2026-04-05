-- Script Utama

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SelectedPlayer = nil

-- =============================================
-- DEFINISI FITUR DENGAN SISTEM KOLOM
-- =============================================
Features = {
    {
        Name = "Player",
        Items = {
            {Text = "Full Health", Func = function() 
                if LocalPlayer.Character then LocalPlayer.Character.Humanoid.Health = 999 end 
            end},
            {Text = "Speed 100", Func = function() 
                if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 100 end 
            end},
            {Text = "Super Jump", Func = function() 
                if LocalPlayer.Character then LocalPlayer.Character.Humanoid.JumpPower = 100 end 
            end}
        }
    },
    {
        Name = "Online",
        -- 👇 DEFINISI BERAPA KOLOM DAN JENISNYA
        Layout = {
            { Type = "List", Title = "Player List" },
            { Type = "Info", Title = "Information" },
            { Type = "Buttons", Title = "Actions" }
        },
        -- Fungsi ini jalan setelah kolom terbikin
        OnBuild = function(MainFrame)
            -- CARI MASING-MASING KOLOM
            local ListCol   = MainFrame:FindFirstChild("List").Content
            local InfoCol  = MainFrame:FindFirstChild("Info").Content
            local BtnCol   = MainFrame:FindFirstChild("Buttons").Content

            -- =============================================
            -- ISI KOLOM 1: LIST PLAYER
            -- =============================================
            local Scrolling = Instance.new("ScrollingFrame")
            Scrolling.Parent = ListCol
            Scrolling.BackgroundTransparency = 1
            Scrolling.BorderSizePixel = 0
            Scrolling.Size = UDim2.new(1, 0, 1, 0)
            Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
            Scrolling.ScrollBarThickness = 3

            local UIList = Instance.new("UIListLayout")
            UIList.Parent = Scrolling
            UIList.Padding = UDim.new(0, 2)
            UIList.SortOrder = Enum.SortOrder.LayoutOrder

            local function RefreshList()
                for _, v in pairs(Scrolling:GetChildren()) do 
                    if v:IsA("TextButton") then v:Destroy() end 
                end

                for _, ply in pairs(Players:GetPlayers()) do
                    if ply ~= LocalPlayer then
                        local Btn = Instance.new("TextButton")
                        Btn.Parent = Scrolling
                        Btn.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
                        Btn.BorderSizePixel = 0
                        Btn.Size = UDim2.new(1, -5, 0, 25)
                        Btn.Font = Enum.Font.Gotham
                        Btn.Text = "• "..ply.Name
                        Btn.TextColor3 = Color3.new(1, 1, 1)
                        Btn.TextSize = 9
                        Btn.TextXAlignment = Enum.TextXAlignment.Left

                        Btn.MouseButton1Click:Connect(function()
                            SelectedPlayer = ply
                            InfoText.Text = "Name: "..ply.Name.."\nID: "..ply.UserId.."\nStatus: Online"
                        end)
                    end
                end
                Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
            end

            -- =============================================
            -- ISI KOLOM 2: INFO BOX
            -- =============================================
            local InfoText = Instance.new("TextLabel")
            InfoText.Parent = InfoCol
            InfoText.BackgroundTransparency = 1
            InfoText.Size = UDim2.new(1, 0, 1, 0)
            InfoText.Font = Enum.Font.Gotham
            InfoText.Text = "Select a player..."
            InfoText.TextColor3 = Color3.new(1, 1, 1)
            InfoText.TextSize = 9
            InfoText.TextWrapped = true
            InfoText.TextXAlignment = Enum.TextXAlignment.Left
            InfoText.TextYAlignment = Enum.TextYAlignment.Top

            -- =============================================
            -- ISI KOLOM 3: TOMBOL ACTION
            -- =============================================
            local Y = 0
            local function MakeActBtn(name, func)
                local btn = Instance.new("TextButton")
                btn.Parent = BtnCol
                btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                btn.BorderColor3 = Color3.new(1, 1, 1)
                btn.BorderSizePixel = 1
                btn.Position = UDim2.new(0, 0, 0, Y)
                btn.Size = UDim2.new(1, 0, 0, 30)
                btn.Font = Enum.Font.GothamBold
                btn.Text = name
                btn.TextColor3 = Color3.new(1, 1, 1)
                btn.TextSize = 10
                btn.MouseButton1Click:Connect(function()
                    if SelectedPlayer then func() end
                end)
                Y = Y + 35
                return btn
            end

            -- BUAT TOMBOLNYA
            MakeActBtn("Teleport", function()
                if LocalPlayer.Character and SelectedPlayer.Character then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame
                end
            end)

            MakeActBtn("Kill", function()
                if SelectedPlayer.Character then
                    SelectedPlayer.Character.Humanoid.Health = 0
                end
            end)

            MakeActBtn("Bring", function()
                if LocalPlayer.Character and SelectedPlayer.Character then
                    SelectedPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end)

            -- REFRESH LIST
            Players.PlayerAdded:Connect(RefreshList)
            Players.PlayerRemoving:Connect(RefreshList)
            RefreshList()
        end
    }
}

-- =============================================
-- PANGGIL FILE UI
-- =============================================
loadstring(game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/UI/refs/heads/main/Jriik/UI.lua"))()
