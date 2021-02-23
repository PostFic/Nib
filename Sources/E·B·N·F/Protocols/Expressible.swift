//  #  E·B·N·F :: Expressible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be converted into an `Expression` using the `′` postfix operator.
public protocol Expressible {

	/// The type of values associated with generated `Expression.symbol`s.
	associatedtype Symbol where Symbol: Symbolic

	/// Returns an `Expression.zeroOrOne` of the generated `Expression`.
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

	@inlinable
	static postfix func ° (
		_ operand: Self
	) -> Expression<Symbol>
	{ .zeroOrOne(operand′) }

	@inlinable
	static postfix func ″ (
		_ operand: Self
	) -> Expression<Symbol>
	{ .oneOrMore(operand′) }

	@inlinable
	static postfix func * (
		_ operand: Self
	) -> Expression<Symbol>
	{ .zeroOrMore(operand′) }

}
