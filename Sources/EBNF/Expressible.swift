//  # EBNF :: Expressible
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// A type which conforms to the `Expressible` protocol can be converted into an expression using the `′` postfix operator.
public protocol Expressible {

	/// A `Expression.zeroOrOne` of the resulting `Expression`.
	static postfix func ° (
		_ operand: Self
	) -> Expression

	/// The `Expression` that this `Expressible` can be expressed as.
	static postfix func ′ (
		_ operand: Self
	) -> Expression

	/// A `Expression.oneOrMore` of the resulting `Expression`.
	static postfix func ″ (
		_ operand: Self
	) -> Expression

	/// A `Expression.zeroOrMore` of the resulting `Expression`.
	static postfix func * (
		_ operand: Self
	) -> Expression

}

public extension Expressible {

	@inlinable
	static postfix func ° (
		_ operand: Self
	) -> Expression
	{ .zeroOrOne(operand′) }

	@inlinable
	static postfix func ″ (
		_ operand: Self
	) -> Expression
	{ .oneOrMore(operand′) }

	@inlinable
	static postfix func * (
		_ operand: Self
	) -> Expression
	{ .zeroOrMore(operand′) }

}
