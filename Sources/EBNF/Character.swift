//  # EBNF :: Character
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// An atomic unit of text as specified by the Universal Character Set (UCS), ISO/IEC 10646.
///
///  +  <https://www.w3.org/TR/xml11/#dt-character>.
///
///  +  note:
///     This is a different definition of “character” than is used by `Swift.Character`.
public typealias Character = Unicode.Scalar

extension Character {

	/// Creates a `BracketedComponent` ranging the operand `Character`s.
	///
	///  +  parameters:
	///      + lhs:
	///        A `Character`·
	///      + rhs:
	///        A `Character`·
	///
	///  +  returns:
	///     A `BracketedComponent` which ranges from `lhs` to `rhs`.
	public static func ... (
		_ lhs: Character,
		_ rhs: Character
	) -> BracketedComponent
	{ BracketedComponent(lhs...rhs) }

}
