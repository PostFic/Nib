//  #  EBNF :: Expression  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import Core

/// Adds an `Array` of `Expression`s to another `Array` of `Expression`s , merging the `.string`s on the boundary.
///
///  +  Parameters:
///      +  collection:
///         The `Array` of `Expression`s to add to.
///      +  addition:
///         The `Array` of `Expression`s to add.
///      +  view:
///         A `Text.SubSequence` which is a supersequence of the `.text`s of all of the `Expression`s.
fileprivate func collectExpressions <Symbol> (
	_ collection: inout [Construct<Symbol>],
	_ addition: [Construct<Symbol>],
	in view: Text.SubSequence
) where Symbol: Symbolic {
	if
		let prev = collection.last,
		let next = addition.first,
		case .string (content: let prevSub) = prev,
		case .string (content: let nextSub) = next
	{
		collection = collection.dropLast() + CollectionOfOne(
			.string(
				content: view[prevSub.startIndex..<nextSub.endIndex]
			)
		)
	} else
	{ collection += addition }
}

/// An enumerated type representing an EBNF expression, potentially containing subexpressions.
///
///  +  Note:
///     `Expression`s are matched using a naive greedy approach which is sufficient for XML but may not match all possible strings in other contexts.
///     In particular, rules of the following form will always fail:
///
///         neverMatches ::= A* A B
public enum Expression <Symbol>:
	Versionable
