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

The goal of this project is to create a lightweight package which supports the aspects of XSD required for use in non-XML technologies like RDF.
As much of the XSD specification has been implemented as was feasible.
However, aspects of the XSD specification which depend on XML processing behaviours have *not* been implemented.

The following aspects of XSD are not fully supported:

 +  The following datatypes:

 +  The following properties:

     +  __`annotations`.__

        Requires XML support, which is beyond the scope of this
          project.

        All datatypes have an `annotations` property of type
          `[XSDAnnotation]` and value `[]`.
        This property cannot be changed.
        The type `XSDAnnotation` is a typealias for `Any`.

     +  __`context`.__

        It is not possible to create anonymous XSD types with this
          package.
        Every type is required to have a `name`.

        All simple datatypes have a `context` property, but its value
          is always `nil`.

 +  The following facets:

     +  __`Assertions`.__

        Requires XML and XPath support, which is beyond the scope of
          this project.

        You can create `Assertions` facets, but their `value` will
          always have a type of `[XSDAssertion]` and a value of `[]`.
        The type `XSDAssertion` is a typealias for `Any`.

##  License  ##

Copyright ©2018 Gô Shoemake.
<cite>Nib</cite> is made available under the terms of the GNU GPL license, either version 3 or (at your option) any later version.
For more information, see [COPYING](COPYING).
