TwitterMap2014
==============

Columbia COMSE6998 assignment 1. 
Author: Yijun Wang, Wei Dai

Description
==============
This application is based on AWS elasticbean stalk and Dynamo database. It can show twitter stream on a map according to the twitters' location. Users can select the keywords and click on the marker to see the content of the twitter. Also support a heatmap layer, which will show the density of the twitters in any area on the map. In the repo are two seperate projects: TwitterMap and TwitterScrape. TwitterScrape is for using twitter API to get twitters and save it into DynamoDB. TwitterMap is for using google map api to show the result in the user's browser.

How to run the software
=======================

The App contains two parts, the first part is collecting Tweets. It's in the Twitter Scrape/twitterMap folder, it's just plain normal JAVA program, you need Twitter4j and AWS lib to use it. The second part is the server part, which is in the TwitterMap folder, you should import this part, and deploy it on the Elastic Beanstalk using Eclipse. It uses Google Map Javascript API and  Apache commons-lang-3-3.3.2 library.
