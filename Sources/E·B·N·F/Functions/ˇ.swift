//  #  E·B·N·F :: ˇ  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Returns an `Expression.choice` whose elements are taken from the provided `expressions`.
///
///  +  Note:
///     The name of this function is `U+02C7 ˇ CARON`.
///     It was chosen for its visual similarity to `U+2228 ∨ LOGICAL OR`.
///
///  +  Authors:
///     [kibigo!](https://go.KIBI.family/About/#me).
///
///  +  Version:
///     `0.2.0`.
///
///  +  Parameters:
///      +  expressions:
///         Some `Expression`s.
///
///  +  Returns:
///     A `Expression.choice` between the expressions in `expressions`, or an equivalent expression.
public func ˇ <Symbol> (
	_ expressions: Symbol.Expression...
) -> Symbol.Expression
where Symbol : Symbolic {
	let simplified = expressions.flatMap { expr -> [Symbol.Expression] in
		if case .choice (
			let inner
		) = expr
		{ return inner }
		else
		{ return [expr] }
	}.reduce(into: [] as [Symbol.Expression]) { result, expr in
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
