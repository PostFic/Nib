import XSD
import XSDLiterals

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct GMonthValue:
		XSDDate·timeSevenPropertyModel,
		XSDCanonicalMappable
	{
		
		public typealias LexicalRepresentation = XSD.gMonthLexicalRep

		public var ·canonicalMapping·:
			XSD.GMonthValue.LexicalRepresentation
		{ return XSD.·gMonthCanonicalMap·(self) }

		public let ·day·: XSD.Integer? = nil

		public let ·hour·: XSD.Integer? = nil

		public let ·minute·: XSD.Integer? = nil

		public let ·month·: XSD.Integer?

		public let ·second·: XSD.DecimalNumber? = nil

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer? = nil

		public init(
			mapping literal: XSD.GMonthValue.LexicalRepresentation
		) {
			let MO = XSD.·gMonthLexicalMap·(literal)
			·month· = MO.·month·
			·timezoneOffset· = MO.·timezoneOffset·
		}
		
		public init?(
			year: XSD.Integer? = nil,
			month: XSD.Integer?,
			day: XSD.Integer? = nil,
			hour: XSD.Integer? = nil,
			minute: XSD.Integer? = nil,
			second: XSD.DecimalNumber? = nil,
			timezoneOffset: XSD.Integer?
		) {
			guard
				year == nil,
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
			else { return nil }
			·month· = d7m.·month·
			·timezoneOffset· = d7m.·timezoneOffset·
		}

	}

}
