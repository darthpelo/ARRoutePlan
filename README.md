ARRoutePlan
===========

Simple excercise to test:
* autocomplete search (with GoEuro)
* calendar picker

UI ispiration by Kayak app.
At the moment this app supports **only iOS 7**, but I'm not use iOS 7 only methods or frameworks,
so porting to iOS 6 is very simple .

The API endpoint returns JSON documents like these if you search string is "post":
```json
{

 "results" : [ {

 "_type" : "Position",

 "_id" : 410978,

 "name" : "Potsdam, USA",

 "type" : "location",

 "geo_position" : {

 "latitude" : 44.66978,

 "longitude" : -74.98131

 }

 }, {

 "_type" : "Position",

 "_id" : 377078,

 "name" : "Potsdam, Deutschland",

 "type" : "location",

 "geo_position" : {

 "latitude" : 52.39886,

 "longitude" : 13.06566

 }

 } ]

}
```
