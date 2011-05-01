MacGameExample
==============

This Xcode project showcases an example of using the capture data to create a game. It uses the UDP feature of OpenGazer and listens on port 20320 for the coordinates of the points that it detects.

Dependencies
------------

This project makes use of AsyncUdpSocket from the [CocoaAsynSocket Propject](http://code.google.com/p/cocoaasyncsocket/). Their code is released under public domain and is compatibly with the GNU GPL license of OpenGazer.

Running
-------

Start opengazerHighGui first. Make sure to calibrate. Once it starts sending its project points over UDP you should be able to see the data streaming in the Log Viewer of this application.