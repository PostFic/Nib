import XSD

public extension XSD {

	/// A day/month combination with optional timezone offset, as in
	///   `XSD.dateTimeLexicalRep`.
	///
	/// ####  Constraint: Day‐of‐month Values  ####
	///
	/// The `day` value must be no more than 30 if `month` is one of 4,
	///   6, 9, or 11, and no more than 29 if `month` is 2.
	///
	/// ````
	/// [21]   gMonthDayLexicalRep ::= '--' monthFrag '-' dayFrag timezoneFrag?    Constraint: Day‐of‐month Representations
	/// ````
	///
	/// ####  Constraint: Day‐of‐month Representations  ####
	///
	/// Within a `XSD.gMonthDayLexicalRep`, a `XSD.dayFrag` must not
	///   begin with the digit `"3"` or be `"29"` unless the value to
	///   which it would map would satisfy the value constraint on
	///   `day` values (“Constraint: Day‐of‐month Values”) given above.
	class gMonthDayLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"--(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?"#

		/// Initializes the `XSD.Literal`, ensuring that the provided `literal` is within its `·lexicalSpace·`, including the appropriate constraints.
		/// Fails otherwise.
		///
		///  +  parameters:
		///      +  literal:
		///         Another `XSD.Literal`.
		public required init? <L> (
			_ literal: L
		) where L: XSD.Literal {
			let Array·M，D，T = literal.description.dropFirst(2).split(
				maxSplits: 2,
				omittingEmptySubsequences: false
			) { $0 == "-" || $0 == "Z" || $0 == "+" }
			guard
				let M = XSD.Integer(Array·M，D，T[0]),
				let D = XSD.Integer(Array·M，D，T[1])
			else
			{ return nil }
			if D > 30 && (M == 4 || M == 6 || M == 9 || M == 11) || D > 29 && M == 2
			{ return nil }
			super.init(literal)
		}

		/// Initializes the `XSD.Literal`, ensuring that the provided `representation` is within its `·lexicalSpace·`, including the appropriate constraints.
		/// Fails otherwise.
		///
		///  +  parameters:
		///      +  representation:
		///         The string value of the `XSD.Literal`, as a `String`.
		public required init? (
			_ representation: String = ""
		) {
			let Array·M，D，T = representation.dropFirst(2).split(
				maxSplits: 2,
				omittingEmptySubsequences: false
			) { $0 == "-" || $0 == "Z" || $0 == "+" }
			guard
				let M = XSD.Integer(Array·M，D，T[0]),
				let D = XSD.Integer(Array·M，D，T[1])
			else
			{ return nil }
			if D > 30 && (M == 4 || M == 6 || M == 9 || M == 11) || D > 29 && M == 2
			{ return nil }
			super.init(representation)
		}

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
