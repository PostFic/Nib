//  #  X·M·L :: X·M·L·Version  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

/// A version of the XML specification.
public enum X·M·L·Version:
	String,
	VersionProtocol
{

	/// _Extensible Markup Language (XML) 1.0 (Fifth Edition)_.
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/>.
	///
	///  +  Version:
	///     `0.2.0`.
	case xml10 = "1.0"

	/// _Extensible Markup Language (XML) 1.1 (Second Edition)_.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/>.
	///
	///  +  Version:
	///     `0.2.0`.
	case xml11 = "1.1"

}

extension X·M·L·Version:
	Defaultable
{

	/// The default XML version for processing (XML 1.1).
	///
	///  +  Version:
	///     `0.2.0`.
	public static let `default` = X·M·L·Version.xml11

}
