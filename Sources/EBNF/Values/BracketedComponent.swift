//  #  EBNF :: BracketedComponent  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import Core

/// A single `Text.Character` or `ClosedRange<Text.Character>`, as present within a set of brackets in the XML EBNF syntax.
///
///  +  Note:
///     Single characters are expressed as ranges whose `.lowerBound` and `.upperBound` are the same.
public struct BracketedComponent:
	Hashable
{

	/// The range of characters represented by this component.
	public let range: ClosedRange<Text.Character>

	/// Creates a `BracketedComponent` from a single `Text.Character`.
	///
	///  +  Parameters:
	///      +  character:
	///         The `Text.Character` which this `BracketedComponent` represents.
	public init (
		_ character: Text.Character
	) { range = character...character }

	/// Creates a `BracketedComponent` from a `ClosedRange<Text.Character>`.
	///
	///  +  Parameters:
	///      +  range:
	///         The `ClosedRange<Text.Character>` which this `BracketedComponent` represents.
	public init (
		_ range: ClosedRange<Text.Character>
	) { self.range = range }

	/// Returns whether this `BracketedComponent` matches a given `Text.Character`.
	///
	///  +  Parameters:
	///      +  character:
	///         The `Text.Character` to test.
	///
	///  +  Returns:
	///     `true` if `character` is an XML `Char` and is contained by this `BracketedComponent`; `false` otherwise.
	///
	///  +  Note:
	///     `.matches(:)` always returns `false` for `Text.Character`s which are not an XML `Char`.
	public func matches (
		_ character: Text.Character
	) -> Bool
	{ ("\u{1}"..."\u{D7FF}" ~= character || "\u{E000}"..."\u{FFFD}" ~= character || "\u{10000}"..."\u{10FFFF}" ~= character) && range ~= character }

	/// Returns whether a given `BracketedComponent` matches a given `Text.Character`.
	///
	///  +  Parameters:
	///      +  lhs:
	///         The `BracketedComponent` to match against.
	///      +  rhs:
	///         The `Text.Character` to test.
	///
	///  +  Returns:
	///     `true` if `character` is an XML `Char` and is contained by this `BracketedComponent`; `false` otherwise.
	///
	///  +  Note:
	///     `~=` always returns `false` for `Text.Character`s which are not an XML `Char`.
	@inlinable
	public static func ~= (
		_ lhs: BracketedComponent,
		_ rhs: Text.Character
	) -> Bool
	{ lhs.matches(rhs) }

}

extension BracketedComponent:
	CustomStringConvertible
{

	/// `#xN` for single characters, and `#xM-#xN` for ranges.
	public var description: String {
		range.lowerBound == range.upperBound ? """
			#x\(
				String(
					UInt32(range.lowerBound),
					radix: 16,
					uppercase: true
				)
			)
			"""
		: """
			#x\(
				String(
					UInt32(range.lowerBound),
					radix: 16,
					uppercase: true
				)
			)-#x\(
				String(
					UInt32(range.upperBound),
					radix: 16,
					uppercase: true
				)
			)
			"""
	}

}

extension BracketedComponent:
	ExpressibleByUnicodeScalarLiteral
{

	/// Creates a `BracketedComponent` from a unicode scalar literal.
	///
	///  +  Parameters:
	///      +  value:
	///         The `Character` which this `BracketedComponent` represents.
	public init(
		unicodeScalarLiteral value: Text.Character
	) { range = value...value }

}
