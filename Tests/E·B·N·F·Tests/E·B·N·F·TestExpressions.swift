//  #  E·B·N·F·Tests :: E·B·N·F·TestExpressions  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import XCTest
import Core
import E·B·N·F

final class E·B·N·F·TestExpressions:
	XCTestCase
{

	private enum Symbol:
		String,
		Symbolic
	{

		typealias Symbol = E·B·N·F·TestExpressions.Symbol

		enum Version:
			String,
			Defaultable,
			VersionProtocol
		{ case `default` = "" }

		case a·s·c·i·i·Character = "asciiCharacter"

		case non·a·s·c·i·i·Character = "non-asciiCharacter"

		case a·s·c·i·i·AnyDiscrete = "asciiAnyDiscrete"

		case a·s·c·i·i·AnyRange = "asciiAnyRange"

		case a·s·c·i·i·Any = "asciiAny"

		case non·a·s·c·i·i·AnyDiscrete = "non-asciiAnyDiscrete"

		case non·a·s·c·i·i·AnyRange = "non-asciiAnyRange"

		case non·a·s·c·i·i·Any = "non-asciiAny"

		case anyDiscrete

		case anyRange

		case any

		case a·s·c·i·i·NoneDiscrete = "asciiNoneDiscrete"

		case a·s·c·i·i·NoneRange = "asciiNoneRange"

		case a·s·c·i·i·None = "asciiNone"

		case non·a·s·c·i·i·NoneDiscrete = "non-asciiNoneDiscrete"

		case non·a·s·c·i·i·NoneRange = "non-asciiNoneRange"

		case non·a·s·c·i·i·None = "non-asciiNone"

		case noneDiscrete

		case noneRange

		case none

		case a·s·c·i·i·String = "asciiString"

		case non·a·s·c·i·i·String = "non-asciiString"

		case string

		case empty

		case symbol

		case choice

		case sequence

		case excluding

		case notIncluding

		case notIncludingAndThenSome

		case zeroOrOne

		case oneOrMore

		case zeroOrMore

		var reference: Text?
		{ nil }

		func callAsFunction (
			_ version: Version = .default
		) -> Symbol.Expression? {
			switch self {
				case .a·s·c·i·i·Character:
					return "!"
				case .non·a·s·c·i·i·Character:
					return "❤"
				case .a·s·c·i·i·AnyDiscrete:
					return √"ABCabc"
				case .a·s·c·i·i·AnyRange:
					return √["I"..."Z", "i"..."z"]
				case .a·s·c·i·i·Any:
					return √("ABC" + ["I"..."Z"] + "abc" + ["i"..."z"])
				case .non·a·s·c·i·i·AnyDiscrete:
					return √"†‡°′″"
				case .non·a·s·c·i·i·AnyRange:
					return √["§"..."¶", "×"..."÷"]
				case .non·a·s·c·i·i·Any:
					return √("†‡" + ["§"..."¶"] + "°′″" + ["×"..."÷"])
				case .anyDiscrete:
					return √"ABCabc†‡°′″"
				case .anyRange:
					return √["~"..."£", "I"..."Z", "i"..."z", "§"..."¶", "×"..."÷"]
				case .any:
					return √([["~"..."£"], "ABC", ["I"..."Z"], "abc", ["i"..."z"], "†‡", ["§"..."¶"], "°′″", ["×"..."÷"]].flatMap { $0 })
				case .a·s·c·i·i·NoneDiscrete:
					return ^"ABCabc"
				case .a·s·c·i·i·NoneRange:
					return ^["I"..."Z", "i"..."z"]
				case .a·s·c·i·i·None:
					return ^("ABC" + ["I"..."Z"] + "abc" + ["i"..."z"])
				case .non·a·s·c·i·i·NoneDiscrete:
					return ^"†‡°′″"
				case .non·a·s·c·i·i·NoneRange:
					return ^["§"..."¶", "×"..."÷"]
				case .non·a·s·c·i·i·None:
					return ^("†‡" + ["§"..."¶"] + "°′″" + ["×"..."÷"])
				case .noneDiscrete:
					return ^"ABCabc†‡°′″"
				case .noneRange:
					return ^["~"..."£", "I"..."Z", "i"..."z", "§"..."¶", "×"..."÷"]
				case .none:
					return ^([["~"..."£"], "ABC", ["I"..."Z"], "abc", ["i"..."z"], "†‡", ["§"..."¶"], "°′″", ["×"..."÷"]].flatMap { $0 })
				case .a·s·c·i·i·String:
					return "GIRLS"
				case .non·a·s·c·i·i·String:
					return "☠️💖"
				case .string:
					return "⒈ GIRLS BE CRUEL ☠️💖"
				case .empty:
					return ""
				case .symbol:
					return .empty′
				case .choice:
					return "ABC" | "123"
				case .sequence:
					return ["do", √"\u{20}\u{9}\u{D}\u{A}", "re", √"\u{20}\u{9}\u{D}\u{A}", "mi"]
				case .excluding:
					return ["❤", ^""] − ["❤", √"\u{FE0E}\u{FE0F}"]
				case .notIncluding:
					return (^"")* ÷ "💔"
				case .notIncludingAndThenSome:
					return ["❤", ([^"\u{FE0E}\u{FE0F}", (^"")*] ÷ "💔")°, "💔"]
				case .zeroOrOne:
					return (^"")°
				case .oneOrMore:
					return (^"")″
				case .zeroOrMore:
					return (^"")*
			}
		}

	}

	func testDescription () {
		for symbol in Symbol.allCases {
			let description: String
			switch symbol {
				case .a·s·c·i·i·Character:
					description = "‹!›"
				case .non·a·s·c·i·i·Character:
					description = "£2764;"
				case .a·s·c·i·i·AnyDiscrete:
					description = "⟨ABCabc⟩"
				case .a·s·c·i·i·AnyRange:
					description = "⟨I–Zi–z⟩"
				case .a·s·c·i·i·Any:
					description = "⟨ABCI–Zabci–z⟩"
				case .non·a·s·c·i·i·AnyDiscrete:
					description = "⟨£2020;£2021;£B0;£2032;£2033;⟩"
				case .non·a·s·c·i·i·AnyRange:
					description = "⟨£A7;–£B6;£D7;–£F7;⟩"
				case .non·a·s·c·i·i·Any:
					description = "⟨£2020;£2021;£A7;–£B6;£B0;£2032;£2033;£D7;–£F7;⟩"
				case .anyDiscrete:
					description = "⟨ABCabc£2020;£2021;£B0;£2032;£2033;⟩"
				case .anyRange:
					description = "⟨~–£A3;I–Zi–z£A7;–£B6;£D7;–£F7;⟩"
				case .any:
					description = "⟨~–£A3;ABCI–Zabci–z£2020;£2021;£A7;–£B6;£B0;£2032;£2033;£D7;–£F7;⟩"
				case .a·s·c·i·i·NoneDiscrete:
					description = "⟨∼ABCabc⟩"
				case .a·s·c·i·i·NoneRange:
					description = "⟨∼I–Zi–z⟩"
				case .a·s·c·i·i·None:
					description = "⟨∼ABCI–Zabci–z⟩"
				case .non·a·s·c·i·i·NoneDiscrete:
					description = "⟨∼£2020;£2021;£B0;£2032;£2033;⟩"
				case .non·a·s·c·i·i·NoneRange:
					description = "⟨∼£A7;–£B6;£D7;–£F7;⟩"
				case .non·a·s·c·i·i·None:
					description = "⟨∼£2020;£2021;£A7;–£B6;£B0;£2032;£2033;£D7;–£F7;⟩"
				case .noneDiscrete:
					description = "⟨∼ABCabc£2020;£2021;£B0;£2032;£2033;⟩"
				case .noneRange:
					description = "⟨∼~–£A3;I–Zi–z£A7;–£B6;£D7;–£F7;⟩"
				case .none:
					description = "⟨∼~–£A3;ABCI–Zabci–z£2020;£2021;£A7;–£B6;£B0;£2032;£2033;£D7;–£F7;⟩"
				case .a·s·c·i·i·String:
					description = "‹GIRLS›"
				case .non·a·s·c·i·i·String:
					description = "(£2620; £FE0F; £1F496;)"
				case .string:
					description = "(£2488; £20; ‹GIRLS› £20; ‹BE› £20; ‹CRUEL› £20; £2620; £FE0F; £1F496;)"
				case .empty:
					description = "()"
				case .symbol:
					description = "empty"
				case .choice:
					description = "(‹ABC› | ‹123›)"
				case .sequence:
					description = "(‹do› ⟨£20;£9;£D;£A;⟩ ‹re› ⟨£20;£9;£D;£A;⟩ ‹mi›)"
				case .excluding:
					description = "((£2764; ⟨∼⟩) − (£2764; ⟨£FE0E;£FE0F;⟩))"
				case .notIncluding:
					description = "((⟨∼⟩×) ÷ £1F494;)"
				case .notIncludingAndThenSome:
					description = "(£2764; (((⟨∼£FE0E;£FE0F;⟩ (⟨∼⟩×)) ÷ £1F494;)?) £1F494;)"
				case .zeroOrOne:
					description = "(⟨∼⟩?)"
				case .oneOrMore:
					description = "(⟨∼⟩+)"
				case .zeroOrMore:
					description = "(⟨∼⟩×)"
			}
			XCTAssertEqual(
				description,
				String(
					describing: symbol()!
				)
			)
		}
	}

	func testCharacterExpressionMatch () {
		XCTAssert(Symbol.a·s·c·i·i·Character ~= "!".unicodeScalars)
		XCTAssert(Symbol.non·a·s·c·i·i·Character ~= "❤".unicodeScalars)
		XCTAssertFalse(Symbol.a·s·c·i·i·Character ~= "".unicodeScalars)
		XCTAssertFalse(Symbol.a·s·c·i·i·Character ~= "!❤".unicodeScalars)
		XCTAssertFalse(Symbol.non·a·s·c·i·i·Character ~= "❤️".unicodeScalars)
	}

	func testAnyOfExpressionMatch () {
		XCTAssert(Symbol.any ~= "~".unicodeScalars)
		XCTAssert(Symbol.any ~= "£".unicodeScalars)
		XCTAssert(Symbol.any ~= "A".unicodeScalars)
		XCTAssert(Symbol.any ~= "j".unicodeScalars)
		XCTAssert(Symbol.any ~= "®".unicodeScalars)
		XCTAssert(Symbol.any ~= "†".unicodeScalars)
		XCTAssertFalse(Symbol.any ~= "".unicodeScalars)
		XCTAssertFalse(Symbol.any ~= "!".unicodeScalars)
		XCTAssertFalse(Symbol.any ~= "¥".unicodeScalars)
		XCTAssertFalse(Symbol.any ~= "D".unicodeScalars)
		XCTAssertFalse(Symbol.any ~= "Aj".unicodeScalars)
	}

	func testNoneOfExpressionMatch () {
		XCTAssert(Symbol.none ~= "!".unicodeScalars)
		XCTAssert(Symbol.none ~= "¥".unicodeScalars)
		XCTAssert(Symbol.none ~= "D".unicodeScalars)
		XCTAssertFalse(Symbol.none ~= "".unicodeScalars)
		XCTAssertFalse(Symbol.none ~= "~".unicodeScalars)
		XCTAssertFalse(Symbol.none ~= "£".unicodeScalars)
		XCTAssertFalse(Symbol.none ~= "A".unicodeScalars)
		XCTAssertFalse(Symbol.none ~= "j".unicodeScalars)
		XCTAssertFalse(Symbol.none ~= "®".unicodeScalars)
		XCTAssertFalse(Symbol.none ~= "†".unicodeScalars)
		XCTAssertFalse(Symbol.none ~= "¥D".unicodeScalars)
	}

	func testStringExpressionMatch () {
		XCTAssert(Symbol.a·s·c·i·i·String ~= "GIRLS".unicodeScalars)
		XCTAssert(Symbol.non·a·s·c·i·i·String ~= "☠️💖".unicodeScalars)
		XCTAssert(Symbol.string ~= "⒈ GIRLS BE CRUEL ☠️💖".unicodeScalars)
		XCTAssertFalse(Symbol.a·s·c·i·i·String ~= "GIRLS ".unicodeScalars)
		XCTAssertFalse(Symbol.non·a·s·c·i·i·String ~= "☠️".unicodeScalars)
		XCTAssertFalse(Symbol.string ~= "1. GIRLS BE CRUEL ☠️💖".unicodeScalars)
		XCTAssertFalse(Symbol.string ~= "⒈ GIRLS BE CRUEL ☠💖".unicodeScalars)
	}

	func testSymbolExpressionMatch () {
		XCTAssert(Symbol.symbol ~= "".unicodeScalars)
		XCTAssertFalse(Symbol.symbol ~= " ".unicodeScalars)
	}

	func testChoiceExpressionMatch () {
		XCTAssert(Symbol.choice ~= "ABC".unicodeScalars)
		XCTAssert(Symbol.choice ~= "123".unicodeScalars)
		XCTAssertFalse(Symbol.choice ~= "".unicodeScalars)
		XCTAssertFalse(Symbol.choice ~= "ABCABC".unicodeScalars)
		XCTAssertFalse(Symbol.choice ~= "ABC123".unicodeScalars)
		XCTAssertFalse(Symbol.choice ~= "YOU&ME".unicodeScalars)
	}

	func testSequenceExpressionMatch () {
		XCTAssert(Symbol.empty ~= "".unicodeScalars)
		XCTAssert(Symbol.sequence ~= "do re mi".unicodeScalars)
		XCTAssert(Symbol.sequence ~= """
			do
			re
			mi
			""".unicodeScalars)
		XCTAssertFalse(Symbol.empty ~= " ".unicodeScalars)
		XCTAssertFalse(Symbol.sequence ~= "".unicodeScalars)
		XCTAssertFalse(Symbol.sequence ~= "doremi".unicodeScalars)
		XCTAssertFalse(Symbol.sequence ~= "do re".unicodeScalars)
		XCTAssertFalse(Symbol.sequence ~= "mi".unicodeScalars)
	}

	func testSequenceExcludingMatch () {
		XCTAssert(Symbol.excluding ~= "❤A".unicodeScalars)
		XCTAssertFalse(Symbol.excluding ~= "❤".unicodeScalars)
		XCTAssertFalse(Symbol.excluding ~= "❤️".unicodeScalars)
		XCTAssertFalse(Symbol.excluding ~= "❤\u{FFFF}".unicodeScalars)
	}

	func testSequenceNotIncludingMatch () {
		XCTAssert(Symbol.notIncluding ~= "❤".unicodeScalars)
		XCTAssert(Symbol.notIncluding ~= "❤️".unicodeScalars)
		XCTAssert(Symbol.notIncluding ~= "abcdef".unicodeScalars)
		XCTAssertFalse(Symbol.notIncluding ~= "\u{FFFF}".unicodeScalars)
		XCTAssertFalse(Symbol.notIncluding ~= "💔".unicodeScalars)
		XCTAssertFalse(Symbol.notIncluding ~= "abcdef💔".unicodeScalars)
	}

	func testSequenceNotIncludingAndThenSomeMatch () {
		XCTAssert(Symbol.notIncludingAndThenSome ~= "❤💔".unicodeScalars)
		XCTAssert(Symbol.notIncludingAndThenSome ~= "❤→💔".unicodeScalars)
		XCTAssert(Symbol.notIncludingAndThenSome ~= "❤abcdef💔".unicodeScalars)
		XCTAssertFalse(Symbol.notIncludingAndThenSome ~= "❤️".unicodeScalars)
		XCTAssertFalse(Symbol.notIncluding ~= "💔".unicodeScalars)
		XCTAssertFalse(Symbol.notIncluding ~= "❤💔💔".unicodeScalars)
	}

	func testSequenceZeroOrOneMatch () {
		XCTAssert(Symbol.zeroOrOne ~= "".unicodeScalars)
		XCTAssert(Symbol.zeroOrOne ~= "❤".unicodeScalars)
		XCTAssertFalse(Symbol.zeroOrOne ~= "❤️".unicodeScalars)
	}

	func testSequenceOneOrMore () {
		XCTAssert(Symbol.oneOrMore ~= "❤".unicodeScalars)
		XCTAssert(Symbol.oneOrMore ~= "❤️".unicodeScalars)
		XCTAssertFalse(Symbol.oneOrMore ~= "".unicodeScalars)
	}

	func testSequenceZeroOrMoreMatch () {
		XCTAssert(Symbol.zeroOrMore ~= "".unicodeScalars)
		XCTAssert(Symbol.zeroOrMore ~= "❤".unicodeScalars)
		XCTAssert(Symbol.zeroOrMore ~= "❤️".unicodeScalars)
		XCTAssertFalse(Symbol.zeroOrMore ~= "abcdef\u{FFFF}ghij".unicodeScalars)
		XCTAssertFalse(Symbol.zeroOrMore ~= "\u{0}".unicodeScalars)
	}

	func testParse () {
		XCTAssertEqual(
			try! (["tracklist: ", .symbol(.string), "\u{A}hearts: ", (.symbol(.non·a·s·c·i·i·Character))*, √"\u{20}\u{9}\u{D}\u{A}", .symbol(.choice), .symbol(.sequence)] as Symbol.Expression).parse(
				"""
					tracklist: ⒈ GIRLS BE CRUEL ☠️💖
					hearts: ❤❤❤❤
					ABCdo re mi
					""".unicodeScalars).map(\.debugDescription).joined(),
			"""
				<string>tracklist: </string><symbol name="string" version=""><string>⒈ GIRLS BE CRUEL ☠️💖</string></symbol><string>
				hearts: </string><symbol name="non-asciiCharacter" version=""><string>❤</string></symbol><symbol name="non-asciiCharacter" version=""><string>❤</string></symbol><symbol name="non-asciiCharacter" version=""><string>❤</string></symbol><symbol name="non-asciiCharacter" version=""><string>❤</string></symbol><string>
				</string><symbol name="choice" version=""><string>ABC</string></symbol><symbol name="sequence" version=""><string>do re mi</string></symbol>
				"""
		)
	}

	func testExpressionDescriptionInitialization () {
		for symbol in Symbol.allCases {
			XCTAssertEqual(symbol()!.description, Symbol.Expression(symbol()!.description)?.description)
		}
	}

}
