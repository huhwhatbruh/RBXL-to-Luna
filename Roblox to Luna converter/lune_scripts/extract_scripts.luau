-- extract_scripts.luau
local fs     = require("@lune/fs")
local roblox = require("@lune/roblox")

-- 1. Read & deserialize your place
local raw = fs.readFile("../game.rbxl")
assert(raw, "❌ Could not read ../game.rbxl – make sure it exists")
local place = roblox.deserializePlace(raw)

-- 2. Helper: recursively collect all descendants
local function collectDescendants(inst, out)
  for _, child in ipairs(inst:GetChildren()) do
    table.insert(out, child)
    collectDescendants(child, out)
  end
end

-- 3. Where to dump scripts
local services = {
  { name = "ServerScriptService", path = "../src/server" },
  { name = "ReplicatedStorage",  path = "../src/shared" },
  { name = "StarterPlayer",      path = "../src/client" },
}

-- 4. Extract!
for _, svc in ipairs(services) do
  -- Ensure the folder exists
  if not fs.isDir(svc.path) then
    fs.writeDir(svc.path)
  end

  -- find the service container
  local container = place:FindFirstChild(svc.name)
  assert(container, "❌ Could not find service '" .. svc.name .. "' in place")

  -- collect every descendant
  local all = {}
  collectDescendants(container, all)
  for _, inst in ipairs(all) do
    if inst:IsA("Script") or inst:IsA("LocalScript") or inst:IsA("ModuleScript") then
      local outPath = string.format("%s/%s.lua", svc.path, inst.Name)
      fs.writeFile(outPath, inst.Source)
    end
  end
end

print("✅ Extraction complete!")
