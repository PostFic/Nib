import Foundation

/// A type that is potentially convertible to a number of basic types.
///
/// Their values will be `nil` if the conversion is not possible.
public protocol BasicTypesConvertible {

	/// The instance as a `Bool`, if possible.
	var bool: Bool? { get }

	/// The instance as a `Decimal`, if possible.
	var decimal: Decimal? { get }

	/// The instance as a `Double`, if possible.
	var double: Double? { get }

	/// The instance as a `Float`, if possible.
	var float: Float? { get }

	/// The instance as a `Float`, if possible.
	var float80: Float80? { get }

	/// The instance as an `Int`, if possible.
	var int: Int? { get }

	/// The instance as an `Int8`, if possible.
	var int8: Int8? { get }

	/// The instance as an `Int16`, if possible.
	var int16: Int16? { get }

	/// The instance as an `Int32`, if possible.
	var int32: Int32? { get }

	/// The instance as an `Int64`, if possible.
	var int64: Int64? { get }

	/// The instance as a `String`, if possible.
	var string: String? { get }

	/// The instance as a `UInt`, if possible.
	var uInt: UInt? { get }

	/// The instance as a `UInt8`, if possible.
	var uInt8: UInt8? { get }

	/// The instance as a `UInt16`, if possible.
	var uInt16: UInt16? { get }

	/// The instance as a `UInt32`, if possible.
	var uInt32: UInt32? { get }

	/// The instance as a `UInt64`, if possible.
	var uInt64: UInt64? { get }

}
