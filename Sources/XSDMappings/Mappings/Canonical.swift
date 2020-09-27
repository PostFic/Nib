import Foundation
import XSD
import XSDLiterals
import XSDValues

public extension XSD {

	/// Maps an `XSD.Integer` between 0 and 9 inclusive to the corresponding `XSD.digit`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digit>
	@XSD.CanonicalMapping({ i in
		switch i {
		case 0:
			return "0"
		case 1:
			return "1"
		case 2:
			return "2"
		case 3:
			return "3"
		case 4:
			return "4"
		case 5:
			return "5"
		case 6:
			return "6"
		case 7:
			return "7"
		case 8:
			return "8"
		case 9:
			return "9"
		default:
			fatalError("Expected an integer between 0 and 9 inclusive, but got \(i).")
		}
	})
	static var ·digit·: (XSD.Integer) -> XSD.digit

	/// Maps each nonnegative `XSD.Integer` to a `XSD.Sequence` of nonnegative `XSD.Integer`s, to be used by `XSD.·digitSeq·` to ultimately create an `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitRemSeq>
	static var ·digitRemainderSeq·: (XSD.Integer) -> XSD.Sequence <XSD.Integer> {
		{ i in
			guard i >= 0 else
			{ fatalError("Expected a nonnegative integer, but got \(i).") }
			return sequence(
				state: i
			) { s_（j＋1） in
				let s_j = s_（j＋1） as! XSD.Integer
				s_（j＋1） = XSD.·div·(s_j, 10)
				return s_j
			}
		}
	}

	/// Maps each nonnegative `XSD.Integer` to a `XSD.Sequence` of `XSD.Integer`s where each term is between 0 and 9 inclusive, to be used by `XSD.·unsignedNoDecimalPtCanonicalMap·` to ultimately create an `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitSeq>
	static var ·digitSeq·: (XSD.Integer) -> XSD.Sequence <XSD.Integer> {
		{ i in
			guard i >= 0 else
			{ fatalError("Expected a nonnegative integer, but got \(i).") }
			return sequence(
				state: XSD.·digitRemainderSeq·(i)
			) { state in
				var nextState = state as! XSD.Sequence <XSD.Integer>
				let ·digitRemainderSeq·i_j = nextState.next()!
				state = nextState
				return XSD.·mod·(·digitRemainderSeq·i_j, 10)
			}
		}
	}

	/// Maps a `XSD.Sequence` of nonnegative `XSD.Integer`s to the one‐based index of its first zero term.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-lastSigDigit>
	///
	///  +  note:
	///     XSD actually only defines `·lastSignificantDigit·` for integers, but it clearly makes use of the function with decimal numbers as well.
	static var ·lastSignificantDigit·: (XSD.Sequence <XSD.Integer>) -> XSD.Integer {
		{ s in
			guard let j = s.enumerated().first(
				where: { s_j＋1 in
					if s_j＋1.1 < 0
					{ fatalError("Expected a nonnegative integer, but got \(s_j＋1.1)") }
					else
					{ return s_j＋1.1 == 0 }
				}
			)?.0 else
			{ return .max }
			return XSD.Integer(j == 0 ? j : j - 1)
		}
	}

	/// Maps each nonnegative `XSD.DecimalNumber` less than 1 to a `XSD.Sequence` of nonnegative `XSD.DecimalNumber`s, to be used by `XSD.·fractionDigitSeq·` to ultimately create an `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitRemSeq>
	///
	///  +  note:
	///     The definition of `·FractionDigitRemainderSeq·` given by the XSD Datatypes specification is incorrect; it uses “minus” instead of “times”.
	///     Nib provides the correct implementation.
	static var ·FractionDigitRemainderSeq·: (XSD.DecimalNumber) -> XSD.Sequence <XSD.DecimalNumber> {
		{ f in
			if f < 0 || f > 1
			{ fatalError("Expected a nonnegative decimal number less than 1, but got \(f).") }
			else {
				return sequence(
					state: XSD.·mod·(f, 1) * 10
				) { s_（j＋1） in
					let s_j = s_（j＋1） as! XSD.DecimalNumber
					s_（j＋1） = XSD.·mod·(s_j, 1) * 10
					return s_j
				}
			}
		}
	}

	/// Maps each nonnegative `XSD.DecimalNumber` less than 1 to a `XSD.Sequence` of
	///   `XSD.Integer`s between 0 and 9 inclusive, to be used by `XSD.·fractionDigitsCanonicalFragmentMap·` to ultimately create an `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fracDigitSeq>
	static var ·fractionDigitSeq·: (XSD.DecimalNumber) -> XSD.Sequence <XSD.Integer> {
		{ f in
			if f < 0 || f > 1
			{ fatalError("Expected a nonnegative decimal number less than 1, but got \(f).") }
			return sequence(
				state: XSD.·FractionDigitRemainderSeq·(f)
			) { state in
				var nextState = state as! XSD.Sequence <XSD.DecimalNumber>
				let ·FractionDigitRemainderSeq·f_j = nextState.next()!
				state = nextState
				return XSD.·div·(·FractionDigitRemainderSeq·f_j, 1)
			}
		}
	}

