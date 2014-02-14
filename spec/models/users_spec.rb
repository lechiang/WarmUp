require 'spec_helper'

describe Users do
  it "adds user" do
   	expect(Users.add('John', 'Smith')).to eq(Users::SUCCESS)
  end

  it "login user" do
  	user = Users.add('John', 'Smith')
  	expect(Users.login('John', 'Smith')).to eq(Users::SUCCESS)
  end

  it "password is too long" do
  	expect(Users.add('Lesley', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')).to eq(Users::ERR_BAD_PASSWORD)
  end

  it "add user with empty password" do
   	expect(Users.add('user', '')).to eq(Users::SUCCESS)
  end

  it "username is empty" do
  	expect(Users.add('', 'password')).to eq(Users::ERR_BAD_USERNAME)
  end

  it "username is too long" do
  	expect(Users.add('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', "password")).to eq(Users::ERR_BAD_USERNAME)
  end

  it "user already exists" do
  	user = Users.add('user1', 'pwd1')
  	expect(Users.add('user1', 'pwd1')).to eq(Users::ERR_USER_EXISTS)
  end

  it "bad credentials" do
  	user = Users.add('user2', 'pwd2')
  	expect(Users.login('user2', 'pw2')).to eq(Users::ERR_BAD_CREDENTIALS)
  end

  it "correct count number" do
  	user = Users.add('user3', 'pwd3')
  	expect(Users.count('user3')).to eq(1)
  end

  it "correct count 2" do
  	user = Users.add('user3', 'pwd3')
  	user1 = Users.add('user3', 'pwd3')
  	user2 = Users.login('user3', 'pwd3')
  	expect(Users.count('user3')).to eq(2)
  end
end


