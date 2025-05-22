repeat wait() until game:IsLoaded()
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo UI đơn giản
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "CustomMacroUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 180)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Custom Macro Recorder"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

-- Nút bắt đầu ghi
local btnRecord = Instance.new("TextButton", frame)
btnRecord.Size = UDim2.new(1, -20, 0, 40)
btnRecord.Position = UDim2.new(0, 10, 0, 40)
btnRecord.Text = "Start Recording"
btnRecord.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
btnRecord.TextColor3 = Color3.new(1,1,1)
btnRecord.Font = Enum.Font.SourceSansBold
btnRecord.TextSize = 18

-- Nút dừng ghi
local btnStop = Instance.new("TextButton", frame)
btnStop.Size = UDim2.new(1, -20, 0, 40)
btnStop.Position = UDim2.new(0, 10, 0, 90)
btnStop.Text = "Stop Recording"
btnStop.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
btnStop.TextColor3 = Color3.new(1,1,1)
btnStop.Font = Enum.Font.SourceSansBold
btnStop.TextSize = 18
btnStop.Active = false
btnStop.AutoButtonColor = false
btnStop.Visible = false

-- Nút phát lại
local btnPlay = Instance.new("TextButton", frame)
btnPlay.Size = UDim2.new(1, -20, 0, 40)
btnPlay.Position = UDim2.new(0, 10, 0, 140)
btnPlay.Text = "Play Macro"
btnPlay.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
btnPlay.TextColor3 = Color3.new(1,1,1)
btnPlay.Font = Enum.Font.SourceSansBold
btnPlay.TextSize = 18

-- Biến lưu trữ hành động
local actions = {}
local isRecording = false

-- Giả sử đây là hàm đặt tháp, bạn cần thay thế phù hợp game
local function placeTower(position)
    print("Đặt tháp ở", position)
    -- Thay thế lệnh dưới bằng remote call game của bạn
    -- game:GetService("ReplicatedStorage").Remotes.PlaceTower:InvokeServer("BasicTower", position)
end

-- Ghi hành động đặt tháp
local function recordPlaceTower(position)
    if isRecording then
        table.insert(actions, {action = "place", position = position})
        print("Ghi lại hành động đặt tháp tại", position)
    end
end

-- Phát lại hành động
local function replayActions()
    print("Bắt đầu phát lại macro...")
    for _, act in ipairs(actions) do
        if act.action == "place" then
            placeTower(act.position)
            wait(1) -- đợi giữa các hành động
        end
    end
    print("Kết thúc phát lại macro.")
end

-- Xử lý nút
btnRecord.MouseButton1Click:Connect(function()
    actions = {} -- reset
    isRecording = true
    btnRecord.Visible = false
    btnStop.Visible = true
    print("Bắt đầu ghi macro...")
end)

btnStop.MouseButton1Click:Connect(function()
    isRecording = false
    btnRecord.Visible = true
    btnStop.Visible = false
    print("Dừng ghi macro.")
end)

btnPlay.MouseButton1Click:Connect(function()
    if #actions > 0 then
        replayActions()
    else
        print("Chưa có hành động nào được ghi.")
    end
end)

-- Ví dụ dùng: khi bạn muốn ghi đặt tháp ở vị trí (0,0,0)
-- Bạn có thể gọi recordPlaceTower(Vector3.new(0,0,0)) trong khi ghi macro đang bật

