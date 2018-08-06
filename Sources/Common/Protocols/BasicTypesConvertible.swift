/// A type that is potentially convertible to a number of basic types.
///
/// The properties `double`, `float`, `int`, `string`, and `uInt` attempt to convert instances of this type into the corresponding Swift objects.
/// Their values will be `nil` if the conversion is not possible.
public protocol BasicTypesConvertible {

	/// The instance as a `Bool`, if possible.
	var bool: Bool? { get }

	/// The instance as a `Double`, if possible.
	var double: Double? { get }

	/// The instance as a `Float`, if possible.
	var float: Float? { get }

	/// The instance as an `Int`, if possible.
	var int: Int? { get }

	/// The instance as a `String`, if possible.
	var string: String? { get }

	/// The instance as a `UInt`, if possible.
	var uInt: UInt? { get }

}
