//  #  E·B·N·F :: DescriptionSymbol  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

public enum DescriptionSymbol:
	String
{

	public enum Version:
		String,
		Defaultable,
		VersionProtocol
	{

		case `default` = ""

	}

	case character

	case anyOf

	case noneOf

	case string

	case symbol

	case choice

	case sequence

	case excluding

	case notIncluding

	case zeroOrOne

	case oneOrMore

	case zeroOrMore

	public var expression: Symbol.Expression {
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
				return ["(", (.S | .comment)*, [.expression, [.comment*, .S, [.comment, .S°]*, .expression]*, (.S | .comment)*]°, ")"]
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

	public typealias Symbol = DescriptionSymbol

	public var reference: Text?
	{ nil }

	public subscript(
		version: Version = .default
	) -> Symbol.Expression?
	{ self.expression }

}
