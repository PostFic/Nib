//  #  E·B·N·F :: ˆ  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Returns an `Expression.sequence` whose elements are taken from the provided `expressions`.
///
///  +  Note:
///     The name of this function is `U+02C6 ˆ MODIFIER LETTER CIRCUMFLEX ACCENT`.
///     It was chosen for its visual similarity to `U+2227 ∧ LOGICAL AND`.
///
///  +  Important:
///     Do not confuse this function with `U+005E ^ CIRCUMFLEX ACCENT`, which is an operator.
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
///     A `Expression.sequence` of the expressions in `expressions`, or an equivalent expression.
public func ˆ <Symbol> (
	_ expressions: Symbol.Expression...
) -> Symbol.Expression
where Symbol : Symbolic {
	let simplified = expressions.flatMap { expr -> [Symbol.Expression] in
		if case .sequence (
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
