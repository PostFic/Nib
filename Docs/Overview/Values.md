

##  The `◊` Operator  ##

The `◊` operator (not to be confused with `⟡`) is used to cast a value into an XSD value space.
Depending on the space you are converting into, this value may be a string, a number, or another XSD value.
The result of this operation will always be an `XSDValue`.
See the protocols `XSDValueConvertible`, `XSDNumberConvertible`, and `XSDDatetimeConvertible`.

If the value is not within the value space, using `◊` will  create a runtime error, so only use this when you are confident that the value can be converted.
For other situations, the `¿◊?` operator will produce an optional in the case that the conversion cannot go through.

    "2012-12-21"◊XSD.DateTimeValue.self
    possiblyADateString ¿◊? XSD.DateTimeValue.self

When the type that you are casting into is obvious from context, you can use a postfix form of the `◊` operator: `◊` or `◊?`.

    //  The only thing which can be added to datetimes is durations.
    //  So specifying XSD.DurationValue is not required.
    "1999-06-01"◊XSD.DateTimeValue.self + "P2M"◊

These operators are provided for convenience purposes.
There are typically more verbose methods of achieving the same effect using the initializers.
