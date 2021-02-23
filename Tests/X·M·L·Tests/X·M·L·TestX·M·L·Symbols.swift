//  # X·M·L·Tests :: X·M·L·TestX·M·L·Symbols
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

import XCTest
import E·B·N·F
import X·M·L

func properDescription (
	for symbol: X·M·L·Symbol,
	version: X·M·L·Version = X·M·L·Version.default
) -> String {
	switch symbol {
	case .document:
		switch version {
		case .xml10:
			return "[1] document ::= (prolog element (Misc×))"
		case .xml11:
			return "[1] document ::= ((prolog element (Misc×)) ÷ RestrictedChar)"
		}
	case .Char:
		switch version {
		case .xml10:
			return "[2] Char ::= ⟨£9;£A;£D;£20;–£D7FF;£E000;–£FFFD;£10000;–£10FFFF;⟩"
		case .xml11:
			return "[2] Char ::= ⟨£1;–£D7FF;£E000;–£FFFD;£10000;–£10FFFF;⟩"
		}
	case .RestrictedChar:
		switch version {
		case .xml10:
			return "[2a] RestrictedChar ::= /* Not defined */"
		case .xml11:
			return "[2a] RestrictedChar ::= ⟨£1;–£8;£B;–£C;£E;–£1F;£7F;–£84;£86;–£9F;⟩"
		}
	case .S:
		return "[3] S ::= (⟨£20;£9;£D;£A;⟩+)"
	case .NameStartChar:
		return "[4] NameStartChar ::= ⟨:A–Z_a–z£C0;–£D6;£D8;–£F6;£F8;–£2FF;£370;–£37D;£37F;–£1FFF;£200C;–£200D;£2070;–£218F;£2C00;–£2FEF;£3001;–£D7FF;£F900;–£FDCF;£FDF0;–£FFFD;£10000;–£EFFFF;⟩"
	case .NameChar:
		return "[4a] NameChar ::= (NameStartChar | ⟨-.0–9£B7;£300;–£36F;£203F;–£2040;⟩)"
	case .Name:
		return "[5] Name ::= (NameStartChar (NameChar×))"
	case .Names:
		return "[6] Names ::= (Name ((£20; Name)×))"
	case .Nmtoken:
		return "[7] Nmtoken ::= (NameChar+)"
	case .Nmtokens:
		return "[8] Nmtokens ::= (Nmtoken ((£20; Nmtoken)×))"
	case .EntityValue:
		return #"[9] EntityValue ::= ((‹"› ((⟨∼%&"⟩ | PEReference | Reference)×) ‹"›) | (‹'› ((⟨∼%&'⟩ | PEReference | Reference)×) ‹'›))"#
	case .AttValue:
		return #"[10] AttValue ::= ((‹"› ((⟨∼<&"⟩ | Reference)×) ‹"›) | (‹'› ((⟨∼<&'⟩ | Reference)×) ‹'›))"#
	case .SystemLiteral:
		return #"[11] SystemLiteral ::= ((‹"› (⟨∼"⟩×) ‹"›) | (‹'› (⟨∼'⟩×) ‹'›))"#
	case .PubidLiteral:
		return #"[12] PubidLiteral ::= ((‹"› (PubidChar×) ‹"›) | (‹'› ((PubidChar − ‹'›)×) ‹'›))"#
	case .PubidChar:
		return "[13] PubidChar ::= ⟨£20;£D;£A;a–zA–Z0–9-'()+,./:=?;!*#@$_%⟩"
	case .CharData:
		return "[14] CharData ::= ((⟨∼<&⟩×) ÷ ‹]]>›)"
	case .Comment:
		return "[15] Comment ::= (‹<!--› (((Char − ‹-›) | (‹-› (Char − ‹-›)))×) ‹-->›)"
	case .PI:
		return "[16] PI ::= (‹<?› PITarget ((S ((Char×) ÷ ‹?>›))?) ‹?>›)"
	case .PITarget:
		return "[17] PITarget ::= (Name − (⟨Xx⟩ ⟨Mm⟩ ⟨Ll⟩))"
	case .CDSect:
		return "[18] CDSect ::= (CDStart CData CDEnd)"
	case .CDStart:
		return "[19] CDStart ::= ‹<![CDATA[›"
	case .CData:
		return "[20] CData ::= ((Char×) ÷ ‹]]>›)"
	case .CDEnd:
		return "[21] CDEnd ::= ‹]]>›"
	case .prolog:
		switch version {
		case .xml10:
			return "[22] prolog ::= ((XMLDecl?) (Misc×) ((doctypedecl (Misc×))?))"
		case .xml11:
			return "[22] prolog ::= (XMLDecl (Misc×) ((doctypedecl (Misc×))?))"
		}
	case .XMLDecl:
		return "[23] XMLDecl ::= (‹<?xml› VersionInfo (EncodingDecl?) (SDDecl?) (S?) ‹?>›)"
	case .VersionInfo:
		return #"[24] VersionInfo ::= (S ‹version› Eq ((‹'› VersionNum ‹'›) | (‹"› VersionNum ‹"›)))"#
	case .Eq:
		return "[25] Eq ::= ((S?) ‹=› (S?))"
	case .VersionNum:
		switch version {
		case .xml10:
			return "[26] VersionNum ::= (‹1.› (⟨0–9⟩+))"
		case .xml11:
			return "[26] VersionNum ::= ‹1.1›"
		}
	case .Misc:
		return "[27] Misc ::= (Comment | PI | S)"
	case .doctypedecl:
		return "[28] doctypedecl ::= (‹<!DOCTYPE› S Name ((S ExternalID)?) (S?) ((‹[› intSubset ‹]› (S?))?) ‹>›)"
	case .DeclSep:
		return "[28a] DeclSep ::= (PEReference | S)"
	case .intSubset:
		return "[28b] intSubset ::= ((markupdecl | DeclSep)×)"
	case .markupdecl:
		return "[29] markupdecl ::= (elementdecl | AttlistDecl | EntityDecl | NotationDecl | PI | Comment)"
	case .extSubset:
		return "[30] extSubset ::= ((TextDecl?) extSubsetDecl)"
	case .extSubsetDecl:
		return "[31] extSubsetDecl ::= ((markupdecl | conditionalSect | DeclSep)×)"
	case .SDDecl:
		return #"[32] SDDecl ::= (S ‹standalone› Eq ((‹'› (‹yes› | ‹no›) ‹'›) | (‹"› (‹yes› | ‹no›) ‹"›)))"#
	case .element:
		return "[39] element ::= (EmptyElemTag | (STag content ETag))"
	case .STag:
		return "[40] STag ::= (‹<› Name ((S Attribute)×) (S?) ‹>›)"
	case .Attribute:
		return "[41] Attribute ::= (Name Eq AttValue)"
	case .ETag:
		return "[42] ETag ::= (‹</› Name (S?) ‹>›)"
	case .content:
		return "[43] content ::= ((CharData?) (((element | Reference | CDSect | PI | Comment) (CharData?))×))"
	case .EmptyElemTag:
		return "[44] EmptyElemTag ::= (‹<› Name ((S Attribute)×) (S?) ‹/>›)"
	case .elementdecl:
		return "[45] elementdecl ::= (‹<!ELEMENT› S Name S contentspec (S?) ‹>›)"
	case .contentspec:
		return "[46] contentspec ::= (‹EMPTY› | ‹ANY› | Mixed | children)"
	case .children:
		return "[47] children ::= ((choice | seq) (⟨?*+⟩?))"
	case .cp:
		return "[48] cp ::= ((Name | choice | seq) (⟨?*+⟩?))"
	case .choice:
		return "[49] choice ::= (‹(› (S?) cp (((S?) ‹|› (S?) cp)+) (S?) ‹)›)"
	case .seq:
		return "[50] seq ::= (‹(› (S?) cp (((S?) ‹,› (S?) cp)×) (S?) ‹)›)"
	case .Mixed:
		return "[51] Mixed ::= ((‹(› (S?) ‹#PCDATA› (((S?) ‹|› (S?) Name)×) (S?) ‹)*›) | (‹(› (S?) ‹#PCDATA› (S?) ‹)›))"
	case .AttlistDecl:
		return "[52] AttlistDecl ::= (‹<!ATTLIST› S Name (AttDef×) (S?) ‹>›)"
	case .AttDef:
		return "[53] AttDef ::= (S Name S AttType S DefaultDecl)"
	case .AttType:
		return "[54] AttType ::= (StringType | TokenizedType | EnumeratedType)"
	case .StringType:
		return "[55] StringType ::= ‹CDATA›"
	case .TokenizedType:
		return "[56] TokenizedType ::= (‹ID› | ‹IDREF› | ‹IDREFS› | ‹ENTITY› | ‹ENTITIES› | ‹NMTOKEN› | ‹NMTOKENS›)"
	case .EnumeratedType:
		return "[57] EnumeratedType ::= (NotationType | Enumeration)"
	case .NotationType:
		return "[58] NotationType ::= (‹NOTATION› S ‹(› (S?) Name (((S?) ‹|› (S?) Name)×) (S?) ‹)›)"
	case .Enumeration:
		return "[59] Enumeration ::= (‹(› (S?) Nmtoken (((S?) ‹|› (S?) Nmtoken)×) (S?) ‹)›)"
	case .DefaultDecl:
		return "[60] DefaultDecl ::= (‹#REQUIRED› | ‹#IMPLIED› | (((‹#FIXED› S)?) AttValue))"
	case .conditionalSect:
		return "[61] conditionalSect ::= (includeSect | ignoreSect)"
	case .includeSect:
		return "[62] includeSect ::= (‹<![› (S?) ‹INCLUDE› (S?) ‹[› extSubsetDecl ‹]]>›)"
	case .ignoreSect:
		return "[63] ignoreSect ::= (‹<![› (S?) ‹IGNORE› (S?) ‹[› (ignoreSectContents×) ‹]]>›)"
	case .ignoreSectContents:
		return "[64] ignoreSectContents ::= (Ignore ((‹<![› ignoreSectContents ‹]]>› Ignore)×))"
	case .Ignore:
		return "[65] Ignore ::= ((Char×) ÷ (‹<![› | ‹]]>›))"
	case .CharRef:
		return "[66] CharRef ::= ((‹&#› (⟨0–9⟩+) ‹;›) | (‹&#x› (⟨0–9a–fA–F⟩+) ‹;›))"
	case .Reference:
		return "[67] Reference ::= (EntityRef | CharRef)"
	case .EntityRef:
		return "[68] EntityRef ::= (‹&› Name ‹;›)"
	case .PEReference:
		return "[69] PEReference ::= (‹%› Name ‹;›)"
	case .EntityDecl:
		return "[70] EntityDecl ::= (GEDecl | PEDecl)"
	case .GEDecl:
		return "[71] GEDecl ::= (‹<!ENTITY› S Name S EntityDef (S?) ‹>›)"
	case .PEDecl:
		return "[72] PEDecl ::= (‹<!ENTITY› S ‹%› S Name S PEDef (S?) ‹>›)"
	case .EntityDef:
		return "[73] EntityDef ::= (EntityValue | (ExternalID (NDataDecl?)))"
	case .PEDef:
		return "[74] PEDef ::= (EntityValue | ExternalID)"
	case .ExternalID:
		return "[75] ExternalID ::= ((‹SYSTEM› S SystemLiteral) | (‹PUBLIC› S PubidLiteral S SystemLiteral))"
	case .NDataDecl:
		return "[76] NDataDecl ::= (S ‹NDATA› S Name)"
	case .TextDecl:
		return "[77] TextDecl ::= (‹<?xml› (VersionInfo?) EncodingDecl (S?) ‹?>›)"
	case .extParsedEnt:
		switch version {
		case .xml10:
			return "[78] extParsedEnt ::= ((TextDecl?) content)"
		case .xml11:
			return "[78] extParsedEnt ::= (((TextDecl?) content) ÷ RestrictedChar)"
		}
	case .EncodingDecl:
		return #"[80] EncodingDecl ::= (S ‹encoding› Eq ((‹"› EncName ‹"›) | (‹'› EncName ‹'›)))"#
	case .EncName:
		return #"[81] EncName ::= (⟨A–Za–z⟩ (⟨A–Za–z0–9._-⟩×))"#
	case .NotationDecl:
		return "[82] NotationDecl ::= (‹<!NOTATION› S Name S (ExternalID | PublicID) (S?) ‹>›)"
	case .PublicID:
		return "[83] PublicID ::= (‹PUBLIC› S PubidLiteral)"
	case .Letter:
		switch version {
		case .xml10:
			return "[84] Letter ::= (BaseChar | Ideographic)"
		case .xml11:
			return "[84] Letter ::= /* Not defined */"
		}
	case .BaseChar:
		switch version {
		case .xml10:
			return "[85] BaseChar ::= ⟨A–Za–z£C0;–£D6;£D8;–£F6;£F8;–£FF;£100;–£131;£134;–£13E;£141;–£148;£14A;–£17E;£180;–£1C3;£1CD;–£1F0;£1F4;–£1F5;£1FA;–£217;£250;–£2A8;£2BB;–£2C1;£386;£388;–£38A;£38C;£38E;–£3A1;£3A3;–£3CE;£3D0;–£3D6;£3DA;£3DC;£3DE;£3E0;£3E2;–£3F3;£401;–£40C;£40E;–£44F;£451;–£45C;£45E;–£481;£490;–£4C4;£4C7;–£4C8;£4CB;–£4CC;£4D0;–£4EB;£4EE;–£4F5;£4F8;–£4F9;£531;–£556;£559;£561;–£586;£5D0;–£5EA;£5F0;–£5F2;£621;–£63A;£641;–£64A;£671;–£6B7;£6BA;–£6BE;£6C0;–£6CE;£6D0;–£6D3;£6D5;£6E5;–£6E6;£905;–£939;£93D;£958;–£961;£985;–£98C;£98F;–£990;£993;–£9A8;£9AA;–£9B0;£9B2;£9B6;–£9B9;£9DC;–£9DD;£9DF;–£9E1;£9F0;–£9F1;£A05;–£A0A;£A0F;–£A10;£A13;–£A28;£A2A;–£A30;£A32;–£A33;£A35;–£A36;£A38;–£A39;£A59;–£A5C;£A5E;£A72;–£A74;£A85;–£A8B;£A8D;£A8F;–£A91;£A93;–£AA8;£AAA;–£AB0;£AB2;–£AB3;£AB5;–£AB9;£ABD;£AE0;£B05;–£B0C;£B0F;–£B10;£B13;–£B28;£B2A;–£B30;£B32;–£B33;£B36;–£B39;£B3D;£B5C;–£B5D;£B5F;–£B61;£B85;–£B8A;£B8E;–£B90;£B92;–£B95;£B99;–£B9A;£B9C;£B9E;–£B9F;£BA3;–£BA4;£BA8;–£BAA;£BAE;–£BB5;£BB7;–£BB9;£C05;–£C0C;£C0E;–£C10;£C12;–£C28;£C2A;–£C33;£C35;–£C39;£C60;–£C61;£C85;–£C8C;£C8E;–£C90;£C92;–£CA8;£CAA;–£CB3;£CB5;–£CB9;£CDE;£CE0;–£CE1;£D05;–£D0C;£D0E;–£D10;£D12;–£D28;£D2A;–£D39;£D60;–£D61;£E01;–£E2E;£E30;£E32;–£E33;£E40;–£E45;£E81;–£E82;£E84;£E87;–£E88;£E8A;£E8D;£E94;–£E97;£E99;–£E9F;£EA1;–£EA3;£EA5;£EA7;£EAA;–£EAB;£EAD;–£EAE;£EB0;£EB2;–£EB3;£EBD;£EC0;–£EC4;£F40;–£F47;£F49;–£F69;£10A0;–£10C5;£10D0;–£10F6;£1100;£1102;–£1103;£1105;–£1107;£1109;£110B;–£110C;£110E;–£1112;£113C;£113E;£1140;£114C;£114E;£1150;£1154;–£1155;£1159;£115F;–£1161;£1163;£1165;£1167;£1169;£116D;–£116E;£1172;–£1173;£1175;£119E;£11A8;£11AB;£11AE;–£11AF;£11B7;–£11B8;£11BA;£11BC;–£11C2;£11EB;£11F0;£11F9;£1E00;–£1E9B;£1EA0;–£1EF9;£1F00;–£1F15;£1F18;–£1F1D;£1F20;–£1F45;£1F48;–£1F4D;£1F50;–£1F57;£1F59;£1F5B;£1F5D;£1F5F;–£1F7D;£1F80;–£1FB4;£1FB6;–£1FBC;£1FBE;£1FC2;–£1FC4;£1FC6;–£1FCC;£1FD0;–£1FD3;£1FD6;–£1FDB;£1FE0;–£1FEC;£1FF2;–£1FF4;£1FF6;–£1FFC;£2126;£212A;–£212B;£212E;£2180;–£2182;£3041;–£3094;£30A1;–£30FA;£3105;–£312C;£AC00;–£D7A3;⟩"
		case .xml11:
			return "[85] BaseChar ::= /* Not defined */"
		}
	case .Ideographic:
		switch version {
		case .xml10:
			return "[86] Ideographic ::= ⟨£4E00;–£9FA5;£3007;£3021;–£3029;⟩"
		case .xml11:
			return "[86] Ideographic ::= /* Not defined */"
		}
	case .CombiningChar:
		switch version {
		case .xml10:
			return "[87] CombiningChar ::= ⟨£300;–£345;£360;–£361;£483;–£486;£591;–£5A1;£5A3;–£5B9;£5BB;–£5BD;£5BF;£5C1;–£5C2;£5C4;£64B;–£652;£670;£6D6;–£6DC;£6DD;–£6DF;£6E0;–£6E4;£6E7;–£6E8;£6EA;–£6ED;£901;–£903;£93C;£93E;–£94C;£94D;£951;–£954;£962;–£963;£981;–£983;£9BC;£9BE;£9BF;£9C0;–£9C4;£9C7;–£9C8;£9CB;–£9CD;£9D7;£9E2;–£9E3;£A02;£A3C;£A3E;£A3F;£A40;–£A42;£A47;–£A48;£A4B;–£A4D;£A70;–£A71;£A81;–£A83;£ABC;£ABE;–£AC5;£AC7;–£AC9;£ACB;–£ACD;£B01;–£B03;£B3C;£B3E;–£B43;£B47;–£B48;£B4B;–£B4D;£B56;–£B57;£B82;–£B83;£BBE;–£BC2;£BC6;–£BC8;£BCA;–£BCD;£BD7;£C01;–£C03;£C3E;–£C44;£C46;–£C48;£C4A;–£C4D;£C55;–£C56;£C82;–£C83;£CBE;–£CC4;£CC6;–£CC8;£CCA;–£CCD;£CD5;–£CD6;£D02;–£D03;£D3E;–£D43;£D46;–£D48;£D4A;–£D4D;£D57;£E31;£E34;–£E3A;£E47;–£E4E;£EB1;£EB4;–£EB9;£EBB;–£EBC;£EC8;–£ECD;£F18;–£F19;£F35;£F37;£F39;£F3E;£F3F;£F71;–£F84;£F86;–£F8B;£F90;–£F95;£F97;£F99;–£FAD;£FB1;–£FB7;£FB9;£20D0;–£20DC;£20E1;£302A;–£302F;£3099;£309A;⟩"
		case .xml11:
			return "[87] CombiningChar ::= /* Not defined */"
		}
	case .Digit:
		switch version {
		case .xml10:
			return "[88] Digit ::= ⟨0–9£660;–£669;£6F0;–£6F9;£966;–£96F;£9E6;–£9EF;£A66;–£A6F;£AE6;–£AEF;£B66;–£B6F;£BE7;–£BEF;£C66;–£C6F;£CE6;–£CEF;£D66;–£D6F;£E50;–£E59;£ED0;–£ED9;£F20;–£F29;⟩"
		case .xml11:
			return "[88] Digit ::= /* Not defined */"
		}
	case .Extender:
		switch version {
		case .xml10:
			return "[89] Extender ::= ⟨£B7;£2D0;£2D1;£387;£640;£E46;£EC6;£3005;£3031;–£3035;£309D;–£309E;£30FC;–£30FE;⟩"
		case .xml11:
			return "[89] Extender ::= /* Not defined */"
		}
	}
}

final class X·M·L·TestX·M·L·Symbols:
	XCTestCase
{

	func testX·M·L·SymbolDebugDescription () {
		for symbol in X·M·L·Symbol.allCases {
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

	func testX·M·L·10SymbolDebugDescription () {
		for symbol in X·M·L·Symbol.allCases {
			XCTAssertEqual(
				properDescription(
					for: symbol,
					version: .xml10
				),
				String(
					reflecting: symbol,
					version: .xml10
				)
			)
		}
	}

}
