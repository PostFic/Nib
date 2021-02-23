//  # EBNF :: Expressible
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// A type which conforms to the `Expressible` protocol can be converted into an expression using the `′` postfix operator.
public protocol Expressible {

	/// The `Grammar` of the resulting `Expression`.
	associatedtype ExpressedGrammar: ExpressibleGrammar

	/// A `Expression.zeroOrOne` of the resulting `Expression`.
	static postfix func ° (
		_ operand: Self
	) -> Expression<ExpressedGrammar>

	/// The `Expression` that this `Expressible` can be expressed as.
	static postfix func ′ (
		_ operand: Self
	) -> Expression<ExpressedGrammar>

	/// A `Expression.oneOrMore` of the resulting `Expression`.
	static postfix func ″ (
		_ operand: Self
	) -> Expression<ExpressedGrammar>

	/// A `Expression.zeroOrMore` of the resulting `Expression`.
	static postfix func * (
		_ operand: Self
	) -> Expression<ExpressedGrammar>

}

public extension Expressible {

	@inlinable
	static postfix func ° (
		_ operand: Self
	) -> Expression<ExpressedGrammar>
	{ .zeroOrOne(operand′) }

	@inlinable
	static postfix func ″ (
		_ operand: Self
	) -> Expression<ExpressedGrammar>
	{ .oneOrMore(operand′) }

	@inlinable
	static postfix func * (
		_ operand: Self
	) -> Expression<ExpressedGrammar>
	{ .zeroOrMore(operand′) }

}
