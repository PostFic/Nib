//  #  EBNF :: Symbolic  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import Core

/// A named, versionable expression.
public protocol Symbolic:
	CustomDebugStringConvertible,
	CustomStringConvertible,
	CustomVersionedDebugStringConvertible,
	Expressible
where
	Symbol == Self,
	Version: Defaultable
{

	/// The `String` reference identifier of this value, if one is defined.
	var referenceID: String?
	{ get }

	/// The `String` name of this value.
	var name: String
	{ get }

	/// Accesses the `Expression` of a given `version` of this value, if one is defined.
	///
	///  +  Parameters:
	///      +  version:
	///         The `Version` of this value to get an `Expression` for.
	///
	///  +  Returns:
	///     An `Expression`, or `nil` if none is defined for the provided `version`.
	subscript(
		_ version: Version
	) -> Expression<Self>?
	{ get }

}

extension Symbolic {

	/// The `String` name of this value.
	@inlinable
	public var description: String
	{ name }

	/// Returns a `String` EBNF rule for this value.
	///
	///  +  Parameters:
	///      +  version:
	///         The `Version` of the EBNF rule to produce.
	///
	///  +  Returns:
	///     A `String` giving the EBNF rule for this value according to the provided `version`.
	public func debugDescription (
		version: Version
	) -> String {
		let expressionString: String
		if let expression = self[version]
		{ expressionString = String(describing: expression) }
		else
		{ expressionString = "/* Not defined */" }
		if let ID = referenceID
		{ return "[\(ID)] \(name) ::= \(expressionString)" }
		else
		{ return "\(name) ::= \(expressionString)" }
	}

	@inlinable
	public static postfix func ° (
		_ operand: Self
	) -> Expression<Self>
	{ .zeroOrOne(operand′) }

	/// Returns an `Expression.symbol` which wraps the given value.
	///
	///  +  Parameters:
	///      +  operand:
	///         The value to create a `Expression.symbol` from.
	///
	///  +  Returns:
	///     An `Expression.symbol`.
	@inlinable
	public static postfix func ′ (
		_ operand: Self
	) -> Expression<Self>
	{ .symbol(operand) }

	@inlinable
	public static postfix func ″ (
		_ operand: Self
	) -> Expression<Self>
	{ .oneOrMore(operand′) }

	@inlinable
	public static postfix func * (
		_ operand: Self
	) -> Expression<Self>
	{ .zeroOrMore(operand′) }

}
