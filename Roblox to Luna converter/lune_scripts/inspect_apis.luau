-- inspect_apis.luau
local fs      = require("@lune/fs")
local roblox  = require("@lune/roblox")

print("FS module:", fs)
for k in pairs(fs) do print("  fs.", k) end

print("Roblox module:", roblox)
for k in pairs(roblox) do print("  roblox.", k) end