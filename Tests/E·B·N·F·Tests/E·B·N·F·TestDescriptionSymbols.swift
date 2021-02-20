//  # E·B·N·F·Tests :: E·B·N·F·TestDescriptionSymbols
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import XCTest
import E·B·N·F

func properDescription (
	for symbol: DescriptionSymbol
) -> String {
	switch symbol {
	case .character:
		return "character ::= (£A3; (⟨0–9A–F⟩+) ‹;›)"
	case .anyOf:
		return "anyOf ::= (£27E8; (((character | ⟨!–~⟩) ((£2013; (character | ⟨!–~⟩))?))×) £27E9;)"
	case .noneOf:
		return "noneOf ::= (£27E8; £223C; (((character | ⟨!–~⟩) ((£2013; (character | ⟨!–~⟩))?))×) £27E9;)"
	case .string:
		return "string ::= (£2039; (⟨!–~⟩×) £203A;)"
	case .symbol:
		return "symbol ::= (((⟨A–Z_a–z£C0;–£D6;£D8;–£F6;£F8;–£2FF;£370;–£37D;£37F;–£1FFF;£200C;–£200D;£2070;–£218F;£2C00;–£2FEF;£3001;–£D7FF;£F900;–£FDCF;£FDF0;–£FFFD;£10000;–£EFFFF;⟩ (⟨A–Z_a–z£C0;–£D6;£D8;–£F6;£F8;–£2FF;£370;–£37D;£37F;–£1FFF;£200C;–£200D;£2070;–£218F;£2C00;–£2FEF;£3001;–£D7FF;£F900;–£FDCF;£FDF0;–£FFFD;£10000;–£EFFFF;-.0–9£B7;£300;–£36F;£203F;–£2040;⟩×)) ‹:› (⟨A–Z_a–z£C0;–£D6;£D8;–£F6;£F8;–£2FF;£370;–£37D;£37F;–£1FFF;£200C;–£200D;£2070;–£218F;£2C00;–£2FEF;£3001;–£D7FF;£F900;–£FDCF;£FDF0;–£FFFD;£10000;–£EFFFF;⟩ (⟨A–Z_a–z£C0;–£D6;£D8;–£F6;£F8;–£2FF;£370;–£37D;£37F;–£1FFF;£200C;–£200D;£2070;–£218F;£2C00;–£2FEF;£3001;–£D7FF;£F900;–£FDCF;£FDF0;–£FFFD;£10000;–£EFFFF;-.0–9£B7;£300;–£36F;£203F;–£2040;⟩×))) | (⟨A–Z_a–z£C0;–£D6;£D8;–£F6;£F8;–£2FF;£370;–£37D;£37F;–£1FFF;£200C;–£200D;£2070;–£218F;£2C00;–£2FEF;£3001;–£D7FF;£F900;–£FDCF;£FDF0;–£FFFD;£10000;–£EFFFF;⟩ (⟨A–Z_a–z£C0;–£D6;£D8;–£F6;£F8;–£2FF;£370;–£37D;£37F;–£1FFF;£200C;–£200D;£2070;–£218F;£2C00;–£2FEF;£3001;–£D7FF;£F900;–£FDCF;£FDF0;–£FFFD;£10000;–£EFFFF;-.0–9£B7;£300;–£36F;£203F;–£2040;⟩×)))"
	case .choice:
		return "choice ::= (‹(› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) (((((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹|› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore))+) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹)›)"
	case .sequence:
		return "sequence ::= (‹(› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (((character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) ((((‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›)×) (⟨£20;£9;£D;£A;⟩+) (((‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›) (⟨£20;£9;£D;£A;⟩×))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore))×) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×))?) ‹)›)"
	case .excluding:
		return "excluding ::= (‹(› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) £2212; (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹)›)"
	case .notIncluding:
		return "notIncluding ::= (‹(› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) £F7; (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹)›)"
	case .zeroOrOne:
		return "zeroOrOne ::= (‹(› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹?› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹)›)"
	case .oneOrMore:
		return "oneOrMore ::= (‹(› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹+› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹)›)"
	case .zeroOrMore:
		return "zeroOrMore ::= (‹(› (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) (character | anyOf | noneOf | string | symbol | choice | sequence | excluding | notIncluding | zeroOrOne | zeroOrMore | oneOrMore) (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) £D7; (((⟨£20;£9;£D;£A;⟩+) | (‹/*› ((⟨∼⟩×) ÷ ‹*/›) ‹*/›))×) ‹)›)"
	}
}

final class E·B·N·F·TestDescriptionSymbols:
	XCTestCase
{

	func testDescriptionSymbolDebugDescription () {
		for symbol in DescriptionSymbol.allCases {
			XCTAssertEqual(
				properDescription(
					for: symbol
				),
				String(
					reflecting: symbol
				)
			)
		}
	}

}
