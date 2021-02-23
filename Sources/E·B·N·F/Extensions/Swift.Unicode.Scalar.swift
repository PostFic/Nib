//  #  E·B·N·F :: Swift.Unicode.Scalar  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension Unicode.Scalar {

	/// Creates a `BracketedComponent` ranging the operand `Unicode.Scalar`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      + l·h·s:
	///        A `Unicode.Scalar`·
	///      + r·h·s:
	///        A `Unicode.Scalar`·
	///
	///  +  Returns:
	///     A `BracketedComponent` which ranges from `l·h·s` to `r·h·s`.
	@inlinable
	public static func ... (
		_ l·h·s: Unicode.Scalar,
		_ r·h·s: Unicode.Scalar
	) -> BracketedComponent
	{ BracketedComponent(l·h·s...r·h·s) }

}
