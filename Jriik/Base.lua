-- Script Utama

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =============================================
-- VARIABEL UNTUK NAVIGASI
-- =============================================
local CurrentObject = game
local History = {}
local PathHistory = {"game"}
local ViewerText = nil -- ISI KODE / PROPERTI
local ViewerTitle = nil -- JUDUL

-- =============================================
-- 🔥 FUNGSI CEK APAKAH INI FOLDER KONTAINER
-- =============================================
local function IsContainer(obj)
    if obj:IsA("Service") or obj.ClassName == "Folder" or obj:IsA("Model") then
        return true
    end
    if obj:IsA("LocalScript") or obj:IsA("Script") or obj:IsA("ModuleScript") then
        return false
    end
    if #obj:GetChildren() > 0 then
        return true
    end
    return false
end

-- =============================================
-- ✅ FUNGSI BACA SCRIPT (WAJIB KELUAR ISINYA)
-- =============================================
local function ReadScript(obj)
    -- CARA 1: COBA SOURCE
    local source = obj.Source
    if source and source ~= "" then
        return source
    end

    -- CARA 2: COBA DECOMPILE LANGSUNG OBJECT
    if type(decompile) == "function" then
        local success, result = pcall(decompile, obj)
        if success and result and result ~= "" then
            return result
        end
    end

    -- CARA 3: COBA GETSCRIPTBYTECODE DULU
    if type(getscriptbytecode) == "function" then
        local bc = getscriptbytecode(obj)
        if bc and type(decompile) == "function" then
            local success, result = pcall(decompile, bc)
            if success and result then
                return result
            end
        end
    end

    -- JIKA MASIH GAGAL, TAMPILKAN HEADER AGAR TIDAK KOSONG
    return "-- SCRIPT: " .. obj.Name .. "\n"
        .. "-- ClassName: " .. obj.ClassName .. "\n"
        .. "-- ======================================\n\n"
        .. "-- Script berhasil dibuka, namun kode bersifat protected atau kosong.\n"
        .. "-- Disabled: " .. tostring(obj.Disabled) .. "\n"
        .. "-- Archivable: " .. tostring(obj.Archivable) .. "\n"
end

