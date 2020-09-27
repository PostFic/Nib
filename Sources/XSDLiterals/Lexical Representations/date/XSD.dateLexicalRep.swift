import XSD

public extension XSD {

	/// A date, as in `XSD.dateTimeLexicalRep`.
	///
	/// ####  Constraint: Day‐of‐month Values  ####
	///
	/// The `day` value must be no more than 30 if `month` is one
	///   of 4, 6, 9, or 11; no more than 28 if `month` is 2 and
	///   `year` is not divisible by 4, or is divisible by 100 but
	///   not by 400; and no more than 29 if `month` is 2 and
	///   `year` is divisible by 400, or by 4 but not by 100.
	///
	/// ````
	/// [18]   dateLexicalRep ::= yearFrag '-' monthFrag '-' dayFrag timezoneFrag?    Constraint: Day‐of‐month Representations
	/// ````
	///
	/// ####  Constraint: Day‐of‐month Representations  ####
	///
	/// Within a `XSD.dateLexicalRep`, a `XSD.dayFrag` must not begin
	///   with the digit `"3"` or be `"29"` unless the value to which
	///   it would map would satisfy the value constraint on `day`
	///   values (“Constraint: Day‐of‐month Values”) given above.
	class dateLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"-?([1-9][0-9]{3,}|0[0-9]{3})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?"#

		/// Initializes the `XSD.Literal`, ensuring that the provided `literal` is within its `·lexicalSpace·`, including the appropriate constraints.
		/// Fails otherwise.
		///
		///  +  parameters:
		///      +  literal:
		///         Another `XSD.Literal`.
		public required init? <L> (
			_ literal: L
		) where L: XSD.Literal {
			let Array·Y，M，D，T = literal.description.dropFirst().split(
				maxSplits: 3,
				omittingEmptySubsequences: false
			) { $0 == "-" || $0 == "Z" || $0 == "+" }
			guard
				let Y = XSD.Integer(literal.description[literal.description.startIndex..<Array·Y，M，D，T[0].endIndex]),
				let M = XSD.Integer(Array·Y，M，D，T[1]),
				let D = XSD.Integer(Array·Y，M，D，T[2])
			else
			{ return nil }
			if D > 30 && (M == 4 || M == 6 || M == 9 || M == 11) || D > 28 && M == 2 && (Y % 4 != 0 || Y % 100 == 0 && Y % 400 != 0) || D > 29 && M == 2 && (Y % 400 == 0 || Y % 4 == 0 && Y % 100 != 0)
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
			let Array·Y，M，D，T = representation.dropFirst().split(
				maxSplits: 3,
				omittingEmptySubsequences: false
			) { $0 == "-" || $0 == "Z" || $0 == "+" }
			guard
				let Y = XSD.Integer(representation[representation.startIndex..<Array·Y，M，D，T[0].endIndex]),
				let M = XSD.Integer(Array·Y，M，D，T[1]),
				let D = XSD.Integer(Array·Y，M，D，T[2])
			else
			{ return nil }
			if D > 30 && (M == 4 || M == 6 || M == 9 || M == 11) || D > 28 && M == 2 && (Y % 4 != 0 || Y % 100 == 0 && Y % 400 != 0) || D > 29 && M == 2 && (Y % 400 == 0 || Y % 4 == 0 && Y % 100 != 0)
			{ return nil }
			super.init(representation)
		}

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
