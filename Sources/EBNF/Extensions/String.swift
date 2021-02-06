//  #  EBNF :: String  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import Core

extension String {

	/// Creates a `String` with a detailed representation of the `subject`, according to the versioning specified in `version`.
	///
	///  +  Parameters:
	///      +  subject:
	///         A `CustomVersionedDebugStringConvertible` value.
	///      +  version:
	///         The `Version` of the representation to provide.
	public init <T> (
		reflecting subject: T,
		version: T.Version
	) where T: CustomVersionedDebugStringConvertible
	{ self = subject.debugDescription(version: version) }

}
