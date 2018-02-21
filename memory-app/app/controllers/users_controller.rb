class UsersController < ApplicationController
  def create
    user = User.new(
        name:params['name'],
        email:params['email'],
        age:params['age'],
        gender:params['gender'],
        password:params['password'],
        password_confirmation:params['password_confirmation']
      )
    if user.save
      render json:{message:"User created succesfully"},status: :created
    else
      render json:{errors:user.errors.full_messages}, status: :bad_request
    end
  end
end
