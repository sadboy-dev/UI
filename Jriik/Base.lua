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
        -- 👇 INI YANG BARU, KASIH TAU UI KITA MAU BERAPA KOLOM
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
            local function RefreshList()
                for _, v in pairs(ListCol:GetChildren()) do 
                    if v:IsA("TextButton") then v:Destroy() end 
                end

                for _, ply in pairs(Players:GetPlayers()) do
                    if ply ~= LocalPlayer then
                        local Btn = Instance.new("TextButton")
                        Btn.Parent = ListCol
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
                            InfoCol.Text = "Name: "..ply.Name.."\nID: "..ply.UserId
                        end)
                    end
                end
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

            -- =============================================
            -- ISI KOLOM 3: TOMBOL ACTION
            -- =============================================
            local Y = 0
            local function MakeActBtn(name, func)
                local btn = Instance.new("TextButton")
               
