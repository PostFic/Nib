public extension XSD {

	/// A named value which is distinct from, and unequal to, all other
	///   values.
	enum SpecialValue: String {

		/// A `positiveInfinity` value.
		case positiveInfinity

		/// A `positiveZero` value.
		case positiveZero

		/// A `negativeInfinity` value.
		case negativeInfinity

		/// A `negativeZero` value.
		case negativeZero

		/// A `notANumber` value.
		case notANumber

	}

}
