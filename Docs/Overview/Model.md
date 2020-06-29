#  Nib: Model  #

##  The Nib Three-Part Model  ##

In Nib, there are three fundamental components used to represent the XSD data model:

 +  **Values** represent particular values in a value space.
    In Nib, values all conform to the protocol `XSDValue`.

 +  **Types** represent constraints placed on value spaces, as well as lists and unions of other types.
    In Nib, XSD types are all represented by instances of the class `XSDSimpleTypeDefinition`.

 +  **Literals** are essentially typed strings.
    They have an associated XSD type, and can be used to access an XSD
      value.
    In Nib, literals all conform to the protocol `XSDLiteral`.

##  XSD Relations  ##

The relations XSD defines between values do not line up with those conventionally expected in Swift in a clean way.
    Consequently, a number of new operators have been defined.
