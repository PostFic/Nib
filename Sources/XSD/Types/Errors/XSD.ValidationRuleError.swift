public extension XSD {

	/// Errors which result from a failure to meet an XSD validation rule, either for literals or their values.
	enum ValidationRuleError: Error {

		/// The literal validates according to the `fractionDigits` facet of its type.
		case fractionDigitsValid

		/// The literal validates according to the `length` facet of its type.
		case lengthValid

		/// The literal validates according to the `maxExclusive` facet of its type.
		case maxExclusiveValid

		/// The literal validates according to the `maxInclusive` facet of its type.
		case maxInclusiveValid

		/// The literal validates according to the `maxLength` facet of its type.
		case maxLengthValid

		/// The literal validates according to the `minExclusive` facet of its type.
		case minExclusiveValid

		/// The literal validates according to the `minInclusive` facet of its type.
		case minInclusiveValid

		/// The literal validates according to the `minLength` facet of its type.
		case minLengthValid

		/// The literal validates according to the `pattern` facet of its type.
		case patternValid

	}

}
