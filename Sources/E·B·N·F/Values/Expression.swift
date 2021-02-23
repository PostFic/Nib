//  #  E·B·N·F :: Expression  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

/// An enumerated type representing an EBNF expression, potentially containing subexpressions.
///
///  +  Note:
///     `Expression`s are matched using a naive greedy approach which is sufficient for XML but may not match all possible strings in other contexts.
///     In particular, rules of the following form will always fail:
///
///         neverMatches ::= A* A B
///
///  +  Version:
///     `0.1.0`.
public enum Expression <Symbol>:
	Versionable
where Symbol: Symbolic {

	/// An EBNF gobbling error.
	private struct GobbleError:
		Swift.Error
	{

		/// The expression which produced the error.
		fileprivate let failedExpression: Symbol.Expression

		/// The text which failed to match.
		fileprivate let text: Text.SubSequence

		/// Creates a new gobbling error from the `text` and `expression`.
		///
		///  +  Authors:
		///     [kibigo!](https://go.KIBI.family/About/#me).
		fileprivate init (
			_ text: Text.SubSequence,
			_ expression: Symbol.Expression
		) {
			failedExpression = expression
			self.text = text
		}

	}

	/// The type of versioning associated with an `Expression`’s associated `Symbol`s.
	///
	///  +  Version:
	///     `0.1.0`.
	public typealias Version = Symbol.Version

	/// Match a single `Text.Character`.
	///
	///     £N;
	///
	///  +  Version:
	///     `0.1.0`.
	case character (
		Text.Character
	)

	/// Match any `Text.Character` matched by the `BracketedExpression`.
	///
	///     ⟨£I;£J;£K;⟩
	///     ⟨£M;–£N;⟩
	///
	///  +  Version:
	///     `0.1.0`.
	case anyOf (
		BracketedExpression
	)

	/// Match any `Text.Character` not matched by the `BracketedExpression`.
	///
	///     ⟨∼£I;£J;£K;⟩
	///     ⟨∼£M;–£N;⟩
	///
	///  +  Version:
	///     `0.1.0`.
	case noneOf (
		BracketedExpression
	)

	/// Match the literal `Text.Character`s in the `String`.
	///
	///     ‹string›
	///
	///  +  Version:
	///     `0.1.0`.
	case string (
		Text
	)

	/// Match a `Symbol`.
	///
	///     symbol
	///
	///  +  Version:
	///     `0.1.0`.
	indirect case symbol (
		Symbol
	)

	/// Match any of the associated `Expression`s.
	///
	///     (A | B | C)
	///
	///  +  Version:
	///     `0.1.0`.
	indirect case choice (
		[Symbol.Expression]
	)

	/// Match each of the associated `Expression`s in order.
	///
	///     (A B C)
	///
	///  +  Version:
	///     `0.1.0`.
	indirect case sequence (
		[Symbol.Expression]
	)

	/// Match anything which matches the first `Expression`, but not the second.
	///
	///     (A − B)
	///
	///  +  Note:
	///     `.excluding` only checks for an exact match with the second `Expression`.
	///     Use `.notIncluding` to check if the second `Expression` matches any substring.
	///
	///  +  Version:
	///     `0.1.0`.
	indirect case excluding (
		Symbol.Expression,
		Symbol.Expression
	)

	/// Match anything which matches the first `Expression`, up until the first instance of the second.
	///
	///     (A ÷ B)
	///
	///  +  Note:
	///     The XML specification specifies this as `A − (Char* B Char*)` (or equivalent).
	///     It is treated specially here because the Nib engine is a greedy parser, and `Char* B` will never match.
	///
	///  +  Version:
	///     `0.1.0`.
	indirect case notIncluding (
		Symbol.Expression,
		Symbol.Expression
	)

	/// Match anything which matches the associated `Expression` zero or one times.
	///
	///     (A?)
	///
	///  +  Version:
	///     `0.1.0`.
	indirect case zeroOrOne (
		Symbol.Expression
	)

	/// Match anything which matches the associated `Expression` one or more times.
	///
	///     (A+)
	///
	///  +  Version:
	///     `0.1.0`.
	indirect case oneOrMore (
		Symbol.Expression
	)

	/// Match anything which matches the associated `Expression` zero or more times.
	///
	///     (A×)
	///
	///  +  Version:
	///     `0.1.0`.
	indirect case zeroOrMore (
		Symbol.Expression
	)

	/// Whether an `Expression` is terminal.
	///
	/// An `Expression` is terminal if it is not `.symbol` and all of its subexpressions are terminal.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	public var isTerminal: Bool {
		switch self {
			case
				.character,
				.anyOf,
				.noneOf,
				.string
			: return true
			case .symbol:
				return false
			case
				.choice (
					let exprs
				),
				.sequence (
					let exprs
				)
			: return exprs.allSatisfy { $0.isTerminal }
			case
				.excluding (
					let A,
					let B
				),
				.notIncluding (
					let A,
					let B
				)
			: return A.isTerminal && B.isTerminal
			case
				.zeroOrOne (
					let A
				),
				.oneOrMore (
					let A
				),
				.zeroOrMore (
					let A
				)
			: return A.isTerminal
		}
	}

	/// Makes an `Expression` from a `.description` string, if possible.
	///
	///  +  Note:
	///     Converting an `Expression` to and from a string is not necessarily lossless, but the resulting `Expression` will be equivalent (match exactly the same `Text`s).
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	public init? (
		_ description: String
	) {
		typealias X = DescriptionSymbol.Expression
		guard
			let (
				endIndex,
				expression
			) = Symbol.Expression.gobbleExpression(
				description.unicodeScalars[
					(
						(
							try? (X.S | X.comment)″.extract(
								from: description.unicodeScalars
							)
						)?.last?.text.endIndex ?? description.startIndex
					)...
				]
			),
			endIndex == description.unicodeScalars.endIndex || (
				try? (X.S | X.comment)″.extract(
					from: description.unicodeScalars[endIndex...]
				)
			)?.last?.text.endIndex == description.endIndex
		else
		{ return nil }
		self = expression
	}

	/// Returns an `Array` of `Construct`s matching this `Expression` from the beginning of the provided `text`, or throws.
	///
	///  +  Note:
	///     This `Expression` need not match the entire `text` for `.extract(from:version:)` to return a value.
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
	///     A `ParseError` if this `Expression` does not match the beginning of the provided `text`.
	///
	///  +  Returns:
	///     An `Array` of `Construct`s.
	public func extract <T> (
		from text: T,
		version: Version = Version.default
	) throws -> [Symbol.Construct]
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{
		let view = text[...]
		do {
			let (
				_,
				contained
			) = try gobble(view, version)
			return contained
		} catch let error as GobbleError {
			throw ParseError(
				view,
				at: error.text.startIndex,
				failed: error.failedExpression,
				version: version
			)
		}
	}

	/// Returns a tuple consisting of a `Text.Index`, signifying where matching ended, and an `Array` of `Construct`s matching this `Expression` from the beginning of the provided `view`, or throws.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  view:
	///         A `Text.SubSequence`.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Throws:
	///     A `GobbleError` if this `Expression` does not match the beginning of the provided `text`.
	///
	///  +  Returns:
	///     A tuple consisting of a `Text.Index` and an `Array` of `Construct`s.
	private func gobble (
		_ view: Text.SubSequence,
		_ version: Version
	) throws -> (
		Text.SubSequence.Index,
		[Symbol.Construct]
	) {
		let failure = GobbleError(view, self)
		switch self {
			case
				.character,
				.anyOf,
				.noneOf
			:
				guard let character = view.first
				else
				{ throw failure }
				switch self {
					case
						.anyOf (
							let bracketed
						) where ("\u{1}"..."\u{D7FF}" as ClosedRange<Text.Character> ~= character || "\u{E000}"..."\u{FFFD}" as ClosedRange<Text.Character> ~= character || "\u{10000}"..."\u{10FFFF}" as ClosedRange<Text.Character> ~= character) && bracketed.contains { $0 ~= character },
						.noneOf (
							let bracketed
						) where ("\u{1}"..."\u{D7FF}" as ClosedRange<Text.Character> ~= character || "\u{E000}"..."\u{FFFD}" as ClosedRange<Text.Character> ~= character || "\u{10000}"..."\u{10FFFF}" as ClosedRange<Text.Character> ~= character) && !(bracketed.contains { $0 ~= character })
					: break
					case
						.character (
							let char
						) where character == char
					: break
					default:
						throw failure
				}
				return (
					view.index(
						after: view.startIndex
					), [
						.string(
							content: view.prefix(1)
						)
					]
				)
			case .string (
				let string
			):
				var iterator = view.indices.lazy.map { ($0, view[$0]) }.makeIterator()
				var charIterator = string.makeIterator()
				while let char = charIterator.next() {
					guard
						let (
							_,
							character
						) = iterator.next(),
						char == character
					else
					{ throw failure }
				}
				let end = iterator.next()?.0 ?? view.endIndex
				return (
					end,
					[
						.string(
							content: view[..<end]
						)
					]
				)
			case .symbol (
				let symbol
			):
				guard let expression = symbol[version]
				else
				{ throw failure }
				do {
					let (
						end,
						contained
					) = try expression.gobble(view, version)
					return (
						end,
						[
							.symbol(
								symbol,
								version: version,
								content: contained
							)
						]
					)
				} catch let error as GobbleError
				where error.text.startIndex == view.startIndex
				{ throw failure }
			case .choice (
				let exprs
			):
				for expr in exprs {
					if let result = try? expr.gobble(view, version)
					{ return result }
				}
				throw failure
			case .sequence (
				let exprs
			):
				var current = view.startIndex
				var allContained: [Construct<Symbol>] = []
				for expr in exprs {
					let (
						end,
						contained
					) = try expr.gobble(view[current...], version)
					Symbol.Expression.collect(
						&allContained,
						contained,
						in: view
					)
					current = end
				}
				return (current, allContained)
			case .excluding (
				let A,
				let B
			):
				let (
					end,
					contained
				) = try A.gobble(view, version)
				if
					let (
						notEnd,
						_
					) = try? B.gobble(view, version),
					end == notEnd
				{ throw failure }
				else
				{ return (end, contained) }
			case .notIncluding (
				let A,
				let B
			):
				let result = try A.gobble(view, version)
				if let firstBIndex = (view.indices.first { (try? B.gobble(view[$0...], version)) != nil }) {
					do
					{ return try A.gobble(view[view.startIndex..<firstBIndex], version) }
					catch
					{ throw failure }
				} else
				{ return result }
			case .oneOrMore (
				let A
			):
				var current = view.startIndex
				var allContained: [Construct<Symbol>] = []
				while let (
					end,
					contained
				) = try? A.gobble(view[current...], version) {
					Symbol.Expression.collect(  //  collect empty before returning
						&allContained,
						contained,
						in: view
					)
					if current == end
					{ return (end, allContained) }
					else
					{ current = end }
					if end == view.endIndex
					{ break }
				}
				if allContained.count == 0
				{ throw failure }
				else
				{ return (current, allContained) }
			case .zeroOrMore (let A):
				var current = view.startIndex
				var allContained: [Construct<Symbol>] = []
				while let (
					end,
					contained
				) = try? A.gobble(view[current...], version) {
					if current == end  //  do not collect empty before returning
					{ return (end, allContained) }
					else {
						Symbol.Expression.collect(
							&allContained,
							contained,
							in: view
						)
						current = end
					}
					if end == view.endIndex
					{ break }
				}
				return (current, allContained)
			case .zeroOrOne (
				let A
			): return (try? A.gobble(view, version)) ?? (view.startIndex, [])
		}
	}

	/// Returns whether this `Expression` exactly matches the provided `text`.
	///
	/// <https://www.w3.org/TR/xml11/#dt-match>.
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
	public func matches <T> (
		_ text: T,
		version: Version = Version.default
	) -> Bool
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{
		(
			try? self.parse(
				text,
				version: version
			)
		) != nil
	}

	/// Returns a tree of `Construct`s parsed from the provided `text`, or throws.
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
	///     A `ParseError` if this `Expression` does not exactly match the provided `text`.
	///
	///  +  Returns:
	///     An `Array` of `Construct`s.
	public func parse <T> (
		_ text: T,
		version: Version = Version.default
	) throws -> [Symbol.Construct]
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{
		let view = text[...]
		let (
			end,
			result
		) = try self.gobble(view, version)
		if end == text.endIndex
		{ return result }
		else {
			throw ParseError(
				view,
				at: text.startIndex,
				failed: self,
				exhaustive: true
			)
		}
	}

	/// Adds an `Array` of `Construct`s to another `Array` of `Construct`s , merging the `.string`s on the boundary.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  collection:
	///         The `Array` of `Construct`s to add to.
	///      +  addition:
	///         The `Array` of `Construct`s to add.
	///      +  view:
	///         A `Text.SubSequence` which is a supersequence of the `.text`s of all of the `Construct`s.
	private static func collect (
		_ collection: inout [Symbol.Construct],
		_ addition: [Symbol.Construct],
		in view: Text.SubSequence
	) {
		if
			let prev = collection.last,
			let next = addition.first,
			case .string (
				content: let prevSub
			) = prev,
			case .string (
				content: let nextSub
			) = next
		{
			collection = collection.dropLast() + CollectionOfOne(
				.string(
					content: view[prevSub.startIndex..<nextSub.endIndex]
				)
			)
		} else
		{ collection += addition }
	}

	/// Gobbles an expression description from the beginning of the provided `text` and returns a tuple of the end·index of the match and the expression produced.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  text:
	///         A `Text.SubSequence` to gobble from.
	///
	///  +  Returns:
	///     A `(Text.SubSequence.Index, Symbol.Expression)` tuple of the end·index of the match and the resulting expression; or `nil` if no expression was found.
	private static func gobbleExpression (
		_ text: Text.SubSequence
	) -> (
		Text.SubSequence.Index,
		Symbol.Expression
	)? {
		typealias X = DescriptionSymbol.Expression
		guard
			let construct = (
				try? X.expression.extract(
					from: text
				)
			)?.first,
			let symbol = construct.symbol
		else
		{ return nil }
		let match = construct.text
		switch symbol {
			case .character:
				guard
					let codepoint = UInt32(
						Substring(match.dropFirst().dropLast()),
						radix: 16
					),
					let char = Text.Character(codepoint)
				else
				{ return nil }
				return (match.endIndex, .character(char))
			case
				.anyOf,
				.noneOf
			:
				let isNegative: Bool
				var index = match.index(
					after: match.startIndex
				)
				if match[index] == "∼" {
					index = match.index(
						after: index
					)
					isNegative = true
				} else
				{ isNegative = false }
				var bra·ket·d = BracketedExpression()
				while index < match.index(
					before: match.endIndex
				) {
					let startChar: Text.Character
					if match[index] == "£" {
						guard
							let (
								charEnd,
								charExpr
							) = Symbol.Expression.gobbleExpression(match[index...]),
							case .character (
								let char
							) = charExpr
						else
						{ return nil }
						index = charEnd
						startChar = char
					} else {
						startChar = match[index]
						index = match.index(
							after: index
						)
					}
					guard match[index] == "–"
					else {
						bra·ket·d.append(startChar...startChar)
						continue
					}
					let endChar: Text.Character
					index = match.index(
						after: index
					)
					if match[index] == "£" {
						guard
							let (
								charEnd,
								charExpr
							) = Symbol.Expression.gobbleExpression(match[index...]),
							case .character(
								let char
							) = charExpr
						else
						{ return nil }
						index = charEnd
						endChar = char
					} else {
						endChar = match[index]
						index = match.index(
							after: index
						)
					}
					guard startChar <= endChar
					else
					{ return nil }
					bra·ket·d.append(startChar...endChar)
				}
				return (match.endIndex, isNegative ? .noneOf(bra·ket·d) : .anyOf(bra·ket·d))
			case .string:
				return (match.endIndex, .string(Text(match.dropFirst().dropLast())))
			case .symbol:
				guard let symbol = (Symbol.allCases.first { $0.name.elementsEqual(construct.text) })
				else
				{ return nil }
				return (match.endIndex, .symbol(symbol))
			case .choice:
				var index = (
					try? (X.S | X.comment)″.extract(
						from: match.dropFirst()
					)
				)?.last?.text.endIndex ?? match.index(
					after: match.startIndex
				)
				var exprs: [Symbol.Expression] = []
				do {
					guard let (
						exprEnd,
						expr
					) = Symbol.Expression.gobbleExpression(match[index...])
					else
					{ return nil }
					exprs.append(expr)
					index = (
						try? (X.S | X.comment)″.extract(
							from: match[exprEnd...]
						)
					)?.last?.text.endIndex ?? exprEnd
				}
				while index < match.index(
					before: match.endIndex
				) {
					guard
						let exprStart = (
							try? ["|", (X.S | X.comment)*]′.extract(
								from: match[index...]
							)
						)?.last?.text.endIndex,
						let (
							exprEnd,
							expr
						) = Symbol.Expression.gobbleExpression(match[exprStart...])
					else { return nil }
					exprs.append(expr)
					index = (
						try? (X.S | X.comment)″.extract(
							from: match[exprEnd...]
						)
					)?.last?.text.endIndex ?? exprEnd
				}
				return (match.endIndex, .choice(exprs))
			case .sequence:
				var index = (
					try? (X.S | X.comment)″.extract(
						from: match.dropFirst()
					)
				)?.last?.text.endIndex ?? match.index(
					after: match.startIndex
				)
				var exprs: [Symbol.Expression] = []
				do {
					guard index < match.index(
						before: match.endIndex
					) else
					{ return (match.endIndex, .sequence(exprs)) }
					guard let (
						exprEnd,
						expr
					) = Symbol.Expression.gobbleExpression(match[index...])
					else
					{ return nil }
					exprs.append(expr)
					index = (
						try? X.comment″.extract(
							from: match[exprEnd...]
						)
					)?.last?.text.endIndex ?? exprEnd
				}
				while index < match.index(
					before: match.endIndex
				) {
					guard
						let exprStart = (
							try? [X.S, [X.comment, X.S°]*]′.extract(
								from: match[index...]
							)
						)?.last?.text.endIndex,
						let (
							exprEnd,
							expr
						) = Symbol.Expression.gobbleExpression(match[exprStart...])
					else { return nil }
					exprs.append(expr)
					index = (
						try? X.comment″.extract(
							from: match[exprEnd...]
						)
					)?.last?.text.endIndex ?? exprEnd
				}
				return (match.endIndex, .sequence(exprs))
			case
				.excluding,
				.notIncluding
			:
				guard
					let (
						endA,
						exprA
					) = Symbol.Expression.gobbleExpression(
						match[
							(
								(
									try? (X.S | X.comment)″.extract(
										from: match.dropFirst()
									)
								)?.last?.text.endIndex ?? match.index(
									after: match.startIndex
								)
							)...
						]
					),
					let startB = (
						try? [(X.S | X.comment)*, √"−÷", (X.S | X.comment)*]′.extract(
							from: match[endA...]
						)
					)?.last?.text.endIndex,
					let (
						_,
						exprB
					) = Symbol.Expression.gobbleExpression(match[startB...])
				else
				{ return nil }
				return (match.endIndex, symbol == .excluding ? .excluding(exprA, exprB) : .notIncluding(exprA, exprB))
			case
				.zeroOrOne,
				.oneOrMore,
				.zeroOrMore
			:
				guard let (
					_,
					expr
				) = Symbol.Expression.gobbleExpression(
					match[
						(
							(
								try? (X.S | X.comment)″.extract(
									from: match.dropFirst()
								)
							)?.last?.text.endIndex ?? match.index(
								after: match.startIndex
							)
						)...
					]
				) else
				{ return nil }
				return (match.endIndex, symbol == .zeroOrOne ? .zeroOrOne(expr) : symbol == .oneOrMore ? .oneOrMore(expr) : .zeroOrMore(expr))
		}
	}

	/// Returns whether a given `Expression` exactly matches the provided text.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Expression`.
	///      +  r·h·s:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public static func ~= <T> (
		_ l·h·s: Symbol.Expression,
		_ r·h·s: T
	) -> Bool
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{ l·h·s.matches(r·h·s) }

	/// Returns an `Expression.sequence` of its operands.
	///
	///  +  Note:
	///     Consider using an array literal instead when you need to produce a `.sequence` of more than two `Expression`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  Returns:
	///     An `Expression.sequence`, or an equivalent expression.
	@inlinable
	public static func & (
		_ l·h·s: Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) -> Symbol.Expression
	{ [l·h·s, r·h·s] }

	/// Returns an `Expression.choice` of its operands.
	///
	///  +  Note:
	///     Consider using `‖` with an array literal instead when you need to produce a `.choice` of more than two `Expression`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  Returns:
	///     An `Expression.choice`, or an equivalent expression.
	@inlinable
	public static func | (
		_ l·h·s: Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) -> Symbol.Expression
	{ ‖[l·h·s, r·h·s] }

	/// Returns an `Expression.excluding` of its operands.
	///
	///  +  Note:
	///     This operator is `U+2212 − MINUS SIGN`, not `U+002D - HYPHEN-MINUS`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Expression`.
	///      +  r·h·s:
	///         An `Expression`.
	///
	///  +  Returns:
	///     An `Expression.excluding` excluding `r·h·s` from `l·h·s`, or an equivalent expression.
	@inlinable
	public static func − (
		_ l·h·s: Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) -> Symbol.Expression {
		guard case .excluding(let l·h·s·A, let l·h·s·B) = l·h·s
		else
		{ return .excluding(l·h·s, r·h·s) }
		return .excluding(l·h·s·A, l·h·s·B | r·h·s)
	}

	/// Returns an `Expression.notIncluding` of its operands.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Expression`.
	///      +  r·h·s:
	///         An `Expression`.
	///
	///  +  Returns:
	///     An `Expression.notIncluding` excluding `r·h·s` from `l·h·s`, or an equivalent expression.
	@inlinable
	public static func ÷ (
		_ l·h·s: Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) -> Symbol.Expression {
		guard case .notIncluding(let l·h·s·A, let l·h·s·B) = l·h·s
		else
		{ return .notIncluding(l·h·s, r·h·s) }
		return .notIncluding(l·h·s·A, l·h·s·B | r·h·s)
	}

	/// Creates an `Expression.sequence` of its operands and stores the result in the left·hand·side variable.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	@inlinable
	public static func &= (
		_ l·h·s: inout Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) { l·h·s = [l·h·s, r·h·s] }

	/// Creates an `Expression.choice` of its operands and stores the result in the left·hand·side variable.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	@inlinable
	public static func |= (
		_ l·h·s: inout Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) { l·h·s = ‖[l·h·s, r·h·s] }

	/// Creates an `Expression.excluding` from its operands and stores the result in the left·hand·side variable.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	@inlinable
	public static func −= (
		_ l·h·s: inout Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) { l·h·s = l·h·s − r·h·s }

	/// Creates an `Expression.notIncluding` from its operands and stores the result in the left·hand·side variable.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	@inlinable
	public static func ÷= (
		_ l·h·s: inout Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) { l·h·s = l·h·s ÷ r·h·s }

}

