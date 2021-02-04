//  # EBNF :: BracketedExpression
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// An ordered collection of `BracketedComponent`s.
public typealias BracketedExpression = [BracketedComponent]

public extension BracketedExpression {

	/// The `√` prefix operator produces a `.anyOf` from a `BracketedExpression`.
	///
	///  +  parameters:
	///      +  operand:
	///         A `BracketedExpression`.
	///
	///  +  returns:
	///     An `.anyOf` including the `operand`.
	static prefix func √ (
		_ operand: BracketedExpression
	) -> Expression
	{ .anyOf(operand) }


	/// The `^` prefix operator produces a `.noneOf` from a `BracketedExpression`.
	///
	///  +  parameters:
	///      +  operand:
	///         A `BracketedExpression`.
	///
	///  +  returns:
	///     An `.noneOf` including the `operand`.
	static prefix func ^ (
		_ operand: BracketedExpression
	) -> Expression
	{ .noneOf(operand) }

}
