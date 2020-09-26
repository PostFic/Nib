import XSD
import XSDLiterals

extension XSD {

	public struct DurationValue:
		XSDCanonicalMappable,
		XSDDurationValue
	{
		
		public typealias LexicalRepresentation = XSD.durationLexicalRep

		public var ·canonicalMapping·: XSD.DurationValue.LexicalRepresentation
		{ XSD.·durationCanonicalMap·(self) }

		public let ·months·: XSD.Integer

		public let ·seconds·: XSD.DecimalNumber

		public init (
			mapping literal: XSD.DurationValue.LexicalRepresentation
		) { self = XSD.·durationMap·(literal) }

		public init? (
			months: XSD.Integer,
			seconds: XSD.DecimalNumber
		) {
			guard months == 0 || seconds == 0 || XSD.DecimalNumber(months).sign == seconds.sign
			else
			{ return nil }
			self.·months· = months
			self.·seconds· = seconds
		}

	}

}
