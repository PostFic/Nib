//  #  EBNF :: Text  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import Core

extension Text.Character {

	/// Creates a `BracketedComponent` ranging the operand `Text.Character`s.
	///
	///  +  Parameters:
	///      + lhs:
	///        A `Text.Character`·
	///      + rhs:
	///        A `Text.Character`·
	///
	///  +  Returns:
	///     A `BracketedComponent` which ranges from `lhs` to `rhs`.
	@inlinable
	public static func ... (
		_ lhs: Text.Character,
		_ rhs: Text.Character
	) -> BracketedComponent
	{ BracketedComponent(lhs...rhs) }

}
