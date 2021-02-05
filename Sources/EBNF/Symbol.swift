//  # EBNF :: Grammar
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// A named `Expression`.
public final class Symbol:
	CustomDebugStringConvertible,
	CustomStringConvertible
{

	/// An EBNF rule defining this `Symbol`.
	public var debugDescription: String {
		if let ID = referenceID
		{ return "[\(ID)] \(name) ::= \(expression)" }
		else
		{ return "\(name) ::= \(expression)" }
	}

	/// The `String` name of this `Symbol`.
	public var description: String
	{ name }

	/// The autoclosure wrapping the `expression` of this `Symbol`.
	private let expressed: () -> Expression

	/// The `Expression` associated with this `Symbol`.
	public var expression: Expression
	{ expressed() }

	/// The `String` reference identifier of this `Symbol`, if one is defined.
	public let referenceID: String?

	/// The `String` name of this `Symbol`.
	public let name: String

	/// Initializes a new `Symbol` with the given reference identifier, name, and expression.
	///
	///  +  parameters:
	///      +  id:
	///         A `String` reference identifier.
	///      +  name:
	///         A `String` name.
	///      +  expression:
	///         An `Expression`.
	///
	///  +  note:
	///     The `expression` parameter is treated as an autoclosure to delay computation and allow for recursive `Symbols`.
	public init (
		id: String? = nil,
		_ name: String,
		_ expression: @autoclosure @escaping () -> Expression
	) {
		referenceID = id
		self.name = name
		expressed = expression
	}

}

extension Symbol:
	Expressible
{


//	@inlinable
//	public static postfix func ° (
//		_ operand: Self
//	) -> Expression<Self>
//	{ .zeroOrOne(operand′) }

	/// A `.symbol` which wraps this `Symbol`.
	@inlinable
	public static postfix func ′ (
		_ operand: Symbol
	) -> Expression
	{ .symbol(operand) }

//	@inlinable
//	public static postfix func ″ (
//		_ operand: Self
//	) -> Expression<Self>
//	{ .oneOrMore(operand′) }
//
//	@inlinable
//	public static postfix func * (
//		_ operand: Self
//	) -> Expression<Self>
//	{ .zeroOrMore(operand′) }

}