where Symbol: Symbolic {

	/// An EBNF gobbling error.
	private struct GobbleError:
		Swift.Error
	{

		/// The expression which produced the error.
		fileprivate let failedExpression: Expression<Symbol>

		/// The text which failed to match.
		fileprivate let text: Text.SubSequence

		/// Creates a new gobbling error from the `text` and `expression`.
		fileprivate init (
			_ text: Text.SubSequence,
			_ expression: Expression<Symbol>
		) {
			failedExpression = expression
			self.text = text
		}

	}

	/// The type of versioning associated with an `Expression`’s associated `Symbol`s.
	public typealias Version = Symbol.Version

	/// Match any `Text.Character` matched by the `BracketedExpression`.
	///
	///     [#xN#xN#xN]
	case anyOf (BracketedExpression)

	/// Match a single `Text.Character`.
	///
	///     #xN
	case character (Text.Character)

	/// Match any `Text.Character` not matched by the `BracketedExpression`.
	///
	///     [^#xN#xN#xN]
	case noneOf (BracketedExpression)

	/// Match the literal `Text.Character`s in the `String`.
	///
	///     "string"
	case string (String)

	/// Match a `Symbol`.
	///
	///     symbol
	indirect case symbol (Symbol)

	/// Match any of the associated `Expression`s.
	///
	///     A [ | B ...]
	indirect case choice ([Expression<Symbol>])

	/// Match each of the associated `Expression`s in order.
	///
	///     A [ B ...]
	indirect case sequence ([Expression<Symbol>])

	/// Match anything which matches the first `Expression`, but not the second.
	///
	///     A − B
	///
	///  +  Note:
	///     `.excluding` only checks for an exact match with the second `Expression`.
	///     Use `.notIncluding` to check if the second `Expression` matches any substring.
	indirect case excluding (Expression<Symbol>,Expression<Symbol>)

	/// Match anything which matches the first `Expression`, but does not contain the second.
	///
	///     A ÷ B
	///
	///  +  Note:
	///     The XML specification specifies this as `A − (Char* B Char*)`.
	///     It is treated specially here because the Nib engine is a greedy parser, so `Char* B` will never match.
	indirect case notIncluding (Expression<Symbol>,Expression<Symbol>)

	/// Match anything which matches the associated `Expression` zero or one times.
	///
	///     A?
	indirect case zeroOrOne (Expression<Symbol>)

	/// Match anything which matches the associated `Expression` one or more times.
	///
	///     A+
	indirect case oneOrMore (Expression<Symbol>)

	/// Match anything which matches the associated `Expression` zero or more times.
	///
	///     A*
	indirect case zeroOrMore (Expression<Symbol>)

	/// Whether an `Expression` is terminal.
	///
	/// An `Expression` is terminal if it is not `.symbol` and all of its subexpressions are terminal.
	public var isTerminal: Bool {
		switch self {
		case
			.anyOf,
			.character,
			.noneOf,
			.string
		: return true
		case .symbol:
			return false
		case
			.choice (let exprs),
			.sequence (let exprs)
		: return exprs.allSatisfy { $0.isTerminal }
		case
			.excluding (let A, let B),
			.notIncluding (let A, let B)
		: return A.isTerminal && B.isTerminal
		case
			.zeroOrOne (let A),
			.oneOrMore (let A),
			.zeroOrMore (let A)
		: return A.isTerminal
		}
	}

	/// Returns an `Array` of `Construct`s matching this `Expression` from the beginning of the provided `text`, or throws.
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
	///
	///  +  Note:
	///     This `Expression` need not match the entire `text` for `.extract(from:version:)` to return a value.
	///     To see if the whole `text` was matched, use `.parse(:version:)` instead.
	public func extract <T> (
		from text: T,
		version: Version = Version.default
	) throws -> [Construct<Symbol>]
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{
		let view = text[...]
		do {
			let (_, contained) = try gobble(view, version)
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
	) throws -> (Text.Index,[Construct<Symbol>]) {
		let failure = GobbleError(view, self)
		switch self {
		case
			.anyOf,
			.character,
			.noneOf
		:
			guard let character = view.first else
			{ throw failure }
			if
				case .anyOf(let bracketed) = self,
				!(bracketed.contains { $0 ~= character })
			{ throw failure }
			else if
				case .character(let char) = self,
				character != char
			{ throw failure }
			else if
				case .noneOf(let bracketed) = self,
				(bracketed.contains { $0 ~= character })
			{ throw failure }
			else {
				return (view.dropFirst().startIndex, [
					.string(
						content: view.prefix(1)
					)
				])
			}
		case .string (let string):
			var iterator = view.indices.lazy.map { ($0, view[$0]) }.makeIterator()
			var charIterator = string.unicodeScalars.makeIterator()
			while let char = charIterator.next() {
				guard
					let (_, character) = iterator.next(),
					char == character
				else
				{ throw failure }
			}
			let end = iterator.next()?.0 ?? view.endIndex
			return (end, [
				.string(
					content: view[..<end]
				)
			])
		case .symbol (let symbol):
			guard let expression = symbol[version]
			else { throw failure }
			do {
				let (end, contained) = try expression.gobble(view, version)
				return (end, [
					.symbol(
						symbol,
						version: version,
						content: contained
					)
				])
			} catch let error as GobbleError
			where error.text.startIndex == view.startIndex
			{ throw failure }
		case .choice (let exprs):
			for expr in exprs {
				if let result = try? expr.gobble(view, version)
				{ return result }
			}
			throw failure
		case .sequence (let exprs):
			var current = view.startIndex
			var allContained: [Construct<Symbol>] = []
			for expr in exprs {
				let (end, contained) = try expr.gobble(view[current...], version)
				collectExpressions(&allContained, contained, in: view)
				current = end
			}
			return (current, allContained)
		case .excluding (let A, let B):
			let (end, contained) = try A.gobble(view, version)
			if
				let (notEnd, _) = try? B.gobble(view, version),
				end == notEnd
			{ throw failure }
			else
			{ return (end, contained) }
		case .notIncluding (let A, let B):
			let result = try A.gobble(view, version)
			if
				view.indices.contains(
					where: { (try? B.gobble(view[$0...], version)) != nil }
				)
			{ throw failure }
			else
			{ return result }
		case .oneOrMore (let A):
			var current = view.startIndex
			var allContained: [Construct<Symbol>] = []
			while let (end, contained) = try? A.gobble(view[current...], version) {
				collectExpressions(&allContained, contained, in: view)
				if current == end || end == view.endIndex
				{ return (end, allContained)  }
				else
				{ current = end }
			}
			if allContained.count == 0
			{ throw failure }
			else
			{ return (current, allContained) }
		case .zeroOrMore (let A):
			var current = view.startIndex
			var allContained: [Construct<Symbol>] = []
			while let (end, contained) = try? A.gobble(view[current...], version) {
				if current == end || end == view.endIndex
				{ return (end, allContained) }
				else {
					collectExpressions(&allContained, contained, in: view)
					current = end
				}
			}
			return (current, allContained)
		case .zeroOrOne (let A):
			return (try? A.gobble(view, version)) ?? (view.startIndex, [])
		}
	}

	/// Returns whether this `Expression` exactly matches the provided `text`.
	///
	///  +  Parameters:
	///      + text:
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
	///  +  Parameters:
	///      + text:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///      +  version:
	///         The `Version` to use when matching.
	///
	///  +  Throws:
	///     A `ParseError` if this `Expression` does not exactly match the provided `Text`.
	///
	///  +  Returns:
	///     An `Array` of `Construct`s.
	public func parse <T> (
		_ text: T,
		version: Version = Version.default
	) throws -> [Construct<Symbol>]
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{
		let view = text[...]
		let (end, result) = try self.gobble(view, version)
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

	/// Returns whether a given `Expression` exactly matches the provided text.
	///
	///  +  Parameters:
	///      + lhs:
	///         An `Expression`.
	///      + rhs:
	///         A `Collection` whose `SubSequence` is `Text.SubSequence`.
	///
	///  +  Returns:
	///     A `Boolean`.
	@inlinable
	public static func ~= <T> (
		_ lhs: Expression<Symbol>,
		_ rhs: T
	) -> Bool
	where
		T: Collection,
		T.SubSequence == Text.SubSequence
	{ lhs.matches(rhs) }

	/// Returns an `Expression.choice` of its operands.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  Returns:
	///     An `Expression.choice`.
	///
	///  +  Note:
	///     Consider using `‖` with an array literal instead when you need to produce a `.choice` of more than two `Expression`s.
	public static func | (
		_ lhs: Expression<Symbol>,
		_ rhs: Expression<Symbol>
	) -> Expression<Symbol>
	{
		guard case .choice(let lhsExprs) = lhs
		else { return .choice([lhs, rhs]) }
		if case .choice(let rhsExprs) = rhs
		{ return .choice(lhsExprs + rhsExprs) }
		else
		{ return .choice(lhsExprs + Swift.CollectionOfOne(rhs)) }
	}

	/// Returns an `Expression.excluding` of its operands.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  Returns:
	///     An `Expression.excluding` excluding `rhs` from `lhs`.
	///
	///  +  Note:
	///     This operator is `U+2212 − MINUS SIGN`, not `U+002D - HYPHEN-MINUS`.
	@inlinable
	public static func − (
		_ lhs: Expression<Symbol>,
		_ rhs: Expression<Symbol>
	) -> Expression<Symbol>
	{ .excluding(lhs, rhs) }

	/// Returns an `Expression.notIncluding` of its operands.
	///
	///  +  Parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  Returns:
	///     An `Expression.notIncluding` excluding `rhs` from `lhs`.
	@inlinable
	public static func ÷ (
		_ lhs: Expression<Symbol>,
		_ rhs: Expression<Symbol>
	) -> Expression<Symbol>
	{ .notIncluding(lhs, rhs) }

	/// Returns an `Expression.choice` whose elements are taken from the provided `Expression.sequence`, or returns the `operand` if it is not an `Expression.sequence`.
	///
	/// `‖` is designed to work well with array literals:
	///
	///     ‖[.A′, .B′] == .choice([.symbol(.A), .symbol(.B)])
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     A `Expression.choice` between the expressions in `operand`, if `operand` is a `Expression.sequence`; `operand` otherwise.
	///
	///  +  Note:
	///     This operator is `U+2016 ‖ DOUBLE VERTICAL LINE`, not two `U+007C | VERTICAL LINES`.
	@inlinable
	public static prefix func ‖ (
		_ operand: Expression<Symbol>
	) -> Expression {
		if case .sequence(let exprs) = operand
		{ return .choice(exprs) }
		else
		{ return operand }
	}

}

extension Expression:
	CustomStringConvertible
{

	/// A `String` representation of the EBNF expression.
	public var description: String {
		switch self {
		case .anyOf (let expr):
			return """
				[\(
					expr.map {
						String(
							describing: $0
						)
					}.joined()
				)]
				"""
		case .character (let char):
			return """
				#x\(
					String(
						UInt32(char),
						radix: 16,
						uppercase: true
					)
				)
				"""
		case .noneOf (let expr):
			return """
				[^\(
					expr.map {
						String(
							describing: $0
						)
					}.joined()
				)]
				"""
		case .string (let str):
			if str.contains("'") && str.contains("\"") {
				return """
					"\(
						str.split(
							separator: "\""
						).joined(
							separator: "\" #x22 \""
						)
					)"
				"""
			} else if str.contains("\"")
			{ return "'\(str)'" }
			else
			{ return "\"\(str)\"" }
		case .symbol (let sym):
			return sym.name
		case .choice (let exprs):
			return """
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
		case .sequence (let exprs):
			return """
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
		case .excluding (let A, let B):
			return "(\(A) − \(B))"
		case .notIncluding (let A, let B):
			return "(\(A) ÷ \(B))"
		case .zeroOrOne (let A):
			return "\(A)?"
		case .oneOrMore (let A):
			return "\(A)+"
		case .zeroOrMore (let A):
			return "\(A)*"
		}
	}

}

extension Expression:
	CustomDebugStringConvertible,
	CustomVersionedDebugStringConvertible
{

	/// Returns an expanded `String` representation of the EBNF expression.
	///
	///  +  Parameters:
	///      +  version:
	///         The `Version` to use when expanding.
	///
	///  +  Returns:
	///     A `String` EBNF representation expanding this `Expression` according to the provided `version`.
	///
	///  +  Complexity:
	///     `O(n)` over nested `Expression`s.
	public func debugDescription (
		version: Version
	) -> String {
		switch self {
		case
			.anyOf,
			.character,
			.noneOf,
			.string
		: return String(describing: self)
		case .symbol (let sym):
			let debugExpression: String
			if let expression = sym[version] {
				debugExpression = String(
					reflecting: expression,
					version: version
				)
			} else
			{ debugExpression = "/* Not defined */" }
			return "/* <\(sym)> */\(debugExpression)/* </\(sym)> */"
		case .choice (let exprs):
			return """
				(\(
					exprs.map {
						String(
							reflecting: $0,
							version: version
						)
					}.joined(
						separator: " | "
					)
				))
				"""
		case .sequence (let exprs):
			return """
				(\(
					exprs.map {
						String(
							reflecting: $0,
							version: version
						)
					}.joined(
						separator: " "
					)
				))
				"""
		case .excluding (let A, let B):
			return """
				(\(
					String(
						reflecting: A,
						version: version
					)
				) − \(
					String(
						reflecting: B,
						version: version
					)
				))
				"""
		case .notIncluding (let A, let B):
			return """
				(\(
					String(
						reflecting: A,
						version: version
					)
				) ÷ \(
					String(
						reflecting: B,
						version: version
					)
				))
				"""
		case .zeroOrOne (let A):
			return """
				(\(
					String(
						reflecting: A,
						version: version
					)
				)?
				"""
		case .oneOrMore (let A):
			return """
				(\(
					String(
						reflecting: A,
						version: version
					)
				)+
				"""
		case .zeroOrMore (let A):
			return """
				(\(
					String(
						reflecting: A,
						version: version
					)
				)*
				"""
		}
	}

}

extension Expression:
	Expressible
{

	/// Returns a `.zeroOrOne` of its operand.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     A `.zeroOrOne` wrapping `operand`.
	@inlinable
	public static postfix func ° (
		_ operand: Expression<Symbol>
	) -> Expression<Symbol>
	{ .zeroOrOne(operand) }

	/// Returns its operand.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     `operand`.
	@inlinable
	public static postfix func ′ (
		_ operand: Expression<Symbol>
	) -> Expression<Symbol>
	{ operand }

	/// Returns a `.oneOrMore` of its operand.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     A `.oneOrMore` wrapping `operand`.
	@inlinable
	public static postfix func ″ (
		_ operand: Expression<Symbol>
	) -> Expression<Symbol>
	{ .oneOrMore(operand) }

	/// Returns a `.zeroOrMore` of its operand.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  Returns:
	///     A `.zeroOrMore` wrapping `operand`.
	@inlinable
	public static postfix func * (
		_ operand: Expression<Symbol>
	) -> Expression<Symbol>
	{ .zeroOrMore(operand) }

}

extension Expression:
	ExpressibleByStringLiteral
{

	/// Creates a `.character` or `.string` from a string literal.
	///
	///  +  Parameters:
	///      +  value:
	///         A `String`.
	///
	///  +  Returns:
	///     A `.character` if `value` consists of a single character; otherwise, a `.string`.
	public init(stringLiteral value: String) {
		if
			value.unicodeScalars.count == 1,
			let character = value.unicodeScalars.first
		{ self = .character(character) }
		else
		{ self = .string(value) }
	}

}

extension Expression:
	ExpressibleByArrayLiteral
{

	/// Creates a `.sequence` from an array literal.
	///
	///  +  Parameters:
	///      +  elements:
	///         An `Array` of `Expression`s.
	///
	///  +  Returns:
	///     A `.sequence` containing `elements`.
	public init(
		arrayLiteral elements: Expression<Symbol>...
	) { self = .sequence(elements) }

}