extension Expression:
	CustomStringConvertible
{

	/// A `String` representation of the EBNF expression.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	public var description: String {
		switch self {
			case .character (
				let char
			): return "!"..."~" as ClosedRange<Text.Character> ~= char ? "‹\(char)›" : """
				£\(
					String(
						UInt32(char),
						radix: 16,
						uppercase: true
					)
				);
				"""
			case .anyOf (
				let expr
			): return """
				⟨\(
					expr.map {
						String(
							describing: $0
						)
					}.joined()
				)⟩
				"""
			case .noneOf (
				let expr
			): return """
				⟨∼\(
					expr.map {
						String(
							describing: $0
						)
					}.joined()
				)⟩
				"""
			case .string (
				let str
			):
				let texts = str.indices.reduce(
					into: [] as [(Bool, Text.SubSequence)]
				) { result, index in
					let isA·S·C·I·I = "!"..."~" as ClosedRange<Text.Character> ~= str[index]
					if
						let last = result.last,
						isA·S·C·I·I == last.0
					{
						result.replaceSubrange(
							result.endIndex - 1 ..< result.endIndex,
							with: CollectionOfOne((last.0, str[last.1.startIndex...index]))
						)
					} else
					{ result.append((isA·S·C·I·I, str[index...index])) }
				}.flatMap { (
					isA·S·C·I·I,
					text
				) in
					isA·S·C·I·I ? ["‹\(Substring(text))›"] : text.map { char in
						String(
							describing: Expression.character(char)
						)
					}
				}
				return texts.count == 1 ? texts[0] : """
					(\(
						texts.joined(
							separator: " "
						)
					))
					"""
			case .symbol (
				let sym
			): return String(sym.name)
			case .choice (
				let exprs
			): return """
				(\(
					exprs.map {
						String(
							describing: $0
						)
					}.joined(
						separator: " | "
					)
				))
				"""
			case .sequence (
				let exprs
			): return """
				(\(
					exprs.map {
						String(
							describing: $0
						)
					}.joined(
						separator: " "
					)
				))
				"""
			case .excluding (
				let A,
				let B
			): return "(\(A) − \(B))"
			case .notIncluding (
				let A,
				let B
			): return "(\(A) ÷ \(B))"
			case .zeroOrOne (
				let A
			): return "(\(A)?)"
			case .oneOrMore (
				let A
			): return "(\(A)+)"
			case .zeroOrMore (
				let A
			): return "(\(A)×)"
		}
	}

}

