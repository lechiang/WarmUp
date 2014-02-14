class Users < ActiveRecord::Base
	ERR_BAD_CREDENTIALS = -1
	ERR_BAD_PASSWORD = -4
	ERR_BAD_USERNAME = -3
	ERR_USER_EXISTS = -2
	MAX_PASSWORD_LENGTH = 128
	MAX_USERNAME_LENGTH = 128
	SUCCESS = 1

	def self.login(user, password)
		username = self.find_by_user(user)
		#p "*"*90
		#p password
		#p username.password
		if password != username.password
			ERR_BAD_CREDENTIALS
		else
			username.count += 1
			username.save
			SUCCESS
		end
	end

	def self.add(user, password)
		username = self.new(user: user, password: password)
		u = self.find_by_user(user)
		if u != nil && user == u.user
			ERR_USER_EXISTS
		elsif password.length > MAX_PASSWORD_LENGTH
			ERR_BAD_PASSWORD
		elsif (user.length < 1) || (user.length > MAX_USERNAME_LENGTH)
			ERR_BAD_USERNAME
		else
			username.count = 1
			username.save
			SUCCESS
		end
	end

	def self.count(user)
		username = self.find_by_user(user)
		username.count
	end
end
