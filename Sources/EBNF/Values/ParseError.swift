//  # EBNF :: ParseError
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import Core

/// An EBNF parse error.
///
/// Signifies that a `text` failed to match the `failedExpression` starting from the provided `startIndex`.
///
/// If `exactMatch` is `true`, then an exact match was desired.
public struct ParseError <Symbol>:
	Error
where Symbol: Symbolic {

	/// Whether an exact (exhaustive) match was desired.
	let exactMatch: Bool

	/// The `Expression` which failed to match.
	let failedExpression: Expression<Symbol>

	/// The start `Text.Index` that the match was attempted from.
	let startIndex: Text.Index

	/// The `Text.SubSequence` that the match was attempted on.
	let text: Text.SubSequence

	/// The `Symbol.Version` that the match was attempted with.
	let version: Symbol.Version

	/// Creates a `ParseError` for a failed match between a `text` and a `expression` at `index`.
	///
	/// If `exhaustive` is `true`, then an exact match was desired.
	///
	///  +  parameters:
	///      +  text:
	///         The `Text.SubSequence` that the match was attempted on.
	///      +  index:
	///         The start `Text.Index` that the match was attempted from.
	///      +  expression:
	///         The `Expression` which failed to match.
	///      +  version:
	///         The `Symbol.Version` that the match was attempted with.
	///      +  exhaustive:
	///         A `Boolean` indicating whether an exact match was desired.
	public init (
		_ text: Text.SubSequence,
		at index: Text.Index,
		failed expression: Expression<Symbol>,
		version: Symbol.Version = Symbol.Version.default,
		exhaustive: Bool = false
	) {
		exactMatch = exhaustive
		failedExpression = expression
		startIndex = index
		self.text = text
		self.version = version
	}

}