-- =============================================
-- 🔥 FUNGSI AMBIL KONTEN
-- =============================================
local function getContent(obj)
    local content = ""
    
    -- JIKA SCRIPT, WAJIB TAMPILKAN ISI KODE
    if obj:IsA("LocalScript") or obj:IsA("Script") or obj:IsA("ModuleScript") then
        content = ReadScript(obj)
    else
        -- =============================================
        -- ✅ BAGIAN OBJECT INFORMATION
        -- =============================================
        content = "--- OBJECT INFORMATION ---\n"
        content ..= "Name: " .. obj.Name .. "\n"
        content ..= "ClassName: " .. obj.ClassName .. "\n"
        content ..= "Parent: " .. tostring(obj.Parent) .. "\n"
        local children = obj:GetChildren()
        content ..= "Children: " .. tostring(#children) .. "\n\n"

        -- =============================================
        -- ✅ KATEGORI 1: APPEARANCE
        -- =============================================
        content ..= "--- APPEARANCE ---\n"
        local appearanceProps = {
            "Color", "Material", "Transparency", "Reflectance", "Texture",
            "BackgroundColor3", "BackgroundTransparency", "BorderColor3", "BorderSizePixel",
            "Text", "TextColor3", "TextTransparency", "TextSize", "Font",
            "Image", "ImageColor3", "ImageTransparency", "ImageRectOffset", "ImageRectSize",
            "HeadColor", "HeadColor3", "TorsoColor", "TorsoColor3",
            "LeftArmColor", "LeftArmColor3", "RightArmColor", "RightArmColor3",
            "LeftLegColor", "LeftLegColor3", "RightLegColor", "RightLegColor3"
        }
        for _, propName in pairs(appearanceProps) do
            local success, val = pcall(function() return obj[propName] end)
            if success and val ~= nil then
                content ..= propName .. ": " .. tostring(val) .. "\n"
            end
        end

        -- =============================================
        -- ✅ KATEGORI 2: DATA
        -- =============================================
        content ..= "\n--- DATA ---\n"
        local dataProps = {
            "Value", "ValueBase", "NumberValue", "StringValue", "BoolValue",
            "Source", "Disabled"
        }
        for _, propName in pairs(dataProps) do
            local success, val = pcall(function() return obj[propName] end)
            if success and val ~= nil then
                content ..= propName .. ": " .. tostring(val) .. "\n"
            end
        end

        -- =============================================
        -- ✅ KATEGORI 3: BEHAVIOR
        -- =============================================
        content ..= "\n--- BEHAVIOR ---\n"
        local behaviorProps = {
            "Anchored", "CanCollide", "CanTouch", "CanQuery", "Massless",
            "CastShadow", "ReceiveLight", "Shape",
            "Visible", "Active", "ClipsDescendants", "Draggable", "Selectable",
            "Archivable", "Locked"
        }
        for _, propName in pairs(behaviorProps) do
            local success, val = pcall(function() return obj[propName] end)
            if success and val ~= nil then
                content ..= propName .. ": " .. tostring(val) .. "\n"
            end
        end

        -- =============================================
        -- ✅ KATEGORI 4: TRANSFORMATION
        -- =============================================
        content ..= "\n--- TRANSFORMATION ---\n"
        local transformProps = {
            "Size", "Position", "CFrame", "Rotation", "Orientation",
            "MinimumSize", "MaximumSize"
        }
        for _, propName in pairs(transformProps) do
            local success, val = pcall(function() return obj[propName] end)
            if success and val ~= nil then
                content ..= propName .. ": " .. tostring(val) .. "\n"
            end
        end

        -- =============================================
        -- ✅ LIST CHILDREN
        -- =============================================
        content ..= "\n--- CHILDREN ---\n"
        if #children > 0 then
            for _, child in pairs(children) do
                content ..= "- " .. child.Name .. " [" .. child.ClassName .. "]\n"
            end
        else
            content ..= "None\n"
        end
    end
    
    return content
end

-- =============================================
-- DEFINISI FITUR
-- =============================================
Features = {
    -- =============================================
    -- FITUR 1: EXPLORER
    -- =============================================
    {
        Name = "Explorer",
        Layout = {
            { Type = "List", Title = "game" }
        },
        OnBuild = function(MainFrame)
            local Content = MainFrame:FindFirstChild("List").Content
            local PanelHeader = MainFrame:FindFirstChild("List")
            local TitleLabel = PanelHeader:FindFirstChild("TextLabel")

            -- 🔙 TOMBOL BACK
            local BackBtn = Instance.new("TextButton")
            BackBtn.Parent = PanelHeader
            BackBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            BackBtn.BorderSizePixel = 1
            BackBtn.Size = UDim2.new(0, 30, 0, 20)
            BackBtn.Position = UDim2.new(0, 5, 0, 0)
            BackBtn.Font = Enum.Font.GothamBold
            BackBtn.Text = "<-"
            BackBtn.TextColor3 = Color3.new(1, 1, 1)
            BackBtn.TextSize = 10
            BackBtn.Visible = false

            TitleLabel.Position = UDim2.new(0, 40, 0, 0)
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            -- 📂 SCROLLING FRAME
            local Scrolling = Instance.new("ScrollingFrame")
            Scrolling.Parent = Content
            Scrolling.BackgroundTransparency = 1
            Scrolling.BorderSizePixel = 0
            Scrolling.Size = UDim2.new(1, 0, 1, 0)
            Scrolling.ScrollBarThickness = 3
            Scrolling.Active = true
            Scrolling.Selectable = true
            Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)

            local UIList = Instance.new("UIListLayout")
            UIList.Parent = Scrolling
            UIList.Padding = UDim.new(0, 2)
            UIList.SortOrder = Enum.SortOrder.LayoutOrder

            -- =============================================
            -- FUNGSI REFRESH LIST
            -- =============================================
            local function RefreshList()
                for _, v in pairs(Scrolling:GetChildren()) do 
                    if v:IsA("TextButton") then v:Destroy() end 
                end

                local Children = CurrentObject:GetChildren()
                table.sort(Children, function(a, b) return a.Name < b.Name end)

                for _, Child in pairs(Children) do
                    local Item = Instance.new("TextButton")
                    Item.Parent = Scrolling
                    Item.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
                    Item.BorderSizePixel = 0
                    Item.Size = UDim2.new(1, -5, 0, 25)
                    Item.Font = Enum.Font.Code
                    
                    -- IKON SESUAI JENIS
                    if Child:IsA("LocalScript") or Child:IsA("Script") or Child:IsA("ModuleScript") then
                        Item.Text = "📜 " .. Child.Name
                    elseif IsContainer(Child) then
                        Item.Text = "📁 " .. Child.Name
                    else
                        Item.Text = "📄 " .. Child.Name
                    end
                    
                    Item.TextColor3 = Color3.new(1, 1, 1)
                    Item.TextSize = 10
                    Item.TextXAlignment = Enum.TextXAlignment.Left

                    -- KLIK ITEM
                    Item.MouseButton1Click:Connect(function()
                        if IsContainer(Child) then
                            -- ==== MASUK KE DALAM ====
                            table.insert(History, CurrentObject)
                            table.insert(PathHistory, Child.Name)
                            CurrentObject = Child
                            RefreshList()
                            BackBtn.Visible = true
                            TitleLabel.Text = table.concat(PathHistory, "/")
                        else
                            -- ==== BUKA DI VIEWER ====
                            local content = getContent(Child)
                            
                            -- 🔥 TAMPILKAN
                            local ViewerFrame = MainFrame.Parent:FindFirstChild("Viewer")
                            if ViewerFrame then
                                local ListFrame = ViewerFrame:FindFirstChild("List")
                                if ListFrame then
                                    local ContentArea = ListFrame.Content
                                    if ContentArea then
                                        local Scroll = ContentArea:FindFirstChildWhichIsA("ScrollingFrame")
                                        if Scroll then
                                            Scroll.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
                                            
                                            if ViewerText then
                                                if Child:IsA("LocalScript") or Child:IsA("Script") or Child:IsA("ModuleScript") then
                                                    ViewerText.TextWrapped = false
                                                    ViewerText.Text = content
                                                    ViewerText.TextColor3 = Color3.new(1, 1, 1)
                                                    ViewerText.TextSize = 14
                                                    
                                                    local text_size = ViewerText.TextBounds
                                                    ViewerText.Size = UDim2.new(0, text_size.X + 50, 0, text_size.Y + 20)
                                                    Scroll.CanvasSize = UDim2.new(0, text_size.X + 50, 0, text_size.Y + 40)
                                                else
                                                    ViewerText.TextWrapped = true
                                                    ViewerText.Text = content
                                                    ViewerText.TextColor3 = Color3.new(1, 1, 1)
                                                    ViewerText.TextSize = 14
                                                    
                                                    local text_size = ViewerText.TextBounds
                                                    ViewerText.Size = UDim2.new(1, -20, 0, text_size.Y + 20)
                                                    Scroll.CanvasSize = UDim2.new(0, 0, 0, text_size.Y + 40)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            
                            -- ✅ UBAH JUDUL
                            if ViewerTitle then
                                ViewerTitle.Text = Child.Name
                            end
                            
                            -- PINDAH TAB
                            local ParentFrame = MainFrame.Parent
                            for _, obj in pairs(ParentFrame:GetChildren()) do
                                if obj:IsA("Frame") and obj.Name ~= "MainFrame" and obj.Name ~= "Header" then
                                    obj.Visible = false
                                end
                            end
                            local ViewerTab = ParentFrame:FindFirstChild("Viewer")
                            if ViewerTab then ViewerTab.Visible = true end
                        end
                    end)
                end

                Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
            end

            -- =============================================
            -- LOGIKA BACK
            -- =============================================
            BackBtn.MouseButton1Click:Connect(function()
                if #History > 0 then
                    CurrentObject = History[#History]
                    table.remove(History, #History)
                    table.remove(PathHistory, #PathHistory)
                    RefreshList()
                    TitleLabel.Text = table.concat(PathHistory, "/")
                    
                    if #History == 0 then
                        BackBtn.Visible = false
                    end
                end
            end)

            RefreshList()
        end
    },

    -- =============================================
    -- FITUR 2: VIEWER
    -- =============================================
    {
        Name = "Viewer",
        Layout = {
            { Type = "List", Title = "Content" }
        },
        OnBuild = function(MainFrame)
            local ListFrame = MainFrame:FindFirstChild("List")
            local Content = ListFrame.Content
            
            -- ✅ SIMPAN REFERENSI JUDUL
            ViewerTitle = ListFrame:FindFirstChild("TextLabel")

            -- 📂 SCROLLING FRAME
            local Scrolling = Instance.new("ScrollingFrame")
            Scrolling.Parent = Content
            Scrolling.BackgroundColor3 = Color3.new(1, 1, 1)
            Scrolling.BorderSizePixel = 0
            Scrolling.Size = UDim2.new(1, 0, 1, 0)
            Scrolling.ScrollBarThickness = 3
            Scrolling.Active = true
            Scrolling.Selectable = true
            Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)

            -- 🟦 TEXTLABEL KODE / PROPERTIES
            ViewerText = Instance.new("TextLabel")
            ViewerText.Name = "ContentText"
            ViewerText.Parent = Scrolling
            ViewerText.BackgroundTransparency = 1
            ViewerText.Size = UDim2.new(1, -20, 1, -20)
            ViewerText.Position = UDim2.new(0, 10, 0, 10)
            ViewerText.Font = Enum.Font.Code
            ViewerText.Text = "-- Select an object to view its content or properties..."
            ViewerText.TextColor3 = Color3.new(0, 0, 0)
            ViewerText.TextSize = 14
            ViewerText.TextWrapped = false
            ViewerText.RichText = false
            ViewerText.TextXAlignment = Enum.TextXAlignment.Left
            ViewerText.TextYAlignment = Enum.TextYAlignment.Top

            -- FUNGSI UPDATE UKURAN
            local function UpdateSize()
                local text_size = ViewerText.TextBounds
                if ViewerText.TextWrapped then
                    ViewerText.Size = UDim2.new(1, -20, 0, text_size.Y + 20)
                    Scrolling.CanvasSize = UDim2.new(0, 0, 0, text_size.Y + 40)
                else
                    ViewerText.Size = UDim2.new(0, text_size.X + 50, 0, text_size.Y + 20)
                    Scrolling.CanvasSize = UDim2.new(0, text_size.X + 50, 0, text_size.Y + 40)
                end
            end

            -- EVENT
            ViewerText:GetPropertyChangedSignal("Text"):Connect(UpdateSize)
            UpdateSize()
        end
    }
}

-- =============================================
-- ✅ LOAD LIBRARY
-- =============================================
loadstring(game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/UI/refs/heads/main/Jriik/UI.lua"))()
