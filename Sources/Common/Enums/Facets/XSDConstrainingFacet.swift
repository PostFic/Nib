public enum XSDConstrainingFacet: Facet {

	case length(
		annotations: [Annotation],
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case minLength(
		annotations: [Annotation],
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case maxLength(
		annotations: [Annotation],
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case pattern(
		annotations: [Annotation],
		value: Set<XSDRegularExpression>
	)

	case enumeration(
		annotations: [Annotation],
		value: Set<XSDValue>
	)

	case whiteSpace(
		annotations: [Annotation],
		value: XSDWhiteSpace,
		fixed: XSDLiteral
	)

	case maxInclusive(
		annotations: [Annotation],
		value: XSDValue,
		fixed: XSDLiteral
	)

	case maxExclusive(
		annotations: [Annotation],
		value: XSDValue,
		fixed: XSDLiteral
	)

	case minExclusive(
		annotations: [Annotation],
		value: XSDValue,
		fixed: XSDLiteral
	)

	case minInclusive(
		annotations: [Annotation],
		value: XSDValue,
		fixed: XSDLiteral
	)

	case totalDigits(
		annotations: [Annotation],
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case fractionDigits(
		annotations: [Annotation],
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	/// `Assertions` are not supported since they require XPath.
	case Assertions(
		annotations: [Annotation],
		value: [Assertion]
	)

	case explicitTimezone(
		annotations: [Annotation],
		value: XSDExplicitTimezone,
		fixed: XSDLiteral
	)

	case 📛(String)

	public var name: String {
		switch self {
		case .length:
			return "length"
		case .minLength:
			return "minLength"
		case .maxLength:
			return "maxLength"
		case .pattern:
			return "pattern"
		case .enumeration:
			return "enumeration"
		case .whiteSpace:
			return "whiteSpace"
		case .maxInclusive:
			return "maxInclusive"
		case .maxExclusive:
			return "maxExclusive"
		case .minExclusive:
			return "minExclusive"
		case .minInclusive:
			return "minInclusive"
		case .totalDigits:
			return "totalDigits"
		case .fractionDigits:
			return "fractionDigits"
		case .Assertions:
			return "Assertions"
		case .explicitTimezone:
			return "explicitTimezone"
		case .📛(let theName):
			return theName
		}
	}

	public var value: Any? {
		var value: Any?
		switch self {
		case
			.length(value: let theValue),
			.minLength(value: let theValue),
			.maxLength(value: let theValue),
			.totalDigits(value: let theValue),
			.fractionDigits(value: let theValue)
		: // `XSDLiteral` values
			value = theValue as Any
		case .pattern(value: let theValue): // `Set<XSDRegularExpression>` values
			value = theValue as Any
		case .enumeration(value: let theValue): // `Set<XSDValue>` values
			value = theValue as Any
		case .whiteSpace(value: let theValue): // `XSDWhiteSpace` values
			value = theValue as Any
		case
			.maxInclusive(value: let theValue),
			.maxExclusive(value: let theValue),
			.minExclusive(value: let theValue),
			.minInclusive(value: let theValue)
		: // `XSDValue` values
			value = theValue as Any
		case .Assertions(value: let theValue):
			value = theValue as Any
		case .explicitTimezone(value: let theValue): // `XSDExplicitTimexone` values
			value = theValue as Any
		case .📛:
			value = nil
		}
		return value
	}

}
