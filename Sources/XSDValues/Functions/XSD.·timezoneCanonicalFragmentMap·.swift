import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the `·timezoneOffset·`
	///   property of a `XSDDate·timeSevenPropertyValue`, onto a
	///   `XSD.timezoneFrag`, part of a
	///   `XSDDate·timeSevenPropertyValue`’s lexical representation.
	///
	///  +  parameters:
	///      +  t:
	///         An `XSD.Integer` between -840 and 840 inclusive.
	///
	///  +  returns:
	///     A `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-tzCanFragMap>
	@inlinable
	static func ·timezoneCanonicalFragmentMap· (
		_ t: XSD.Integer
	) -> XSD.timezoneFrag {
		if t == 0
		{ return XSD.timezoneFrag("Z")! }
		else if t < 0
		{ return XSD.timezoneFrag("-" + String(XSD.·unsTwoDigitCanonicalFragmentMap·(XSD.·div·(-t, 60))) + ":" + String(XSD.·unsTwoDigitCanonicalFragmentMap·(XSD.·mod·(-t, 60))))! }
		else
		{ return XSD.timezoneFrag(t < 0 ? "-" + String(XSD.·unsTwoDigitCanonicalFragmentMap·(XSD.·div·(t, 60))) + ":" + String(XSD.·unsTwoDigitCanonicalFragmentMap·(XSD.·mod·(t, 60))) : "+" + String(XSD.·unsTwoDigitCanonicalFragmentMap·(XSD.·div·(t, 60))) + ":" + String(XSD.·unsTwoDigitCanonicalFragmentMap·(XSD.·mod·(t, 60))))! }
	}

}
