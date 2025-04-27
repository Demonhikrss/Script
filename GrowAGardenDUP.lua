local player = game.Players.LocalPlayer
if not player then
    warn("Локальный игрок не найден.")
    return
end

local PlayerGui = player:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "GrowAGardenDuplication"

local TextButton = Instance.new("TextButton")
TextButton.Parent = ScreenGui
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Position = UDim2.new(0.5, -100, 0.8, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.Font = Enum.Font.SourceSansBold
TextButton.TextSize = 24
TextButton.Text = "Дюпнуть семена"

local cooldown = false
local seeds = {
    "Bamboo Seed"
}

TextButton.MouseButton1Click:Connect(function()
    if cooldown then
        TextButton.Text = "Жди 10 сек!"
        return
    end

    cooldown = true
    TextButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

    local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory"):WaitForChild("AddItem")
    if not RemoteEvent then
        warn("Ошибка: RemoteEvent 'AddItem' не найден!")
        TextButton.Text = "Ошибка дюпа!"
        cooldown = true
        return
    end

    local success, err = pcall(function()
        for _, seedName in pairs(seeds) do
            RemoteEvent:FireServer(seedName, 1)
        end
    end)

    if not success then
        warn("Ошибка при дюпе семян:", err)
    end

    TextButton.Text = "Подождите 10 сек..."
    wait(10)
    TextButton.Text = "Dupe"
    TextButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    cooldown = 10 
end)
