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
	static func ·yearMonthDurationMap· (
		_ YM: XSD.yearMonthDurationLexicalRep
	) -> XSD.DurationValue {
		let first = String(YM).first
		let P = String(YM).dropFirst(first == "-" ? 2 : 1)
		let m = XSD.·duYearMonthFragmentMap·(XSD.duYearMonthFrag(P)!)
		return XSD.DurationValue(
			months: first == "-" ? -m : m,
			seconds: 0
		)!
	}

}
