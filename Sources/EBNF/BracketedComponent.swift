//  # EBNF :: BracketedComponent
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// A single `Character` or `ClosedRange<Character>`, as present within a set of brackets in the XML EBNF syntax.
///
///  +  note:
///     Single characters are expressed as ranges whose `.lowerBound` and `.upperBound` are the same.
public struct BracketedComponent:
	CustomStringConvertible,
	ExpressibleByUnicodeScalarLiteral,
	Hashable
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

	/// The range of characters represented by this component.
	public let range: ClosedRange<Character>

	/// Initializes a `BracketedComponent` from a single `Character`.
	///
	///  +  parameters:
	///      +  character:
	///         The `Character` which this `BracketedComponent` represents.
	public init (
		_ character: Character
	) { range = character...character }

	/// Initializes a `BracketedComponent` from a `ClosedRange<Character>`.
	///
	///  +  parameters:
	///      +  range:
	///         The `ClosedRange<Character>` which this `BracketedComponent` represents.
	public init (
		_ range: ClosedRange<Character>
	) { self.range = range }

	/// Initializes a `BracketedComponent` from a unicode scalar literal.
	///
	///  +  parameters:
	///      +  value:
	///         The `Character` which this `BracketedComponent` represents.
	public init(
		unicodeScalarLiteral value: Character
	) { range = value...value }

	/// Whether this `BracketedComponent` matches a given `Character`.
	///
	///  +  parameters:
	///      +  character:
	///         The `Character` to test.
	///
	///  +  returns:
	///     `true` if `character` matches `XML11.Grammar.Char` and contains `character`; `false` otherwise.
	///
	///  +  note:
	///     `.matches(:)` always returns `false` for `Character`s which are not an XML `Char`.
	public func matches (
		_ character: Character
	) -> Bool
	{ (("\u{1}"..."\u{D7FF}").contains(character) || ("\u{E000}"..."\u{FFFD}").contains(character) || ("\u{10000}"..."\u{10FFFF}").contains(character)) && range.contains(character) }

}