	/// Maps a nonnegative `XSD.DecimalNumber` less than 1 to a `XSD.fracFrag`, to be used by `XSD.unsignedDecimalPtCanonicalMap` to ultimately create an `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fracDigitSeq>
	///
	///  +  note:
	///     The XSD specification incorrectly calls `XSD.·lastSignificantDigit·` with `XSD.·FractionDigitRemainterSeq·(f)`, despite the fact that the latter does not produce integers.
	///     Nib simply maps each decimal to `1` if it is nonzero, and `0` if it is zero.
	@XSD.CanonicalMapping({ f in
		guard f >= 0 && f < 1
		else
		{ fatalError("Expected a nonnegative integer less than 1, but got \(f).") }
		var ·fractionDigitSeq·f = XSD.·fractionDigitSeq·(f)
		let ·lastSignificantDigit·FractionDigitRemainderSeq·f = XSD.·lastSignificantDigit·(
			sequence(
				state: XSD.·FractionDigitRemainderSeq·(f).makeIterator()
			) { state in
				var nextState = state as! XSD.Sequence <XSD.DecimalNumber>.Iterator
				guard let S_i = nextState.next() else
				{ return nil }
				state = nextState
				return S_i == 0 ? 0 : 1
			}
		)
		var result: Array <String> = []
		result.reserveCapacity(Int(·lastSignificantDigit·FractionDigitRemainderSeq·f))
		for _ in 0...·lastSignificantDigit·FractionDigitRemainderSeq·f {
			result += CollectionOfOne(XSD._·digit·.toString(·fractionDigitSeq·f.next()!))
		}
		return result.joined()
	})
	static var ·fractionDigitsCanonicalFragmentMap·: (XSD.DecimalNumber) -> XSD.fracFrag

	/// Maps a nonnegative `XSD.Integer` to an `XSD.unsignedNoDecimalPtNumeral`, its canonical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsNoDecCanFragMap>
	@XSD.CanonicalMapping({ i in
		guard i >= 0
		else
		{ fatalError("Expected a nonnegative integer, but got \(i).") }
		var ·digitSeq·i = XSD.·digitSeq·(i)
		let ·lastSignificantDigit·digitRemainderSeq·i = XSD.·lastSignificantDigit·(XSD.·digitRemainderSeq·(i))
		var result: Array <String> = []
		result.reserveCapacity(Int(·lastSignificantDigit·digitRemainderSeq·i))
		for _ in 0...·lastSignificantDigit·digitRemainderSeq·i
		{ result += CollectionOfOne(XSD._·digit·.toString(·digitSeq·i.next()!)) }
		return result.reversed().joined()
	})
	static var ·unsignedNoDecimalPtCanonicalMap·: (XSD.Integer) -> XSD.unsignedNoDecimalPtNumeral

	/// Maps an `XSD.Integer` to a `XSD.noDecimalPtNumeral`, its canonical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-noDecCanMap>
	@XSD.CanonicalMapping({ i in i < 0 ? "-" + XSD._·unsignedNoDecimalPtCanonicalMap·.toString(-i) : XSD._·unsignedNoDecimalPtCanonicalMap·.toString(i) })
	static var ·noDecimalPtCanonicalMap·: (XSD.Integer) -> XSD.noDecimalPtNumeral

	/// Maps a nonnegative `XSD.DecimalNumber` to an `XSD.unsignedDecimalPtNumeral`, its canonical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsDecCanFragMap>
	@XSD.CanonicalMapping({ n in
		guard n >= 0
		else
		{ fatalError("Expected a nonnegative decimal number, but got \(n).") }
		return XSD._·unsignedNoDecimalPtCanonicalMap·.toString(XSD.·div·(n, 1)) + "." + XSD._·fractionDigitsCanonicalFragmentMap·.toString(XSD.·mod·(n, 1))
	})
	static var ·unsignedDecimalPtCanonicalMap·: (XSD.DecimalNumber) -> XSD.unsignedDecimalPtNumeral

	/// Maps a `XSD.DecimalNumber` to a `XSD.decimalPtNumeral`, its canonical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-decCanFragMap>
	@XSD.CanonicalMapping({ n in n < 0 ? "-" + XSD._·unsignedDecimalPtCanonicalMap·.toString(-n) : XSD._·unsignedDecimalPtCanonicalMap·.toString(n) })
	static var ·decimalPtCanonicalMap·: (XSD.DecimalNumber) -> XSD.decimalPtNumeral


