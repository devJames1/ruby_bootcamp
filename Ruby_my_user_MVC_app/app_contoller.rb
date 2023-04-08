##
## GET on /users. This action will return all users
## (without their passwords).
##
## POST on /users. Receiving firstname, lastname, age,
## password and email. It will create a user and store
## in your database and returns the user created (without
## password).
##
## POST on /sign_in. Receiving email and password. It
## will add a session containing the user_id in order
## to be logged in and returns the user created (without
## password).
##
## PUT on /users. This action require a user to be logged
## in. It will receive a new password and will update it.
## It returns the user created (without password).
##
## DELETE on /sign_out. This action require a user to be
## logged in. It will sign_out the current user. It returns
## nothing (code 204 in HTTP).
##
## DELETE on /users. This action require a user to be
## logged in. It will sign_out the current user and it
## will destroy the current user. It returns nothing
## (code 204 in HTTP).
##
## GET on /. This action will render the template in
## index.html
##




require "sinatra"
require_relative './my_user_model'
require 'json'


set('views', './views')
set :port, 8080
set :bind, '0.0.0.0'


enable :sessions




get '/users' do
    content_type :json
    all_hash = User.all
    all_hash.select do |row|
        row.delete(:password)
    end
    all_hash.to_json
end


post "/users" do
    usr_id = User.create(params)
    puts "Created successfully"
    usr_hash = User.find(usr_id)
    usr_hash.delete(:password)
    usr_hash.to_json
end


post '/sign_in' do
    curr_user = User.check_pass_email(params['email'], params['password'])
    if curr_user
        session[:user_id] = curr_user[:id]


        curr_user.delete(:password)
        curr_user.to_json
        puts "sign In Successfull"
    else
        puts "Incorrect email/password"
    end
end


put '/users' do
    params['password']
    if session[:user_id]
        curr_user_updated = User.update(session[:user_id], :password, params['password'])
        curr_user_updated.delete(:password)
        curr_user_updated.to_json
    else
        puts "Unauthorized"
    end
end


delete '/sign_out' do
   
    session.clear
    puts 'sign out succesfull'
    status 204
end


delete '/users' do
    if session[:user_id]
        curr_user = User.find(session[:user_id])
        if curr_user
            User.destroy(session[:user_id])
            session.clear
            puts "User deleted succesfully"
            status 204
        end
    end
end


get '/' do
    erb :index
end
