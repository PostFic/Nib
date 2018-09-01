#  Nib

A Swift implementation of [<cite>XML Schema: Datatypes</cite>](https://www.w3.org/TR/xmlschema11-2/).
Intended for use with RDF tools and libraries, but conceivably could be utilized elsewhere.

| XSD version | Package version | Swift version |
| :---------: | :-------------: | :-----------: |
|     1.1     | _Not released._ |      4.2      |

##  About/Usage  ##

Please see the [Docs](Docs/) directory for general and usage information.

##  Requirements  ##

Requires Foundation; in particular, the following classes:

+ `Data`
+ `Decimal`
+ `NSDecimalNumber`
+ `NSRegularExpression`
+ `NumberFormatter`

[`swift-corelibs-foundation`](https://github.com/apple/swift-corelibs-foundation) should provide sufficient compatibility for non-Apple platforms.

##  Limitations  ##

The following aspects of XSD are not fully supported:

+ The following datatypes:
+ The following properties:
    + `annotations`
    + `context`
+ The following facets:
    + `Assertions`

##  License  ##

Copyright ©2018 Gô Shoemake.
<cite>Nib</cite> is made available under the terms of the GNU GPL license, either version 3 or (at your option) any later version.
For more information, see [COPYING](COPYING).
