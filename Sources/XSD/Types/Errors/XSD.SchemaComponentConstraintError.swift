public extension XSD {

	/// Errors which result from a failure to meet an XSD schema component constraint.
	enum SchemaComponentConstraintError: Error {

		/// Only certain facets are applicable depending on the `variety` of the datatype.
		case applicableFacets

		/// `fractionDigits` cannot be greater than `totalDigits`.
		///
		/// Note that, despite its name, this constraint actually checks "not greater-than", not "less-than-or-equal".
		case fractionDigitsLessThanOrEqualToTotalDigits

		/// `fractionDigits` can only be constrained to be more restrictive.
		case fractionDigitsValidRestriction

		/// `length` must be within `minLength` and `maxLength`
		case lengthAndMinLengthOrMaxLength

		/// `length` can only be constrained to the same value.
		case lengthValidRestriction

		/// `minInclusive` can only be constrained to be more restrictive.
		case maxExclusiveValidRestriction

		/// `minInclusive` can only be constrained to be more restrictive.
		case maxInclusiveValidRestriction

		/// `length` can only be constrained to the same value.
		case maxLengthValidRestriction

		/// `minInclusive` can only be constrained to be more restrictive.
		case minExclusiveValidRestriction

		/// `minInclusive` can only be constrained to be more restrictive.
		case minInclusiveValidRestriction

		/// `length` can only be constrained to the same value.
		case minLengthValidRestriction

		/// `minLength` must be less-than-or-equal to `maxLength`.
		case minLength＜＝MaxLength

		/// `minInclusive` can only be constrained to be more restrictive.
		case totalDigitsValidRestriction

		/// `whiteSpace` can only be constrained to be more restrictive.
		case whiteSpaceValidRestriction

		/// Pattern restrictions must be supersets of their bases.
		case validRestrictionOfPattern

	}

}
