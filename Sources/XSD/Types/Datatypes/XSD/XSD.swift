/// An enumeration representing the XSD namespace.
///
/// Only those datatypes defined in XSD Part 2 are listed; notably, `anyType` is not included.
public enum XSD:
	String,
	XSDDatatype,
	CrossConvertibleToXSDLiteral,
	CrossConvertibleToXSDValue
{

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
	## Properties and Methods.
	*/

	/// Provides the `XSDSimpleTypeDefinition` corresponding to the given case.
	public var definition: XSDSimpleTypeDefinition {
		switch self {
		case .anySimpleType:
			return 🌉anySimpleType
		case .anyAtomicType:
			return 🌉anyAtomicType
		/*
		case .string:
			return 🌉string
		case .boolean:
			return 🌉boolean
		case .float:
			return 🌉float
		case .double:
			return 🌉double
		case .decimal:
			return 🌉decimal
		case .dateTime:
			return 🌉dateTime
		case .duration:
			return 🌉duration
		case .time:
			return 🌉time
		case .date:
			return 🌉date
		case .gMonth:
			return 🌉gMonth
		case .gMonthDay:
			return 🌉gMonthDay
		case .gDay:
			return 🌉gDay
		case .gYear:
			return 🌉gYear
		case .gYearMonth:
			return 🌉gYearMonth
		case .hexBinary:
			return 🌉hexBinary
		case .base64Binary:
			return 🌉base64Binary
		case .anyURI:
			return 🌉anyURI
		case .normalizedString:
			return 🌉normalizedString
		case .token:
			return 🌉token
		case .language:
			return 🌉language
		case .NMTOKEN:
			return 🌉NMTOKEN
		case .NMTOKENS:
			return 🌉NMTOKENS
		case .Name:
			return 🌉Name
		case .NCName:
			return 🌉NCName
		case .integer:
			return 🌉integer
		case .nonPositiveInteger:
			return 🌉nonPositiveInteger
		case .negativeInteger:
			return 🌉negativeInteger
		case .long:
			return 🌉long
		case .int:
			return 🌉int
		case .short:
			return 🌉short
		case .byte:
			return 🌉byte
		case .nonNegativeInteger:
			return 🌉nonNegativeInteger
		case .unsignedLong:
			return 🌉unsignedLong
		case .unsignedInt:
			return 🌉unsignedInt
		case .unsignedShort:
			return 🌉unsignedShort
		case .unsignedByte:
			return 🌉unsignedByte
		case .positiveInteger:
			return 🌉positiveInteger
		case .yearMonthDuration:
			return 🌉yearMonthDuration
		case .dayTimeDuration:
			return 🌉dayTimeDuration
		case .dateTimeStamp:
			return 🌉dateTimeStamp
		*/
		default:
			return 🌉anySimpleType
		}
	}

	/// The XSD namespace.
	public static let targetNamespace = "http://www.w3.org/2001/XMLSchema"

	/// Creates the case which reflects the given datatype, if possible.
	public init?(_ type: XSDSimpleTypeDefinition) {
		if
			let theName = type.name?.string,
			let theNamespace = type.targetNamespace?.string,
			theNamespace == XSD.targetNamespace,
			let theCase = XSD(rawValue: theName),
			theCase.definition === type
		{
			self = theCase
		} else {
			return nil
		}
	}

}
