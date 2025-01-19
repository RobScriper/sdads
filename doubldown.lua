local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("dkjson") -- Убедитесь, что у вас установлена эта библиотека для работы с JSON.

-- URL вашего вебхука Discord
local webhookURL = "https://discord.com/api/webhooks/1330467876829794355/7MScs2cJO59fyTLofXCHVS_8j6Fg8dKfkzri428_0jb80_3qqdLHUGNUTbhSPBfU_YVn"

-- Создаём данные для отправки
local data = {
    username = "Lua Bot", -- Имя отправителя
    content = "Привет! Это сообщение отправлено через Lua." -- Сообщение
}

-- Преобразуем таблицу в JSON
local jsonData, err = json.encode(data)
if err then
    print("Ошибка кодирования JSON: " .. err)
    return
end

-- Настраиваем HTTP-запрос
local response = {}
local res, code, headers = http.request {
    url = webhookURL,
    method = "POST",
    headers = {
        ["Content-Type"] = "application/json",
        ["Content-Length"] = tostring(#jsonData),
    },
    source = ltn12.source.string(jsonData),
    sink = ltn12.sink.table(response),
}

-- Выводим результат
if code == 200 then
    print("Сообщение успешно отправлено!")
else
    print("Ошибка отправки: " .. tostring(code))
end
