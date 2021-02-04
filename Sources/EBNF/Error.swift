//  # EBNF :: Error
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// An EBNF processing error.
public enum Error:
	Swift.Error
{

	/// Signifies that a `Text.SubSequence` failed to match the given `Expression` starting from the provided `Text.Index`.
	///
	/// If `exhaustive` is `true`, then an exact match was desired.
	case parseError (
		Text.SubSequence,
		index: Text.Index,
		expression: Expression,
		exhaustive: Bool = false
	)

}
