"""
testAdditional.py
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib
        
class TestAddUser(testLib.RestTestCase):
    
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 1)

    """Test logging in users"""
    def testLogin(self):
        add = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user2', 'password' : 'password2'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user2', 'password' : 'password2'} )
        self.assertResponse(respData, count = 2)

    """Test username length minimum"""
    def testUsernameShort(self):

    """Test username length maximum"""
    def testUsernameLong(self):

    """Test password length"""
    def testPassword(self):

    """Test uniqueness of login"""
    def testExistence(self):


    """Test count of user logins"""
    def testCount(self):