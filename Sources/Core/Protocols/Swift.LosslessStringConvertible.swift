//  #  Core :: Swift.LosslessStringConvertible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

public extension LosslessStringConvertible
where Self : LosslessTextConvertible {

	/// Creates a new value from the `.text` of its description.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  description:
	///         A `String` value.
	@inlinable
	init? (
		_ description: String
	) {
		if let text = Text(description.text)
		{ self.init(text) }
		else
		{ return nil }
	}

}
