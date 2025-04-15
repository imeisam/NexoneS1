local function TrimString(name)
	-- remove word society_ from name
  return name:sub(9)
end

-- RegisterCommand("convertesxsociety", function()
--   local societyData = MySQL.Sync.fetchAll("SELECT * FROM `addon_account_data`")
--   local totalAmount = {}
--   local jobMoney = {}
--   for k, v in pairs(societyData) do
--     local job = TrimString(v.account_name)
--       if jobGangAccounts[job] then
--         if not jobMoney[job] then
--           jobMoney[job] = v.money
--         end
--       end
--   end

--   for k, v in pairs(jobMoney) do
--       print("Adding money for job with id: " .. k .. " with amount: " .. v)
--       MySQL.query.await("UPDATE banking_accounts SET amount = ? WHERE account = ?", {v, k})
--       jobGangAccounts[k] = v
--   end

-- end, true)


