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

    def testUserExists(self):
        user = self.makeRequest("/users/create", method="POST", data = {'user':'user1', 'password':'pwd1'})
        respData = self.makeRequest("/users/create", method="POST", data = {'user':'user2', 'password':'pwd1'})
        self.assertEquals(respData['errCode'], testLib.RestTestCase.ERR_USER_EXISTS)

    def testBadUsername(self):
        respData = self.makeRequest("/users/create", method="POST", data={'user':'','password':''})
        self.assertEquals(respData['errCode'], testLib.RestTestCase.ERR_BAD_USERNAME)

    def testBadPassword(self):
        respData = self.makeRequest("/users/create", method="POST", data={'user':'user2', 'password':'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'})
        self.assertEquals(respData['errCode'], testLib.RestTestCase.ERR_BAD_PASSWORD)

    def testLogin(self):
        user = self.makeRequest("/users/create", method="POST", data = {'user':'user3', 'password':'pwd3'})
        respData = self.makeRequest("/users/login", method="POST", data = {'user':'user3', 'password':'pwd3'})
        self.assertEquals(respData['errCode'], testLib.RestTestCase.SUCCESS)

    def testBadCredentials(self):
        user = self.makeRequest("/users/create", method="POST", data = {'user':'user4', 'password':'pwd4'})
        respData = self.makeRequest("/users/login", method="POST", data = {'user':'user4', 'password':'pwd5'})
        self.assertEquals(respData['errCode'], testLib.RestTestCase.ERR_BAD_CREDENTIALS)

    def testReset(self):
        user = self.makeRequest("/users/create", method="POST", data = {'user':'user5', 'password':'pwd5'})
        self.makeRequest('/TESTAPI/resetFixture', method="POST", data = {})
        respData = self.makeRequest("/users/create", method="POST", data = {'user':'user5', 'password':'pwd5'})
        self.assertEquals(1, respData['errCode'])