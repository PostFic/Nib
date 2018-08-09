public extension XSD {

	/// Errors which result from a failure to meet an XSD validation rule, either for literals or their values.
	enum ValidationRuleError: Error {

		/// The literal validates according to the `pattern` facet of its type.
		case patternValid

	}

}
