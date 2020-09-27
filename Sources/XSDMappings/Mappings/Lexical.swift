import XSD
import XSDLiterals
import XSDValues

public extension XSD {

	/// Maps each `XSD.digit` to its numerical value, a nonnegative `XSD.Integer` less than 10.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitVal>
	@XSD.LexicalMapping({ d in
		switch d {
		case "0":
			return 0
		case "1":
			return 1
		case "2":
			return 2
		case "3":
			return 3
		case "4":
			return 4
		case "5":
			return 5
		case "6":
			return 6
		case "7":
			return 7
		case "8":
			return 8
		case "9":
			return 9
		default:
			fatalError("Expected a digit but received \"\(d)\".")
		}
	})
	static var ·digitValue·: (XSD.digit) -> XSD.Integer

	/// Maps a `XSD.Sequence` of `XSD.digit`s to the base‐10 position‐weighted sum of their numerical values, as a nonnegative `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitSeqVal>
	@XSD.LexicalSequenceMapping({ S in
		return S.reduce(
			into: 0 as XSD.Integer
		) { $0 = $0 * 10 + XSD._·digitValue·.fromSubstring($1) }
	})
	static var ·digitSequenceValue·: (XSD.Sequence <XSD.digit>) -> XSD.Integer

	/// Maps a `XSD.Sequence` of `XSD.digit`s to the inverse base‐10 position‐weighted sum of their numerical values, as a nonnegative `XSD.DecimalNumber`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fracDigitSeqVal>
	///
	///  +  note:
	///     The definition of `·fractionDigitSequenceValue·` given by the XSD Datatypes specification is incorrect; it uses “minus” instead of “times” and returns an integer when it should return a decimal number.
	///     Nib provides the correct implementation.
	@XSD.LexicalSequenceMapping({ S in
		return S.reversed().reduce(
			into: 0 as XSD.DecimalNumber
		) { result, S_i in
			result = result * XSD.DecimalNumber(
				sign: .plus,
				exponent: -1,
				significand: 1
			) + XSD.DecimalNumber(
				sign: .plus,
				exponent: -1,
				significand: XSD.DecimalNumber(XSD._·digitValue·.fromSubstring(S_i))
			)
		}
	})
	static var ·fractionDigitSequenceValue·: (XSD.Sequence <XSD.digit>) -> XSD.DecimalNumber

	/// Maps a `XSD.fracFrag` to the appropriate fractional nonnegative `XSD.DecimalNumber`.
	///
	/// `N` is necessarily the left‐to‐right concatenation of a finite `XSD.Sequence` of `XSD.digit`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fracFragVal>
	@XSD.LexicalMapping({ N in
		return XSD._·fractionDigitSequenceValue·.fromSubstring(
			sequence(
				state: N
			) { state in
				let S = state as! Substring
				let S_i = S.prefix(1)
				state = S.dropFirst()
				return S_i.count < 1 ? nil : S_i
			}
		)
	})
	static var ·fractionFragValue·: (XSD.fracFrag) -> XSD.DecimalNumber

	/// Maps an `XSD.unsignedNoDecimalPtNumeral` to its numerical value, a nonnegative `XSD.Integer`.
	///
	/// The argument is the left‐to‐right concatenation of a finite `XSD.Sequence` of `XSD.digit`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsNoDecVal>
	@XSD.LexicalMapping({ N in
		return XSD._·digitSequenceValue·.fromSubstring(
			sequence(
				state: N
			) { state in
				let S = state as! Substring
				let S_i = S.prefix(1)
				state = S.dropFirst()
				return S_i.count < 1 ? nil : S_i
			}
		)
	})
	static var ·unsignedNoDecimalMap·: (XSD.unsignedNoDecimalPtNumeral) -> XSD.Integer

	/// Maps a `XSD.noDecimalPtNumeral` to its numerical value, an `XSD.Integer`.
	///
	/// `N` necessarily consists of an optional sign (`"+"` or `"-"`) and then an `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-noDecVal>
	@XSD.LexicalMapping({ N in
		let U = N.first == "-" || N.first == "+" ? N.dropFirst() : N
		return N.first == "-" ? -1 * XSD._·unsignedNoDecimalMap·.fromSubstring(U) : XSD._·unsignedNoDecimalMap·.fromSubstring(U)
	})
	static var ·noDecimalMap·: (XSD.noDecimalPtNumeral) -> XSD.Integer

