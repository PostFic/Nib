//  #  E·B·N·F :: Core.Text.Character  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

extension Text.Character {

	/// Creates a `BracketedComponent` ranging the operand `Text.Character`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      + l·h·s:
	///        A `Text.Character`·
	///      + r·h·s:
	///        A `Text.Character`·
	///
	///  +  Returns:
	///     A `BracketedComponent` which ranges from `l·h·s` to `r·h·s`.
	@inlinable
	public static func ... (
		_ l·h·s: Text.Character,
		_ r·h·s: Text.Character
	) -> BracketedComponent
	{ BracketedComponent(l·h·s...r·h·s) }

}
