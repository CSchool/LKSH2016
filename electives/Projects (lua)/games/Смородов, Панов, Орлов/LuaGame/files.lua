--[[
io.open открывает файл с выбранным режимом:
    1) "r" - режим только чтения
    2) "w" - режим записи. Если файла не существует, то он создается; если существует, то очищается
    3) "a" - режим записи. Если файла не существует, то он создается; если существует, то запись идет в конец файла

file:read() -- чтение строки
file:write() -- запись строки
file:close() -- закрыть файл (только после закрытия файла произойдет запись данных в него!)

--]]
 
-- пример чтения всего файла

-- 1

local count = 1
file = io.open("main.lua", "r")
while true do
    local line = file:read()
    if line == nil then break end
    print(string.format("%6d  ", count), line, "\n")
    count = count + 1
end

-- 2
file = io.open("main.lua", "r")
t = file:read("*all")
print(t)

-- 3

for line in io.lines("main.lua") do
    print(line)
end


-- Пример записи строки в конце файла
-- Открываем файл test.lua в режиме дополнения строк
file = io.open("test.lua", "a")

-- Дополняем конец файла строчкой с переводом строки ("\n")
file:write("--test\n")

-- Закрываем файл
file:close()
