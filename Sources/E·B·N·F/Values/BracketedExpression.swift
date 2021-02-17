//  #  E·B·N·F :: BracketedExpression  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

/// An ordered collection of `BracketedComponent`s.
public typealias BracketedExpression = [BracketedComponent]

extension BracketedExpression {

	/// Returns an `.anyOf` wrapping the given `BracketedExpression`.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `BracketedExpression`.
	///
	///  +  Returns:
	///     An `.anyOf` wrapping the `operand`.
	@inlinable
	public static prefix func √ <Symbol> (
		_ operand: BracketedExpression
	) -> Expression<Symbol>
	where Symbol: Symbolic
	{ .anyOf(operand) }

	/// Returns a `.noneOf` wrapping the given `BracketedExpression`.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `BracketedExpression`.
	///
	///  +  Returns:
	///     A `.noneOf` wrapping the `operand`.
	@inlinable
	public static prefix func ^ <Symbol> (
		_ operand: BracketedExpression
	) -> Expression<Symbol>
	where Symbol: Symbolic
	{ .noneOf(operand) }

}

extension BracketedExpression:
	ExpressibleByUnicodeScalarLiteral
{

	/// Creates a `BracketedExpression` from a Unicode scalar literal.
	///
	/// The resulting `BracketedExpression` will have one component, matching only the provided `unicodeScalarLiteral`.
	///
	///  + Parameters:
	///      +  unicodeScalarLiteral:
	///         A `Text.Character` representing the Unicode scalar literal.
	public init(
		unicodeScalarLiteral value: Text.Character
	) { self = [BracketedComponent(value)] }

}

extension BracketedExpression:
	ExpressibleByExtendedGraphemeClusterLiteral
{

	/// Creates a `BracketedExpression` from an extended grapheme cluster.
	///
	/// The resulting `BracketedExpression` will only match those `Text.Character`s in the provided `extendedGraphemeClusterLiteral`.
	///
	///  + Parameters:
	///      +  extendedGraphemeClusterLiteral:
	///         A `String` representing the extended grapheme cluster.
	public init(
		extendedGraphemeClusterLiteral value: String
	) { self = value.unicodeScalars.map { BracketedComponent($0) } }

}

extension BracketedExpression:
	ExpressibleByStringLiteral
{

	/// Creates a `BracketedExpression` from a `String`.
	///
	/// The resulting `BracketedExpression` will only match those `Text.Character`s in the provided `stringLiteral`.
	///
	///  + Parameters:
	///      +  stringLiteral:
	///         A `String`.
	public init(
		stringLiteral value: String
	) { self = value.unicodeScalars.map { BracketedComponent($0) } }

}
