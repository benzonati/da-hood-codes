local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("MainEvent")

local url = "https://github.com/benzonati/da-hood-codes/raw/refs/heads/main/codes.json"

local success, response = pcall(function()
    return HttpService:GetAsync(url)
end)

if success then
    local data = HttpService:JSONDecode(response)
    if data and data.codes then
        for _, code in ipairs(data.codes) do
            print("Redeeming", code)
            Remote:FireServer("EnterPromoCode", code)
            task.wait(2.5)
        end
    else
        warn("The 'codes' key does not exist in the JSON data.")
    end
else
    warn("Failed to fetch data from the URL: " .. response)
end

return true
