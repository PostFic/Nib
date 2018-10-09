import Foundation

public protocol XSDInteger: XSDNumber where Integer == Self {}

public extension XSDInteger {

	var decimalValue: Decimal {
		return Decimal(doubleValue)
	}

	var doubleValue: Double {
		return Double(self)
	}

	var floatValue: Float {
		return Float(self)
	}

	var int8Value: Int8 {
		return Int8(self)
	}

	var int16Value: Int16 {
		return Int16(self)
	}

	var int32Value: Int32 {
		return Int32(self)
	}

	var int64Value: Int64 {
		return Int64(self)
	}

	var intValue: Int {
		return Int(self)
	}

	var integer: Self {
		return self
	}

	var isInteger: Bool {
		return true
	}

	var uInt8Value: UInt8 {
		return UInt8(self)
	}

	var uInt16Value: UInt16 {
		return UInt16(self)
	}

	var uInt32Value: UInt32 {
		return UInt32(self)
	}

	var uInt64Value: UInt64 {
		return UInt64(self)
	}

	var uIntValue: UInt {
		return UInt(self)
	}

	init?<Number: XSDNumber>(number value: Number) {
		self.init(exactly: value.integer)
	}

	init<Number: XSDNumber>(rounding value: Number) {
		self.init(clamping: value.integer)
	}

	func div(_ other: Self) -> Self {
		return self / other
	}

	func mod(_ other: Self) -> Self {
		return self % other
	}

}
