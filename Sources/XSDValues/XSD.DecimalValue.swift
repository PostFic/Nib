import Foundation
import XSD
import XSDLiterals

extension XSD {

	public struct DecimalValue:
		XSDCanonicalMappable,
		XSDNumberValue
	{

		public typealias LexicalRepresentation = XSD.decimalLexicalRep

		public var ·canonicalMapping·: XSD.DecimalValue.LexicalRepresentation
		{ XSD.·decimalCanonicalMap·(self) }

		public var decimalNumber: XSD.DecimalNumber?
		{ value }

		public var specialValue: XSD.SpecialValue?
		{ nil }

		private let value: XSD.DecimalNumber

		public init? (
			exactly value: XSD.DecimalNumber
		) {
			if value.isFinite
			{ self.value = value }
			else
			{ return nil }
		}

		public init? (
			exactly value: XSD.SpecialValue
		) {
			if value == .positiveZero || value == .negativeZero
			{ self.value = 0 }
			else
			{ return nil }
		}

		public init (
			mapping literal: XSD.DecimalValue.LexicalRepresentation
		) { self = XSD.·decimalLexicalMap·(literal) }

		public init (
			truncating value: XSD.DecimalNumber
		) {
			if value.isFinite
			{ self.value = value }
			else
			{ self.value = 0 }
		}

		public init (
			truncating value: XSD.SpecialValue
		) {
			switch value {
			case .negativeInfinity:
				self.value = XSD.DecimalNumber.leastFiniteMagnitude
			case .negativeZero:
				self.value = 0
			case .notANumber:
				self.value = 0
			case .positiveInfinity:
				self.value = XSD.DecimalNumber.greatestFiniteMagnitude
			case .positiveZero:
				self.value = 0
			}
		}

	}

}
