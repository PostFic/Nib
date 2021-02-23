//  #  EBNF :: Operators  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// Excluding
infix operator −: ExclusionPrecedence

/// Not Including
infix operator ÷: ExclusionPrecedence

/// Choose Between
prefix operator ‖

/// Any Of
prefix operator √

/// None Of
prefix operator ^

/// Zero Or One Of
postfix operator °

/// One Of
postfix operator ′

/// One Or More Of
postfix operator ″

/// Zero Or More Of
postfix operator *

