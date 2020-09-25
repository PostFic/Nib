import XSD
import XSDLiterals

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct GDayValue:
		XSDCanonicalMappable,
		XSDDate·timeSevenPropertyModelValue
	{
		
		public typealias LexicalRepresentation = XSD.gDayLexicalRep

		public var ·canonicalMapping·:
			XSD.GDayValue.LexicalRepresentation
		{ return XSD.·gDayCanonicalMap·(self) }

		public let ·day·: XSD.Integer?

		public let ·hour·: XSD.Integer? = nil

		public let ·minute·: XSD.Integer? = nil

		public let ·month·: XSD.Integer? = nil

		public let ·second·: XSD.DecimalNumber? = nil

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer? = nil

		public init(
			mapping literal: XSD.GDayValue.LexicalRepresentation
		) {
			let DA = XSD.·gDayLexicalMap·(literal)
			·day· = DA.·day·
			·timezoneOffset· = DA.·timezoneOffset·
		}
		
		public init?(
			year: XSD.Integer? = nil,
			month: XSD.Integer? = nil,
			day: XSD.Integer?,
			hour: XSD.Integer? = nil,
			minute: XSD.Integer? = nil,
			second: XSD.DecimalNumber? = nil,
			timezoneOffset: XSD.Integer?
		) {
			guard
				year == nil,
				month == nil,
				day != nil,
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
			·day· = d7m.·day·
			·timezoneOffset· = d7m.·timezoneOffset·
		}

	}

}
