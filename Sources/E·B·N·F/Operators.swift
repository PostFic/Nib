//  #  E·B·N·F :: Operators  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Not·including.
///
///  +  Version:
///     `0.1.0`.
infix operator ÷: AdditionPrecedence

/// Not·including Assignment.
///
///  +  Version:
///     `0.1.0`.
infix operator ÷=: AssignmentPrecedence

/// Choice.
///
///  +  Version:
///     `0.2.0`.
prefix operator ∑

/// Sequence.
///
///  +  Version:
///     `0.2.0`.
prefix operator ∏

/// Any·of.
///
///  +  Version:
///     `0.1.0`.
prefix operator √

/// None·of.
///
///  +  Version:
///     `0.1.0`.
prefix operator ^

/// Zero·or·more·of.
///
///  +  Version:
///     `0.1.0`.
prefix operator *

/// One·of.
///
///  +  Version:
///     `0.2.0`.
postfix operator ®

/// Zero·or·one·of.
///
///  +  Version:
///     `0.2.0`.
postfix operator ^?

/// One·or·more·of.
///
///  +  Version:
///     `0.2.0`.
postfix operator ^+

/// Zero·or·more·of.
///
///  +  Version:
///     `0.2.0`.
postfix operator ^*

