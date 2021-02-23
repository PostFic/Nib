//  #  E·B·N·F·Tests :: E·B·N·F·TestReadmeExpressions  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import XCTest
import Core
import E·B·N·F

final class E·B·N·F·TestReadmeExpressions:
	XCTestCase
{

	private enum ExampleSymbol:
		String,
		Symbolic
	{

		typealias Symbol = ExampleSymbol

		enum Version:
			String,
			Defaultable,
			VersionProtocol
		{ case `default` = "" }

		case S

		case endsWithSpace

		case somethingMore

		case symbol

		case postfix

		case postfixed

		case expression

		case properExpression

		var reference: Text?
		{ nil }

		subscript (
			_ version: Version = .default
		) -> Expression<ExampleSymbol>? {
			switch self {
				case .S:
					return (‖["\u{20}", "\u{9}", "\u{D}", "\u{A}"])″
				case .endsWithSpace:
					return ["something", .S°]
				case .somethingMore:
					return [.endsWithSpace′, .S′, "else"]
				case .symbol:
					return ^[]
				case .postfix:
					return "*"
				case .postfixed:
					return [.expression′, .postfix′]
				case .expression:
					return "$" | .postfixed′
				case .properExpression:
					return ["$", .postfix*]
			}
		}

	}

	func testReadmeSymbolDebugDescription () {
		for symbol in ExampleSymbol.allCases {
			let description: String
			switch symbol {
				case .S:
					description = "S ::= (⟨£20;£9;£D;£A;⟩+)"
				case .endsWithSpace:
					description = "endsWithSpace ::= (‹something› (S?))"
				case .somethingMore:
					description = "somethingMore ::= (endsWithSpace S ‹else›)"
				case .symbol:
					description = "symbol ::= ⟨∼⟩"
				case .postfix:
					description = "postfix ::= ‹*›"
				case .postfixed:
					description = "postfixed ::= (expression postfix)"
				case .expression:
					description = "expression ::= (‹$› | postfixed)"
				case .properExpression:
					description = "properExpression ::= (‹$› (postfix×))"
			}
			XCTAssertEqual(
				description,
				String(
					reflecting: symbol
				)
			)
		}
	}

	func testReadmeExpressionDescriptionInitialization () {
		for symbol in ExampleSymbol.allCases {
			XCTAssertEqual(symbol[]!.description, ExampleSymbol.Expression(symbol[]!.description)?.description)
		}
	}

	func testGreedySomethingElse () {
		XCTAssertFalse(ExampleSymbol.somethingMore ~= "something  else".unicodeScalars)
	}

	func testShortcutChoice () {
		XCTAssertFalse(ExampleSymbol.expression ~= "$*".unicodeScalars)
	}

}
