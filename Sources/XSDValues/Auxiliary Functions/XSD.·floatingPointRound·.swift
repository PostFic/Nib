import Foundation
import XSD

public extension XSD {

	/// Rounds a `XSD.DecimalNumber` to the nearest floating‐point
	///   value.
	///
	///  +  parameters:
	///      +  nV:
	///         A `XSD.DecimalNumber`.
	///      +  cWidth:
	///         An `XSD.Integer` *(ignored)*.
	///      +  eMin:
	///         An `XSD.Integer` *(ignored)*.
	///      +  eMax:
	///         An `XSD.Integer` *(ignored)*.
	///
	///  +  returns:
	///     A `Float32`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-floatPtRound>
	///
	///  +  note:
	///     Nib cheats and defines separate `·floatingPointRound·`
	///       functions for `Float32` and `Float64`, relying on Swift’s
	///       internal rounding, instead of implementing the algorithm
	///       described in the XSD Specification.
	///     Consequently, all arguments after the first are ignored,
	///       and the return value is the requested floating‐point
	///       type, not a `XSD.DecimalNumber`.
	@inlinable
	static func ·floatingPointRound· (
		_ nV: XSD.DecimalNumber,
		_ cWidth: XSD.Integer = 0,
		_ eMin: XSD.Integer = 0,
		_ eMax: XSD.Integer = 0
	) -> Float32! {
		return Float32(
			truncating: nV as NSDecimalNumber
		)
	}

	/// Rounds a `XSD.DecimalNumber` to the nearest floating‐point
	///   value.
	///
	///  +  parameters:
	///      +  nV:
	///         An `XSD.DecimalNumber`.
	///      +  cWidth:
	///         An `XSD.Integer` *(ignored)*.
	///      +  eMin:
	///         An `XSD.Integer` *(ignored)*.
	///      +  eMax:
	///         An `XSD.Integer` *(ignored)*.
	///
	///  +  returns:
	///     A `Float64`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-floatPtRound>
	///
	///  +  note:
	///     Nib cheats and defines separate `·floatingPointRound·`
	///       functions for `Float32` and `Float64`, relying on Swift’s
	///       internal rounding, instead of implementing the algorithm
	///       described in the XSD Specification.
	///     Consequently, all arguments after the first are ignored,
	///       and the return value is the requested floating‐point
	///       type, not a `XSD.DecimalNumber`.
	@inlinable
	static func ·floatingPointRound· (
		_ nV: XSD.DecimalNumber,
		_ cWidth: XSD.Integer = 0,
		_ eMin: XSD.Integer = 0,
		_ eMax: XSD.Integer = 0
	) -> Float64! {
		return Float64(
			truncating: nV as NSDecimalNumber
		)
	}

}
