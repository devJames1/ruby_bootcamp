##
## my_data_transform -- It will take a string which contains data
## in CSV format and it will return a string in CSV format with
## the column Email, Age and Order At transformed.
##
## @param {string} csv_content
##
## @return {string[]}
##


require 'date'


def transform_time_range(time)


    date_obj = DateTime.parse(time, '%Y-%m-%d %H:%M:%S')


    if(date_obj.hour < 12)
        return "morning"
    elsif(date_obj.hour < 18)
        return "afternoon"
    else
        return "evening"
    end


end




def transform_age(age)


    if (age < 21)
        return "1->20"
    elsif(age < 41)
        return "21->40"
    elsif(age < 66)
        return "41->65"
    else
        return "66->99"
    end


end
 


def transform_email(email)
    return email.split("@")[1]
end




def my_data_transform(csv_content)
    result = []
    line_nbr = 0


    for line in csv_content.split("\n")
        values = line.split(",")


        # skip first row/line
        if (line_nbr > 0)
            values[4] = transform_email(values[4])
            values[5] = transform_age(values[5].to_i)
            values[9] = transform_time_range(values[9])
        end


        line_nbr += 1
        result.push(values.join(","))
    end


    return result
end




# p (my_data_transform("Gender,FirstName,LastName,UserName,Email,Age,City,Device,Coffee Quantity,Order At\nMale,Carl,Wilderman,carl,wilderman_carl@yahoo.com,29,Seattle,Safari iPhone,2,2020-03-06 16:37:56\nMale,Marvin,Lind,marvin,marvin_lind@hotmail.com,77,Detroit,Chrome Android,2,2020-03-02 13:55:51\nFemale,Shanelle,Marquardt,shanelle,marquardt.shanelle@hotmail.com,21,Las Vegas,Chrome,1,2020-03-05 17:53:05\nFemale,Lavonne,Romaguera,lavonne,romaguera.lavonne@yahoo.com,81,Seattle,Chrome,2,2020-03-04 10:33:53\nMale,Derick,McLaughlin,derick,mclaughlin.derick@hotmail.com,47,Chicago,Chrome Android,1,2020-03-05 15:19:48\n"))
