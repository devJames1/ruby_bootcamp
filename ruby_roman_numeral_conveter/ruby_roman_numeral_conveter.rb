##
## my_roman_numerals_converter -  function converts from normal
## numbers to Roman Numerals.
##
## @param {Integer} norm_num
##
## @return {string}
##


def my_roman_numerals_converter(norm_num)


    roman_num = {1 => 'I', 2 => 'II', 3 => 'III', 4 => 'IV', 5 => 'V', 6 => 'VI', 7 => 'VII', 8 => 'VIII', 9 => 'IX', 10 => 'X', 20 => 'XX', 30 => 'XXX', 40 => 'XL', 50 => 'L', 60 => 'LX', 70 => 'LXX', 80 => 'LXXX', 90 => 'XC', 100 => 'C', 200 => 'CC', 300 => 'CCC', 400 => 'CD', 500 => 'D', 600 => 'DC', 700 => 'DCC', 800 => 'DCCC', 900 => 'CM', 1000 => 'M', 2000 => 'MM', 3000 => 'MMM'}


    string = []
    arr_thou_hun_tens_unit = my_thous_hun_tens_unit(norm_num)


    for num in arr_thou_hun_tens_unit
        string.push(roman_num[num])
    end


    return string.join("")


end




##
## my_thous_hun_tens_unit -- Functions takes a number and returns an
## integer array with the Thousands, hundreds, tens and unit,
## starting from the highest.
##
## @param {integer} number
##
## @return {integer[]}
##

def my_thous_hun_tens_unit(number)
   
    result = []
    length = number.digits.length


    if length == 4


        result.push((number / 1000) * 1000)
        hun_remainder = number % 1000
        result.push((hun_remainder / 100) * 100)
        ten_remainder = hun_remainder % 100
        result.push((ten_remainder / 10) * 10)
        unit_remainder = ten_remainder % 10
        result.push(unit_remainder)


    elsif length == 3


        result.push((number / 100) * 100)
        ten_remainder = number % 100
        result.push((ten_remainder / 10) * 10)
        unit_remainder = ten_remainder % 10
        result.push(unit_remainder)


    elsif length == 2


        result.push((number / 10) * 10)
        unit_remainder = number % 10
        result.push(unit_remainder)


    elsif length == 1


        result.push(number)


    end
    return result
end


# p(my_roman_numerals_converter(79))
