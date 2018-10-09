/// An enumeration representing the XSD namespace.
///
/// Only those datatypes defined in XSD Part 2 are listed; notably, `anyType` is not included.
public enum XSD: String {

	/*
	## Special built-in datatypes.
	*/

	/// `xsd:anySimpleType`.
	case anySimpleType

	/// `xsd:anyAtomicType`.
	case anyAtomicType

	/*
	## Primitive datatypes.
	*/

	/// `xsd:string`.
	case string

	/// `xsd:boolean`.
	case boolean

	/// `xsd:float`.
	case float

	/// `xsd:double`.
	case double

	/// `xsd:decimal`.
	case decimal

	/// `xsd:dateTime`.
	case dateTime

	/// `xsd:duration`.
	case duration

	/// `xsd:time`.
	case time

	/// `xsd:date`.
	case date

	/// `xsd:gMonth`.
	case gMonth

	/// `xsd:gMonthDay`.
	case gMonthDay

	/// `xsd:gDay`.
	case gDay

	/// `xsd:gYear`.
	case gYear

	/// `xsd:gYearMonth`.
	case gYearMonth

	/// `xsd:hexBinary`.
	case hexBinary

	/// `xsd:base64Binary`.
	case base64Binary

	/// `xsd:anyURI`.
	case anyURI

	/// `xsd:QName` (*not supported*).
	case QName

	/// `xsd:NOTATION` (*not supported*).
	case NOTATION

	/*
	## Other built-in datatypes.
	*/

	/// `xsd:normalizedString`.
	case normalizedString

	/// `xsd:token`.
	case token

	/// `xsd:language`.
	case language

	/// `xsd:NMTOKEN`.
	case NMTOKEN

	/// `xsd:NMTOKENS`.
	case NMTOKENS

	/// `xsd:Name`.
	case Name

	/// `xsd:NCName`.
	case NCName

	/// `xsd:ID` (*not supported*).
	case ID

	/// `xsd:IDREF` (*not supported*).
	case IDREF

	/// `xsd:IDREFS` (*not supported*).
	case IDREFS

	/// `xsd:ENTITY` (*not supported*).
	case ENTITY

	/// `xsd:ENTITIES` (*not supported*).
	case ENTITIES

	/// `xsd:integer`.
	case integer

	/// `xsd:nonPositiveInteger`.
	case nonPositiveInteger

	/// `xsd:negativeInteger`.
	case negativeInteger

	/// `xsd:long`.
	case long

	/// `xsd:int`.
	case int

	/// `xsd:short`.
	case short

	/// `xsd:byte`.
	case byte

	/// `xsd:nonNegativeInteger`.
	case nonNegativeInteger

	/// `xsd:unsignedLong`.
	case unsignedLong

	/// `xsd:unsignedInt`.
	case unsignedInt

	/// `xsd:unsignedShort`.
	case unsignedShort

	/// `xsd:unsignedByte`.
	case unsignedByte

	/// `xsd:positiveInteger`.
	case positiveInteger

	/// `xsd:yearMonthDuration`.
	case yearMonthDuration

	/// `xsd:dayTimeDuration`.
	case dayTimeDuration

	/// `xsd:dateTimeStamp`.
	case dateTimeStamp

	/*
	## Types
	*/

	public enum ConstrainingFacet: String {

		case length
		case minLength
		case maxLength
		case pattern
		case enumeration
		case whiteSpace
		case maxInclusive
		case maxExclusive
		case minExclusive
		case minInclusive
		case totalDigits
		case fractionDigits
		case Assertions
		case explicitTimezone

	}

	public enum FundamentalFacet: String {

		case ordered
		case bounded
		case cardinality
		case numeric

	}

	/*
	## Properties and Methods
	*/

	/// The XSD namespace.
	public static let targetNamespace = "http://www.w3.org/2001/XMLSchema"

}
