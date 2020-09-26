import XSD
import XSDLiterals

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct DateValue:
		XSDCanonicalMappable,
		XSDDate·timeSevenPropertyModelValue
	{
		
		public typealias LexicalRepresentation = XSD.dateLexicalRep

		public var ·canonicalMapping·: XSD.DateValue.LexicalRepresentation
		{ XSD.·dateCanonicalMap·(self) }

		public let ·day·: XSD.Integer?

		public let ·hour·: XSD.Integer? = nil

		public let ·minute·: XSD.Integer? = nil

		public let ·month·: XSD.Integer?

		public let ·second·: XSD.DecimalNumber? = nil

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer?

		public init (
			mapping literal: XSD.DateValue.LexicalRepresentation
		) {
			let D = XSD.·dateLexicalMap·(literal)
			·year· = D.·year·
			·month· = D.·month·
			·day· = D.·day·
			·timezoneOffset· = D.·timezoneOffset·
		}
		
		public init? (
			year: XSD.Integer?,
			month: XSD.Integer?,
			day: XSD.Integer?,
			hour: XSD.Integer? = nil,
			minute: XSD.Integer? = nil,
			second: XSD.DecimalNumber? = nil,
			timezoneOffset: XSD.Integer?
		) {
			guard
				year != nil,
				month != nil,
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
			else
			{ return nil }
			·year· = d7m.·year·
			·month· = d7m.·month·
			·day· = d7m.·day·
			·timezoneOffset· = d7m.·timezoneOffset·
		}

	}

}
