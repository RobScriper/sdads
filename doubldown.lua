local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("dkjson") -- Для кодирования JSON

-- Ваш вебхук Discord
local webhookURL = "https://discord.com/api/webhooks/1330467876829794355/7MScs2cJO59fyTLofXCHVS_8j6Fg8dKfkzri428_0jb80_3qqdLHUGNUTbhSPBfU_YVn"

-- Сообщение для отправки
local data = {
    username = "Lua Bot", -- Имя отправителя
    content = "Привет! Это тестовое сообщение через Lua." -- Основное сообщение
}

-- Преобразуем таблицу в JSON
local jsonData, err = json.encode(data)
if not jsonData then
    print("Ошибка при кодировании JSON: " .. err)
    return
end

-- Настраиваем HTTP-запрос
local response = {}
local success, statusCode = pcall(function()
    return http.request{
        url = webhookURL,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#jsonData)
        },
        source = ltn12.source.string(jsonData),
        sink = ltn12.sink.table(response)
    }
end)

-- Проверяем результат
if not success then
    print("Ошибка отправки запроса.")
elseif statusCode == 204 then
    print("Сообщение успешно отправлено!")
else
    print("Ошибка! Код ответа: " .. tostring(statusCode))
    print("Ответ сервера: " .. table.concat(response))
end
