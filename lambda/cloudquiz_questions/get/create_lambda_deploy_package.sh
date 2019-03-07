#!/bin/sh
#Sets up a deplyoment file for AWS lambda
#This will use pip to add python modules to the same directory as the code.
#And then zip it up as deployment pacakge
#This can be added to your lambda function definition

if [ ! -d $PWD/build ]; then
  mkdir -p $PWD/build;
fi

sudo rm -rf $PWD/build/*

#Create Lambda Zip File
sudo cp -R *.py build/
cd $PWD/build
zip -r main.zip *

aws lambda --region=eu-west-2 update-function-code --function-name cloudquiz_questions --zip-file fileb://main.zip
