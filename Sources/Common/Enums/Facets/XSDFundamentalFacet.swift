public enum XSDFundamentalFacet: Facet {

	case ordered(value: XSDOrdered)

	case bounded(value: XSDLiteral)

	case cardinality(value: XSDCardinality)

	case numeric(value: XSDLiteral)

	case 📛(String)

	public var name: String {
		switch self {
		case .ordered:
			return "ordered"
		case .bounded:
			return "bounded"
		case .cardinality:
			return "cardinality"
		case .numeric:
			return "numeric"
		case .📛(let theName):
			return theName
		}
	}

	public var value: Any? {
		var value: Any?
		switch self {
		case .ordered(value: let theValue): // `XSDOrdered` values
			value = theValue as Any
		case
			.bounded(value: let theValue),
			.numeric(value: let theValue)
		: // `XSDLiteral` values
			value = theValue as Any
		case .cardinality(value: let theValue): // `XSDCardinality` values
			value = theValue as Any
		case .📛:
			value = nil
		}
		return value
	}

}
