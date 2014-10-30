TwitterMap2014
==============

Columbia COMSE6998 assignment 1. 
Author: Wei Dai, Yijun Wang

Description

This application is based on AWS elasticbean stalk and Dynamo database. It can show twitter stream on a map according to the twitters' location. Users can select the keywords and click on the marker to see the content of the twitter. Also support a heatmap layer, which will show the density of the twitters in any area on the map. In the repo are two seperate projects: TwitterMap and TwitterScrape. TwitterScrape is for using twitter API to get twitters and save it into DynamoDB. TwitterMap is for using google map api to show the result in the user's browser.
