import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.yearMonthDurationLexicalRep` to a
	///   `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  YM:
	///         A `XSD.yearMonthDurationLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.DurationValue`.
	///
	/// `YM` necessarily consists of an optional leading `"-"`,
	///   followed by `"P"` and then an instance of
	///   `XSD.duYearMonthFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-yearMonthDurationMap>
	@inlinable
	static func ·yearMonthDurationMap·(
		_ YM: XSD.yearMonthDurationLexicalRep
	) -> XSD.DurationValue {
		let first = String(describing: YM).first
		let P = String(describing: YM).dropFirst(first == "-" ? 2 : 1)
		let m = XSD.·duYearMonthFragmentMap·(P◊)
		return XSD.DurationValue(
			months: first == "-" ? -m : m,
			seconds: 0
		)!
	}

}
