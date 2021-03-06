class UsersController < ApplicationController
  def view
  	@user = Users.new
		render :form
	end

	def kevin
		p param
	end

	def login
    #input_pwd = params[:user][:password]
    #input_user = params[:user][:user]
    #if params[:login]
    #valid = User.login(input_user, input_pwd)
    input_user = params[:user]
    input_pwd= params[:password]
    valid = Users.login(input_user, input_pwd)

    if valid > 0
    	@user = input_user
      @count = valid
      test = {errCode: 1, count: @count}
      #render :welcome
      render json: test
    else 
    	test = {errCode: valid}
      #render :action => "bad_credentials"
      render json: test
    end
  end

  # POST /users
  # POST /users.json
  def create
    input_user = params[:user]
    input_pwd= params[:password]
    valid = Users.add(input_user, input_pwd)
    
    if valid > 0
      @user = input_user
      @count = valid
      test = {errCode: 1, count: @count}
      #render :welcome, 
      render json: test
    else
      test = {errCode: valid}
      #render :action => "user_exists"
      render json: test
    end
  end

  def resetFixture
  	Users.destroy_all
  	render json: {errCode: 1}
  end

  def unitTests
  	output = `rspec #{Rails.root}/spec/`
  	p '*'*50
  	p output
    example = /(\d+) example/.match(output)[1]
    failures = /(\d+) failures/.match(output)[1]
    render json: {nrFailed: failures.to_i, output: output, totalTests: example.to_i}
  end

end