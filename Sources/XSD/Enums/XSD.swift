/// An enumeration representing the XSD namespace.
///
/// Only those datatypes defined in XSD Part 2 are listed; notably,
///   [xsd:anyType](http://www.w3.org/2001/XMLSchema#anyType) is not
///   included.
public enum XSD: String {

	/// [xsd:anySimpleType](http://www.w3.org/2001/XMLSchema#anySimpleType).
	case anySimpleType

	/// [xsd:anyAtomicType](http://www.w3.org/2001/XMLSchema#anyAtomicType).
	case anyAtomicType

	/// [xsd:string](http://www.w3.org/2001/XMLSchema#string).
	case string

	/// [xsd:boolean](http://www.w3.org/2001/XMLSchema#boolean).
	case boolean

	/// [xsd:float](http://www.w3.org/2001/XMLSchema#float).
	case float

	/// [xsd:double](http://www.w3.org/2001/XMLSchema#double).
	case double

	/// [xsd:decimal](http://www.w3.org/2001/XMLSchema#decimal).
	case decimal

	/// [xsd:dateTime](http://www.w3.org/2001/XMLSchema#dateTime).
	case dateTime

	/// [xsd:duration](http://www.w3.org/2001/XMLSchema#duration).
	case duration

	/// [xsd:time](http://www.w3.org/2001/XMLSchema#time).
	case time

	/// [xsd:date](http://www.w3.org/2001/XMLSchema#date).
	case date

	/// [xsd:gMonth](http://www.w3.org/2001/XMLSchema#gMonth).
	case gMonth

	/// [xsd:gMonthDay](http://www.w3.org/2001/XMLSchema#gMonthDay).
	case gMonthDay

	/// [xsd:gDay](http://www.w3.org/2001/XMLSchema#gDay).
	case gDay

	/// [xsd:gYear](http://www.w3.org/2001/XMLSchema#gYear).
	case gYear

	/// [xsd:gYearMonth](http://www.w3.org/2001/XMLSchema#gYearMonth).
	case gYearMonth

	/// [xsd:hexBinary](http://www.w3.org/2001/XMLSchema#hexBinary).
	case hexBinary

	/// [xsd:base64Binary](http://www.w3.org/2001/XMLSchema#base64Binary).
	case base64Binary

	/// [xsd:anyURI](http://www.w3.org/2001/XMLSchema#anyURI).
	case anyURI

	/// [xsd:QName](http://www.w3.org/2001/XMLSchema#QName)
	///   (*not supported*).
	case QName

	/// [xsd:NOTATION](http://www.w3.org/2001/XMLSchema#NOTATION)
	///   (*not supported*).
	case NOTATION

	/// [xsd:normalizedString](http://www.w3.org/2001/XMLSchema#normalizedString).
	case normalizedString

	/// [xsd:token](http://www.w3.org/2001/XMLSchema#token).
	case token

	/// [xsd:language](http://www.w3.org/2001/XMLSchema#language).
	case language

	/// [xsd:NMTOKEN](http://www.w3.org/2001/XMLSchema#NMTOKEN).
	case NMTOKEN

	/// [xsd:NMTOKENS](http://www.w3.org/2001/XMLSchema#NMTOKENS).
	case NMTOKENS

	/// [xsd:Name](http://www.w3.org/2001/XMLSchema#Name).
	case Name

	/// [xsd:NCName](http://www.w3.org/2001/XMLSchema#NCName).
	case NCName

	/// [xsd:ID](http://www.w3.org/2001/XMLSchema#ID)
	///   (*not supported*).
	case ID

	/// [xsd:IDREF](http://www.w3.org/2001/XMLSchema#IDREF)
	///   (*not supported*).
	case IDREF

	/// [xsd:IDREFS](http://www.w3.org/2001/XMLSchema#IDREFS)
	///   (*not supported*).
	case IDREFS

	/// [xsd:ENTITY](http://www.w3.org/2001/XMLSchema#ENTITY)
	///   (*not supported*).
	case ENTITY

	/// [xsd:ENTITIES](http://www.w3.org/2001/XMLSchema#ENTITIES)
	///   (*not supported*).
	case ENTITIES

	/// [xsd:integer](http://www.w3.org/2001/XMLSchema#integer).
	case integer

	/// [xsd:nonPositiveInteger](http://www.w3.org/2001/XMLSchema#nonPositiveInteger).
	case nonPositiveInteger

	/// [xsd:negativeInteger](http://www.w3.org/2001/XMLSchema#negativeInteger).
	case negativeInteger

	/// [xsd:long](http://www.w3.org/2001/XMLSchema#long).
	case long

	/// [xsd:int](http://www.w3.org/2001/XMLSchema#int).
	case int

	/// [xsd:short](http://www.w3.org/2001/XMLSchema#short).
	case short

	/// [xsd:byte](http://www.w3.org/2001/XMLSchema#byte).
	case byte

	/// [xsd:nonNegativeInteger](http://www.w3.org/2001/XMLSchema#nonNegativeInteger).
	case nonNegativeInteger

	/// [xsd:unsignedLong](http://www.w3.org/2001/XMLSchema#unsignedLong).
	case unsignedLong

	/// [xsd:unsignedInt](http://www.w3.org/2001/XMLSchema#unsignedInt).
	case unsignedInt

	/// [xsd:unsignedShort](http://www.w3.org/2001/XMLSchema#unsignedShort).
	case unsignedShort

	/// [xsd:unsignedByte](http://www.w3.org/2001/XMLSchema#unsignedByte).
	case unsignedByte

	/// [xsd:positiveInteger](http://www.w3.org/2001/XMLSchema#positiveInteger).
	case positiveInteger

	/// [xsd:yearMonthDuration](http://www.w3.org/2001/XMLSchema#yearMonthDuration).
	case yearMonthDuration

	/// [xsd:dayTimeDuration](http://www.w3.org/2001/XMLSchema#dayTimeDuration).
	case dayTimeDuration

	/// [xsd:dateTimeStamp](http://www.w3.org/2001/XMLSchema#dateTimeStamp).
	case dateTimeStamp

	/// The XSD namespace.
	public static let ·targetNamespace· = "http://www.w3.org/2001/XMLSchema"

}
