//  #  E·B·N·F :: Swift.Array  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension Array {

	/// Returns an `Expression.choice` whose elements are taken from the provided `operand`.
	///
	/// `∑` is designed to work well with array literals:
	///
	///     ∑[.A′, .B′] == .choice([.symbol(.A), .symbol(.B)])
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
	///     A `Expression.choice` between the expressions in `operand`, or an equivalent expression.
	public static prefix func ∑ <Symbol> (
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
				^[] as DescriptionSymbol.Expression ~= CollectionOfOne(char),
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
				^[] as DescriptionSymbol.Expression ~= CollectionOfOne(lastChar)
			{
				result.replaceSubrange(
					result.endIndex - 1 ..< result.endIndex,
					with: CollectionOfOne(.anyOf(CollectionOfOne(BracketedComponent(lastChar)) + bracket))
				)
			} else if
				case .character (
					let char
				) = expr,
				^[] as DescriptionSymbol.Expression ~= CollectionOfOne(char),
				case .character (
					let lastChar
				) = last,
				^[] as DescriptionSymbol.Expression ~= CollectionOfOne(lastChar)
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
	public static prefix func ∏ <Symbol> (
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
					with: CollectionOfOne(.string(String.UnicodeScalarView(CollectionOfOne(char) + lastStr)))
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
					with: CollectionOfOne(.string(String.UnicodeScalarView(str + CollectionOfOne(lastChar))))
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
					with: CollectionOfOne(.string(String.UnicodeScalarView([char, lastChar])))
				)
			} else
			{ result.append(expr) }
		}
		return simplified.count == 1 ? simplified[0] : .sequence(simplified)
	}

}
