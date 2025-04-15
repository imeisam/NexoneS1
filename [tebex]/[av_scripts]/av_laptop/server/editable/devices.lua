function getSerial(source,metadata) -- get phone serial number, used to fetch data from gallery table
    if Config.UsingPhone == "qb-phone" then
        return getIdentifier(source) or ""
    end
end

function getFiles(serial) -- fetch files from phone_gallery using phone serial
    local column = "identifier"
    if Config.UsingPhone == "qb-phone" then
        column = "citizenid"
    end
    return MySQL.query.await('SELECT * FROM `phone_gallery` WHERE `'..column..'` = ?', {
        serial
    })
end

function getFileInfo(name,data)
    local info = {
        id = data['id'] or math.random(1,100),
        name = name,
        identifier = data['identifier'] or data['citizenid'],
        type = data['type'] or "image",
        content = data['content'] or data['image'],
        created = data['created_at'] or data['date']
    }
    return info
end

function updateFileName(data, serial)
    local column = "identifier"
    if Config.UsingPhone == "qb-phone" then
        column = "citizenid"
        return MySQL.update.await('UPDATE phone_gallery SET label = ? WHERE `'..column..'` = ? AND `image` = ?', {
            data['name'], serial, data['content']
        })
    end
    return MySQL.update.await('UPDATE phone_gallery SET label = ? WHERE id = ? AND `'..column..'` = ?', {
        name, id, serial
    })
end

function saveFile(table, toDevice, file)
    if table == "av_files" or Config.UsingPhone == "qs-smartphone-pro" then
        local exists = MySQL.query.await('SELECT * FROM `'..table..'` WHERE `identifier` = ? AND `content` = ? AND `label` = ?', {
            toDevice, file['content'], file['name']
        })
        if exists and next(exists) then return false end
        return MySQL.insert.await('INSERT INTO '..table..' (identifier, label, type, content, created_at) VALUES (?, ?, ?, ?, FROM_UNIXTIME(?/1000))', {
            toDevice, file['name'], file['type'], file['content'], tonumber(file['created'])
        })
    else
        local exists = MySQL.query.await('SELECT * FROM `'..table..'` WHERE `citizenid` = ? AND image = ?', {
            toDevice, file['content']
        })
        if exists and next(exists) then return false end
        return MySQL.insert.await('INSERT INTO `'..table..'` (citizenid, image, date, label) VALUES (?, ?, FROM_UNIXTIME(?/1000), ?)', {
            toDevice, file['content'], tonumber(file['created']), file['name']
        })
    end
    return false
end

function deleteFile(table, file)
    if table == "av_files" or Config.UsingPhone == "qs-smartphone-pro" then
        return MySQL.query.await('DELETE FROM '..table..' WHERE id = ? AND identifier = ? AND type = ?', {
            file['id'], file['identifier'], file['type']
        })
    else
        return MySQL.query.await('DELETE FROM '..table..' WHERE `citizenid` = ? AND `image` = ?', {
            file['identifier'], file['content']
        })
    end
end