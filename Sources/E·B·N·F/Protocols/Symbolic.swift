//  #  E·B·N·F :: Symbolic  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

/// A named, versionable expression.
///
///  +  Version:
///     `0.1.0`.
public protocol Symbolic:
	CaseIterable,
	CustomDebugStringConvertible,
	CustomStringConvertible,
	CustomVersionedDebugStringConvertible,
	Expressible,
	Hashable,
	RawRepresentable
where
	Symbol == Self,
	RawValue == String,
	Version: Defaultable
{

	/// The `Text` name of this value.
	///
	///  +  Version:
	///     `0.1.0`.
	var name: Text
	{ get }

	/// The `Text` reference identifier of this value, if one is defined.
	///
	///  +  Version:
	///     `0.1.0`.
	var reference: Text?
	{ get }

	/// Returns the `Expression` of a given `version` of this value, if one is defined.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  version:
	///         The `Version` of this value to get an `Expression` for.
	///
	///  +  Returns:
	///     An `Expression`, or `nil` if none is defined for the provided `version`.
	func callAsFunction (
		_ version: Version
	) -> Expression?

	/// Extracts and returns a `Construct.symbol` from the beginning of the provided `text` according to the given `version`, or throws.
	///
	///  +  Note:
	///     This `Symbolic` need not match the entire `text` for `.extract(from:version:)` to return a value.
	///     To see if the whole `text` was matched, use `.parse(:version:)` instead.
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Throws:
	///     A `ParseError` if the `expression` of this `Symbolic` does not match the beginning of the provided `text`.
	///
	///  +  Returns:
	///     A `Construct.symbol`.
	func extract <T> (
		from text: T,
		version: Version
	) throws -> Construct
	where
		T: Collection,
		T.SubSequence == Text.SubSequence

	/// Returns a `Construct.symbol` parsed from the provided `text` according to the `expression` of this `Symbolic`, or throws.
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Throws:
	///     A `ParseError` if the `expression` of this `Symbolic` does not exactly match the provided `text`.
	///
	///  +  Returns:
	///     A `Construct.symbol`.
	func parse <T> (
		_ text: T,
		version: Version
	) throws -> Construct
	where
		T: Collection,
		T.SubSequence == Text.SubSequence

}

extension Symbolic {

	/// The `Construct`s produced by this `Symbolic`.
	///
	///  +  Version:
	///     `0.1.0`.
	public typealias Construct = E·B·N·F.Construct<Self>

	/// The `Expression`s produced by this `Symbolic`.
	///
	///  +  Version:
	///     `0.1.0`.
	public typealias Expression = E·B·N·F.Expression<Self>

	/// The `String` name of this `Symbolic`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	public var description: String
	{ String(name) }

	/// The `name` of this `Symbolic`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	public var name: Text
	{ rawValue.unicodeScalars }

	/// Returns a `String` EBNF rule for this `Symbolic`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
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
		if let expression = self(version)
		{ expressionString = String(describing: expression) }
		else
		{ expressionString = "/* Not defined */" }
		if let i·d = reference
		{ return "[\(i·d)] \(name) ::= \(expressionString)" }
		else
		{ return "\(name) ::= \(expressionString)" }
	}

	/// Extracts and returns a `Construct.symbol` from the beginning of the provided `text` according to the given `version`, or throws.
	///
	///  +  Note:
	///     This `Symbolic` need not match the entire `text` for `.extract(from:version:)` to return a value.
	///     To see if the whole `text` was matched, use `.parse(:version:)` instead.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Throws:
	///     A `ParseError` if the `expression` of this `Symbolic` does not match the beginning of the provided `text`.
	///
	///  +  Returns:
	///     A `Construct.symbol`.
	@inlinable
	public func extract <T> (
		from text: T,
		version: Version = Version.default
	) throws -> Construct
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{
		try self′.extract(
			from: text,
			version: version
		)[0]
	}

	/// Returns whether the `expression` of this `Symbolic` exactly matches the provided `text`.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-match>.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public func parse <T> (
		_ text: T,
		version: Version = Version.default
	) throws -> Construct
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{
		try self′.parse(
			text,
			version: version
		)[0]
	}

	/// Returns an `Expression.zeroOrOne` of an `Expression.symbol` which wraps the given value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The value to create a `Expression.symbol` from.
	///
	///  +  Returns:
	///     An `Expression.zeroOrOne`.
	@inlinable
	public static postfix func ° (
		_ operand: Self
	) -> Expression
	{ .zeroOrOne(operand′) }

	/// Returns an `Expression.symbol` which wraps the given value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
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
	) -> Expression
	{ .symbol(operand) }

	/// Returns an `Expression.oneOrMore` of an `Expression.symbol` which wraps the given value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The value to create a `Expression.symbol` from.
	///
	///  +  Returns:
	///     An `Expression.oneOrMore`.
	@inlinable
	public static postfix func ″ (
		_ operand: Self
	) -> Expression
	{ .oneOrMore(operand′) }

	/// Returns an `Expression.zeroOrMore` of an `Expression.symbol` which wraps the given value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The value to create a `Expression.symbol` from.
	///
	///  +  Returns:
	///     An `Expression.zeroOrMore`.
	@inlinable
	public static postfix func * (
		_ operand: Self
	) -> Expression
	{ .zeroOrMore(operand′) }

}
