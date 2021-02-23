//  #  E·B·N·F :: ParseError  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An EBNF parse error.
///
/// Signifies that a `text` failed to match the `failedExpression` starting from the provided `startIndex`.
///
/// If `exactMatch` is `true`, then an exact match was desired.
///
///  +  Version:
///     `0.1.0`.
public struct ParseError <Symbol>:
	Error
where Symbol: Symbolic {

	/// Whether an exact (exhaustive) match was desired.
	///
	///  +  Version:
	///     `0.1.0`.
	public let exactMatch: Bool

	/// The `Expression` which failed to match.
	///
	///  +  Version:
	///     `0.1.0`.
	public let failedExpression: Symbol.Expression

	/// The start `Text.Index` that the match was attempted from.
	///
	///  +  Version:
	///     `0.1.0`.
	public let startIndex: Substring.UnicodeScalarView.Index

	/// The `Text.SubSequence` that the match was attempted on.
	///
	///  +  Version:
	///     `0.1.0`.
	public let text: Substring.UnicodeScalarView

	/// The `Symbol.Version` that the match was attempted with.
	///
	///  +  Version:
	///     `0.1.0`.
	public let version: Symbol.Version

	/// Creates a `ParseError` for a failed match between a `text` and a `expression` at `index`.
	///
	/// If `exhaustive` is `true`, then an exact match was desired.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         The `Substring.UnicodeScalarView` that the match was attempted on.
	///      +  index:
	///         The start `Substring.UnicodeScalarView.Index` that the match was attempted from.
	///      +  expression:
	///         The `Expression` which failed to match.
	///      +  version:
	///         The `Symbol.Version` that the match was attempted with.
	///      +  exhaustive:
	///         A `Boolean` indicating whether an exact match was desired.
	public init (
		_ text: Substring.UnicodeScalarView,
		at index: Substring.UnicodeScalarView.Index,
		failed expression: Symbol.Expression,
		version: Symbol.Version = .default,
		exhaustive: Bool = false
	) {
		exactMatch = exhaustive
		failedExpression = expression
		startIndex = index
		self.text = text
		self.version = version
	}

}
