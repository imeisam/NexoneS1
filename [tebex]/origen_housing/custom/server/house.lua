--@param src Player source
--@param data Table with the following fields:
-- price (number): Price of the house
-- houseID (number): ID of the house
-- owner (string): Owner of the house
Custom.OnBuyHouse = function(src, data)

end

--@param src Player source
--@param data Table with the following fields:
-- houseID (number): ID of the house
-- owner (string): Owner of the house
Custom.OnDeleteHouse = function(src, data)

end

--@param src Player source
--@param data Table with the following fields:
-- upgrade (string): Name of the upgrade
-- houseID (number): ID of the house
-- owner (string): Owner of the house
-- price (number): Price of the upgrade
Custom.OnBuyUpgrade = function(src, data)

end

--@param src Player source
--@param data Table with the following fields:
-- object (string): Name of the object
-- type (string): Type of the object
-- houseID (number): ID of the house
-- owner (string): Owner of the house
-- price (number): Price of the object
Custom.OnBuyFurniture = function(src, data)

end

-- @param src Player source
-- @param data Table with the following fields:
-- objectID (number): ID of the object
-- model (string): Model of the object
Custom.OnDeleteFurniture = function(src, data)

end

--@param data Table with the following fields:
-- houseID (number): ID of the house
-- stage (number): Stage of the building
Custom.OnStartBuilding = function(data)

end

--@param src Player source
--@param data Table with the following fields:
-- type (string): Type of the object
-- houseID (number): ID of the house
-- owner (string): Owner of the house
-- price (number): Price of the object
Custom.OnTryBuyObject = function(src, data)
    return true
end