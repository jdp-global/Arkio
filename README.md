Arkio for Data.com
===========================
Arkio is an Objective-C client library for [Data.com](http://data.com).

<table width="100%" border=0>
	<tr>
		<td width="50%">1. <a href="#features">Features</a></td><td>5. <a href="#quickstart">Quick Start</a></td>
	</tr>
	<tr>
		<td>2. <a href="#overview">Overview</a></td><td>6. <a href="#referencedocs">Reference Documentation</a></td>
	</tr>
	<tr>
		<td>3. <a href="#installation">Installation</a></td><td>7. <a href="#contact">Contact</a></td>
	</tr>
	<tr>
		<td>4. <a href="#configuration">Configuration</a></td><td>8. <a href="#license">License</a></td>
	</tr>

</table>

##<a name="features">Features</a>
- Full implementation of the Data.com Connect API. ([PDF](http://www.data.com/export/sites/data/common/assets/pdf/DS_Datadotcom_Connect_API_Docs.pdf)) 
- XCText unit test suite
- Available via CocoaPods
- Complete AppleDocs with a build to install the docset in Xcode
- Built on top of AFNetworking 2.0

##<a name="overview">Overview</a>
Full implementation of the Data.com Connect API means that you are able to do the following with Arkio:

- Search for Contacts.
- Purchase and download Contacts.
- Retrieve a Company's Contact Count Statistics.
- Retrieve a User's point balance.


##<a name="installation">Installation</a>
In addition to manual Xcode project installation, the Arkio source code is also available via CocoaPods. Bear in mind that you will not get the unit test suite or the ability to install the docset locally, if installing via the CcocoaPods route.  

###Install via CocoaPods 
Simply add the following line to your project's [Podfile](http://docs.cocoapods.org/podfile.html):

```
pod 'Arkio'
```
then, at the command line, from the same directory as your Podfile, run
 
```
pod install
```

###Install via Xcode

##<a name="configuration">Configuration</a>
To interface successfully with the Data.com API you will need a Developer Token/Key. The easiet way to configure Arkio is to add your developer token to you app's Info.plist file as the value for the key **arkio.api.developer.token** as below:

![Token Config](https://raw.github.com/rayascott/Arkio/master/Arkio/arkio-api-developer-token-example.png?token=86224__eyJzY29wZSI6IlJhd0Jsb2I6cmF5YXNjb3R0L0Fya2lvL21hc3Rlci9Bcmtpby9hcmtpby1hcGktZGV2ZWxvcGVyLXRva2VuLWV4YW1wbGUucG5nIiwiZXhwaXJlcyI6MTM4NjkzMjI0NH0%3D--960a8be3343c2413c30d9778003b89f145a15147)  

This allows `ARKSession` instances to pick up the value automatically. Alternately, you can set the token value directly on the session as below:

```
[arkSession setAPIDeveloperToken:@"developertokentext"];
```

##<a name="quickstart">Quick Start</a>
After installation, include the library header file somewhere in your code:

```
#include "Arkio.h"
```
Then, 

##<a name="referencedocs">Reference Documentation</a>

- The [class reference documentation](http://cocoadocs.org/docsets/Arkio/) can be found on Cocoadocs.org.
- Official Data.com Connect API Documentation ([PDF](http://www.data.com/export/sites/data/common/assets/pdf/DS_Datadotcom_Connect_API_Docs.pdf)) from the Data.com [Connect Developer Program](http://www.data.com/data-resources/connect-developer/index.jsp).

##<a name="contact">Contact</a>
Arkio is maintained by [Ray Scott](https://github.com/rayascott) ([@rayascott](http://www.twitter.com/rayascott)).

##<a name="license">License</a>
Arkio is available under the MIT license. For more information, see the included [LICENSE](./LICENSE) file.
