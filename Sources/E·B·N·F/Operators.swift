//  #  E·B·N·F :: Operators  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Excluding
infix operator −: ExclusionPrecedence

/// Not·including
infix operator ÷: ExclusionPrecedence

/// Excluding Assignment
infix operator −=: AssignmentPrecedence

/// Not·including Assignment
infix operator ÷=: AssignmentPrecedence

/// Choose·between
prefix operator ‖

/// Any·of
prefix operator √

/// None·of
prefix operator ^

/// Zero·or·one·of
postfix operator °

/// One·of
postfix operator ′

/// One·or·more·of
postfix operator ″

/// Zero·or·more·of
postfix operator *

