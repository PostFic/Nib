#  Nib: Scope  #

##  Purpose and Intent  ##

Nib is, first and foremost, an implementation of <cite>W3C XML Schema Definition Language (XSD) 1.1 Part 2: Datatypes</cite> [\[SCHEMA11-2]][SCHEMA11-2] into Swift.
The aim of Nib is to create a data model for use with related technologies, like RDF.
However, it goes above‐and‐beyond the basic requirements of RDF processors and attempts to implement XSD as fully as possible.

Although Nib aims to be a *nearly*‐complete XSD datatype engine, it fails to meet the requirements for minimally‐conforming independent implementations set forward in the XSD specification.
This means that Nib is *not* (on its own) suitable for use in an XSD schema processor—some properties and datatypes are missing.
These missing properties and datatypes are those that depend on XML technologies, environments, or advanced processing tools to parse or understand, and which are not suitable for a generalized data framework.
Nothing missing in Nib is needed in RDF.

[SCHEMA11-2]: https://www.w3.org/TR/xmlschema11-2/

##  RDF Types  ##

Nib fully implements the set of RDF types set forth in <cite>RDF 1.1 Concepts and Abstract Syntax</cite> [\[RDF11-CONCEPTS]][RDF11-CONCEPTS]; these are:

+ **Core types:** `xsd:string`, `xsd:boolean`, `xsd:decimal`,
  `xsd:integer`
+ **IEEE floating‐point numbers:** `xsd:double`, `xsd:float`
+ **Time and date:** `xsd:date`, `xsd:time`, `xsd:dateTime`,
  `xsd:dateTimeStamp`
+ **Recurring and partial dates:** `xsd:gYear`, `xsd:gMonth`,
  `xsd:gDay`, `xsd:gYearMonth`, `xsd:gMonthDay`, `xsd:duration`,
  `xsd:yearMonthDuration`, `xsd:dayTimeDuration`
+ **Limited‐range integer numbers:** `xsd:byte`, `xsd:short`,
  `xsd:int`, `xsd:long`, `xsd:unsignedByte`, `xsd:unsignedShort`,
  `xsd:unsignedInt`, `xsd:unsignedLong`, `xsd:positiveInteger`,
  `xsd:nonNegativeInteger`, `xsd:negativeInteger`,
  `xsd:nonPositiveInteger`
+ **Encoded binary data:** `xsd:hexBinary`, `xsd:base64Binary`
+ **Miscellaneous XSD types:** `xsd:anyURI`, `xsd:language`,
  `xsd:normalizedString`, `xsd:token`, `xsd:NMTOKEN`, `xsd:Name`,
  `xsd:NCName`

[RDF11-CONCEPTS]: https://www.w3.org/TR/rdf11-concepts/

##  Other Types  ##

Although *not* recommended for use in RDF, because it doesn't fit the RDF model (lists should be represented as RDF lists and not as XSD ones), Nib also supports `xsd:NMTOKENS` and the creation of other XSD list types.

##  Not Supported  ##

The following aspects of XSD Datatypes are not supported:

 +  The datatypes `xsd:QName`, `xsd:ENTITY`, `xsd:ID`, `xsd:IDREF`, `xsd:NOTATION`, `xsd:IDREFS`, and `xsd:ENTITIES` are all XML-specific datatypes which are not recommended for use in RDF or other contexts.
As supporting these would require involved XML support and provide little benefit to Nib's intented use‐case, these types are not supported.

 +  The `annotations` property, the value of which is defined—essentially—as XML content, has been left unsupported on XSD Simple Type Definitions, as it would add needless processing and weight to the package for a property that has no bearing on datatype validity or significance.

 +  The `Assertions` constraining facet is not supported, as validating against it requires XPath.
This only has an impact on custom type definitions, which are already outside of the scope of Nib's intended use‐case.

 +  Nib does not support comparing atomic literals with non‐atomic literals, list literals with non‐list literals, and union literals with non‐union literals.
(It additionally does not support comparing atomic literals from different value spaces, which are generally held to be non‐comparable.)

    Nib does, however, provide access to the underlying values that these literals represent, so that you can do the comparisons yourself.
