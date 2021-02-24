//  #  L·E·I·R·I :: E·B·N·F.Expression  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import E·B·N·F

extension Expression
where Symbol == L·E·I·R·I·Symbol {

	/// A–Z / a–z
	internal static let ALPHA: L·E·I·R·I·Symbol.Expression = √["\u{41}"..."\u{5A}"] | √["\u{61}"..."\u{7A}"]

	/// 0–9
	internal static let DIGIT: L·E·I·R·I·Symbol.Expression = √["\u{30}"..."\u{39}"]

	/// Hexadecimal digit (case·insensitive)
	internal static let HEXDIG: L·E·I·R·I·Symbol.Expression = ˇ(DIGIT, √"Aa", √"Bb", √"Cc", √"Dd", √"Ee", √"Ff")

}
