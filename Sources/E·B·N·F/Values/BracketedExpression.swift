//  #  E·B·N·F :: BracketedExpression  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An ordered collection of `BracketedComponent`s.
///
///  +  Version:
///     `0.1.0`.
public typealias BracketedExpression = [BracketedComponent]

extension BracketedExpression {

	/// Returns an `Expression.anyOf` wrapping the given `BracketedExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `BracketedExpression`.
	///
	///  +  Returns:
	///     An `Expression.anyOf` wrapping the `operand`.
	@inlinable
	public static prefix func √ <Symbol> (
		_ operand: BracketedExpression
	) -> Symbol.Expression
	where Symbol: Symbolic
	{ .anyOf(operand) }

	/// Returns an `Expression.noneOf` wrapping the given `BracketedExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `BracketedExpression`.
	///
	///  +  Returns:
	///     An `Expression.noneOf` wrapping the `operand`.
	@inlinable
	public static prefix func ^ <Symbol> (
		_ operand: BracketedExpression
	) -> Symbol.Expression
	where Symbol: Symbolic
	{ .noneOf(operand) }

}

extension BracketedExpression:
	ExpressibleByUnicodeScalarLiteral
{

	/// Creates a `BracketedExpression` from a Unicode scalar literal.
	///
	/// The resulting `BracketedExpression` will have one component, matching only the provided `Unicode.Scalar`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  + Parameters:
	///      +  value:
	///         A `Unicode.Scalar` representing the Unicode scalar literal.
	public init (
		unicodeScalarLiteral value: Unicode.Scalar
	) { self = [BracketedComponent(value)] }

}

extension BracketedExpression:
	ExpressibleByExtendedGraphemeClusterLiteral
{

	/// Creates a `BracketedExpression` from an extended grapheme cluster literal.
	///
	/// The resulting `BracketedExpression` will only match those `Unicode.Scalar`s in the provided `String`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  + Parameters:
	///      +  value:
	///         A `String` representing the extended grapheme cluster.
	public init (
		extendedGraphemeClusterLiteral value: String
	) { self = value.unicodeScalars.map { BracketedComponent($0) } }

}

extension BracketedExpression:
	ExpressibleByStringLiteral
{

	/// Creates a `BracketedExpression` from a string literal.
	///
	/// The resulting `BracketedExpression` will only match those `Unicode.Scalar`s in the provided `String`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  + Parameters:
	///      +  value:
	///         A `String`.
	public init (
		stringLiteral value: String
	) { self = value.unicodeScalars.map { BracketedComponent($0) } }

}