	/// Maps an `XSD.unsignedDecimalPtNumeral` to its numerical value, a nonnegative `XSD.DecimalNumber`.
	///
	/// `D` necessarily consists of an optional `XSD.Literal` matching `XSD.unsignedNoDecimalPtNumeral`, a decimal point, and then an optional `XSD.fracFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsDecVal>
	@XSD.LexicalMapping({ D in
		let parts = D.split(
			separator: ".",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if parts.count == 1 || parts[1] == "" {
			let N = parts[0]
			return XSD.DecimalNumber(XSD._·unsignedNoDecimalMap·.fromSubstring(N))
		} else if parts[0] == "" {
			let F = parts[1]
			return XSD._·fractionFragValue·.fromSubstring(F)
		} else {
			let N = parts[0]
			let F = parts[1]
			return XSD.DecimalNumber(XSD._·unsignedNoDecimalMap·.fromSubstring(N)) + XSD._·fractionFragValue·.fromSubstring(F)
		}
	})
	static var ·unsignedDecimalPtMap·: (XSD.unsignedDecimalPtNumeral) -> XSD.DecimalNumber

	/// Maps a `XSD.decimalPtNumeral` to its numerical value, a `XSD.DecimalNumber`.
	///
	/// `N` necessarily consists of an optional sign (`"+"` or `"-"`) and then an instance of `XSD.unsignedDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-decVal>
	@XSD.LexicalMapping({ N in
		let U = N.first == "-" || N.first == "+" ? N.dropFirst() : N
		return N.first == "-" ? -1 * XSD._·unsignedDecimalPtMap·.fromSubstring(U) : XSD._·unsignedDecimalPtMap·.fromSubstring(U)
	})
	static var ·decimalPtMap·: (XSD.decimalPtNumeral) -> XSD.DecimalNumber

	/// Maps a `XSD.scientificNotationNumeral` to its numerical value, a `XSD.DecimalNumber`.
	///
	/// `N` necessarily consists of an instance of either `XSD.noDecimalPtNumeral` or `XSD.decimalPtNumeral`, either an `"e"` or an `"E"`, and then an instance of `XSD.noDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-sciVal>
	///
	///  +  note:
	///     The definition provided by the XSD specification is incorrect; it uses `XSD.·unsignedDecimalPtMap·` to calculate exponents, rather than `XSD.·noDecimalMap·`.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ N in
		let parts = N.split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { $0 == "e" || $0 == "E" }
		let E = parts[1]
		if parts[0].contains(".") {
			let C = parts[0]
			let ·decimalPtMap·C = XSD._·decimalPtMap·.fromSubstring(C)
			return XSD.DecimalNumber(
				sign: ·decimalPtMap·C.sign,
				exponent: Int(XSD._·noDecimalMap·.fromSubstring(E)),
				significand: ·decimalPtMap·C.magnitude
			)
		} else {
			let C = parts[0]
			let ·noDecimalMap·C = XSD._·noDecimalMap·.fromSubstring(C)
			return XSD.DecimalNumber(
				sign: ·noDecimalMap·C < 0 ? .minus : .plus,
				exponent: Int(XSD._·noDecimalMap·.fromSubstring(E)),
				significand: XSD.DecimalNumber(·noDecimalMap·C.magnitude)
			)
		}
	})
	static var ·scientificMap·: (XSD.scientificNotationNumeral) -> XSD.DecimalNumber

	/// Maps the lexical representations of `XSD.SpecialValue`s used with some numerical datatypes (one of `.positiveInfinity`, `.negativeInfinity`, or `.notANumber`) to those `XSD.SpecialValue`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-specRepVal>
	@XSD.LexicalMapping({ S in
		switch S {
		case "INF", "+INF":
			return .positiveInfinity
		case "-INF":
			return .negativeInfinity
		case "NaN":
			return .notANumber
		default:
			fatalError("Expected the lexical representation of a special value, but got \(S).")
		}
	})
	static var ·specialRepValue·: (XSD.numericalSpecialRep) -> XSD.SpecialValue

	/// Maps a `XSD.decimalLexicalRep` onto a `XSD.DecimalValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-decimalLexmap>
	@XSD.LexicalMapping({ LEX in
		let d: XSD.DecimalNumber
		if XSD.noDecimalPtNumeral.·lexicalSpace·.·matches·(LEX)
		{ d = XSD.DecimalNumber(XSD._·noDecimalMap·.fromSubstring(LEX)) }
		else
		{ d = XSD._·decimalPtMap·.fromSubstring(LEX) }
		return XSD.DecimalValue(exactly: d)!
	})
	static var ·decimalLexicalMap·: (XSD.decimalLexicalRep) -> XSD.DecimalValue

	/// Maps a `XSD.floatRep` onto a `XSD.FloatValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-floatLexmap>
	@XSD.LexicalMapping({ LEX in
		if XSD.numericalSpecialRep.·lexicalSpace·.·matches·(LEX) {
			return XSD.FloatValue(
				truncating: XSD._·specialRepValue·.fromSubstring(LEX)
			)
		} else {
			let nV: XSD.DecimalNumber
			if XSD.noDecimalPtNumeral.·lexicalSpace·.·matches·(LEX)
			{ nV = XSD.DecimalNumber(XSD._·noDecimalMap·.fromSubstring(LEX)) }
			else if XSD.decimalPtNumeral.·lexicalSpace·.·matches·(LEX)
			{ nV = XSD._·decimalPtMap·.fromSubstring(LEX) }
			else
			{ nV = XSD._·scientificMap·.fromSubstring(LEX) }
			if nV == 0
			{ return LEX.first == "-" ? -0.0 : 0.0 }
			else {
				return XSD.FloatValue(
					truncating: nV
				)
			}
		}
	})
	static var ·floatLexicalMap·: (XSD.floatRep) -> XSD.FloatValue

	/// Maps a `XSD.doubleRep` onto a `XSD.DoubleValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-doubleLexmap>
	@XSD.LexicalMapping({ LEX in
		if XSD.numericalSpecialRep.·lexicalSpace·.·matches·(LEX) {
			return XSD.DoubleValue(
				truncating: XSD._·specialRepValue·.fromSubstring(LEX)
			)
		} else {
			let nV: XSD.DecimalNumber
			if XSD.noDecimalPtNumeral.·lexicalSpace·.·matches·(LEX)
			{ nV = XSD.DecimalNumber(XSD._·noDecimalMap·.fromSubstring(LEX)) }
			else if XSD.decimalPtNumeral.·lexicalSpace·.·matches·(LEX)
			{ nV = XSD._·decimalPtMap·.fromSubstring(LEX) }
			else
			{ nV = XSD._·scientificMap·.fromSubstring(LEX) }
			if nV == 0
			{ return LEX.first == "-" ? -0.0 : 0.0 }
			else {
				return XSD.DoubleValue(
					truncating: nV
				)
			}
		}
	})
	static var ·doubleLexicalMap·: (XSD.doubleRep) -> XSD.DoubleValue

	/// Maps a `XSD.duYearFrag` to a nonnegative `XSD.Integer`, to be used when calculating the `·months·` of a `XSD.DurationValue`.
	///
	/// The argument is necessarily the letter `"Y"` preceded by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duYrMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that the argument consists  of the letter `"Y"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as preceding.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ Y in
		let N = Y.dropLast()
		return XSD._·noDecimalMap·.fromSubstring(N)
	})
	static var ·duYearFragmentMap·: (XSD.duYearFrag) -> XSD.Integer

	/// Maps a `XSD.duMonthFrag` to a nonnegative `XSD.Integer`, to be used when calculating the `·months·` of a `XSD.DurationValue`.
	///
	/// The argument is necessarily the letter `"M"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duMoMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that the argument consists of the letter `"M"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as preceding.
	///     Nib provides the correct implementation.
	///
	///  +  note:
	///     The XSD Specification improperly defines the argument as being a `XSD.duYearFrag`.
	///     This has no impact on the underlying algorithm, which properly assumes a `XSD.duMonthFrag` instead.
	@XSD.LexicalMapping({ M in
		let N = M.dropLast()
		return XSD._·noDecimalMap·.fromSubstring(N)
	})
	static var ·duMonthFragmentMap·: (XSD.duMonthFrag) -> XSD.Integer

	/// Maps a `XSD.duDayFrag` to a nonnegative `XSD.Integer`, to be used when calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	/// The argument is necessarily the letter `"D"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duDaMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that the argument consists of the letter `"D"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as preceding.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ D in
		let N = D.dropLast()
		return XSD._·noDecimalMap·.fromSubstring(N)
	})
	static var ·duDayFragmentMap·: (XSD.duDayFrag) -> XSD.Integer

	/// Maps a `XSD.duHourFrag` to a nonnegative `XSD.Integer`, to be used when calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	/// The argument is necessarily the letter `"H"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duHrMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly expects an argument prefixed with a `"D"` instead of an argument followed by `"H"`, as described by the grammar.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ H in
		let N = H.dropLast()
		return XSD._·noDecimalMap·.fromSubstring(N)
	})
	static var ·duHourFragmentMap·: (XSD.duHourFrag) -> XSD.Integer

	/// Maps a `XSD.duMinuteFrag` to a nonnegative `XSD.Integer`, to be used when calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	/// The argument is necessarily the letter `"M"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duMiMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that the argument consists of the letter `"M"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as preceding.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ M in
		let N = M.dropLast()
		return XSD._·noDecimalMap·.fromSubstring(N)
	})
	static var ·duMinuteFragmentMap·: (XSD.duMinuteFrag) -> XSD.Integer

	/// Maps a `XSD.duSecondFrag` to a nonnegative `XSD.DecimalNumber`, to be used when calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	/// The argument is necessarily the letter `"S"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duSeMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that the argument consists of the letter `"S"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as preceding.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ S in
		let N = S.dropLast()
		if N.contains(".")
		{ return XSD._·decimalPtMap·.fromSubstring(N) }
		else
		{ return XSD.DecimalNumber(XSD._·noDecimalMap·.fromSubstring(N)) }
	})
	static var ·duSecondFragmentMap·: (XSD.duSecondFrag) -> XSD.DecimalNumber

	/// Maps a `XSD.duYearMonthFrag` into a nonnegative `XSD.Integer`, to be used when calculating the `·months·` of a `XSD.DurationValue`.
	///
	/// The input necessarily consists of an instance of `XSD.duYearFrag` and/or an instance of `XSD.duMonthFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duYMMap>
	@XSD.LexicalMapping({ YM in
		let y: XSD.Integer
		let m: XSD.Integer
		let Array·Y，M = YM.split(
			separator: "Y",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if Array·Y，M.count == 2 {
			y = XSD._·duYearFragmentMap·.fromSubstring(YM[YM.startIndex..<Array·Y，M[1].startIndex])
			m = Array·Y，M[1] == "" ? 0 : XSD._·duMonthFragmentMap·.fromSubstring(Array·Y，M[1])
		} else {
			y = 0
			m = XSD._·duMonthFragmentMap·.fromSubstring(YM)
		}
		return 12 * y + m
	})
	static var ·duYearMonthFragmentMap·: (XSD.duYearMonthFrag) -> XSD.Integer

	/// Maps a `XSD.duTimeFrag` into a nonnegative `XSD.DecimalNumber`, to be used when calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	/// The argument necessarily consists of an instance of `XSD.duHourFrag` and/or an instance of `XSD.duMinuteFrag` and/or an instance of `XSD.duSecondFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duTMap>
	@XSD.LexicalMapping({ T in
		let HMS = T.dropFirst()
		let MS: Substring
		let h: XSD.Integer
		let m: XSD.Integer
		let s: XSD.DecimalNumber
		let Array·H，MS = HMS.split(
			separator: "H",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if Array·H，MS.count == 2 {
			h = XSD._·duHourFragmentMap·.fromSubstring(T[HMS.startIndex..<Array·H，MS[1].startIndex])
			MS = Array·H，MS[1]
		} else {
			h = 0
			MS = Array·H，MS[0]
		}
		let Array·M，S = MS.split(
			separator: "M",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if Array·M，S.count == 2 {
			m = XSD._·duMinuteFragmentMap·.fromSubstring(MS[MS.startIndex..<Array·M，S[1].startIndex])
			s = Array·M，S[1] == "" ? 0 : XSD._·duSecondFragmentMap·.fromSubstring(Array·M，S[1])
		} else {
			m = 0
			s = MS == "" ? 0 : XSD._·duSecondFragmentMap·.fromSubstring(MS)
		}
		return 3600 * XSD.DecimalNumber(h) + 60 * XSD.DecimalNumber(m) + s
	})
	static var ·duTimeFragmentMap·: (XSD.duTimeFrag) -> XSD.DecimalNumber

	/// Maps a `XSD.duDayTimeFrag` into a nonnegative `XSD.DecimalNumber`, which is a potential value for the `·seconds·` of a `XSD.DurationValue`.
	///
	/// The argument necessarily consists of an instance of `XSD.duDayFrag` and/or an instance of `XSD.duTimeFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duDTMap>
	@XSD.LexicalMapping({ DT in
		let d: XSD.Integer
		let t: XSD.DecimalNumber
		let Array·D，T = DT.split(
			separator: "T",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if Array·D，T.count == 2 {
			d = Array·D，T[0] == "" ? 0 : XSD._·duDayFragmentMap·.fromSubstring(Array·D，T[0])
			t = XSD._·duTimeFragmentMap·.fromSubstring(DT[Array·D，T[0].endIndex..<DT.endIndex])
		} else {
			d = XSD._·duDayFragmentMap·.fromSubstring(Array·D，T[0])
			t = 0
		}
		return 86400 * XSD.DecimalNumber(d) + t
	})
	static var ·duDayTimeFragmentMap·: (XSD.duDayTimeFrag) -> XSD.DecimalNumber

	/// Maps a `XSD.durationLexicalRep` to a `XSD.DurationValue`.
	///
	/// The argument necessarily consists of possibly a leading `"-"`, followed by `"P"` and then an instance of `XSD.duYearMonthFrag` and/or an instance of `XSD.duDayTimeFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-durationMap>
	@XSD.LexicalMapping({ DUR in
		let P = DUR.dropFirst(DUR.first == "-" ? 2 : 1)
		let m: XSD.Integer
		let s: XSD.DecimalNumber
		let Array·Y，M，D = P.split(
			maxSplits: 2,
			omittingEmptySubsequences: false
		) { $0 == "Y" || $0 == "M" }
		if Array·Y，M，D.count > 1 {
			m = XSD._·duYearMonthFragmentMap·.fromSubstring(P[P.startIndex..<Array·Y，M，D[Array·Y，M，D.count - 1].startIndex])
			s = Array·Y，M，D.last == "" ? 0 : XSD._·duDayTimeFragmentMap·.fromSubstring(Array·Y，M，D[Array·Y，M，D.count - 1])
		} else {
			m = 0
			s = XSD._·duDayTimeFragmentMap·.fromSubstring(P)
		}
		return XSD.DurationValue(
			sign: DUR.first == "-" ? .minus : .plus,
			months: m,
			seconds: s
		)
	})
	static var ·durationMap·: (XSD.durationLexicalRep) -> XSD.DurationValue

	/// Maps a `XSD.yearMonthDurationLexicalRep` to a `XSD.DurationValue` whose `·seconds·` is always 0.
	/// `XSD.·yearMonthDurationMap·` is a restriction of `XSD.·durationMap·`.
	///
	/// The argument necessarily consists of an optional leading `"-"`, followed by `"P"` and then an instance of `XSD.duYearMonthFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-yearMonthDurationMap>
	@XSD.LexicalMapping({ YM in
		let P = YM.dropFirst(YM.first == "-" ? 2 : 1)
		let m = XSD._·duYearMonthFragmentMap·.fromSubstring(P)
		return XSD.DurationValue(
			sign: YM.first == "-" ? .minus : .plus,
			months: m,
			seconds: 0
		)
	})
	static var ·yearMonthDurationMap·: (XSD.yearMonthDurationLexicalRep) -> XSD.DurationValue

	/// Maps a `XSD.dayTimeDurationLexicalRep` to a `XSD.DurationValue` whose `·months·` is always 0.
	/// `XSD.·dayTimeDurationMap·` is a restriction of `XSD.·durationMap·`.
	///
	/// The argument necessarily consists of an optional leading `"-"`, followed by `"P"` and then an instance of `XSD.duDayTimeFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dayTimeDurationMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly identifies the argument as a value, rather than a literal.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ DT in
		let P = DT.dropFirst(DT.first == "-" ? 2 : 1)
		let s = XSD._·duDayTimeFragmentMap·.fromSubstring(P)
		return XSD.DurationValue(
			sign: DT.first == "-" ? .minus : .plus,
			months: 0,
			seconds: s
		)
	})
	static var ·dayTimeDurationMap·: (XSD.dayTimeDurationLexicalRep) -> XSD.DurationValue

	/// Maps a `XSD.yearFrag`, part of a `XSDDate·timeSevenPropertyModel`’s lexical representation, onto an `XSD.Integer`, presumably the `·year·` property of a `XSDDate·timeSevenPropertyModel`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-yrMap>
	@XSD.LexicalMapping({ YR in XSD._·noDecimalMap·.fromSubstring(YR) })
	static var ·yearFragValue·: (XSD.yearFrag) -> XSD.Integer

	/// Maps a `XSD.monthFrag`, part of a `XSDDate·timeSevenPropertyModel`’s lexical representation, onto an `XSD.Integer`, presumably the `·month·` property of a `XSDDate·timeSevenPropertyModel`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-moMap>
	@XSD.LexicalMapping({ MO in XSD._·unsignedNoDecimalMap·.fromSubstring(MO) })
	static var ·monthFragValue·: (XSD.monthFrag) -> XSD.Integer

	/// Maps a `XSD.dayFrag`, part of a `XSDDate·timeSevenPropertyModel`’s lexical representation, onto an `XSD.Integer`, presumably the `·day·` property of a `XSDDate·timeSevenPropertyModel`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-daMap>
	@XSD.LexicalMapping({ DA in XSD._·unsignedNoDecimalMap·.fromSubstring(DA) })
	static var ·dayFragValue·: (XSD.dayFrag) -> XSD.Integer

	/// Maps a `XSD.hourFrag`, part of a `XSDDate·timeSevenPropertyModel`’s lexical representation, onto an `XSD.Integer`, presumably the `·hour·` property of a `XSDDate·timeSevenPropertyModel`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-hrMap>
	@XSD.LexicalMapping({ HR in XSD._·unsignedNoDecimalMap·.fromSubstring(HR) })
	static var ·hourFragValue·: (XSD.hourFrag) -> XSD.Integer

	/// Maps a `XSD.minuteFrag`, part of a `XSDDate·timeSevenPropertyModel`’s lexical representation, onto an `XSD.Integer`, presumably the `·minute·` property of a `XSDDate·timeSevenPropertyModel`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-miMap>
	@XSD.LexicalMapping({ MI in XSD._·unsignedNoDecimalMap·.fromSubstring(MI) })
	static var ·minuteFragValue·: (XSD.minuteFrag) -> XSD.Integer

	/// Maps a `XSD.secondFrag`, part of a
	///   `XSDDate·timeSevenPropertyModel`’s lexical representation,
	///   onto an `XSD.DecimalNumber`, presumably the `·second·`
	///   property of a `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  SE:
	///         A `XSD.secondFrag`.
	///
	///  +  returns:
	///     A `XSD.DecimalNumber`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-seMap>
	@XSD.LexicalMapping({ SE in SE.contains(".") ? XSD._·unsignedDecimalPtMap·.fromSubstring(SE) : XSD.DecimalNumber(XSD._·unsignedNoDecimalMap·.fromSubstring(SE)) })
	static var ·secondFragValue·: (XSD.secondFrag) -> XSD.DecimalNumber

	/// Maps a `XSD.timezoneFrag`, part of a `XSDDate·timeSevenPropertyModel`’s lexical representation, onto an `XSD.Integer`, presumably the `·timezoneOffset·` property of a `XSDDate·timeSevenPropertyModel`.
	///
	/// The argument necessarily consists of either just `"Z"`, or a sign (`"+"` or `"-"`) followed by an instance `H` of `XSD.hourFrag`, a colon, and an instance `M` of `XSD.minuteFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-tzMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly specifies using `XSD.·unsignedDecimalPtMap·` to get the hour and minute values, instead of `XSD.·unsignedNoDecimalMap·`.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ TZ in
		if TZ == "Z"
		{ return 0 }
		else {
			let Array·H，M = TZ.dropFirst().split(
				separator: ":",
				maxSplits: 1,
				omittingEmptySubsequences: false
			)
			let H = Array·H，M[0]
			let M = Array·H，M[1]
			return TZ.first == "-" ? -(XSD._·unsignedNoDecimalMap·.fromSubstring(H) * 60 + XSD._·unsignedNoDecimalMap·.fromSubstring(M)) : XSD._·unsignedNoDecimalMap·.fromSubstring(H) * 60 + XSD._·unsignedNoDecimalMap·.fromSubstring(M)
		}
	})
	static var ·timezoneFragValue·: (XSD.timezoneFrag) -> XSD.Integer

	/// Maps a `XSD.dateTimeLexicalRep` to a `XSD.DateTimeValue`.
	///
	/// The argument necessarily includes substrings that are instances of `XSD.yearFrag`, `XSD.monthFrag`, and `XSD.dayFrag`; it also contains either instances of `XSD.hourFrag`, `XSD.minuteFrag`, and `XSD.secondFrag`, or else an instance of `XSD.endOfDayFrag`; finally, it may optionally contain an instance of `XSD.timezoneFrag` (`T`).
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dateTimeLexRep>
	///
	///  +  note:
	///     The XSD Specification incorrectly names the `XSD.hourFrag` as `Y` instead of `H`.
	///     Nib provides the correct implementation.
	@XSD.LexicalMapping({ LEX in
		let Array·Y，MO，D，H，MI，S，T = LEX.dropFirst().split(
			maxSplits: 6,
			omittingEmptySubsequences: false
		) { char in
			switch char {
			case "-", "T", ":", "Z", "+":
				return true
			default:
				return false
			}
		}
		let tz = Array·Y，MO，D，H，MI，S，T.count == 7 ? XSD._·timezoneFragValue·.fromSubstring(LEX[Array·Y，MO，D，H，MI，S，T[5].endIndex..<LEX.endIndex]) : nil
		let Y = LEX[LEX.startIndex..<Array·Y，MO，D，H，MI，S，T[0].endIndex]
		let MO = Array·Y，MO，D，H，MI，S，T[1]
		let D = Array·Y，MO，D，H，MI，S，T[2]
		if Array·Y，MO，D，H，MI，S，T[3] == "24"
		{ return XSD.·newDateTime·(XSD._·yearFragValue·.fromSubstring(Y), XSD._·monthFragValue·.fromSubstring(MO), XSD._·dayFragValue·.fromSubstring(D), 24, 0, 0, tz) }
		else {
			let H = Array·Y，MO，D，H，MI，S，T[3]
			let MI = Array·Y，MO，D，H，MI，S，T[4]
			let S = Array·Y，MO，D，H，MI，S，T[5]
			return XSD.·newDateTime·(XSD._·yearFragValue·.fromSubstring(Y), XSD._·monthFragValue·.fromSubstring(MO), XSD._·dayFragValue·.fromSubstring(D), XSD._·hourFragValue·.fromSubstring(H), XSD._·minuteFragValue·.fromSubstring(MI), XSD._·secondFragValue·.fromSubstring(S), tz)
		}
	})
	static var ·dateTimeLexicalMap·: (XSD.dateTimeLexicalRep) -> XSD.DateTimeValue

	/// Maps a `XSD.timeLexicalRep` to a `XSD.TimeValue`.
	///
	/// The argument necessarily includes either substrings that are instances of `XSD.hourFrag`, `XSD.minuteFrag`, and `XSD.secondFrag`, or else an instance of `XSD.endOfDayFrag`; finally, it may optionally contain an instance of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-timeLexRep>
	@XSD.LexicalMapping({ LEX in
		let Array·H，M，S，T = LEX.split(
			maxSplits: 3,
			omittingEmptySubsequences: false
		) { char in
			switch char {
			case "-", ":", "Z", "+":
				return true
			default:
				return false
			}
		}
		let tz = Array·H，M，S，T.count == 4 ? XSD._·timezoneFragValue·.fromSubstring(LEX[Array·H，M，S，T[2].endIndex..<LEX.endIndex]) : nil
		if Array·H，M，S，T[0] == "24"
		{ return XSD.·newDateTime·(nil, nil, nil, 24, 0, 0, tz) }
		else {
			let H = Array·H，M，S，T[0]
			let M = Array·H，M，S，T[1]
			let S = Array·H，M，S，T[2]
			return XSD.·newDateTime·(nil, nil, nil, XSD._·hourFragValue·.fromSubstring(H), XSD._·minuteFragValue·.fromSubstring(M), XSD._·secondFragValue·.fromSubstring(S), tz)
		}
	})
	static var ·timeLexicalMap·: (XSD.timeLexicalRep) -> XSD.TimeValue

	/// Maps a `XSD.dateLexicalRep` to a `XSD.DateValue`.
	///
	/// The argument necessarily includes an instance `Y` of `XSD.yearFrag`, an instance `M` of `XSD.monthFrag`, and an instance `D` of `XSD.dayFrag`, hyphen‐separated and optionally followed by an instance `T` of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dateLexRep>
	@XSD.LexicalMapping({ LEX in
		let Array·Y，M，D，T = LEX.dropFirst().split(
			maxSplits: 3,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz = Array·Y，M，D，T.count == 4 ? XSD._·timezoneFragValue·.fromSubstring(LEX[Array·Y，M，D，T[2].endIndex..<LEX.endIndex]) : nil
		let Y = LEX[LEX.startIndex..<Array·Y，M，D，T[0].endIndex]
		let M = Array·Y，M，D，T[1]
		let D = Array·Y，M，D，T[2]
		return XSD.·newDateTime·(XSD._·yearFragValue·.fromSubstring(Y), XSD._·monthFragValue·.fromSubstring(M), XSD._·dayFragValue·.fromSubstring(D), nil, nil, nil, tz)
	})
	static var ·dateLexicalMap·: (XSD.dateLexicalRep) -> XSD.DateValue

	/// Maps a `XSD.gYearMonthLexicalRep` to a `XSD.GYearMonthValue`.
	///
	/// The argument necessarily includes an instance of `XSD.yearFrag` and an instance of `XSD.monthFrag`, hyphen‐separated and optionally followed by an instance of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gYearMonthLexRep>
	@XSD.LexicalMapping({ LEX in
		let Array·Y，M，T = LEX.dropFirst().split(
			maxSplits: 2,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz = Array·Y，M，T.count == 3 ? XSD._·timezoneFragValue·.fromSubstring(LEX[Array·Y，M，T[1].endIndex..<LEX.endIndex]) : nil
		let Y = LEX[LEX.startIndex..<Array·Y，M，T[0].endIndex]
		let M = Array·Y，M，T[1]
		return XSD.·newDateTime·(XSD._·yearFragValue·.fromSubstring(Y), XSD._·monthFragValue·.fromSubstring(M), nil, nil, nil, nil, tz)
	})
	static var ·gYearMonthLexicalMap·: (XSD.gYearMonthLexicalRep) -> XSD.GYearMonthValue

	/// Maps a `XSD.gYearLexicalRep` to a `XSD.GYearValue`.
	///
	/// The argument necessarily includes an instance of `XSD.yearFrag`, optionally followed by an instance of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gYearLexRep>
	@XSD.LexicalMapping({ LEX in
		let Array·Y，T = LEX.dropFirst().split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz = Array·Y，T.count == 2 ? XSD._·timezoneFragValue·.fromSubstring(LEX[Array·Y，T[0].endIndex..<LEX.endIndex]) : nil
		let Y = LEX[LEX.startIndex..<Array·Y，T[0].endIndex]
		return XSD.·newDateTime·(XSD._·yearFragValue·.fromSubstring(Y), nil, nil, nil, nil, nil, tz)
	})
	static var ·gYearLexicalMap·: (XSD.gYearLexicalRep) -> XSD.GYearValue

	/// Maps a `XSD.gMonthDayLexicalRep` to a `XSD.GMonthDayValue`.
	///
	/// The argument necessarily includes an instance of `XSD.monthFrag` and an instance of `XSD.dayFrag`, hyphen‐separated and optionally followed by an instance of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gMonthDayLexRep>
	@XSD.LexicalMapping({ LEX in
		let Array·M，D，T = LEX.dropFirst(2).split(
			maxSplits: 2,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz = Array·M，D，T.count == 3 ? XSD._·timezoneFragValue·.fromSubstring(LEX[Array·M，D，T[1].endIndex..<LEX.endIndex]) : nil
		let M = Array·M，D，T[0]
		let D = Array·M，D，T[1]
		return XSD.·newDateTime·(nil, XSD._·monthFragValue·.fromSubstring(M), XSD._·dayFragValue·.fromSubstring(D), nil, nil, nil, tz)
	})
	static var ·gMonthDayLexicalMap·: (XSD.gMonthDayLexicalRep) -> XSD.GMonthDayValue

	/// Maps a `XSD.gDayLexicalRep` to a `XSD.GDayValue`.
	///
	/// The argument necessarily includes an instance of `XSD.dayFrag`, optionally followed by an instance of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gDayLexRep>
	@XSD.LexicalMapping({ LEX in
		let Array·D，T = LEX.dropFirst(3).split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz = Array·D，T.count == 2 ? XSD._·timezoneFragValue·.fromSubstring(LEX[Array·D，T[0].endIndex..<LEX.endIndex]) : nil
		let D = Array·D，T[0]
		return XSD.·newDateTime·(nil, nil, XSD._·dayFragValue·.fromSubstring(D), nil, nil, nil, tz)
	})
	static var ·gDayLexicalMap·: (XSD.gDayLexicalRep) -> XSD.GDayValue

	/// Maps a `XSD.gMonthLexicalRep` to a `XSD.GMonthValue`.
	///
	/// The argument necessarily includes an instance of `XSD.monthFrag`, optionally followed by an instance `T` of `XSD.timezoneFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gMonthLexRep>
	@XSD.LexicalMapping({ LEX in
		let Array·M，T = LEX.dropFirst(2).split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { $0 == "-" || $0 == "Z" || $0 == "+" }
		let tz = Array·M，T.count == 2 ? XSD._·timezoneFragValue·.fromSubstring(LEX[Array·M，T[0].endIndex..<LEX.endIndex]) : nil
		let M = Array·M，T[0]
		return XSD.·newDateTime·(nil, XSD._·monthFragValue·.fromSubstring(M), nil, nil, nil, nil, tz)
	})
	static var ·gMonthLexicalMap·: (XSD.gMonthLexicalRep) -> XSD.GMonthValue

	/// Maps a `XSD.stringRep` to a `XSD.StringValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-stringLexmap>
	@XSD.LexicalMapping({ LEX in XSD.StringValue(String(LEX))! })
	static var ·stringLexicalMap·: (XSD.stringRep) -> XSD.StringValue

	/// Maps a `XSD.booleanRep` to a `XSD.BooleanValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-booleanLexmap>
	@XSD.LexicalMapping({ LEX in LEX == "true" || LEX == "1" ? .true : .false })
	static var ·booleanLexicalMap·: (XSD.booleanRep) -> XSD.BooleanValue

	/// Maps a `XSD.hexBinaryRep` to a sequence of `XSD.BinaryOctet`s in the form of a `XSD.HexBinaryValue`.
	///
	/// The argument necessarily includes a sequence of zero or more matching the `XSD.hexOctet` production.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexBinaryMap>
	@XSD.LexicalMapping({ LEX in
		let o: UnfoldSequence <XSD.BinaryOctet, Substring> = sequence(
			state: LEX[LEX.startIndex..<LEX.endIndex]
		) { state in
			let octet = state.prefix(2)
			guard octet.count == 2
			else
			{ return nil }
			state = LEX[octet.endIndex..<LEX.endIndex]
			return XSD._·hexOctetMap·.fromSubstring(octet)
		}
		return XSD.HexBinaryValue(o)
	})
	static var ·hexBinaryMap·: (XSD.hexBinaryRep) -> XSD.HexBinaryValue

	/// Maps a `XSD.hexOctet` (`LEX`) to a single `XSD.BinaryOctet`.
	///
	/// `LEX` necessarily consists of exactly two `XSD.hexDigit`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexOctetMap>
	@XSD.LexicalMapping({ LEX in
		let d0 = LEX.prefix(1)
		let d1 = LEX.suffix(1)
		return XSD._·hexDigitMap·.fromSubstring(d1).enumerated().reduce(
			into: XSD._·hexDigitMap·.fromSubstring(d0).enumerated().reduce(
				into: 0
			) { $0 |= $1.1.rawValue << UInt8(7 - $1.0) }
		) { $0 |= $1.1.rawValue << UInt8(3 - $1.0) }
	})
	static var ·hexOctetMap·: (XSD.hexOctet) -> XSD.BinaryOctet

	/// Maps a `XSD.hexDigit` to a `XSD.Sequence` of four `XSD.BinaryDigit`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hexDigitMap>
	@XSD.LexicalMapping({ d in
		return sequence(
			state: 0 as UInt8
		) { state in
			let nextState = state as! UInt8 + 1
			guard nextState < 5
			else
			{ return nil }
			state = nextState
			switch d {
			case "0":
				return .０
			case "1":
				return nextState == 4 ? .１ : .０
			case "2":
				return nextState == 3 ? .１ : .０
			case "3":
				return nextState == 1 || nextState == 2 ? .０ : .１
			case "4":
				return nextState == 2 ? .１ : .０
			case "5":
				return nextState == 1 || nextState == 3 ? .０ : .１
			case "6":
				return nextState == 1 || nextState == 4 ? .０ : .１
			case "7":
				return nextState == 1 ? .０ : .１
			case "8":
				return nextState == 1 ? .１ : .０
			case "9":
				return nextState == 1 || nextState == 4 ? .１ : .０
			case "A", "a":
				return nextState == 1 || nextState == 3 ? .１ : .０
			case "B", "b":
				return nextState == 2 ? .０ : .１
			case "C", "c":
				return nextState == 1 || nextState == 2 ? .１ : .０
			case "D", "d":
				return nextState == 3 ? .０ : .１
			case "E", "e":
				return nextState == 4 ? .０ : .１
			case "F", "f":
				return .１
			default:
				fatalError("Expected a hex digit but got \(d)")
			}
		}
	})
	static var ·hexDigitMap·: (XSD.hexDigit) -> XSD.Sequence <XSD.BinaryDigit>

}
