-- функция разделения строки по заданному шаблону
function string:split(delimiter)
    local result = { }
    local from = 1
    local delim_from, delim_to = string.find( self, delimiter, from )
    
    while delim_from do
        table.insert( result, string.sub( self, from , delim_from-1 ) )
        from = delim_to + 1
        delim_from, delim_to = string.find( self, delimiter, from )
    end
  
    table.insert( result, string.sub( self, from ) )
    return result
end

-- этот цикл будет передавать из файла "main.lua" каждую строчку в переменную line
for line in io.lines("main.lua") do
    -- line:split(" ") разбивает строку (т.е. ищет подпоследовательности строки, которые оканчиваются выбранным символом) 
    -- и переносит их в таблицу
    for k,v in pairs(line:split(" ")) do
        print(k .. " " .. " " .. v)
    end
end