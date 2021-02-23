//  #  E·B·N·F :: BracketedComponent  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A single `Unicode.Scalar` or `ClosedRange<Unicode.Scalar>`, as present within a set of brackets in the XML EBNF syntax.
///
///  +  Note:
///     Single characters are expressed as ranges whose `.lowerBound` and `.upperBound` are the same.
///
///  +  Version:
///     `0.1.0`.
public struct BracketedComponent:
	Hashable
{

	/// The range of characters represented by this component.
	public let range: ClosedRange<Unicode.Scalar>

	/// Creates a `BracketedComponent` from a single `Unicode.Scalar`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  character:
	///         The `Unicode.Scalar` which this `BracketedComponent` represents.
	public init (
		_ character: Unicode.Scalar
	) { range = character...character }

	/// Creates a `BracketedComponent` from a `ClosedRange<Unicode.Scalar>`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  range:
	///         The `ClosedRange<Unicode.Scalar>` which this `BracketedComponent` represents.
	public init (
		_ range: ClosedRange<Unicode.Scalar>
	) { self.range = range }

	/// Returns whether this `BracketedComponent` matches a given `Unicode.Scalar`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  character:
	///         The `Unicode.Scalar` to test.
	///
	///  +  Returns:
	///     `true` if `character` is contained by this `BracketedComponent`; `false` otherwise.
	@inlinable
	public func matches (
		_ character: Unicode.Scalar
	) -> Bool
	{ range ~= character }

	/// Returns whether a given `BracketedComponent` matches a given `Unicode.Scalar`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  lhs:
	///         The `BracketedComponent` to match against.
	///      +  rhs:
	///         The `Unicode.Scalar` to test.
	///
	///  +  Returns:
	///     `true` if `character` is contained by this `BracketedComponent`; `false` otherwise.
	@inlinable
	public static func ~= (
		_ lhs: BracketedComponent,
		_ rhs: Unicode.Scalar
	) -> Bool
	{ lhs.matches(rhs) }


	/// Escapes all nonprintable ASCII characters as `£N;`, where `N` is the Unicode codepoint (in hexadecimal).
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  char:
	///         The `Unicode.Scalar` to escape.
	///
	///  +  Returns:
	///     A `String` escaping the `Text.Character` if necessary.
	private static func charString (
		_ char: Unicode.Scalar
	) -> String {
		return "!"..."~" as ClosedRange<Unicode.Scalar> ~= char ? String(char) : """
			£\(
				String(
					UInt32(char),
					radix: 16,
					uppercase: true
				)
			);
			"""
	}

}

extension BracketedComponent:
	CustomStringConvertible
{

	/// `£N;` for single characters, and `£M;–£N;` for ranges.
	///
	/// The literal character is used instead of the escaped counterpart for printable ASCII characters (not including space).
	///
	///  +  Note:
	///     The character used to delimit ranges is `U+2013 EN DASH`, not `U+002D HYPHEN-MINUS`.
	///     The latter may appear literally in strings.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	public var description: String
	{ range.lowerBound == range.upperBound ? BracketedComponent.charString(range.lowerBound) : "\(BracketedComponent.charString(range.lowerBound))–\(BracketedComponent.charString(range.upperBound))" }

}

extension BracketedComponent:
	ExpressibleByUnicodeScalarLiteral
{

	/// Creates a `BracketedComponent` from a Unicode scalar literal.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  value:
	///         The `Unicode.Scalar` which this `BracketedComponent` represents.
	public init(
		unicodeScalarLiteral value: Unicode.Scalar
	) { range = value...value }

}
