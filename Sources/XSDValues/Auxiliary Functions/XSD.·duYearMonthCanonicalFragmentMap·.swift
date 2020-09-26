import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.Integer`, presumably the absolute value of the
	///   `·months·` of a `XSD.DurationValue`, to a
	///   `XSD.duYearMonthFrag`, a fragment of a `XSD.DurationValue`
	///   lexical representation.
	///
	///  +  parameters:
	///      +  ym:
	///         A nonnegative `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.duYearMonthFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duYMCan>
	@inlinable
	static func ·duYearMonthCanonicalFragmentMap· (
		_ ym: XSD.Integer
	) -> XSD.duYearMonthFrag {
		let y = XSD.·div·(ym, 12)
		let m = XSD.·mod·(ym, 12)
		if y != 0 && m != 0
		{ return XSD.duYearMonthFrag(String(XSD.·unsignedNoDecimalPtCanonicalMap·(y)) + "Y" + String(XSD.·unsignedNoDecimalPtCanonicalMap·(m)) + "M")! }
		else if y != 0 && m == 0
		{ return XSD.duYearMonthFrag(String(XSD.·unsignedNoDecimalPtCanonicalMap·(y)) + "Y")! }
		else
		{ return XSD.duYearMonthFrag(String(XSD.·unsignedNoDecimalPtCanonicalMap·(m)) + "M")! }
	}

}
