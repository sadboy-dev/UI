-- Script Utama

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =============================================
-- DEFINISI FITUR EXPLORER
-- =============================================
Features = {
    {
        Name = "Explorer",
        Layout = {
            { Type = "List", Title = "Explorer" }
        },
        OnBuild = function(MainFrame)
            local Content = MainFrame:FindFirstChild("List").Content

            -- Buat Scrolling Frame
            local Scrolling = Instance.new("ScrollingFrame")
            Scrolling.Parent = Content
            Scrolling.BackgroundTransparency = 1
            Scrolling.BorderSizePixel = 0
            Scrolling.Size = UDim2.new(1, 0, 1, 0)
            Scrolling.Position = UDim2.new(0, 0, 0, 0)
            Scrolling.ScrollBarThickness = 3
            Scrolling.ScrollingDirection = Enum.ScrollingDirection.Y -- 👈 KUNCI: HANYA BAWAH ATAS
            Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)

            local UIList = Instance.new("UIListLayout")
            UIList.Parent = Scrolling
            UIList.Padding = UDim.new(0, 2)
            UIList.SortOrder = Enum.SortOrder.LayoutOrder

            -- =============================================
            -- LOGIKA AMBIL DATA
            -- =============================================
            local function RefreshList()
                for _, v in pairs(Scrolling:GetChildren()) do 
                    if v:IsA("TextButton") or v:IsA("TextLabel") then 
                        v:Destroy() 
                    end 
                end

                local Objects = game:GetChildren()
                table.sort(Objects, function(a, b) return a.Name < b.Name end)

                for _, Object in pairs(Objects) do
                    local Item = Instance.new("TextButton")
                    Item.Parent = Scrolling
                    Item.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
                    Item.BorderSizePixel = 0
                    Item.Size = UDim2.new(1, -5, 0, 25)
                    Item.Font = Enum.Font.Gotham
                    Item.Text = "📁 " .. Object.Name
                    Item.TextColor3 = Color3.new(1, 1, 1)
                    Item.TextSize = 10
                    Item.TextXAlignment = Enum.TextXAlignment.Left

                    Item.MouseButton1Click:Connect(function()
                        print("Selected: " .. Object.Name)
                    end)
                end

                Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
            end

            RefreshList()
        end
    }
}

-- =============================================
-- PANGGIL FILE UI
-- =============================================
loadstring(game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/UI/refs/heads/main/Jriik/UI.lua"))()
