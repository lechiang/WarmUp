#Unit Tests
require 'test/unit'
require 'users'
require 'userscontroller'
class TestAdd < Test::Unit::TestCase
	def test_add
		assert_equal 1, Users.add('John', 'Smith')
		assert_equal 1, Users.login('John', 'Smith')
		assert_equal 2, Users.count('John')
		assert_equal -1, Users.login('John', 'Smit')
		assert_equal 2, Users.count('John')
	end

	def test_password
		assert_equal 1, Users.add('Lesley', '')
		assert_equal 1, Users.add('Beverley', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')
		assert_equal 1, Users.count('Lesley')
	end

	def test_password_long
		assert_equal -4, Users.add('Lesley', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')
	end

	def test_username
		assert_equal -3, User.add('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', "password")
		assert_equal 1, User.add('username', 'password')
	end

	def test_empty_username
		assert_equal -3, User.add('', 'password')
		assert_equal -3, Users.add('', '')
	end

	def test_credentials
		assert_equal 1, Users.add('test', 'pwd')
		assert_equal -1, Users.login('test', '')
	end

	def test_exists
		assert_equal 1, Users.add('user', 'password')
		assert_equal -2, Users.add('user', 'Smith')
	end

	def test_count
		assert_equal 1, Users.add('hey', 'hello')
		assert_equal 1, Users.count('hey')
		assert_equal 1, Users.login('hey', 'hello')
		assert_equal 2, Users.count('hey')
	end

	def test_add2
		assert_equal 1, Users.add('user1', 'pwd1')
		assert_equal 1, Users.add('user2', 'pwd2')
	end

	def test_count2
		assert_equal 1, Users.add('login', 'password')
		assert_equal 1, Users.count('login')
		assert_equal -2, Users.add('login', 'password')
		assert_equal 1, Users.count('login')
end

