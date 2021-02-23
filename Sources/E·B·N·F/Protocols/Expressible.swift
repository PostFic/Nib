//  #  E·B·N·F :: Expressible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be converted into an `Expression` using the `′` postfix operator.
///
///  +  Version:
///     `0.1.0`.
public protocol Expressible {

	/// The type of values associated with generated `Expression.symbol`s.
	///
	///  +  Version:
	///     `0.1.0`.
	associatedtype Symbol where Symbol: Symbolic

	/// Returns an `Expression.zeroOrOne` of the generated `Expression`.
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value to create an `Expression` from.
	///
	///  +  Returns:
	///     An `Expression.zeroOrOne`, or an equivalent expression.
	static postfix func ° (
		_ operand: Self
	) -> Symbol.Expression

	/// Returns the `Expression` that this `Expressible` can be expressed as.
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value to create an `Expression` from.
	///
	///  +  Returns:
	///     An `Expression`.
	static postfix func ′ (
		_ operand: Self
	) -> Symbol.Expression

	/// Returns an `Expression.oneOrMore` of the generated `Expression`.
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value to create an `Expression` from.
	///
	///  +  Returns:
	///     An `Expression.oneOrMore`, or an equivalent expression.
	static postfix func ″ (
		_ operand: Self
	) -> Symbol.Expression

	/// Returns an `Expression.zeroOrMore` of the generated `Expression`.
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value to create an `Expression` from.
	///
	///  +  Returns:
	///     An `Expression.zeroOrMore`, or an equivalent expression.
	static postfix func * (
		_ operand: Self
	) -> Symbol.Expression

}

public extension Expressible {

	/// Returns an `Expression.zeroOrOne` of the `operand`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	static postfix func ° (
		_ operand: Self
	) -> Symbol.Expression
	{ .zeroOrOne(operand′) }

	/// Returns an `Expression.oneOrMore` of the `operand`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	static postfix func ″ (
		_ operand: Self
	) -> Symbol.Expression
	{ .oneOrMore(operand′) }

	/// Returns an `Expression.zeroOrMore` of the `operand`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	static postfix func * (
		_ operand: Self
	) -> Symbol.Expression
	{ .zeroOrMore(operand′) }

}
