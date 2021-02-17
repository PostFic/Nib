//  #  E·B·N·F :: ParseError  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

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
	public let exactMatch: Bool

	/// The `Expression` which failed to match.
	public let failedExpression: Symbol.Expression

	/// The start `Text.Index` that the match was attempted from.
	public let startIndex: Text.Index

	/// The `Text.SubSequence` that the match was attempted on.
	public let text: Text.SubSequence

	/// The `Symbol.Version` that the match was attempted with.
	public let version: Symbol.Version

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
		failed expression: Symbol.Expression,
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
