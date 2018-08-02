public enum XSDConstrainingFacet: Facet {

	case length(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case minLength(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case maxLength(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case pattern(value: Set<XSDRegularExpression>)

	case enumeration(value: Set<XSDValue>)

	case whiteSpace(
		value: XSDWhiteSpace,
		fixed: XSDLiteral
	)

	case maxInclusive(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case maxExclusive(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case minExclusive(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case minInclusive(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case totalDigits(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	case fractionDigits(
		value: XSDLiteral,
		fixed: XSDLiteral
	)

	/// `Assertions` are not supported since they require XPath.
	case Assertions(value: [Any])

	case explicitTimezone(
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

}