	/// Maps a nonnegative `XSD.DecimalNumber` to a `XSD.unsignedScientificNotationNumeral`, its canonical
	///   representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsSciCanFragMap>
	///
	///  +  note:
	///     Nib’s implementation of this function “cheats” and gets the length of the (decimal) string representation of the significand to calculate `log(n) div 1`.
	///     Swift does not have a general `log10` available for use with nonbinary decimal numbers.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsSciCanFragMap>
	@XSD.CanonicalMapping({ n in
		guard n >= 0
		else
		{ fatalError("Expected a nonnegative decimal number, but got \(n).") }
		let ·div·（log·n），1 = Int16(
			String(
				describing: n.significand
			).count + n.exponent - 1
		)
		return XSD._·unsignedDecimalPtCanonicalMap·.toString(
			(n as NSDecimalNumber).multiplying(
				byPowerOf10: -·div·（log·n），1
			) as XSD.DecimalNumber
		) + "E" + XSD._·noDecimalPtCanonicalMap·.toString(XSD.Integer(·div·（log·n），1))
	})
	static var ·unsignedScientificCanonicalMap·: (XSD.DecimalNumber) -> XSD.unsignedScientificNotationNumeral

	/// Maps a `XSD.DecimalNumber` to a `XSD.scientificNotationNumeral`, its canonical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-sciCanFragMap>
	@XSD.CanonicalMapping({ i in i < 0 ? "-" + XSD._·unsignedScientificCanonicalMap·.toString(-i) : XSD._·unsignedScientificCanonicalMap·.toString(i) })
	static var ·scientificCanonicalMap·: (XSD.DecimalNumber) -> XSD.scientificNotationNumeral

	/// Maps the `XSD.SpecialValue`s used with some numeric datatypes (one of `.positiveInfinity`, `.negativeInfinity`, or `.notANumber`) to a `XSD.numericalSpecialRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-specValCanMap>
	@XSD.CanonicalMapping({ c in
		switch c {
		case .negativeInfinity:
			return "-INF"
		case .positiveInfinity:
			return "INF"
		case .notANumber:
			return "NaN"
		default:
			fatalError("Expected one of positiveInfinity, negativeInfinity, or notANumber, but got \(c).")
		}
	})
	static var ·specialRepCanonicalMap·: (XSD.SpecialValue) -> XSD.numericalSpecialRep

	/// Maps a `XSD.DecimalValue` to its canonical representation, a `XSD.decimalLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-decimalCanmap>
	@XSD.CanonicalMapping({ d in
		if let integer = d.integer
		{ return XSD._·noDecimalPtCanonicalMap·.toString(integer) }
		else
		{ return XSD._·decimalPtCanonicalMap·.toString(d.decimalNumber.unsafelyUnwrapped) }
	})
	static var ·decimalCanonicalMap·: (XSD.DecimalValue) -> XSD.decimalLexicalRep

	/// Maps a `XSD.FloatValue` to its canonical representation, a `XSD.floatRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-floatCanmap>
	///
	///  +  note:
	///     This implementation cheats a bit, letting Swift determine the proper float approximation in its conversion to a `XSD.DecimalNumber`.
	@XSD.CanonicalMapping({ f in
		if let specialValue = f.specialValue {
			switch specialValue {
			case .positiveInfinity, .negativeInfinity, .notANumber:
				return XSD._·specialRepCanonicalMap·.toString(specialValue)
			case .positiveZero:
				return "0.0E0"
			case .negativeZero:
				return "-0.0E0"
			}
		} else
		{ return XSD._·scientificCanonicalMap·.toString(f.decimalNumber.unsafelyUnwrapped) }
	})
	static var ·floatCanonicalMap·: (XSD.FloatValue) -> XSD.floatRep

	/// Maps a `XSD.DoubleValue` to its canonical representation, a `XSD.doubleRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-doubleCanmap>
	///
	///  +  note:
	///     This implementation cheats a bit, letting Swift determine the proper float approximation in its conversion to a `XSD.DecimalNumber`.
	@XSD.CanonicalMapping({ f in
		if let specialValue = f.specialValue {
			switch specialValue {
			case .positiveInfinity, .negativeInfinity, .notANumber:
				return XSD._·specialRepCanonicalMap·.toString(specialValue)
			case .positiveZero:
				return "0.0E0"
			case .negativeZero:
				return "-0.0E0"
			}
		} else
		{ return XSD._·scientificCanonicalMap·.toString(f.decimalNumber.unsafelyUnwrapped) }
	})
	static var ·doubleCanonicalMap·: (XSD.DoubleValue) -> XSD.doubleRep

