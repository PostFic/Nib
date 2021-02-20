//  #  E·B·N·F :: DescriptionSymbol  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

/// A symbol describing Nib’s EBNF description syntax.
///
///  +  Version:
///     `0.1.0`.
public enum DescriptionSymbol:
	String
{

	/// The version of EBNF description syntax.
	///
	/// There is only one version, `.default`.
	///
	///  +  Version:
	///     `0.1.0`.
	public enum Version:
		String,
		Defaultable,
		VersionProtocol
	{

		/// The default version of EBNF descriptions.
		///
		///  +  Version:
		///     `0.1.0`.
		case `default` = ""

	}

	/// An EBNF character expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case character

	/// An EBNF any·of expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case anyOf

	/// An EBNF none·of expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case noneOf

	/// An EBNF string expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case string

	/// An EBNF symbol expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case symbol

	/// An EBNF choice expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case choice

	/// An EBNF sequence expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case sequence

	/// An EBNF excluding expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case excluding

	/// An EBNF not·including expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case notIncluding

	/// An EBNF zero·or·one expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case zeroOrOne

	/// An EBNF one·or·more expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case oneOrMore

	/// An EBNF zero·or·more expression.
	///
	///  +  Version:
	///     `0.1.0`.
	case zeroOrMore

	/// Returns the `Expression` corresponding to this `DescriptionSymbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  version:
	///         The `Version` of this value to get an `Expression` for.
	///
	///  +  Returns:
	///     An `Expression`.
	public func callAsFunction ()
	-> Symbol.Expression {
		switch self {
			case .character:
				return ["£", (√["0"..."9", "A"..."F"])″, ";"]
			case .anyOf:
				return ["⟨", [.character′ | √["!"..."~"], ["–", .character′ | √["!"..."~"]]°]*, "⟩"]
			case .noneOf:
				return ["⟨∼", [.character′ | √["!"..."~"], ["–", .character′ | √["!"..."~"]]°]*, "⟩"]
			case .string:
				return ["‹", (√["!"..."~"])*, "›"]
			case .symbol:
				return .QName
			case .choice:
				return ["(", (.S | .comment)*, .expression, [(.S | .comment)*, "|", (.S | .comment)*, .expression]″, (.S | .comment)*, ")"]
			case .sequence:
				return ["(", (.S | .comment)*, [.expression, [.comment*, .S, (.comment & .S°)*, .expression]*, (.S | .comment)*]°, ")"]
			case .excluding:
				return ["(", (.S | .comment)*, .expression, (.S | .comment)*, "−", (.S | .comment)*, .expression, (.S | .comment)*, ")"]
			case .notIncluding:
				return ["(", (.S | .comment)*, .expression, (.S | .comment)*, "÷", (.S | .comment)*, .expression, (.S | .comment)*, ")"]
			case .zeroOrOne:
				return ["(", (.S | .comment)*, .expression, (.S | .comment)*, "?", (.S | .comment)*, ")"]
			case .oneOrMore:
				return ["(", (.S | .comment)*, .expression, (.S | .comment)*, "+", (.S | .comment)*, ")"]
			case .zeroOrMore:
				return ["(", (.S | .comment)*, .expression, (.S | .comment)*, "×", (.S | .comment)*, ")"]
		}
	}

}

extension DescriptionSymbol:
	Symbolic
{

	/// The type of this `Symbolic`.
	///
	///  +  Version:
	///     `0.1.0`.
	public typealias Symbol = DescriptionSymbol

	/// The reference identifier for this `DescriptionSymbol`.
	///
	/// `DescriptionSymbol`s have no reference specification, so this value is always `nil`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	public var reference: Text?
	{ nil }

	/// Returns the `Expression` corresponding to this `DescriptionSymbol` for the given `version`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  version:
	///         The `Version` of this value to get an `Expression` for.
	///
	///  +  Returns:
	///     An `Expression`.
	public func callAsFunction (
		_ version: Version
	) -> Symbol.Expression?
	{ self() }

}
