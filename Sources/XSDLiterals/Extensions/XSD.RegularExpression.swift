import XSD

internal extension XSD.RegularExpression {

	/// Wraps a string to associate it with a regular expression,
	///   used for defining the static lexical spaces of literals.
	///
	/// Only use with strings which are known to be valid regular
	///   expressions, or a runtime error may result.
	@propertyWrapper
	struct Wrapper {

		/// The wrapped string.
		internal let wrappedValue: String

		/// The compiled regular expression represented by the
		///   string.
		internal let projectedValue: XSD.RegularExpression

		/// Forces a compilation of the wrapped string into its
		///   projected regular expression.
		///
		///  +  parameters:
		///      +  wrappedValue:
		///         The string value to be wrap.
		internal init(wrappedValue: String) {
			self.wrappedValue = wrappedValue
			self.projectedValue =
				XSD.RegularExpression(wrappedValue)!
		}

	}

}
