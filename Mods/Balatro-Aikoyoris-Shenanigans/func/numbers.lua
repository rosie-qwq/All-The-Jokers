local DIGITS_WORDS = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
local TEENS_WORDS = {"", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"}
local TENTHS_WORDS = {"", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"}
local TEN_POWERS = {"", "thousand", "million", "billion", "trillion", "quadrillion", "quintillion", "sextillion", "septillion", "octillion", "nonillion", "decillion", "undecillion", "duodecillion", "tredecillion", "quattuordecillion", "quindecillion", "sexdecillion", "septendecillion", "octodecillion", "novemdecillion", "vigintillion"}
local TUPLE_WORDS = {"Single", "Double", "Triple", "Quadruple", "Quintuple", "Sextuple", "Septuple", "Octuple", "Nonuple", "Decuple"}

local THAI_ENGLISH_DIGITS_WORDS = {"ซีโร่", "วัน", "ทู", "ทรี", "โฟว์", "ไฟว์", "สิกซ์", "เซเวน", "เอท", "ไนน์"}
local THAI_ENGLISH_TEENS_WORDS = {"", "เอเลเวน", "ทเวลฟ์", "เธิร์ทีน", "ฟอร์ทีน", "ไฟฟ์ทีน", "ซิกส์ทีน", "เซเวนทีน", "เอทีน", "ไนน์ทีน"}
local THAI_ENGLISH_TENTHS_WORDS = {"", "เทน", "ทเวนตี", "เธิร์ตี", "ฟอร์ตี", "ไฟฟ์ตี", "ซิกส์ตี", "เซเวนตี", "เอตี", "ไนน์ตี"}
local THAI_ENGLISH_TEN_POWERS = {"", "เธาซันด์", "มิลเลียน", "บิลเลียน", "ไตรลียน", "ควอดริลียน", "ควินติลียน", "เซกซ์ติลียน", "เซปติลียน", "ออกติลียน", "นอนิลียน", "เดคิลียน", "อันดิคิลียน", "ดูโอเดคิลียน", "เทริดิคิลียน", "ควัตตูออเดคิลียน", "ควินดิคิลียน", "เซกซิลีออดคิลียน", "เซปเตนดิคิลียน", "ออกโตดิคิลียน", "นอเวมดิคิลียน", "วิกิลีออดคิลียน"}
local THAI_ENGLISH_TUPLE_WORDS = {"ซิงเกิ้ล", "ดับเบิ้ล", "ทริเพิ้ล", "ควอดรูเพิ้ล", "ควินทูเพิ้ล", "เซกซ์ทูเพิ้ล", "เซปทูเพิ้ล", "ออกทูเพิ้ล", "นอนูเพิ้ล", "เดคูเพิ้ล"}

local THAI_DIGITS_WORDS = {"ศูนย์", "หนึ่ง", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า"}
local THAI_UNIT_WORDS = {"เอ็ด", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า"}
local THAI_TENTHS_WORDS = {"", "สิบ", "ยี่สิบ", "สามสิบ", "สี่สิบ", "ห้าสิบ", "หกสิบ", "เจ็ดสิบ", "แปดสิบ", "เก้าสิบ"}
local THAI_TEN_POWERS = {"", "พัน", "ล้าน", "พันล้าน", "ล้านล้าน", "พันล้านล้าน", "ล้านล้านล้าน", "พันล้านล้านล้าน", "ล้านล้านล้านล้าน", "พันล้านล้านล้านล้าน", "ล้านล้านล้านล้านล้าน", "พันล้านล้านล้านล้านล้าน", "ล้านล้านล้านล้านล้านล้าน", "พันล้านล้านล้านล้านล้านล้าน", "ล้านล้านล้านล้านล้านล้านล้าน", "พันล้านล้านล้านล้านล้านล้านล้าน", "ล้านล้านล้านล้านล้านล้านล้านล้าน", "พันล้านล้านล้านล้านล้านล้านล้านล้าน", "ล้านล้านล้านล้านล้านล้านล้านล้านล้าน", "พันล้านล้านล้านล้านล้านล้านล้านล้านล้าน"}
local THAI_TUPLE_WORDS = {"เดี่ยว", "คู่", "ตอง", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า", "สิบ"}
-- got this from twitter lol
local THAI_HONORARY_TUPLE_WORDS = {"สูญญ", "เอก", "ทวิ", "ตรี", "จตุ", "เบญจ", "ฉะ", "อัฎฐะ", "อตุ", "นพ", "ทศ","เอกาทศ","ทวาทศ","เตรส","จุททท","ปัณณรส","โสฬส","สตรส","อัฏฐารส","เอกูนวีสติ","วีสะ",}

function aiko_ThEnTupleWord(i, single)
    if i == 1 and not single then
        return ""
    end
    if i > 10 then
        return THAI_ENGLISH_TUPLE_WORDS[i]
    elseif i > 0 then
        return THAI_ENGLISH_TUPLE_WORDS[i]
    else
        return "???"
    end
end

function aiko_ThEnNumberToWords(n)
    if n < 10 then
        return (THAI_ENGLISH_DIGITS_WORDS[n + 1])
    elseif n == 10 then
        return (THAI_ENGLISH_TENTHS_WORDS[2])
    elseif n < 20 then
        return (THAI_ENGLISH_TEENS_WORDS[n - 10 + 1])
    elseif n < 100 then
        local tens = math.floor(n / 10)
        local units = n % 10
        if units == 0 then
            return (THAI_ENGLISH_TENTHS_WORDS[tens + 1])
        else
            return (THAI_ENGLISH_TENTHS_WORDS[tens + 1]) .. "-" .. (THAI_ENGLISH_DIGITS_WORDS[units + 1])
        end
    elseif n < 1000 then
        local hundreds = math.floor(n / 100)
        local rest = n % 100
        if rest == 0 then
            return (THAI_ENGLISH_DIGITS_WORDS[hundreds + 1]) .. " ฮันเดรด"
        else
            return (THAI_ENGLISH_DIGITS_WORDS[hundreds + 1]) .. " ฮันเดรด แอนด์ " .. aiko_ThEnNumberToWords(rest)
        end
    else
        local words = {}
        local power = math.floor(math.log(n, 1000))
        for i = power, 0, -1 do
            local part = math.floor(n / (1000 ^ i))
            if part > 0 then
                table.insert(words, (aiko_ThEnNumberToWords(part)) .. " " .. (THAI_ENGLISH_TEN_POWERS[i + 1]))
                n = n % (1000 ^ i)
            end
        end
        return table.concat(words, " ")

    end
end

function aiko_getThaiTupleWord(i, single)
    if i == 1 and not single then
        return ""
    end
    if i > 10 then
        return THAI_TUPLE_WORDS[i]
    elseif i > 0 then
        return THAI_TUPLE_WORDS[i]
    else
        return "???"
    end
end

function aiko_getThaiNumberToWords(n)
    if n < 10 then
        return (THAI_DIGITS_WORDS[n + 1])
    elseif n == 10 then
        return (THAI_TENTHS_WORDS[2])
    elseif n < 20 then
        return (THAI_TENTHS_WORDS[2] .. THAI_UNIT_WORDS[n - 10])
    elseif n < 100 then
        local tens = math.floor(n / 10)
        local units = n % 10
        if units == 0 then
            return (THAI_TENTHS_WORDS[tens + 1])
        else
            return (THAI_TENTHS_WORDS[tens + 1]) .. aiko_getThaiNumberToWords(THAI_UNIT_WORDS[units + 1])
        end
    elseif n < 1000 then
        local hundreds = math.floor(n / 100)
        local rest = n % 100
        if rest == 0 then
            return (THAI_DIGITS_WORDS[hundreds + 1]) .. "ร้อย"
        else
            return (THAI_DIGITS_WORDS[hundreds + 1]) .. "ร้อย" .. aiko_getThaiNumberToWords(rest)
        end
    else
        local words = {}
        local power = math.floor(math.log(n, 1000))
        for i = power, 0, -1 do
            local part = math.floor(n / (1000 ^ i))
            if part > 0 then
                table.insert(words, (aiko_getThaiNumberToWords(part)) .. (math.fmod(power,2)==0 and "ล้าน" or "ฟัน"))
                n = n % (1000 ^ i)
            end
        end
        return table.concat(words, " ")
    end
end

local function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function getTupleWord(i, single)
    if i == 1 and not single then
        return ""
    end
    if i > 10 then
        return i.."-ple"
    elseif i > 0 then
        return TUPLE_WORDS[i]
    else
        return "???"
    end
end


function aiko_numberToWords(n)
    if n < 10 then
        return capitalize(DIGITS_WORDS[n + 1])
    elseif n == 10 then
        return capitalize(TENTHS_WORDS[2])
    elseif n < 20 then
        return capitalize(TEENS_WORDS[n - 10 + 1])
    elseif n < 100 then
        local tens = math.floor(n / 10)
        local units = n % 10
        if units == 0 then
            return capitalize(TENTHS_WORDS[tens + 1])
        else
            return capitalize(TENTHS_WORDS[tens + 1]) .. "-" .. capitalize(DIGITS_WORDS[units + 1])
        end
    elseif n < 1000 then
        local hundreds = math.floor(n / 100)
        local rest = n % 100
        if rest == 0 then
            return capitalize(DIGITS_WORDS[hundreds + 1]) .. " Hundred"
        else
            return capitalize(DIGITS_WORDS[hundreds + 1]) .. " Hundred And " .. aiko_numberToWords(rest)
        end
    else
        local words = {}
        local power = math.floor(math.log(n, 1000))
        for i = power, 0, -1 do
            local part = math.floor(n / (1000 ^ i))
            if part > 0 then
                table.insert(words, capitalize(aiko_numberToWords(part)) .. " " .. capitalize(TEN_POWERS[i + 1]))
                n = n % (1000 ^ i)
            end
        end
        return table.concat(words, " ")

    end
end