extension Expression:
	Equatable
{

	/// Returns whether the operands are identical expressions.
	///
	///  +  Note:
	///     Two `Expression`s might not be equal but may still match exactly the same strings.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Expression`.
	///      +  r·h·s:
	///         An `Expression`.
	///
	///  +  Returns:
	///     `true` if the operands are identicial; false otherwise.
	public static func == (
		_ l·h·s: Symbol.Expression,
		_ r·h·s: Symbol.Expression
	) -> Bool {
		switch l·h·s {
			case .character (
				let char
			):
				if case .character (
					char
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .anyOf (
				let bra·ket
			):
				if case .anyOf (
					bra·ket
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .noneOf (
				let bra·ket
			):
				if case .noneOf (
					bra·ket
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .string (
				let l·h·s·text
			):
				if
					case .string (
						let r·h·s·text
					) = r·h·s,
					l·h·s·text.elementsEqual(r·h·s·text)
				{ return true }
				else
				{ return false }
			case .symbol(
				let symbol
			):
				if case .symbol (
					symbol
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .choice (
				let exprs
			):
				if case .choice (
					exprs
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .sequence (
				let exprs
			):
				if case .sequence (
					exprs
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .excluding (
				let exprA,
				let exprB
			):
				if case .excluding (
					exprA,
					exprB
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .notIncluding (
				let exprA,
				let exprB
			):
				if case .notIncluding (
					exprA,
					exprB
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .zeroOrOne (
				let expr
			):
				if case .zeroOrOne (
					expr
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .oneOrMore (
				let expr
			):
				if case .oneOrMore (
					expr
				) = r·h·s
				{ return true }
				else
				{ return false }
			case .zeroOrMore (
				let expr
			):
				if case .zeroOrMore (
					expr
				) = r·h·s
				{ return true }
				else
				{ return false }
		}
	}

}

extension Expression:
	Expressible
{

	/// Returns a `.zeroOrOne` of its operand.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     A `.zeroOrOne` wrapping `operand`, or an equivalent expression.
	@inlinable
	public static postfix func ° (
		_ operand: Symbol.Expression
	) -> Symbol.Expression {
		switch operand {
			case
				.zeroOrOne,
				.zeroOrMore
			: return operand
			case .oneOrMore (
				let A
			): return .zeroOrMore(A)
			default:
				return .zeroOrOne(operand)
		}
	}

	/// Returns its operand.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     `operand`.
	@inlinable
	public static postfix func ′ (
		_ operand: Symbol.Expression
	) -> Symbol.Expression
	{ operand }

	/// Returns a `.oneOrMore` of its operand.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     A `.oneOrMore` wrapping `operand`, or an equivalent expression.
	@inlinable
	public static postfix func ″ (
		_ operand: Symbol.Expression
	) -> Symbol.Expression {
		switch operand {
			case
				.oneOrMore,
				.zeroOrMore
			: return operand
			case .zeroOrOne(
				let A
			): return .zeroOrMore(A)
			default:
				return .oneOrMore(operand)
		}
	}

	/// Returns a `.zeroOrMore` of its operand.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     A `.zeroOrMore` wrapping `operand`, or an equivalent expression.
	@inlinable
	public static postfix func * (
		_ operand: Symbol.Expression
	) -> Symbol.Expression {
		switch operand {
			case .zeroOrMore:
				return operand
			case
				.zeroOrOne(
					let A
				),
				.oneOrMore (
					let A
				)
			: return .zeroOrMore(A)
			default:
				return .zeroOrMore(operand)
		}
	}

}

extension Expression:
	ExpressibleByArrayLiteral
{

	/// Creates a `.sequence` from an array literal.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  elements:
	///         An `Array` of `Expression`s.
	///
	///  +  Returns:
	///     A `.sequence` containing `elements`, or an equivalent expression.
	public init(
		arrayLiteral elements: Symbol.Expression...
	) { self = .sequence(elements) }

}

extension Expression:
	ExpressibleByStringLiteral
{

	/// Creates a `.character` or `.string` from a string literal.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  value:
	///         A `String`.
	///
	///  +  Returns:
	///     A `.character` if `value` consists of a single character; otherwise, a `.string`.
	public init (
		stringLiteral value: String
	) {
		if
			value.unicodeScalars.count == 1,
			let character = value.unicodeScalars.first
		{ self = .character(character) }
		else
		{ self = .string(value.unicodeScalars) }
	}

}

extension Expression
where Symbol == DescriptionSymbol {

	/// An XML Names 1.1 QName.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	internal static let QName: Symbol.Expression = {
		let NCNameStartChar: Symbol.Expression = ‖[√["A"..."Z"], "_", √["a"..."z"], √["\u{C0}"..."\u{D6}"], √["\u{D8}"..."\u{F6}"], √["\u{F8}"..."\u{2FF}"], √["\u{370}"..."\u{37D}"], √["\u{37F}"..."\u{1FFF}"], √["\u{200C}"..."\u{200D}"], √["\u{2070}"..."\u{218F}"], √["\u{2C00}"..."\u{2FEF}"], √["\u{3001}"..."\u{D7FF}"], √["\u{F900}"..."\u{FDCF}"], √["\u{FDF0}"..."\u{FFFD}"], √["\u{10000}"..."\u{EFFFF}"]]
		let NCNameChar: Symbol.Expression = ‖[NCNameStartChar, "-", ".", √["0"..."9"], "\u{B7}", √["\u{300}"..."\u{36F}"], √["\u{203F}"..."\u{2040}"]]
		let NCName: Symbol.Expression = [NCNameStartChar, NCNameChar*]
		return [NCName, ":", NCName] | NCName
	}()

	/// XML whitespace.
	internal static let S: Symbol.Expression = (√"\u{20}\u{9}\u{D}\u{A}")″

	/// An EBNF comment.
	internal static let comment: Symbol.Expression = ["/*", (^[])* ÷ "*/", "*/"]

	/// Any EBNF expression.
	internal static let expression: Symbol.Expression = ‖[.character′, .anyOf′, .noneOf′, .string′, .symbol′, .choice′, .sequence′, .excluding′, .notIncluding′, .zeroOrOne′, .zeroOrMore′, .oneOrMore′]

}
