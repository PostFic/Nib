import XSD
import XSDLiterals

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct GYearMonthValue:
		XSDCanonicalMappable,
		XSDDate·timeSevenPropertyModelValue
	{
		
		public typealias LexicalRepresentation = XSD.gYearMonthLexicalRep

		public var ·canonicalMapping·: XSD.GYearMonthValue.LexicalRepresentation
		{ XSD.·gYearMonthCanonicalMap·(self) }

		public let ·day·: XSD.Integer? = nil

		public let ·hour·: XSD.Integer? = nil

		public let ·minute·: XSD.Integer? = nil

		public let ·month·: XSD.Integer?

		public let ·second·: XSD.DecimalNumber? = nil

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer?

		public init (
			mapping literal: XSD.GYearMonthValue.LexicalRepresentation
		) {
			let YM = XSD.·gYearMonthLexicalMap·(literal)
			·year· = YM.·year·
			·month· = YM.·month·
			·timezoneOffset· = YM.·timezoneOffset·
		}
		
		public init? (
			year: XSD.Integer?,
			month: XSD.Integer?,
			day: XSD.Integer? = nil,
			hour: XSD.Integer? = nil,
			minute: XSD.Integer? = nil,
			second: XSD.DecimalNumber? = nil,
			timezoneOffset: XSD.Integer?
		) {
			guard
				year != nil,
				month != nil,
				day == nil,
				hour == nil,
				minute == nil,
				second == nil,
				let d7m = Date·timeSevenPropertyModel(
					year: year,
					month: month,
					day: day,
					hour: hour,
					minute: minute,
					second: second,
					timezoneOffset: timezoneOffset
				)
			else
			{ return nil }
			·year· = d7m.·year·
			·month· = d7m.·month·
			·timezoneOffset· = d7m.·timezoneOffset·
		}

	}

}
