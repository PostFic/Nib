//  # EBNF :: Expression
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// Adds an `Array` of `Expression`s to another `Array` of `Expression`s , merging the `.string`s on the boundary.
///
///  +  parameters:
///      +  collection:
///         The `Array` of `Expression`s to add to.
///      +  addition:
///         The `Array` of `Expression`s to add.
///      +  view:
///         A `Text.SubSequence` which is a supersequence of the `.text`s of all of the `Expression`s.
fileprivate func collectExpressions (
	_ collection: inout [Construct],
	_ addition: [Construct],
	in view: Text.SubSequence
) {
	if
		let prev = collection.last,
		let next = addition.first,
		case .string(content: let prevSub) = prev,
		case .string(content: let nextSub) = next
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
public enum Expression:
	CustomDebugStringConvertible
{

	/// An EBNF gobbling error.
	private enum GobbleError:
		Swift.Error
	{

		/// Signifies that gobbling failed to match the given `Expression` starting from the provided `Text.SubSequence`.
		case parseError (Text.SubSequence, Expression)

	}

	/// `[#xN#xN#xN]`
	///
	/// Matches any `Character` matched by the `BracketedExpression`.
	case anyOf (BracketedExpression)

	/// `#xN`
	///
	/// Matches a single `Character`.
	case character (Character)

	/// `[^#xN#xN#xN]`
	///
	/// Matches any `Character` not matched by the `BracketedExpression`.
	case noneOf (BracketedExpression)

	/// `"string"`
	///
	/// Matches the literal `Character`s in the `String`.
	case string (String)

	/// `symbol`
	///
	/// Matches a `Symbol`.
	indirect case symbol (Symbol)

	/// `A [ | B ...]`
	///
	/// Matches any of the `Expression`s.
	indirect case choice ([Expression])


	/// `A [ B ...]`
	///
	/// Matches each of the `Expression`s in order.
	indirect case sequence ([Expression])

	/// `A − B`
	///
	/// Matches anything which matches the first `Expression`, but not the second.
	///
	///  +  note:
	///     `.excluding` only checks for an exact match with the second `Expression`.
	///     Use `.notIncluding` to check if the second `Expression` matches any substring.
	indirect case excluding (Expression,Expression)

	/// `A ÷ B`
	///
	/// Matches anything which matches the first `Expression`, but does not contain the second.
	///
	///  +  note:
	///     The XML specification specifies this as `A − (Char* B Char*)`.
	///     It is treated specially here because the Nib engine is a greedy parser, so `Char* B` will never match.
	indirect case notIncluding (Expression,Expression)

	/// `A?`
	///
	/// Matches anything which matches the `Expression` zero or one times.
	indirect case zeroOrOne (Expression)

	/// `A+`
	///
	/// Matches anything which matches the `Expression` one or more times.
	indirect case oneOrMore (Expression)

	/// `A*`
	///
	/// Matches anything which matches the `Expression` zero or more times.
	indirect case zeroOrMore (Expression)

	/// An EBNF string representing this `Expression`.
	public var debugDescription: String {
		switch self {
		case .anyOf(let expr):
			return """
				[\(
					expr.map {
						String(
							describing: $0
						)
					}.joined()
				)]
				"""
		case .character(let char):
			return """
				#x\(
					String(
						UInt32(char),
						radix: 16,
						uppercase: true
					)
				)
				"""
		case .noneOf(let expr):
			return """
				[^\(
					expr.map {
						String(
							describing: $0
						)
					}.joined()
				)]
				"""
		case .string(let str):
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
		case .symbol(let sym):
			return "/* <\(sym)> */\(sym.expression)/* </\(sym)> */"
		case .choice(let exprs):
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
		case .sequence(let exprs):
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
		case .excluding(let A, let B):
			return "(\(A) − \(B))"
		case .notIncluding(let A, let B):
			return "(\(A) ÷ \(B))"
		case .zeroOrOne(let A):
			return "\(A)?"
		case .oneOrMore(let A):
			return "\(A)+"
		case .zeroOrMore(let A):
			return "\(A)*"
		}
	}

	/// An `Expression` is terminal if it is not `.symbol` and all of its subexpressions are terminal.
	public var isTerminal: Bool {
		switch self {
		case .anyOf, .character, .noneOf, .string:
			return true
		case .symbol:
			return false
		case .choice (let exprs), .sequence (let exprs):
			return exprs.allSatisfy { $0.isTerminal }
		case .excluding (let A, let B), .notIncluding (let A, let B):
			return A.isTerminal && B.isTerminal
		case .zeroOrOne (let A), .oneOrMore (let A), .zeroOrMore (let A):
			return A.isTerminal
		}
	}

	/// Extracts an `Array` of `Construct`s matching this `Expression` from the beginning of the provided `Text`, or returns `nil`.
	///
	///  +  parameters:
	///      +  text:
	///         The `Text` to extract from.
	///
	///  +  throws:
	///     A `Error.parseError` if this `Expression` does not match the beginning of the provided `Text`.
	///
	///  +  returns:
	///     An `Array` of `Construct`s.
	///
	///  +  note:
	///     This `Expression` need not match the entire `text` for `.extract(from:)` to return a value.
	///     To see if the whole `text` was matched, compare the `.endIndex` of the `.text` property of the final `Construct` in the result to the `.endIndex` of the provided argument.
	@inlinable
	public func extract (
		from text: Text
	) throws -> [Construct] {
		try extract(
			from: text[...]
		)
	}

	/// Extracts an `Array` of `Construct`s matching this `Expression` from the beginning of the provided `Text.SubSequence`, or throws.
	///
	///  +  parameters:
	///      +  text:
	///         The `Text.SubSequence` to extract from.
	///
	///  +  throws:
	///     A `Error.parseError` if this `Expression` does not match the beginning of the provided `Text.SubSequence`.
	///
	///  +  returns:
	///     An `Array` of `Construct`s.
	///
	///  +  note:
	///     This `Expression` need not match the entire `text` for `.extract(from:)` to return a value.
	///     To see if the whole `text` was matched, compare the `.endIndex` of the `.text` property of the final `Construct` in the result to the `.endIndex` of the provided argument.
	public func extract (
		from text: Text.SubSequence
	) throws -> [Construct] {
		do {
			let (_, contained) = try gobble(text)
			return contained
		} catch let GobbleError.parseError(sub, expr) {
			throw Error.parseError(
				text,
				index: sub.startIndex,
				expression: expr
			)
		}
	}

	private func gobble (
		_ view: Text.SubSequence
	) throws -> (Text.Index,[Construct]) {
		let failure = GobbleError.parseError(view, self)
		switch self {
		case .anyOf, .character, .noneOf:
			guard let character = view.first else
			{ throw failure }
			if
				case .anyOf(let bracketed) = self,
				!(bracketed.contains { $0.matches(character) })
			{ throw failure }
			else if
				case .character(let char) = self,
				character != char
			{ throw failure }
			else if
				case .noneOf(let bracketed) = self,
				(bracketed.contains { $0.matches(character) })
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
			do {
				let (end, contained) = try symbol.expression.gobble(view)
				return (end, [
					.symbol(
						symbol,
						content: contained
					)
				])
			} catch let GobbleError.parseError(text, expr) {
				if text.startIndex == view.startIndex
				{ throw failure }
				else
				{ throw GobbleError.parseError(text, expr) }
			}
		case .choice (let exprs):
			for expr in exprs {
				if let result = try? expr.gobble(view)
				{ return result }
			}
			throw failure
		case .sequence (let exprs):
			var current = view.startIndex
			var allContained: [Construct] = []
			for expr in exprs {
				let (end, contained) = try expr.gobble(view[current...])
				collectExpressions(&allContained, contained, in: view)
				current = end
			}
			return (current, allContained)
		case .excluding (let A, let B):
			let (end, contained) = try A.gobble(view)
			if
				let (notEnd, _) = try? B.gobble(view),
				end == notEnd
			{ throw failure }
			else
			{ return (end, contained) }
		case .notIncluding (let A, let B):
			let result = try A.gobble(view)
			if
				view.indices.contains(
					where: { (try? B.gobble(view[$0...])) != nil }
				)
			{ throw failure }
			else
			{ return result }
		case .oneOrMore (let A):
			var current = view.startIndex
			var allContained: [Construct] = []
			while let (end, contained) = try? A.gobble(view[current...]) {
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
			var allContained: [Construct] = []
			while let (end, contained) = try? A.gobble(view[current...]) {
				if current == end || end == view.endIndex
				{ return (end, allContained) }
				else {
					collectExpressions(&allContained, contained, in: view)
					current = end
				}
			}
			return (current, allContained)
		case .zeroOrOne (let A):
			return (try? A.gobble(view)) ?? (view.startIndex, [])
		}
	}

	/// Parses the provided `Text` into a tree of `Construct`s, or throws.
	///
	///  +  parameters:
	///     + text:
	///       The `Text` to parse.
	///
	///  +  throws:
	///     A `Error.parseError` if this `Expression` does not exactly match the provided `Text`.
	///
	///  +  returns:
	///     An `Array` of `Construct`s.
	@inlinable
	public func parse (
		_ text: Text
	) throws -> [Construct]
	{ try self.parse(text[...]) }

	/// Parses the provided `Text.SubSequence` into a tree of `Construct`s, or throws.
	///
	///  +  parameters:
	///     + text:
	///       The `Text.SubSequence` to parse.
	///
	///  +  throws:
	///     A `Error.parseError` if this `Expression` does not exactly match the provided `Text.SubSequence`.
	///
	///  +  returns:
	///     An `Array` of `Construct`s.
	public func parse (
		_ text: Text.SubSequence
	) throws -> [Construct] {
		let (end, result) = try self.gobble(text)
		if end == text.endIndex
		{ return result }
		else {
			throw Error.parseError(
				text,
				index: text.startIndex,
				expression: self,
				exhaustive: true
			)
		}
	}

	/// The `|` infix operator produces a `.choice` of its operands.
	///
	///  +  parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `.choice`.
	///
	///  +  note:
	///     Consider using `‖` with an array literal instead when you need to produce a `.choice` of more than two `Expression`s.
	public static func | (
		_ lhs: Expression,
		_ rhs: Expression
	) -> Expression
	{
		if case .choice(let lhsExprs) = lhs {
			if case .choice(let rhsExprs) = rhs
			{ return .choice(lhsExprs + rhsExprs) }
			else
			{ return .choice(lhsExprs + Swift.CollectionOfOne(rhs)) }
		} else
		{ return .choice([lhs, rhs]) }
	}

	/// The `−` infix operator produces a `.excluding` of its operands.
	///
	///  +  parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `.excluding` excluding `rhs` from `lhs`.
	///
	///  +  note:
	///     This operator is `U+2212 − MINUS SIGN`, not `U+002D - HYPHEN-MINUS`.
	@inlinable
	public static func − (
		_ lhs: Expression,
		_ rhs: Expression
	) -> Expression
	{ .excluding(lhs, rhs) }

	/// The `÷` infix operator produces a `.notIncluding` of its operands.
	///
	///  +  parameters:
	///      +  lhs:
	///         An `Expression`.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `.notIncluding` excluding `rhs` from `lhs`.
	@inlinable
	public static func ÷ (
		_ lhs: Expression,
		_ rhs: Expression
	) -> Expression
	{ .notIncluding(lhs, rhs) }

	/// The `«=` infix operator produces a `Symbol` with the name and expression specified by its operands.
	///
	///  +  parameters:
	///      +  lhs:
	///         A `String` name.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `Symbol`.
	@inlinable
	public static func «= (
		_ lhs: String,
		_ rhs: Expression
	) -> Symbol
	{ Symbol(lhs, rhs) }


	/// The `«=` infix operator produces a `Symbol` with the reference identifier, name, and expression specified by its operands.
	///
	///  +  parameters:
	///      +  lhs:
	///         A `(id:String,String)` reference identifier and name.
	///      +  rhs:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `Symbol`.
	public static func «= (
		_ lhs: (id:String,String),
		_ rhs: Expression
	) -> Symbol {
		Symbol(
			id: lhs.id,
			lhs.1,
			rhs
		)
	}

	/// The `‖` prefix operator produces a `.choice` from a `.sequence`.
	///
	///  +  parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `.choice` between the expressions in `operand`, if `operand` is a `.sequence`; `operand` otherwise.
	///
	/// `‖` is designed to work well with array literals:
	/// ````
	/// ‖[.A′, .B′] == .choice([.symbol(.A), .symbol(.B)])
	/// ````
	///
	///  +  note:
	///     This operator is `U+2016 ‖ DOUBLE VERTICAL LINE`, not two `U+007C | VERTICAL LINES`.
	@inlinable
	public static prefix func ‖ (
		_ operand: Expression
	) -> Expression {
		if case .sequence(let exprs) = operand
		{ return .choice(exprs) }
		else
		{ return operand }
	}

}

extension Expression:
	Expressible
{

	/// The `°` postfix operator produces a `.zeroOrOne` of its operand.
	///
	///  +  parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `.zeroOrOne` containing `operand`.
	@inlinable
	public static postfix func ° (
		_ operand: Expression
	) -> Expression
	{ .zeroOrOne(operand) }

	/// The `′` postfix operator simply returns its operand.
	///
	///  +  parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  returns:
	///     `operand`.
	@inlinable
	public static postfix func ′ (
		_ operand: Expression
	) -> Expression
	{ operand }

	/// The `″` postfix operator produces a `.oneOrMore` of its operand.
	///
	///  +  parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `.oneOrMore` containing `operand`.
	@inlinable
	public static postfix func ″ (
		_ operand: Expression
	) -> Expression
	{ .oneOrMore(operand) }

	/// The `*` postfix operator produces a `.zeroOrMore` of its operand.
	///
	///  +  parameters:
	///      +  operand:
	///         An `Expression`.
	///
	///  +  returns:
	///     A `.zeroOrMore` containing `operand`.
	@inlinable
	public static postfix func * (
		_ operand: Expression
	) -> Expression
	{ .zeroOrMore(operand) }

}

extension Expression:
	ExpressibleByStringLiteral
{

	/// Initializes a `.character` or `.string` from a string literal.
	///
	///  +  parameters:
	///      +  value:
	///         A `String`.
	///
	///  +  returns:
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

	/// Initializes a `.sequence` from an array literal.
	///
	///  +  parameters:
	///      +  elements:
	///         An `Array` of `Expression`s.
	///
	///  +  returns:
	///     A `.sequence` containing `elements`.
	public init(
		arrayLiteral elements: Expression...
	) { self = .sequence(elements) }

}
