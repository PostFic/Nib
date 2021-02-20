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
	///         An `[Expression]`.
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
				case .noneOf (
					let bracket
				) = expr,
				case .noneOf (
					let lastBracket
				) = last
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.noneOf(lastBracket + bracket))
				)
			} else if
				case .character (
					let char
				) = expr,
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
				) = last
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.anyOf(CollectionOfOne(BracketedComponent(lastChar)) + bracket))
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
					with: CollectionOfOne(.anyOf([BracketedComponent(lastChar), BracketedComponent(char)]))
				)
			} else
			{ result.append(expr) }
		}
		return simplified.count == 1 ? simplified[0] : .choice(simplified)
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
	///      +  expression:
	///         An `Expressible`.
	///      +  r·h·s:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public static func ~= <Expressed> (
		_ l·h·s: Expressed,
		_ r·h·s: Self
	) -> Bool
	where Expressed: Expressible
	{ Text(r·h·s).matches(l·h·s) }

}
