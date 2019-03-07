import unittest
from main import lambda_handler

class test_main_lambda_handler(unittest.TestCase):
    """Tests for main.py"""

    def test_return_questions(self):
        """Do we recieve json response. We want one please"""
        event = {}
        event["queryStringParameters"] = {}
        context = {}
        response = lambda_handler(event, context)

        self.assertTrue( "application/json" in response["headers"]["Content-Type"] )

    def test_return_questions_category(self):
        """When we supply a category will we get questions returned in said category"""
        event = {}
        event["queryStringParameters"] = {"category":"dynamodb"}
        context = {}
        response = lambda_handler(event, context)

        self.assertTrue( "dynamodb" in response["body"] )

    def test_return_questions_no_category(self):
        """When we do not supply a category will want to recieve a warning"""
        event = {}
        event["queryStringParameters"] = {}
        context = {}
        response = lambda_handler(event, context)
        print (response)
        self.assertTrue( "No Category Supplied" in response["body"] )

if __name__ == '__main__':
    unittest.main()
