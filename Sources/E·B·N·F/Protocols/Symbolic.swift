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

	/// The `String` name of this value.
	///
	///  +  Version:
	///     `0.2.0`.
	var name: String
	{ get }

	/// The `String` reference identifier of this value, if one is defined.
	///
	///  +  Version:
	///     `0.2.0`.
	var reference: String?
	{ get }

	/// Creates a `Symbol` with the given `name`.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  name:
	///         The `String` name of the `Symbol` to create.
	init? (
		name: String
	)

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
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `LosslessTextConvertible` value.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Throws:
	///     A `ParseError` if the `expression` of this `Symbolic` does not match the beginning of the provided `text`.
	///
	///  +  Returns:
	///     A `Construct.symbol`.
	func extract <TextConvertible> (
		from text: TextConvertible,
		version: Version
	) throws -> Construct
	where TextConvertible : LosslessTextConvertible

	/// Returns a `Construct.symbol` parsed from the provided `text` according to the `expression` of this `Symbolic`, or throws.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `LosslessTextConvertible` value.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Throws:
	///     A `ParseError` if the `expression` of this `Symbolic` does not exactly match the provided `text`.
	///
	///  +  Returns:
	///     A `Construct.symbol`.
	func parse <TextConvertible> (
		_ text: TextConvertible,
		version: Version
	) throws -> Construct
	where TextConvertible : LosslessTextConvertible

}

public extension Symbolic {

	/// The `Construct`s produced by this `Symbolic`.
	///
	///  +  Version:
	///     `0.1.0`.
	typealias Construct = E·B·N·F.Construct<Self>

	/// The `Expression`s produced by this `Symbolic`.
	///
	///  +  Version:
	///     `0.1.0`.
	typealias Expression = E·B·N·F.Expression<Self>

	/// The name of this `Symbolic`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	var description: String
	{ name }

	/// The name of this `Symbolic`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	var name: String
	{ rawValue }

	/// Creates the `Symbol` whose `.rawValue` matches the given `name`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  name:
	///         The `String` name of the `Symbol` to create.
	@inlinable
	init? (
		name: String
	) { self.init(rawValue: name) }

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
	@inlinable
	func debugDescription (
		version: Version
	) -> String {
		let expressionString: String
		if let expression = self(version) {
			expressionString = String(
				describing: expression
			)
		} else
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
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `LosslessTextConvertible` value.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Throws:
	///     A `ParseError` if the `expression` of this `Symbolic` does not match the beginning of the provided `text`.
	///
	///  +  Returns:
	///     A `Construct.symbol`.
	@inlinable
	func extract <TextConvertible> (
		from text: TextConvertible,
		version: Version = Version.default
	) throws -> Construct
	where TextConvertible : LosslessTextConvertible {
		try self®.extract(
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
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `LosslessTextConvertible` value.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Returns:
	///     A `Construct.symbol`.
	@inlinable
	func parse <TextConvertible> (
		_ text: TextConvertible,
		version: Version = Version.default
	) throws -> Construct
	where TextConvertible : LosslessTextConvertible {
		try self®.parse(
			text,
			version: version
		)[0]
	}

	/// Returns an `Expression.symbol` which wraps the given value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The value to create a `Expression.symbol` from.
	///
	///  +  Returns:
	///     An `Expression.symbol`.
	@inlinable
	static postfix func ® (
		_ operand: Self
	) -> Expression
	{ .symbol(operand) }

	/// Returns an `Expression.zeroOrOne` of an `Expression.symbol` which wraps the given value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The value to create a `Expression.symbol` from.
	///
	///  +  Returns:
	///     An `Expression.zeroOrOne`.
	@inlinable
	static postfix func ^? (
		_ operand: Self
	) -> Expression
	{ .zeroOrOne(operand®) }

	/// Returns an `Expression.oneOrMore` of an `Expression.symbol` which wraps the given value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The value to create a `Expression.symbol` from.
	///
	///  +  Returns:
	///     An `Expression.oneOrMore`.
	@inlinable
	static postfix func ^+ (
		_ operand: Self
	) -> Expression
	{ .oneOrMore(operand®) }

	/// Returns an `Expression.zeroOrMore` of an `Expression.symbol` which wraps the given value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         The value to create a `Expression.symbol` from.
	///
	///  +  Returns:
	///     An `Expression.zeroOrMore`.
	@inlinable
	static postfix func ^* (
		_ operand: Self
	) -> Expression
	{ .zeroOrMore(operand®) }

}
