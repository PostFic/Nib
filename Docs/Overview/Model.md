#  Nib: Model  #

##  The Nib Four‐Part Model  ##

In Nib, there are four fundamental components used to represent the XSD data model:

 +  **Literals** are strings with an optional associated lexical space.
    In Nib, all literals are all represented by instances of the class `XSD.Literal`.

 +  **Values** represent particular values in a value space.
    In Nib, values all conform to the protocol `XSDValue`.

 +  **Types** represent constraints placed on value spaces, as well as lists and unions of other types.
    In Nib, XSD types are all represented by instances of the class `XSD.SimpleTypeDefinition`.

 +  **Mappings** are associations between a single literal and the corresponding value in the value space of a particular type.
    In Nib, mappings are all instances of the struct `XSD.Mapping`.

##  XSD Relations  ##

The relations XSD defines between values do not line up with those conventionally expected in Swift in a clean way.
Consequently, a number of new operators have been defined.
