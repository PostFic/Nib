import Foundation
import XSD

extension XSD {

	public struct DecimalValue:
		XSDNumberValue
	{

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
