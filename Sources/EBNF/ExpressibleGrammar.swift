//  # EBNF :: ExpressibleGrammar
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// A type which conforms to the `ExpressibleGrammar` protocol represents an EBNF grammar.
/// It has an associated `Expression`, and can parse `Text` into a tree of `Construct`s.
public protocol ExpressibleGrammar:
	CustomStringConvertible,
	Expressible,
	Hashable
where ExpressedGrammar == Self {

	/// The `Expression` associated with this `ExpressibleGrammar`.
	var expression: Expression<Self>
	{ get }

	/// Parses the provided `Text` into a tree of `Construct`s.
	///
	///  +  parameters:
	///     + text:
	///       The `Text` to parse.
	///
	///  +  throws:
	///     A `Error.parseError` if this `ExpressibleGrammar` does not exactly match the provided `Text`.
	///
	///  +  returns:
	///     An `Array` of `Construct`s.
	func parse (
		_ text: Text
	) throws -> [Construct<Self>]

	/// Parses the provided `Text.SubSequence` into a tree of `Construct`s.
	///
	///  +  parameters:
	///     + text:
	///       The `Text.SubSequence` to parse.
	///
	///  +  throws:
	///     A `Error.parseError` if this `ExpressibleGrammar` does not exactly match the provided `Text.SubSequence`.
	///
	///  +  returns:
	///     An `Array` of `Construct`s.
	func parse (
		_ text: Text.SubSequence
	) throws -> [Construct<Self>]

}

public extension ExpressibleGrammar {

	@inlinable
	func parse (
		_ text: Text
	) throws -> [Construct<Self>]
	{ try self.parse(text[...]) }

	func parse (
		_ text: Text.SubSequence
	) throws -> [Construct<Self>] {
		let (end, result) = try self.expression.gobble(text)
		if end == text.endIndex
		{ return result }
		else {
			throw Error.parseError(
				text,
				index: text.startIndex,
				expression: self.expression,
				exhaustive: true
			)
		}
	}

//	@inlinable
//	static postfix func ° (
//		_ operand: Self
//	) -> Expression<Self>
//	{ .zeroOrOne(operand′) }

	@inlinable
	static postfix func ′ (
		_ operand: Self
	) -> Expression<Self>
	{ .symbol(operand) }

//	@inlinable
//	static postfix func ″ (
//		_ operand: Self
//	) -> Expression<Self>
//	{ .oneOrMore(operand′) }
//
//	@inlinable
//	static postfix func * (
//		_ operand: Self
//	) -> Expression<Self>
//	{ .zeroOrMore(operand′) }

}
