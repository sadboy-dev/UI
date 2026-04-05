-- Script Utama

-- 1. DEFINISIKAN DAFTAR FITUR
-- Variabel ini yang akan di-scan oleh UI
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
        Name = "Fun",
        Items = {
            {Text = "Spin Me", Func = function() 
                print("Fitur Spin") 
            end}
        }
    }
}

-- 2. PANGGIL FILE UI
loadstring(game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/UI/refs/heads/main/Jriik/ui.lua"))()
