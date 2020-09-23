import Foundation
import XSD

public protocol XSDNumber:
	ExpressibleByFloatLiteral,
	ExpressibleByIntegerLiteral,
	Strideable,
	XSDNumberConvertible
where Stride == XSD.DecimalNumber {

	var decimalNumber: XSD.DecimalNumber? { get }

	var integer: XSD.Integer? { get }

	var specialValue: XSD.SpecialValue? { get }

	init?<N: BinaryInteger>(
		exactly value: N
	)

	init?<N: XSDNumber>(
		exactly value: N
	)

	init?(
		exactly value: XSD.DecimalNumber
	)

	init?(
		exactly value: XSD.SpecialValue
	)

	init<N: XSDNumber>(
		truncating value: N
	)

	init(
		truncating value: XSD.DecimalNumber
	)

	init(
		truncating value: XSD.SpecialValue
	)
	
}

public extension XSDNumber {

	var integer: XSD.Integer? {
		if let decimalNumber = self.decimalNumber {
			return XSD.Integer(
				exactly: decimalNumber as NSDecimalNumber
			)
		} else { return nil }
	}

	init?<N: BinaryInteger>(
		exactly value: N
	) {
		if let decimalValue = XSD.DecimalNumber(exactly: value) {
			self.init(exactly: decimalValue)
		} else { return nil }
	}

	init?<N: XSDNumber>(
		exactly value: N
	) {
		if let decimalNumber = value.decimalNumber {
			self.init(exactly: decimalNumber)
		} else if let specialValue = value.specialValue {
			self.init(exactly: specialValue)
		} else { return nil }
	}

	init<N: XSDNumber>(
		truncating value: N
	) {
		if let decimalNumber = value.decimalNumber {
			self.init(truncating: decimalNumber)
		} else if let specialValue = value.specialValue {
			self.init(truncating: specialValue)
		} else { self.init(truncating: .notANumber) }
	}

	@inlinable
	init(
		floatLiteral value: Double
	) { self.init(exactly: XSD.DecimalNumber(value))! }

	@inlinable
	init(
		integerLiteral value: Int
	) { self.init(exactly: value)! }

	func advanced(
		by n: XSD.DecimalNumber
	) -> Self {
		if let decimalNumber = self.decimalNumber {
			return Self(truncating: decimalNumber.advanced(by: n))
		} else if let specialValue = self.specialValue {
			return Self(truncating: specialValue)
		} else { return Self(truncating: .notANumber) }
	}

	func distance(
		to other: Self
	) -> XSD.DecimalNumber {
		if
			let decimalNumber = self.decimalNumber,
			let otherDecimalNumber = other.decimalNumber
		{ return decimalNumber.distance(to: otherDecimalNumber) }
		else if
			let decimalNumber = self.decimalNumber,
			other.specialValue == .positiveZero
				|| other.specialValue == .negativeZero
		{ return decimalNumber }
		else if
			let otherDecimalNumber = other.decimalNumber,
			self.specialValue == .positiveZero
				|| self.specialValue == .negativeZero
		{ return otherDecimalNumber }
		else if
			self.specialValue == nil ||
				self.specialValue == .notANumber ||
				other.specialValue == nil ||
				other.specialValue == .notANumber ||
				self.specialValue == other.specialValue
		{ return 0 }
		else { return XSD.DecimalNumber.greatestFiniteMagnitude }
	}

	static func ==(
		lhs: Self,
		rhs: Self
	) -> Bool {
		return lhs.decimalNumber == rhs.decimalNumber && (
				lhs.specialValue == rhs.specialValue ||
					lhs.specialValue == .positiveZero &&
					rhs.specialValue == .negativeZero ||
					lhs.specialValue == .negativeZero &&
					rhs.specialValue == .positiveZero
			) && lhs.specialValue != .notANumber
	}

	static func <(
		lhs: Self,
		rhs: Self
	) -> Bool {
		if let lhdn = lhs.decimalNumber {
			if let rhdn = rhs.decimalNumber { return lhdn < rhdn }
			else if
				rhs.specialValue == .positiveZero ||
					rhs.specialValue == .negativeZero
			{ return lhdn < 0 }
			else if rhs.specialValue == .positiveInfinity {
				return true
			} else { return false }
		} else if
			lhs.specialValue == .positiveZero ||
				lhs.specialValue == .negativeZero
		{
			if let rhdn = rhs.decimalNumber { return 0 < rhdn }
			else if rhs.specialValue == .positiveInfinity {
				return true
			} else { return false }
		} else if lhs.specialValue == .negativeInfinity {
			if rhs.decimalNumber != nil ||
				rhs.specialValue == .positiveInfinity
			{ return true }
			else { return false }
		} else { return false }
	}

	@inlinable
	static postfix func ◊?<N: XSDNumber>(
		operand: Self
	) -> N? { N(exactly: operand) }

}
