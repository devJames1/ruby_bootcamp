# import file my_data_transform.rb into this file
# give access to use my_data_transform function


require_relative "my_data_transform"


# csv_trans_content = my_data_transform("Gender,FirstName,LastName,UserName,Email,Age,City,Device,Coffee Quantity,Order At\nMale,Carl,Wilderman,carl,wilderman_carl@yahoo.com,29,Seattle,Safari iPhone,2,2020-03-06 16:37:56\nMale,Marvin,Lind,marvin,marvin_lind@hotmail.com,77,Detroit,Chrome Android,2,2020-03-02 13:55:51\nFemale,Shanelle,Marquardt,shanelle,marquardt.shanelle@hotmail.com,21,Las Vegas,Chrome,1,2020-03-05 17:53:05\nFemale,Lavonne,Romaguera,lavonne,romaguera.lavonne@yahoo.com,81,Seattle,Chrome,2,2020-03-04 10:33:53\nMale,Derick,McLaughlin,derick,mclaughlin.derick@hotmail.com,47,Chicago,Chrome Android,1,2020-03-05 15:19:48\n")




##
## my_data_process -- take a string array which is
## the output of your function my_data_transform,
## it will return a json string of hash of hash
##
## @param {string[]} csv_trans_content
##
## @return {string}
##


def my_data_process(csv_trans_content)


    result = Hash.new


    gender_hash = Hash.new
    email_hash = Hash.new
    age_hash = Hash.new
    city_hash = Hash.new
    device_hash = Hash.new
    order_hash = Hash.new


    result["Gender"] = gender_hash
    result["Email"] = email_hash
    result["Age"] = age_hash
    result["City"] = city_hash
    result["Device"] = device_hash
    result["Order At"] = order_hash


    for line in csv_trans_content[1..-1]
        values = line.split(',')


        add_value_to_hash(gender_hash, values[0])
        add_value_to_hash(email_hash, values[4])
        add_value_to_hash(age_hash, values[5])
        add_value_to_hash(city_hash, values[6])
        add_value_to_hash(device_hash, values[7])
        add_value_to_hash(order_hash, values[9])
       
    end


    return result.to_s.gsub(", ", ",").gsub("=>",":").gsub("'", '"')


end




##
## add_value_to_hash -- function creates or updates a key
## value in a given hash


##
## @param {(string : integer){}} hash
## @param {string} vale
##


def add_value_to_hash(hash, value)


    if hash.has_key?(value)
        hash[value] += 1
    else
        hash[value] = 1  
    end


end


# my_data_process(csv_trans_content)
