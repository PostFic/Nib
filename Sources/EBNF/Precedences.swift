//  # EBNF :: Precedences
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

precedencegroup ExclusionPrecedence {
	associativity: none
	higherThan: RangeFormationPrecedence
	lowerThan: AdditionPrecedence
}

precedencegroup DeclarationPrecedence {
	associativity: none
	higherThan: TernaryPrecedence
	lowerThan: LogicalDisjunctionPrecedence
}
