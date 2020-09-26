import Foundation

public protocol XSDNumberValue:
	ExpressibleByFloatLiteral,
	ExpressibleByIntegerLiteral,
	Strideable,
	XSDValue
where
	Self.FloatLiteralType == Double,
	Self.IntegerLiteralType == Int,
	Stride == XSD.DecimalNumber
{

	var decimalNumber: XSD.DecimalNumber?
	{ get }

	var integer: XSD.Integer?
	{ get }

	var specialValue: XSD.SpecialValue?
	{ get }

	init? <N> (
		exactly value: N
	) where N: BinaryInteger

	init? <N> (
		exactly value: N
	) where N: XSDNumberValue

	init? (
		exactly value: XSD.DecimalNumber
	)

	init? (
		exactly value: XSD.SpecialValue
	)

	init <N>(
		truncating value: N
	) where N: XSDNumberValue

	init (
		truncating value: XSD.DecimalNumber
	)

	init (
		truncating value: XSD.SpecialValue
	)

	static func == <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue

	static func != <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue

	static func < <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue

	static func <= <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue

	static func > <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue

	static func >= <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue
	
}

public extension XSDNumberValue {

	var integer: XSD.Integer? {
		if let decimalNumber = self.decimalNumber {
			return XSD.Integer(
				exactly: decimalNumber as NSDecimalNumber
			)
		} else
		{ return nil }
	}

	init? <N> (
		exactly value: N
	) where N: BinaryInteger {
		if
			let mantissa = UInt64(
				exactly: value.magnitude
			)
		{
			self.init(
				exactly: NSDecimalNumber(
					mantissa: mantissa,
					exponent: 0,
					isNegative: value.signum() < 0
				) as Decimal
			)
		} else
		{ return nil }
	}

	init? <N> (
		exactly value: N
	) where N: XSDNumberValue {
		if let specialValue = value.specialValue {
			self.init(
				exactly: specialValue
			)
		} else if let decimalNumber = value.decimalNumber {
			self.init(
				exactly: decimalNumber
			)
		} else
		{ return nil }
	}

	init <N> (
		truncating value: N
	) where N: XSDNumberValue {
		if let specialValue = value.specialValue {
			self.init(
				truncating: specialValue
			)
		} else if let decimalNumber = value.decimalNumber {
			self.init(
				truncating: decimalNumber
			)
		} else {
			self.init(
				truncating: .notANumber
			)
		}
	}

	@inlinable
	init (
		floatLiteral value: Self.FloatLiteralType
	) {
		if value.isNaN {
			self.init(
				exactly: .notANumber
			)!
		}
		else {
			switch value.floatingPointClass {
			case .negativeInfinity:
				self.init(
					exactly: .negativeInfinity
				)!
			case .negativeZero:
				self.init(
					exactly: .negativeZero
				)!
			case .positiveInfinity:
				self.init(
					exactly: .positiveInfinity
				)!
			case .positiveZero:
				self.init(
					exactly: .positiveZero
				)!
			default:
				self.init(
					exactly: XSD.DecimalNumber(value)
				)!
			}
		}
	}

	@inlinable
	init (
		integerLiteral value: Self.IntegerLiteralType
	) {
		self.init(
			exactly: value
		)!
	}

	func advanced (
		by n: XSD.DecimalNumber
	) -> Self {
		if let specialValue = self.specialValue {
			return Self(
				truncating: specialValue
			)
		} else if let decimalNumber = self.decimalNumber {
			return Self(
				truncating: decimalNumber.advanced(
					by: n
				)
			)
		} else {
			return Self(
				truncating: .notANumber
			)
		}
	}

