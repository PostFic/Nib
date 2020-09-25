public extension XSD {

	/// An enumeration representing the XSD‐defined constraining
	///   facets.
	enum ConstrainingFacet: String {

		/// [xsd:length](http://www.w3.org/2001/XMLSchema#length).
		case length

		/// [xsd:minLength](http://www.w3.org/2001/XMLSchema#minLength).
		case minLength

		/// [xsd:maxLength](http://www.w3.org/2001/XMLSchema#maxLength).
		case maxLength

		/// [xsd:pattern](http://www.w3.org/2001/XMLSchema#pattern).
		case pattern

		/// [xsd:enumeration](http://www.w3.org/2001/XMLSchema#enumeration).
		case enumeration

		/// [xsd:whiteSpace](http://www.w3.org/2001/XMLSchema#whiteSpace).
		case whiteSpace

		/// [xsd:maxInclusive](http://www.w3.org/2001/XMLSchema#maxInclusive).
		case maxInclusive

		/// [xsd:maxExclusive](http://www.w3.org/2001/XMLSchema#maxExclusive).
		case maxExclusive

		/// [xsd:minExclusive](http://www.w3.org/2001/XMLSchema#minExclusive).
		case minExclusive

		/// [xsd:minInclusive](http://www.w3.org/2001/XMLSchema#minInclusive).
		case minInclusive

		/// [xsd:totalDigits](http://www.w3.org/2001/XMLSchema#totalDigits).
		case totalDigits

		/// [xsd:fractionDigits](http://www.w3.org/2001/XMLSchema#fractionDigits).
		case fractionDigits

		/// [xsd:Assertions](http://www.w3.org/2001/XMLSchema#Assertions).
		case Assertions

		/// [xsd:explicitTimezone](http://www.w3.org/2001/XMLSchema#explicitTimezone).
		case explicitTimezone

	}

}
