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

}