	/// Maps a nonnegative `XSD.Integer`, presumably the absolute value of the `·months·` of a `XSD.DurationValue`, to a `XSD.duYearMonthFrag`, a fragment of a `XSD.DurationValue` lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duYMCan>
	@XSD.CanonicalMapping({ ym in
		guard ym >= 0
		else
		{ fatalError("Expected a nonnegative integer, but got \(ym).") }
		let y = XSD.·div·(ym, 12)
		let m = XSD.·mod·(ym, 12)
		return y != 0 && m != 0 ? XSD._·unsignedNoDecimalPtCanonicalMap·.toString(y) + "Y" + XSD._·unsignedNoDecimalPtCanonicalMap·.toString(m) + "M" : y != 0 && m == 0 ? XSD._·unsignedNoDecimalPtCanonicalMap·.toString(y) + "Y" : XSD._·unsignedNoDecimalPtCanonicalMap·.toString(m) + "M"
	})
	static var ·duYearMonthCanonicalFragmentMap·: (XSD.Integer) -> XSD.duYearMonthFrag

	/// Maps a nonnegative `XSD.Integer`, presumably the day normalized value from the `·seconds·` of a `XSD.DurationValue`, to a `XSD.duDayFrag`, a fragment of a `XSD.DurationValue` lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duDCan>
	@XSD.CanonicalMapping({ d in
		if d < 0
		{ fatalError("Expected a nonnegative integer, but got \(d).") }
		else
		{ return d != 0 ? XSD._·unsignedNoDecimalPtCanonicalMap·.toString(d) + "D" : "" }
	})
	static var ·duDayCanonicalFragmentMap·: (XSD.Integer) -> XSD.duDayFrag

	/// Maps a nonnegative `XSD.Integer`, presumably the hour normalized value from the `·seconds·` of a `XSD.DurationValue`, to a `XSD.duHourFrag`, a fragment of a `XSD.DurationValue` lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duHCan>
	@XSD.CanonicalMapping({ h in
		if h < 0
		{ fatalError("Expected a nonnegative integer, but got \(h).") }
		else
		{ return h != 0 ? XSD._·unsignedNoDecimalPtCanonicalMap·.toString(h) + "H" : "" }
	})
	static var ·duHourCanonicalFragmentMap·: (XSD.Integer) -> XSD.duHourFrag

	/// Maps a nonnegative `XSD.Integer`, presumably the minute normalized value from the `·seconds·` of a `XSD.DurationValue`, to a `XSD.duMinuteFrag`, a fragment of a `XSD.DurationValue` lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duMCan>
	@XSD.CanonicalMapping({ m in
		if m < 0
		{ fatalError("Expected a nonnegative integer, but got \(m).") }
		else
		{ return m != 0 ? XSD._·unsignedNoDecimalPtCanonicalMap·.toString(m) + "M" : "" }
	})
	static var ·duMinuteCanonicalFragmentMap·: (XSD.Integer) -> XSD.duMinuteFrag

	/// Maps a nonnegative `XSD.DecimalNumber`, presumably the second normalized value from the `·seconds·` of a `XSD.DurationValue`, to a `XSD.duSecondFrag`, a fragment of a `XSD.DurationValue` lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duSCan>
	@XSD.CanonicalMapping({ s in
		if s < 0
		{ fatalError("Expected a nonnegative decimal number, but got \(s).") }
		else if s != 0 {
			if let integer = XSD.Integer(
				exactly: s as NSNumber
			) { return XSD._·unsignedNoDecimalPtCanonicalMap·.toString(integer) + "S" }
			else
			{ return XSD._·unsignedDecimalPtCanonicalMap·.toString(s) + "S" }
		} else
		{ return "" }
	})
	static var ·duSecondCanonicalFragmentMap·: (XSD.DecimalNumber) -> XSD.duSecondFrag

	/// Maps three nonnegative `XSD.Number`s, presumably the hour, minute, and second normalized values from the `·seconds·` of a `XSD.DurationValue`, to a `XSD.duTimeFrag`, a fragment of a `XSD.DurationValue` lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duTCan>
	@XSD.CanonicalMapping({ (h, m, s) in
		guard
			h >= 0,
			m >= 0,
			s >= 0
		else
		{ fatalError("Expected three nonnegative numbers, but got (\(h), \(m), \(s)).") }
		return h != 0 || m != 0 || s != 0 ? "T" + XSD._·duHourCanonicalFragmentMap·.toString(h) + XSD._·duMinuteCanonicalFragmentMap·.toString(m) + XSD._·duSecondCanonicalFragmentMap·.toString(s) : ""
	})
	static var ·duTimeCanonicalFragmentMap·: ((XSD.Integer, XSD.Integer, XSD.DecimalNumber)) -> XSD.duTimeFrag


