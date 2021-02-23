//  #  E·B·N·F :: Swift.Array  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

extension Array {

	/// Returns an `Expression.choice` whose elements are taken from the provided `operand`.
	///
	/// `‖` is designed to work well with array literals:
	///
	///     ‖[.A′, .B′] == .choice([.symbol(.A), .symbol(.B)])
	///
	///  +  Note:
	///     This operator is `U+2016 ‖ DOUBLE VERTICAL LINE`, not two `U+007C | VERTICAL LINES`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Array` of `Expression`s.
	///
	///  +  Returns:
	///     A `Expression.choice` between the expressions in `operand`, or an equivalent expression.
	public static prefix func ‖ <Symbol> (
		_ operand: [Element]
	) -> Element
	where
		Symbol: Symbolic,
		Element == Symbol.Expression
	{
		let simplified = operand.flatMap { expr -> [Element] in
			if case .choice (
				let inner
			) = expr
			{ return inner }
			else
			{ return [expr] }
		}.reduce(into: [] as [Element]) { result, expr in
			guard let last = result.last
			else {
				result.append(expr)
				return
			}
			if
				case .anyOf (
					let bracket
				) = expr,
				case .anyOf (
					let lastBracket
				) = last
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.anyOf(lastBracket + bracket))
				)
			} else if
				case .character (
					let char
				) = expr,
				("\u{1}"..."\u{D7FF}" as ClosedRange<Text.Character> ~= char || "\u{E000}"..."\u{FFFD}" as ClosedRange<Text.Character> ~= char || "\u{10000}"..."\u{10FFFF}" as ClosedRange<Text.Character> ~= char),
				case .anyOf (
					let lastBracket
				) = last
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.anyOf(lastBracket + CollectionOfOne(BracketedComponent(char))))
				)
			} else if
				case .anyOf (
					let bracket
				) = expr,
				case .character (
					let lastChar
				) = last,
				("\u{1}"..."\u{D7FF}" as ClosedRange<Text.Character> ~= lastChar || "\u{E000}"..."\u{FFFD}" as ClosedRange<Text.Character> ~= lastChar || "\u{10000}"..."\u{10FFFF}" as ClosedRange<Text.Character> ~= lastChar)
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.anyOf(CollectionOfOne(BracketedComponent(lastChar)) + bracket))
				)
			} else if
				case .character (
					let char
				) = expr,
				("\u{1}"..."\u{D7FF}" as ClosedRange<Text.Character> ~= char || "\u{E000}"..."\u{FFFD}" as ClosedRange<Text.Character> ~= char || "\u{10000}"..."\u{10FFFF}" as ClosedRange<Text.Character> ~= char),
				case .character (
					let lastChar
				) = last,
				("\u{1}"..."\u{D7FF}" as ClosedRange<Text.Character> ~= lastChar || "\u{E000}"..."\u{FFFD}" as ClosedRange<Text.Character> ~= lastChar || "\u{10000}"..."\u{10FFFF}" as ClosedRange<Text.Character> ~= lastChar)
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.anyOf([BracketedComponent(lastChar), BracketedComponent(char)]))
				)
			} else
			{ result.append(expr) }
		}
		return simplified.count == 1 ? simplified[0] : .choice(simplified)
	}

	/// Returns an `Expression.sequence` of the `operand`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Array` of `Expression`s.
	///
	///  +  Returns:
	///     A `Expression.sequence` of the expressions in `operand`, or an equivalent expression.
	@inlinable
	public static postfix func ′ <Symbol> (
		_ operand: [Element]
	) -> Element
	where
		Symbol: Symbolic,
		Element == Symbol.Expression
	{
		let simplified = operand.flatMap { expr -> [Element] in
			if case .sequence (
				let inner
			) = expr
			{ return inner }
			else
			{ return [expr] }
		}.reduce(into: [] as [Element]) { result, expr in
			guard let last = result.last
			else {
				result.append(expr)
				return
			}
			if
				case .string (
					let str
				) = expr,
				case .string (
					let lastStr
				) = last
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.string(str + lastStr))
				)
			} else if
				case .character (
					let char
				) = expr,
				case .string (
					let lastStr
				) = last
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.string(Text(CollectionOfOne(char) + lastStr)))
				)
			} else if
				case .string (
					let str
				) = expr,
				case .character (
					let lastChar
				) = last
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.string(Text(str + CollectionOfOne(lastChar))))
				)
			} else if
				case .character (
					let char
				) = expr,
				case .character (
					let lastChar
				) = last
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.string(Text([char, lastChar])))
				)
			} else
			{ result.append(expr) }
		}
		return simplified.count == 1 ? simplified[0] : .sequence(simplified)
	}

}

extension Array
where Element == Text.Character {

	/// Returns whether the characters of this `Array` start with something which matches the provided `expression`.
	///
	/// <https://www.w3.org/TR/xml11/#dt-match>.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  expression:
	///         An `Expressible`.
	///      +  version:
	///         The `VersionProtocol` to use when matching.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public func starts <Expressed> (
		with expression: Expressed,
		version: Expressed.Symbol.Version = .default
	) -> Bool
	where Expressed: Expressible {
		Text(self).starts(
			with: expression,
			version: version
		)
	}

	/// Returns whether the characters of this `Array` exactly match the provided `expression`.
	///
	/// <https://www.w3.org/TR/xml11/#dt-match>.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  expression:
	///         An `Expressible`.
	///      +  version:
	///         The `VersionProtocol` to use when matching.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public func matches <Expressed> (
		_ expression: Expressed,
		version: Expressed.Symbol.Version = .default
	) -> Bool
	where Expressed: Expressible {
		Text(self).matches(
			expression,
			version: version
		)
	}

	/// Returns whether the characters of the provided `Array` exactly match a given `expression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Expressible`.
	///      +  r·h·s:
	///         A `Array` whose `Element` is `Text.Character`.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public static func ~= <Expressed> (
		_ l·h·s: Expressed,
		_ r·h·s: [Text.Character]
	) -> Bool
	where Expressed: Expressible
	{ Text(r·h·s).matches(l·h·s) }

}
