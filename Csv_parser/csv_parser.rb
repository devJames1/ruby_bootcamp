##
## my_csv_parser -- Function will takes two arguments, the content of
## a CSV as a string and a separator. Function will return an
## arrays (lines) of arrays (columns).
##
## @param {string} csv_content
## @param {string} separator
##
## @return {string[]}


def my_csv_parser(csv_content, separator)
    result = []


    for line in csv_content.split("\n")
        row = line.split(separator)
        result.push(row)
    end


    return result
end


# p(my_csv_parser("a,b,c,e\n1,2,3,4\n", ","))