	/// Maps a nonnegative `XSD.DecimalNumber`, presumably the absolute value of the `·seconds·` of a `XSD.DurationValue`, to a `XSD.duDayTimeFrag`, a fragment of a `XSD.DurationValue` lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duDTCan>
	@XSD.CanonicalMapping({ ss in
		guard ss >= 0
		else
		{ fatalError("Expected a nonnegative decimal number, but got \(ss).") }
		let d = XSD.·div·(ss, 86400)
		let h = XSD.·div·(XSD.·mod·(ss, 86400), 3600)
		let m = XSD.·div·(XSD.·mod·(ss, 3600), 60)
		let s = XSD.·mod·(ss, 60)
		return ss != 0 ? XSD._·duDayCanonicalFragmentMap·.toString(d) + XSD._·duTimeCanonicalFragmentMap·.toString((h, m, s)) : "T0S"
	})
	static var ·duDayTimeCanonicalFragmentMap·: (XSD.DecimalNumber) -> XSD.duDayTimeFrag

	/// Maps a `XSD.DurationValue`’s property values to `XSD.durationLexicalRep` fragments and combines the fragments into a complete `XSD.durationLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-durationCanMap>
	@XSD.CanonicalMapping({ v in
		let m = v.·months·
		let s = v.·seconds·
		let sgn = m < 0 || s < 0 ? "-" : ""
		return m != 0 && s != 0 ? sgn + "P" + XSD._·duYearMonthCanonicalFragmentMap·.toString(abs(m)) + XSD._·duDayTimeCanonicalFragmentMap·.toString(abs(s)) : m != 0 && s == 0 ? sgn + "P" + XSD._·duYearMonthCanonicalFragmentMap·.toString(abs(m)) : sgn + "P" + XSD._·duDayTimeCanonicalFragmentMap·.toString(abs(s))
	})
	static var ·durationCanonicalMap·: (XSD.DurationValue) -> XSD.durationLexicalRep

	/// Maps a `XSD.DurationValue`’s `·months·` value to a `XSD.yearMonthDurationLexicalRep`.
	///
	/// `XSD.yearMonthDurationCanonicalMap` is a restriction of `XSD.durationCanonicalMap`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-yearMonthDurationCanMap>
	@XSD.CanonicalMapping({ ym in
		let m = ym.·months·
		let sgn = m < 0 ? "-" : ""
		return sgn + "P" + XSD._·duYearMonthCanonicalFragmentMap·.toString(abs(m))
	})
	static var ·yearMonthDurationCanonicalMap·: (XSD.DurationValue) -> XSD.yearMonthDurationLexicalRep

	/// Maps a `XSD.DurationValue`’s `·seconds·` value to a `XSD.dayTimeDurationLexicalRep`.
	///
	/// `XSD.·dayTimeDurationCanonicalMap·` is a restriction of
	///   `XSD.·durationCanonicalMap·`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dayTimeDurationCanMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly calls `XSD.·duYearMonthCanonicalFragmentMap·` instead of `XSD.·duDayTimeCanonicalFragmentMap·` in its provided algorithm.
	///     Nib gives the correct implementation.
	@XSD.CanonicalMapping({ dt in
		let s = dt.·seconds·
		let sgn = s < 0 ? "-" : ""
		return sgn + "P" + XSD._·duDayTimeCanonicalFragmentMap·.toString(abs(s))
	})
	static var ·dayTimeDurationCanonicalMap·: (XSD.DurationValue) -> XSD.dayTimeDurationLexicalRep

	/// Maps a nonnegative `XSD.Integer` less than 100 onto an `XSD.unsignedNoDecimalPtNumeral` which is always two digits.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsTwoDigCanFragMap>
	@XSD.CanonicalMapping({ i in
		if i >= 0 && i < 100
		{ return XSD._·digit·.toString(XSD.·div·(i, 10)) + XSD._·digit·.toString(XSD.·mod·(i, 10)) }
		else
		{ fatalError("Expected a nonnegative integer less than 100, but got \(i).") }
	})
	static var ·unsTwoDigitCanonicalFragmentMap·: (XSD.Integer) -> XSD.unsignedNoDecimalPtNumeral

