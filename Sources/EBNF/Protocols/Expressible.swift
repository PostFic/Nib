//  #  EBNF :: Expressible  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// A type which can be converted into an expression using the `′` postfix operator.
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
	///     An `Expression.zeroOrOne`.
	static postfix func ° (
		_ operand: Self
	) -> Expression<Symbol>

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
	) -> Expression<Symbol>

	/// Returns an `Expression.oneOrMore` of the generated `Expression`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value to create an `Expression` from.
	///
	///  +  Returns:
	///     An `Expression.oneOrMore`.
	static postfix func ″ (
		_ operand: Self
	) -> Expression<Symbol>

	/// Returns an `Expression.zeroOrMore` of the generated `Expression`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value to create an `Expression` from.
	///
	///  +  Returns:
	///     An `Expression.zeroOrMore`.
	static postfix func * (
		_ operand: Self
	) -> Expression<Symbol>

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
