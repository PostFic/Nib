import Foundation
import XSD

public protocol XSDNumber:
	Numeric,
	Strideable,
	XSDAtomicValue
{

	associatedtype Integer: XSDNumber & BinaryInteger

	var boolValue: Bool { get }

	var decimalValue: Decimal { get }

	var doubleValue: Double { get }

	var floatValue: Float { get }

	var int8Value: Int8 { get }

	var int16Value: Int16 { get }

	var int32Value: Int32 { get }

	var int64Value: Int64 { get }

	var intValue: Int { get }

	var integer: Integer { get }

	var isInteger: Bool { get }

	var stringValue: String { get }

	var uint8Value: UInt8 { get }

	var uint16Value: UInt16 { get }

	var uint32Value: UInt32 { get }

	var uint64Value: UInt64 { get }

	var uintValue: UInt { get }

	init?<Number: XSDNumber>(number value: Number)

	init?(exactly value: NSDecimalNumber)

	init<Number: XSDNumber>(rounding value: Number)

	init(truncating value: NSDecimalNumber)

	func div(_ other: Self) -> Integer

	func mod(_ other: Self) -> Self

	static func %(lhs: Self, rhs: Self) -> Self

	static func ⫽(lhs: Self, rhs: Self) -> Integer

	static func ☆<Number: XSDNumber>(lhs: Self, rhs: Number.Type) -> Number

	static func ☆?<Number: XSDNumber>(lhs: Self, rhs: Number.Type) -> Number?

}

public extension XSDNumber {

	var boolValue: Bool {
		return !(self == 0)
	}

	var doubleValue: Double {
		return NSDecimalNumber(decimal: decimalValue).doubleValue
	}

	var floatValue: Float {
		return NSDecimalNumber(decimal: decimalValue).floatValue
	}

	var int8Value: Int8 {
		return NSDecimalNumber(decimal: decimalValue).int8Value
	}

	var int16Value: Int16 {
		return NSDecimalNumber(decimal: decimalValue).int16Value
	}

	var int32Value: Int32 {
		return NSDecimalNumber(decimal: decimalValue).int32Value
	}

	var int64Value: Int64 {
		return NSDecimalNumber(decimal: decimalValue).int64Value
	}

	var intValue: Int {
		return NSDecimalNumber(decimal: decimalValue).intValue
	}

	var isInteger: Bool {
		return self == Self.init(number: integer)
	}

	var stringValue: String {
		return String(describing: self)
	}

	var uint8Value: UInt8 {
		return NSDecimalNumber(decimal: decimalValue).uint8Value
	}

	var uint16Value: UInt16 {
		return NSDecimalNumber(decimal: decimalValue).uint16Value
	}

	var uint32Value: UInt32 {
		return NSDecimalNumber(decimal: decimalValue).uint32Value
	}

	var uint64Value: UInt64 {
		return NSDecimalNumber(decimal: decimalValue).uint64Value
	}

	var uintValue: UInt {
		return NSDecimalNumber(decimal: decimalValue).uintValue
	}

	init?<DecimalNumber: XSDDecimalNumber>(decimalNumber value: DecimalNumber) {
		self.init(exactly: NSDecimalNumber(decimal: value.decimalValue))
	}

	init<DecimalNumber: XSDDecimalNumber>(roundingDecimalNumber value: DecimalNumber) {
		self.init(truncating: NSDecimalNumber(decimal: value.decimalValue))
	}

	func mod(_ other: Self) -> Self {
		return self - other * Self.init(rounding: div(other))
	}

	static func %(lhs: Self, rhs: Self) -> Self {
		return lhs.mod(rhs)
	}

	static func ⫽(lhs: Self, rhs: Self) -> Integer {
		return lhs.div(rhs)
	}

	static func ☆<Number: XSDNumber>(lhs: Self, rhs: Number.Type) -> Number {
		return rhs.init(rounding: lhs)
	}

	static func ☆?<Number: XSDNumber>(lhs: Self, rhs: Number.Type) -> Number? {
		return rhs.init(number: lhs)
	}

}