	/// Maps an `XSD.Integer` between -10000 and 10000 onto an `XSD.noDecimalPtNumeral` which is always four digits.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fourDigCanFragMap>
	@XSD.CanonicalMapping({ i in
		if abs(i) <= 10000
		{ return i < 0 ? "-" + XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·div·(-i, 100)) + XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·mod·(-i, 100)) : XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·div·(i, 100)) + XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·mod·(i, 100)) }
		else
		{ fatalError("Expected an integer whose absolute value is less than 10000, but got \(i).") }
	})
	static var ·fourDigitCanonicalFragmentMap·: (XSD.Integer) -> XSD.noDecimalPtNumeral

	/// Maps an `XSD.Integer`, presumably the `·year·` property of a `XSDDate·timeSevenPropertyValue`, onto a `XSD.yearFrag`, part of a `XSDDate·timeSevenPropertyValue`’s lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-yrCanFragMap>
	@XSD.CanonicalMapping({ y in abs(y) > 9999 ? XSD._·noDecimalPtCanonicalMap·.toString(y) : XSD._·fourDigitCanonicalFragmentMap·.toString(y) })
	static var ·yearCanonicalFragmentMap·: (XSD.Integer) -> XSD.yearFrag


	/// Maps an `XSD.Integer` between 1 and 12 inclusive, presumably the `·month·` property of a `XSDDate·timeSevenPropertyValue`, onto a `XSD.monthFrag`, part of a `XSDDate·timeSevenPropertyValue`’s lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-moCanFragMap>
	@XSD.CanonicalMapping({ m in
		if m >= 1 && m <= 12
		{ return XSD._·unsTwoDigitCanonicalFragmentMap·.toString(m) }
		else
		{ fatalError("Expected an integer between 1 and 12 inclusive, but got \(m).") }
	})
	static var ·monthCanonicalFragmentMap·: (XSD.Integer) -> XSD.monthFrag

	/// Maps an `XSD.Integer` between 1 and 31 inclusive, presumably the `·day·` property of a `XSDDate·timeSevenPropertyValue`, onto a `XSD.dayFrag`, part of a `XSDDate·timeSevenPropertyValue`’s lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-daCanFragMap>
	@XSD.CanonicalMapping({ d in
		if d >= 1 && d <= 31
		{ return XSD._·unsTwoDigitCanonicalFragmentMap·.toString(d) }
		else
		{ fatalError("Expected an integer between 1 and 31 inclusive, but got \(d).") }
	})
	static var ·dayCanonicalFragmentMap·: (XSD.Integer) -> XSD.dayFrag

	/// Maps an `XSD.Integer` between 0 and 23 inclusive, presumably the `·hour·` property of a `XSDDate·timeSevenPropertyValue`, onto a `XSD.hourFrag`, part of a `XSDDate·timeSevenPropertyValue`’s lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hrCanFragMap>
	@XSD.CanonicalMapping({ h in
		if h >= 0 && h <= 23
		{ return XSD._·unsTwoDigitCanonicalFragmentMap·.toString(h) }
		else
		{ fatalError("Expected an integer between 0 and 23 inclusive, but got \(h).") }
	})
	static var ·hourCanonicalFragmentMap·: (XSD.Integer) -> XSD.hourFrag

	/// Maps an `XSD.Integer` between 0 and 59 inclusive, presumably the `·minute·` property of a `XSDDate·timeSevenPropertyValue`, onto a `XSD.minuteFrag`, part of a `XSDDate·timeSevenPropertyValue`’s lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-miCanFragMap>
	@XSD.CanonicalMapping({ m in
		if m >= 0 && m <= 59
		{ return XSD._·unsTwoDigitCanonicalFragmentMap·.toString(m) }
		else
		{ fatalError("Expected an integer between 0 and 59 inclusive, but got \(m).") }
	})
	static var ·minuteCanonicalFragmentMap·: (XSD.Integer) -> XSD.minuteFrag

	/// Maps a nonnegative `XSD.Integer` less than 60, presumably the `·second·` property of a `XSDDate·timeSevenPropertyValue`, onto a `XSD.secondFrag`, part of a `XSDDate·timeSevenPropertyValue`’s lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-seCanFragMap>
	///
	///  +  note:
	///     The XSD specification incorrectly specifies `s` as being less than 70; only values less than 60 can be used with Nib.
	@XSD.CanonicalMapping({ s in
		if s >= 0 && s < 60 {
			if let integer = XSD.Integer(
				exactly: s as NSDecimalNumber
			) { return XSD._·unsTwoDigitCanonicalFragmentMap·.toString(integer) }
			else
			{ return XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·div·(s, 1)) + "." + XSD._·fractionDigitsCanonicalFragmentMap·.toString(XSD.·mod·(s, 1)) }
		}
		else
		{ fatalError("Expected a nonnegative decimal number less than 60, but got \(s).") }
	})
	static var ·secondCanonicalFragmentMap·: (XSD.DecimalNumber) -> XSD.secondFrag

	/// Maps an `XSD.Integer` between -840 and 840 inclusive, presumably the `·timezoneOffset·` property of a `XSDDate·timeSevenPropertyValue`, onto a `XSD.timezoneFrag`, part of a `XSDDate·timeSevenPropertyValue`’s lexical representation.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-tzCanFragMap>
	@XSD.CanonicalMapping({ t in
		if t >= -840 && t <= 840
		{ return t == 0 ? "Z" : t < 0 ? "-" + XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·div·(-t, 60)) + ":" + XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·mod·(-t, 60)) : "+" + XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·div·(t, 60)) + ":" + XSD._·unsTwoDigitCanonicalFragmentMap·.toString(XSD.·mod·(t, 60)) }
		else
		{ fatalError("Expected an integer between -840 and 840 inclusive, but got \(t).") }
	})
	static var ·timezoneCanonicalFragmentMap·: (XSD.Integer) -> XSD.timezoneFrag

	/// Maps a `XSD.DateTimeValue` to a `XSD.dateTimeLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dateTimeCanRep>
	@XSD.CanonicalMapping({ dt in
		let DT = XSD._·yearCanonicalFragmentMap·.toString(dt.·year·.unsafelyUnwrapped) + "-" + XSD._·monthCanonicalFragmentMap·.toString(dt.·month·.unsafelyUnwrapped) + "-" + XSD._·dayCanonicalFragmentMap·.toString(dt.·day·.unsafelyUnwrapped) + "T" + XSD._·hourCanonicalFragmentMap·.toString(dt.·hour·.unsafelyUnwrapped) + ":" + XSD._·minuteCanonicalFragmentMap·.toString(dt.·minute·.unsafelyUnwrapped) + ":" + XSD._·secondCanonicalFragmentMap·.toString(dt.·second·.unsafelyUnwrapped)
		if let tz = dt.·timezoneOffset·
		{ return DT + XSD._·timezoneCanonicalFragmentMap·.toString(tz) }
		else
		{ return DT }
	})
	static var ·dateTimeCanonicalMap·: (XSD.DateTimeValue) -> XSD.dateTimeLexicalRep

	/// Maps a `XSD.TimeValue` to a `XSD.timeLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-timeCanRep>
	@XSD.CanonicalMapping({ ti in
		let T = XSD._·hourCanonicalFragmentMap·.toString(ti.·hour·.unsafelyUnwrapped) + ":" + XSD._·minuteCanonicalFragmentMap·.toString(ti.·minute·.unsafelyUnwrapped) + ":" + XSD._·secondCanonicalFragmentMap·.toString(ti.·second·.unsafelyUnwrapped)
		if let tz = ti.·timezoneOffset·
		{ return T + XSD._·timezoneCanonicalFragmentMap·.toString(tz) }
		else { return T }
	})
	static var ·timeCanonicalMap·: (XSD.TimeValue) -> XSD.timeLexicalRep

	/// Maps a `XSD.DateValue` to a `XSD.dateLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dateCanRep>
	@XSD.CanonicalMapping({ da in
		let D = XSD._·yearCanonicalFragmentMap·.toString(da.·year·.unsafelyUnwrapped) + "-" + XSD._·monthCanonicalFragmentMap·.toString(da.·month·.unsafelyUnwrapped) + "-" + XSD._·dayCanonicalFragmentMap·.toString(da.·day·.unsafelyUnwrapped)
		if let tz = da.·timezoneOffset·
		{ return D + XSD._·timezoneCanonicalFragmentMap·.toString(tz) }
		else
		{ return D }
	})
	static var ·dateCanonicalMap·: (XSD.DateValue) -> XSD.dateLexicalRep

	/// Maps a `XSD.GYearMonthValue` to a `XSD.gYearMonthLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gYearMonthCanRep>
	@XSD.CanonicalMapping({ ym in
		let YM = XSD._·yearCanonicalFragmentMap·.toString(ym.·year·.unsafelyUnwrapped) + "-" + XSD._·monthCanonicalFragmentMap·.toString(ym.·month·.unsafelyUnwrapped)
		if let tz = ym.·timezoneOffset·
		{ return YM + XSD._·timezoneCanonicalFragmentMap·.toString(tz) }
		else
		{ return YM }
	})
	static var ·gYearMonthCanonicalMap·: (XSD.GYearMonthValue) -> XSD.gYearMonthLexicalRep

	/// Maps a `XSD.GYearValue` to a `XSD.gYearLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gYearCanRep>
	@XSD.CanonicalMapping({ gY in
		if let tz = gY.·timezoneOffset·
		{ return XSD._·yearCanonicalFragmentMap·.toString(gY.·year·.unsafelyUnwrapped) + XSD._·timezoneCanonicalFragmentMap·.toString(tz) }
		else
		{ return XSD._·yearCanonicalFragmentMap·.toString(gY.·year·.unsafelyUnwrapped) }
	})
	static var ·gYearCanonicalMap·: (XSD.GYearValue) -> XSD.gYearLexicalRep

	/// Maps a `XSD.GMonthDayValue` to a `XSD.gMonthDayLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gMonthDayCanRep>
	@XSD.CanonicalMapping({ md in
		let MD = "--" + XSD._·monthCanonicalFragmentMap·.toString(md.·month·.unsafelyUnwrapped) + "-" + XSD._·dayCanonicalFragmentMap·.toString(md.·day·.unsafelyUnwrapped)
		if let tz = md.·timezoneOffset·
		{ return MD + XSD._·timezoneCanonicalFragmentMap·.toString(tz) }
		else
		{ return MD }
	})
	static var ·gMonthDayCanonicalMap·: (XSD.GMonthDayValue) -> XSD.gMonthDayLexicalRep

	/// Maps a `XSD.GDayValue` to a `XSD.gDayLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gDayCanRep>
	@XSD.CanonicalMapping({ gD in
		if let tz = gD.·timezoneOffset·
		{ return "---" + XSD._·dayCanonicalFragmentMap·.toString(gD.·day·.unsafelyUnwrapped) + XSD._·timezoneCanonicalFragmentMap·.toString(tz) }
		else
		{ return "---" + XSD._·dayCanonicalFragmentMap·.toString(gD.·day·.unsafelyUnwrapped) }
	})
	static var ·gDayCanonicalMap·: (XSD.GDayValue) -> XSD.gDayLexicalRep

	/// Maps a `XSD.GMonthValue` to a `XSD.gMonthLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gMonthCanRep>
	@XSD.CanonicalMapping({ gM in
		if let tz = gM.·timezoneOffset·
		{ return "--" + XSD._·monthCanonicalFragmentMap·.toString(gM.·month·.unsafelyUnwrapped) + XSD._·timezoneCanonicalFragmentMap·.toString(tz) }
		else
		{ return "--" + XSD._·monthCanonicalFragmentMap·.toString(gM.·month·.unsafelyUnwrapped) }
	})
	static var ·gMonthCanonicalMap·: (XSD.GMonthValue) -> XSD.gMonthLexicalRep

	/// Maps a `XSD.StringValue` to a `XSD.stringRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-stringCanmap>
	@XSD.CanonicalMapping({ s in s.description })
	static var ·stringCanonicalMap·: (XSD.StringValue) -> XSD.stringRep

	/// Maps a `XSD.BooleanValue` (`b`) to a `XSD.booleanRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-booleanCanmap>
	@XSD.CanonicalMapping({ b in b.rawValue })
	static var ·booleanCanonicalMap·: (XSD.BooleanValue) -> XSD.booleanRep

	/// Maps a `XSD.HexBinaryValue` to a `XSD.hexBinaryRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexBinaryCanonical>
	@XSD.CanonicalMapping({ o in
		let h = o.octets.map
		{ XSD._·hexOctetCanonical·.toString($0) }
		return h.joined()
	})
	static var ·hexBinaryCanonical·: (XSD.HexBinaryValue) -> XSD.hexBinaryRep

	/// Maps a `XSD.BinaryOctet` to a `XSD.hexOctet`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexOctetCanonical>
	@XSD.CanonicalMapping({ o in
		let lo: XSD.Sequence <XSD.BinaryDigit> = sequence(
			state: 0 as UInt8
		) { state in
			let nextState = state as! UInt8 + 1
			guard nextState < 5
			else
			{ return nil }
			state = nextState
			return (1 << (4 - nextState)) & o == 0 ? .０ : .１
		}
		let hi: XSD.Sequence <XSD.BinaryDigit> = sequence(
			state: 0 as UInt8
		) { state in
			let nextState = state as! UInt8 + 1
			guard nextState < 5
			else
			{ return nil }
			state = nextState
			return (1 << (8 - nextState)) & o == 0 ? .０ : .１
		}
		return XSD._·hexDigitCanonical·.toString(hi) + XSD._·hexDigitCanonical·.toString(lo)
	})
	static var ·hexOctetCanonical·: (XSD.BinaryOctet) -> XSD.hexOctet

	/// Maps a `XSD.Sequence` of `XSD.BinaryDigit`s to a `XSD.hexOctet`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexDigitCanonical>
	@XSD.CanonicalMapping({ d in
		var iterator = d.makeIterator()
		if iterator.next() == .０ {
			if iterator.next() == .０ {
				if iterator.next() == .０
				{ return iterator.next() == .０ ? "0" : "1" }
				else
				{ return iterator.next() == .０ ? "2" : "3" }
			}
			else {
				if iterator.next() == .０
				{ return iterator.next() == .０ ? "4" : "5" }
				else
				{ return iterator.next() == .０ ? "6" : "7" }
			}
		} else {
			if iterator.next() == .０ {
				if iterator.next() == .０
				{ return iterator.next() == .０ ? "8" : "9" }
				else
				{ return iterator.next() == .０ ? "A" : "B" }
			}
			else {
				if iterator.next() == .０
				{ return iterator.next() == .０ ? "C" : "D" }
				else
				{ return iterator.next() == .０ ? "E" : "F" }
			}
		}
	})
	static var ·hexDigitCanonical·: (XSD.Sequence <XSD.BinaryDigit>) -> XSD.hexDigit

}