	func distance (
		to other: Self
	) -> XSD.DecimalNumber {
		if
			let decimalNumber = self.decimalNumber,
			let otherDecimalNumber = other.decimalNumber
		{
			return decimalNumber.distance(
				to: otherDecimalNumber
			)
		}
		else if
			let decimalNumber = self.decimalNumber,
			other.specialValue == .positiveZero || other.specialValue == .negativeZero
		{ return decimalNumber }
		else if
			let otherDecimalNumber = other.decimalNumber,
			self.specialValue == .positiveZero || self.specialValue == .negativeZero
		{ return otherDecimalNumber }
		else if self.specialValue == nil || self.specialValue == .notANumber || other.specialValue == nil || other.specialValue == .notANumber || self.specialValue == other.specialValue
		{ return 0 }
		else
		{ return XSD.DecimalNumber.greatestFiniteMagnitude }
	}

	func hash (
		into hasher: inout Hasher
	) {
		if let specialValue = self.specialValue {
			if specialValue == .positiveZero || specialValue == .negativeZero
			{ hasher.combine(0 as XSD.Integer) }
			else { hasher.combine(specialValue) }
		} else if let integer = self.integer {
			hasher.combine(integer)
		} else if let decimalNumber = self.decimalNumber {
			hasher.combine(decimalNumber)
		}
	}

	static func === (
		lhs: Self,
		rhs: Self
	) -> Bool {
		if let specialValue = lhs.specialValue
		{ return specialValue == rhs.specialValue }
		else if let decimalNumber = lhs.decimalNumber
		{ return decimalNumber == rhs.decimalNumber }
		else if let integer = lhs.integer
		{ return integer == rhs.integer }
		else
		{ return false }
	}

	static func == <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue {
		if let specialValue = lhs.specialValue {
			guard
				specialValue != .notANumber,
				let otherSpecialValue = rhs.specialValue
			else
			{ return false }
			if specialValue == .positiveZero || specialValue == .negativeZero
			{ return otherSpecialValue == .positiveZero || otherSpecialValue == .negativeZero }
			else
			{ return specialValue == otherSpecialValue }
		} else if let decimalNumber = lhs.decimalNumber
		{ return decimalNumber == rhs.decimalNumber }
		else if let integer = lhs.integer
		{ return integer == rhs.integer }
		else
		{ return false }
	}

	@inlinable
	static func != <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue
	{ !(lhs == rhs) }

	static func < <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue {
		if let specialValue = lhs.specialValue {
			switch specialValue {
			case .notANumber, .positiveInfinity:
				return false
			case .positiveZero, .negativeZero:
				if let otherSpecialValue = rhs.specialValue
				{ return otherSpecialValue == .positiveInfinity }
				else if let otherDecimalNumber = rhs.decimalNumber
				{ return 0 < otherDecimalNumber }
				else if let otherInteger = rhs.integer
				{ return 0 < otherInteger }
				else
				{ return false }
			case .negativeInfinity:
				return true
			}
		} else if let otherSpecialValue = rhs.specialValue {
			switch otherSpecialValue {
			case .notANumber, .negativeInfinity:
				return false
			case .positiveZero, .negativeZero:
				if let decimalNumber = lhs.decimalNumber
				{ return decimalNumber < 0 }
				else if let integer = lhs.integer
				{ return integer < 0 }
				else
				{ return false }
			case .positiveInfinity:
				return true
			}
		} else if let decimalNumber = lhs.decimalNumber {
			if let otherDecimalNumber = rhs.decimalNumber
			{ return decimalNumber < otherDecimalNumber }
			else if let otherInteger = rhs.integer
			{ return decimalNumber < XSD.DecimalNumber(otherInteger) }
			else
			{ return false }
		} else if let integer = lhs.integer {
			if let otherDecimalNumber = rhs.decimalNumber
			{ return XSD.DecimalNumber(integer) < otherDecimalNumber }
			else if let otherInteger = rhs.integer
			{ return integer < otherInteger }
			else
			{ return false }
		} else { return false }
	}

	@inlinable
	static func <= <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue
	{ lhs < rhs || lhs == rhs }

	@inlinable
	static func > <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue
	{ !(lhs < rhs || lhs == rhs) }

	@inlinable
	static func >= <N> (
		lhs: Self,
		rhs: N
	) -> Bool
	where N: XSDNumberValue
	{ !(lhs < rhs) }

}
