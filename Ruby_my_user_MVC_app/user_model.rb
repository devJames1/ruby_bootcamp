##
## User -- class that is an interface to some methods that
## transact with a database. create, find, all, update,
## destroy
##
## create -- User class method that will create a user.
## User info will be: firstname, lastname, age, password and
## email
## And it will return a unique ID (a positive integer)
##
## find -- User class method that will retrieve the
## associated user and return all information contained in
## the database.
##
## all -- User class method that will retrieve all users and
## return a hash of users.
##
## update -- User class method that will retrieve the
## associated user, update the attribute sent as parameter
## with the value and return the user hash.
##
## destroy -- It will retrieve the associated user and
## destroy it from your database.
##




require 'sqlite3'




class User
       
    @@db = SQLite3::Database.open "db.sql"
    @@db.execute "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, age INT, password TEXT, email TEXT)"
   
    attr_accessor :id, :firstname, :lastname, :age, :password, :email


    def initialize(user_array)
        @id         = user_array[0]
        @firstname  = user_array[1]
        @lastname   = user_array[2]
        @age        = user_array[3]
        @password   = user_array[4]
        @email      = user_array[5]
    end


    def to_hash
        {id: @id, firstname: @firstname, lastname: @lastname, age: @age, password: @password, email: @email}
    end


    def self.create(user_info)


        @@db.execute "INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)", [user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email]]
   
        last_user_id = @@db.last_insert_row_id


    end


    def self.existsCheck(database, id)


        database.execute("SELECT * FROM users WHERE id=?", [id]).length > 0


    end


    def self.find(user_id)


        if (self.existsCheck(@@db, user_id))
           
            user_info = @@db.get_first_row "SELECT * FROM users WHERE id=?", [user_id]
            User.new(user_info).to_hash
        else
            puts "User not found"
        end  
    end


    def self.all
        all_users = @@db.execute "SELECT * FROM users"


        if all_users.any?
            all_users.collect do |row|
                User.new(row).to_hash
            end
       else
            []
       end
    end


    def self.check_pass_email(email, password)


        User.all.select {|user| user[:email] == email && user[:password] == password}.first


    end


    def self.update(user_id, attribute, value)


        if attribute["'"] || attribute[";"] #prevent dangerous characters
            puts "Dangerous input detected!"
        else


            if (existsCheck(@@db, user_id))
                @@db.execute "UPDATE users SET #{attribute} = ? WHERE id=?", [value, user_id]


                user_updated = self.find(user_id).to_hash
            else
                puts "User not found"
            end


        end


    end


    def self.destroy(user_id)


        if (existsCheck(@@db, user_id))
            @@db.execute "DELETE FROM users WHERE id=?", [user_id]


        else
            puts "User not found"
        end


    end
   
rescue SQLite3::Exception => e


    puts "Exception occured"
    puts e


end




# user_inf = {firstname: "henry", lastname: "Ali", age: 49, password: "hen676", email: "henry@gmail.com"}


# p User.create(user_inf)
