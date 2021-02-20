//  #  X·M·L :: X·M·L·Symbol  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core
import E·B·N·F

/// A symbol representing an XML syntactic construct.
///
///  +  Version:
///     `0.2.0`.
public enum X·M·L·Symbol:
	String,
	CaseIterable
{

	/// An XML document.
	///
	/// ###  XML 1.1  ###
	///
	///     [1] document ::= ( prolog element Misc* ) - ( Char* RestrictedChar Char* )
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-document>.
	///
	/// ###  XML 1.0  ###
	///
	///     [1] document ::= prolog element Misc*
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-document>.
	///
	///  +  Version:
	///     `0.2.0`.
	case document

	/// Any Unicode character, excluding the surrogate blocks, U+FFFE, and U+FFFF.
	///
	/// ###  XML 1.1  ###
	///
	///     [2] Char ::= [#x1-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Char>.
	///
	/// ###  XML 1.0  ###
	///
	///     [2] Char ::= #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-Char>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Char

	/// Characters which are not allowed to be included verbatim in XML documents.
	///
	/// ###  XML 1.1  ###
	///
	///     [2a] RestrictedChar ::= [#x1-#x8] | [#xB-#xC] | [#xE-#x1F] | [#x7F-#x84] | [#x86-#x9F]
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-RestrictedChar>.
	///
	///  +  Version:
	///     `0.2.0`.
	case RestrictedChar

	/// One or more space (U+0020) characters, carriage returns, line feeds, or tabs.
	///
	///     [3] S ::= (#x20 | #x9 | #xD | #xA)+
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-S>.
	///
	///  +  Version:
	///     `0.2.0`.
	case S

	/// An XML Name character, excepting European (ASCII) digits and basic combining characters which may not begin a Name.
	///
	///     [4] NameStartChar ::= ":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-NameStartChar>.
	///
	///  +  Version:
	///     `0.2.0`.
	case NameStartChar

	/// An XML Name character.
	///
	///     [4a] NameChar ::= NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-NameChar>.
	///
	///  +  Version:
	///     `0.2.0`.
	case NameChar

	/// A token beginning with a letter or one of a few punctuation characters, and continuing with letters, digits, hyphens, underscores, colons, or full stops, together known as name characters.
	///
	///     [5] Name ::= NameStartChar (NameChar)*
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Name>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Name

	/// One or more `XML11.Grammar.Symbol.Name`s, separated by spaces.
	///
	///     [6] Names ::= Name (#x20 Name)*
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Names>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Names

	/// A name token: any mixture of name characters.
	///
	///     [7] Nmtoken ::= (NameChar)+
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Nmtoken>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Nmtoken

	/// One or more `XML11.Grammar.Symbol.Nmtoken`s, separated by spaces.
	///
	///     [8] Nmtokens ::= Nmtoken (#x20 Nmtoken)*
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Nmtokens>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Nmtokens

	/// A literal used for specifying the content of internal entities.
	///
	///     [9] EntityValue ::= '"' ([^%&"] | PEReference | Reference)* '"' | "'" ([^%&'] | PEReference | Reference)* "'"
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-EntityValue>.
	///
	///  +  Version:
	///     `0.2.0`.
	case EntityValue

	/// A literal used for specifying the values of attributes.
	///
	///     [10] AttValue ::= '"' ([^<&"] | Reference)* '"' | "'" ([^<&'] | Reference)* "'"—
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-AttValue>.
	///
	///  +  Version:
	///     `0.2.0`.
	case AttValue

	/// A literal used for specifying external identifiers.
	///
	///     [11] SystemLiteral ::= ('"' [^"]* '"') | ("'" [^']* "'")
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-SystemLiteral>.
	///
	///  +  Version:
	///     `0.2.0`.
	case SystemLiteral

	/// A literal used for specifying public identifiers.
	///
	///     [12] PubidLiteral ::= '"' PubidChar* '"' | "'" (PubidChar - "'")* "'"
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-PubidLiteral>.
	///
	///  +  Version:
	///     `0.2.0`.
	case PubidLiteral

	/// A character for use in public identifiers.
	///
	///     [13] PubidChar ::= #x20 | #xD | #xA | [a-zA-Z0-9] | [-'()+,./:=?;!*#@$_%]
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-PubidChar>.
	///
	///  +  Version:
	///     `0.2.0`.
	case PubidChar

	/// All text which is not markup.
	///
	///     [14] CharData ::= [^<&]* - ([^<&]* ']]>' [^<&]*)
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-CharData>.
	///
	///  +  Version:
	///     `0.2.0`.
	case CharData

	/// A comment.
	///
	///     [15] Comment ::= '<!--' ((Char - '-') | ('-' (Char - '-')))* '-->'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Comment>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Comment

	/// A Processing Instruction (PI).
	///
	///     [16] PI ::= '<?' PITarget (S (Char* - (Char* '?>' Char*)))? '?>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-PI>.
	///
	///  +  Version:
	///     `0.2.0`.
	case PI

	/// The application target of a PI.
	///
	///     [17] PITarget ::= Name - (('X' | 'x') ('M' | 'm') ('L' | 'l'))
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-PITarget>.
	///
	///  +  Version:
	///     `0.2.0`.
	case PITarget

	/// A CDATA section, escaping characters which otherwise would be recognized as markup.
	///
	///     [18] CDSect ::= CDStart CData CDEnd
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-CDSect>.
	///
	///  +  Version:
	///     `0.2.0`.
	case CDSect

	/// The start string of a CDATA section.
	///
	///     [19] CDStart ::= '<![CDATA['
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-CDStart>.
	///
	///  +  Version:
	///     `0.2.0`.
	case CDStart

	/// The contents of a CDATA section.
	///
	///     [20] CData ::= (Char* - (Char* ']]>' Char*))
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-CData>.
	///
	///  +  Version:
	///     `0.2.0`.
	case CData

	/// The end string of a CDATA section.
	///
	///     [21] CDEnd ::= ']]>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-CDEnd>.
	///
	///  +  Version:
	///     `0.2.0`.
	case CDEnd

	/// The prolog to an XML document.
	///
	///     [22] prolog ::= XMLDecl Misc* (doctypedecl Misc*)?
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-prolog>.
	///
	///  +  Version:
	///     `0.2.0`.
	case prolog

	/// The XML declaration which specifies the version of XML being used.
	///
	///     [23] XMLDecl ::= '<?xml' VersionInfo EncodingDecl? SDDecl? S? '?>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-XMLDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case XMLDecl

	/// The version info within an XML declaration.
	///
	///     [24] VersionInfo ::= S 'version' Eq ("'" VersionNum "'" | '"' VersionNum '"')
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-VersionInfo>.
	///
	///  +  Version:
	///     `0.2.0`.
	case VersionInfo

	/// An equals, optionally surrounded by whitespace.
	///
	///     [25] Eq ::= S? '=' S?
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Eq>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Eq

	/// The version number of the XML document (always `1.1` for XML 1.1 documents).
	///
	/// ###  XML 1.1  ###
	///
	///     [26] VersionNum ::= '1.1'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-VersionNum>.
	///
	/// ###  XML 1.0  ###
	///
	///     [26] VersionNum ::= '1.' [0-9]+
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-VersionNum>.
	///
	///  +  Version:
	///     `0.2.0`.
	case VersionNum

	/// Miscellaneous content which does not contribute meaning.
	///
	///     [27] Misc ::= Comment | PI | S
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Misc>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Misc

	/// An XML document type declaration.
	///
	///     [28] doctypedecl ::= '<!DOCTYPE' S Name (S ExternalID)? S? ('[' intSubset ']' S?)? '>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-doctypedecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case doctypedecl

	/// A separator of declarations within a document type declaration.
	///
	///     [28a] DeclSep ::= PEReference | S
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-DeclSep>.
	///
	///  +  Version:
	///     `0.2.0`.
	case DeclSep

	/// An internal subset of declarations within a document type declaration.
	///
	///     [28b] intSubset ::= (markupdecl | DeclSep)*
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-intSubset>.
	///
	///  +  Version:
	///     `0.2.0`.
	case intSubset

	/// A markup declaration, as found within a document type declaration.
	///
	///     [29] markupdecl ::= elementdecl | AttlistDecl | EntityDecl | NotationDecl | PI | Comment
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-markupdecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case markupdecl

	/// An external subset of declarations within a document type declaration.
	///
	///     [30] extSubset ::= TextDecl? extSubsetDecl
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-extSubset>.
	///
	///  +  Version:
	///     `0.2.0`.
	case extSubset

	/// A declaration in an external subset.
	///
	///     [31] extSubsetDecl ::= ( markupdecl | conditionalSect | DeclSep)*
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-extSubsetDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case extSubsetDecl

	/// A standalone document declaration.
	///
	///     [32] SDDecl ::= S 'standalone' Eq (("'" ('yes' | 'no') "'") | ('"' ('yes' | 'no') '"'))
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-SDDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case SDDecl

	/// An XML element.
	///
	///     [39] element ::= EmptyElemTag | STag content ETag
	///
	/// ### Well‐formedness constraint: Element Type Match
	///
	/// The `.Name` in an `.element`’s `.ETag` **must** match the `.Name` in the element’s `.STag`.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-element>.
	///
	///  +  Version:
	///     `0.2.0`.
	case element

	/// The start‐tag of an XML element.
	///
	///     [40] STag ::= '<' Name (S Attribute)* S? '>'
	///
	/// ### Well‐formedness constraint: Unique Att Spec
	///
	/// `.STag`s **must not** have two `.Attribute`s with the same `.Name`.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-STag>.
	///
	///  +  Version:
	///     `0.2.0`.
	case STag

	/// An attribute specification for an element.
	///
	///     [41] Attribute ::= Name Eq AttValue
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Attribute>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Attribute

	/// The end‐tag of an XML element.
	///
	///     [42] ETag ::= '</' Name S? '>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-ETag>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ETag

	/// The contents of an XML element.
	///
	///     [43] content ::= CharData? ((element | Reference | CDSect | PI | Comment) CharData?)*
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-content>.
	///
	///  +  Version:
	///     `0.2.0`.
	case content

	/// The an empty XML element.
	///
	///     [44] EmptyElemTag ::= '<' Name (S Attribute)* S? '/>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-EmptyElemTag>.
	///
	///  +  Version:
	///     `0.2.0`.
	case EmptyElemTag

	/// An element type declaration.
	///
	///     [45] elementdecl ::= '<!ELEMENT' S Name S contentspec S? '>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-elementdecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case elementdecl

	/// The specification for element contents in an element type declaration.
	///
	///     [46] contentspec ::= 'EMPTY' | 'ANY' | Mixed | children
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-contentspec>.
	///
	///  +  Version:
	///     `0.2.0`.
	case contentspec

	/// The allowed children in an element.
	///
	///     [47] children ::= (choice | seq) ('?' | '*' | '+')?
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-children>.
	///
	///  +  Version:
	///     `0.2.0`.
	case children

	/// A single content particle.
	///
	///     [48] cp ::= (Name | choice | seq) ('?' | '*' | '+')?
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-cp>.
	///
	///  +  Version:
	///     `0.2.0`.
	case cp

	/// A choice list of content particles.
	///
	///     [49] choice ::= '(' S? cp ( S? '|' S? cp )+ S? ')'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-choice>.
	///
	///  +  Version:
	///     `0.2.0`.
	case choice

	/// A sequence list of content particles.
	///
	///     [50] seq ::= '(' S? cp ( S? ',' S? cp )* S? ')'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-seq>.
	///
	///  +  Version:
	///     `0.2.0`.
	case seq

	/// Mixed content.
	///
	///     [51] Mixed ::= '(' S? '#PCDATA' (S? '|' S? Name)* S? ')*' | '(' S? '#PCDATA' S? ')'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Mixed>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Mixed

	/// An attribute‐list declaration.
	///
	///     [52] AttlistDecl ::= '<!ATTLIST' S Name AttDef* S? '>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-AttlistDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case AttlistDecl

	/// An attribute definition.
	///
	///     [53] AttDef ::= S Name S AttType S DefaultDecl
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-AttDef>.
	///
	///  +  Version:
	///     `0.2.0`.
	case AttDef

	/// An attribute type.
	///
	///     [54] AttType ::= StringType | TokenizedType | EnumeratedType
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-AttType>.
	///
	///  +  Version:
	///     `0.2.0`.
	case AttType

	/// A string attribute type.
	///
	///     [55] StringType ::= 'CDATA'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-StringType>.
	///
	///  +  Version:
	///     `0.2.0`.
	case StringType

	/// A tokenized attribute type.
	///
	///     [56] TokenizedType ::= 'ID' | 'IDREF' | 'IDREFS' | 'ENTITY' | 'ENTITIES' | 'NMTOKEN' | 'NMTOKENS'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-TokenizedType>.
	///
	///  +  Version:
	///     `0.2.0`.
	case TokenizedType

	/// An enumerated attribute type.
	///
	///     [57] EnumeratedType ::= NotationType | Enumeration
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-EnumeratedType>.
	///
	///  +  Version:
	///     `0.2.0`.
	case EnumeratedType

	/// A `NOTATION` attribute type.
	///
	///     [58] NotationType ::= 'NOTATION' S '(' S? Name (S? '|' S? Name)* S? ')'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-NotationType>.
	///
	///  +  Version:
	///     `0.2.0`.
	case NotationType

	/// An enumeration attibute type.
	///
	///     [59] Enumeration ::= '(' S? Nmtoken (S? '|' S? Nmtoken)* S? ')'
	///
	///  For interoperability, the same `.Nmtoken` **should not** occur more than once in the `.Enumeration`s of a single element type.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Enumeration>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Enumeration

	/// An attribute default.
	///
	///     [60] DefaultDecl ::= '#REQUIRED' | '#IMPLIED' | (('#FIXED' S)? AttValue)
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-DefaultDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case DefaultDecl

	/// Portions of the `.extSubset` which are included in, or excluded from, the logical structure of the DTD based on the keyword which governs them.
	///
	///     [61] conditionalSect ::= includeSect | ignoreSect
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-conditionalSect>.
	///
	///  +  Version:
	///     `0.2.0`.
	case conditionalSect

	/// An `INCLUDE` conditional section.
	///
	///     [62] includeSect ::= '<![' S? 'INCLUDE' S? '[' extSubsetDecl ']]>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-includeSect>.
	///
	///  +  Version:
	///     `0.2.0`.
	case includeSect

	/// An `IGNORE` conditional section.
	///
	///     [63] ignoreSect ::= '<![' S? 'IGNORE' S? '[' ignoreSectContents* ']]>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-ignoreSect>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ignoreSect

	/// The contents of an `IGNORE` conditional section.
	///
	///     [64] ignoreSectContents ::= Ignore ('<![' ignoreSectContents ']]>' Ignore)*
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-ignoreSectContents>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ignoreSectContents

	/// The contents of an `IGNORE` conditional section, excluding conditional section starts `<![` and ends `]]>`.
	///
	///     [65] Ignore ::= Char* - (Char* ('<![' | ']]>') Char*)
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Ignore>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Ignore

	/// A reference to a specific character in the ISO/IEC 10646 character set.
	///
	///     [66] CharRef ::= '&#' [0-9]+ ';' | '&#x' [0-9a-fA-F]+ ';'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-CharRef>.
	///
	///  +  Version:
	///     `0.2.0`.
	case CharRef

	/// A general entity reference.
	///
	///     [67] Reference ::= EntityRef | CharRef
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-Reference>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Reference

	/// A reference to the content of a named entity.
	///
	///     [68] EntityRef ::= '&' Name ';'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-EntityRef>.
	///
	///  +  Version:
	///     `0.2.0`.
	case EntityRef

	/// A reference to the content of a parameter entity.
	///
	///     [69] PEReference ::= '%' Name ';'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-PEReference>.
	///
	///  +  Version:
	///     `0.2.0`.
	case PEReference

	/// An entity declaration.
	///
	///     [70] EntityDecl ::= GEDecl | PEDecl
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-EntityDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case EntityDecl

	/// A general entity declaration.
	///
	///     [71] GEDecl ::= '<!ENTITY' S Name S EntityDef S? '>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-GEDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case GEDecl

	/// A parameter entity declaration.
	///
	///     [72] PEDecl ::= '<!ENTITY' S '%' S Name S PEDef S? '>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-PEDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case PEDecl

	/// A general entity definition.
	///
	///     [73] EntityDef ::= EntityValue | (ExternalID NDataDecl?)
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-EntityDef>.
	///
	///  +  Version:
	///     `0.2.0`.
	case EntityDef

	/// A parameter entity definition.
	///
	///     [74] PEDef ::= EntityValue | ExternalID
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-PEDef>.
	///
	///  +  Version:
	///     `0.2.0`.
	case PEDef

	/// An external entity identifier.
	///
	///     [75] ExternalID ::= 'SYSTEM' S SystemLiteral | 'PUBLIC' S PubidLiteral S SystemLiteral
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-ExternalID>.
	///
	///  +  Version:
	///     `0.2.0`.
	case ExternalID

	/// A notation declaration.
	///
	///     [76] NDataDecl ::= S 'NDATA' S Name
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-NDataDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case NDataDecl

	/// A text declaration.
	///
	///     [77] TextDecl ::= '<?xml' VersionInfo? EncodingDecl S? '?>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-TextDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case TextDecl

	/// A well‐formed external parsed entity.
	///
	/// ###  XML 1.1  ###
	///
	///     [78] extParsedEnt ::= ( TextDecl? content ) - ( Char* RestrictedChar Char* )
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-extParsedEnt>.
	///
	/// ###  XML 1.0  ###
	///
	///     [26] VersionNum ::= TextDecl? content
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-extParsedEnt>.
	///
	///  +  Version:
	///     `0.2.0`.
	case extParsedEnt

	/// An encoding declaration.
	///
	///     [80] EncodingDecl ::= S 'encoding' Eq ('"' EncName '"' | "'" EncName "'" )
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-EncodingDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case EncodingDecl

	/// An encoding declaration.
	///
	///     [81] EncName ::= [A-Za-z] ([A-Za-z0-9._] | '-')*
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-EncName>.
	///
	///  +  Version:
	///     `0.2.0`.
	case EncName

	/// A notation declaration.
	///
	///     [82] NotationDecl ::= '<!NOTATION' S Name S (ExternalID | PublicID) S? '>'
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-NotationDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case NotationDecl

	/// A public identifier.
	///
	///     [83] PublicID ::= 'PUBLIC' S PubidLiteral
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#NT-PublicID>.
	///
	///  +  Version:
	///     `0.2.0`.
	case PublicID

	/// XML 1.0 Fourth Edition letter.
	///
	///     [84] Letter ::= BaseChar | Ideographic
	///
	/// ###  XML 1.0  ###
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-Letter>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Letter

	/// XML 1.0 Fourth Edition base character.
	///
	/// ###  XML 1.0  ###
	///
	///     [85] BaseChar := [#x0041-#x005A] | [#x0061-#x007A] | [#x00C0-#x00D6] | [#x00D8-#x00F6] | [#x00F8-#x00FF] | [#x0100-#x0131] | [#x0134-#x013E] | [#x0141-#x0148] | [#x014A-#x017E] | [#x0180-#x01C3] | [#x01CD-#x01F0] | [#x01F4-#x01F5] | [#x01FA-#x0217] | [#x0250-#x02A8] | [#x02BB-#x02C1] | #x0386 | [#x0388-#x038A] | #x038C | [#x038E-#x03A1] | [#x03A3-#x03CE] | [#x03D0-#x03D6] | #x03DA | #x03DC | #x03DE | #x03E0 | [#x03E2-#x03F3] | [#x0401-#x040C] | [#x040E-#x044F] | [#x0451-#x045C] | [#x045E-#x0481] | [#x0490-#x04C4] | [#x04C7-#x04C8] | [#x04CB-#x04CC] | [#x04D0-#x04EB] | [#x04EE-#x04F5] | [#x04F8-#x04F9] | [#x0531-#x0556] | #x0559 | [#x0561-#x0586] | [#x05D0-#x05EA] | [#x05F0-#x05F2] | [#x0621-#x063A] | [#x0641-#x064A] | [#x0671-#x06B7] | [#x06BA-#x06BE] | [#x06C0-#x06CE] | [#x06D0-#x06D3] | #x06D5 | [#x06E5-#x06E6] | [#x0905-#x0939] | #x093D | [#x0958-#x0961] | [#x0985-#x098C] | [#x098F-#x0990] | [#x0993-#x09A8] | [#x09AA-#x09B0] | #x09B2 | [#x09B6-#x09B9] | [#x09DC-#x09DD] | [#x09DF-#x09E1] | [#x09F0-#x09F1] | [#x0A05-#x0A0A] | [#x0A0F-#x0A10] | [#x0A13-#x0A28] | [#x0A2A-#x0A30] | [#x0A32-#x0A33] | [#x0A35-#x0A36] | [#x0A38-#x0A39] | [#x0A59-#x0A5C] | #x0A5E | [#x0A72-#x0A74] | [#x0A85-#x0A8B] | #x0A8D | [#x0A8F-#x0A91] | [#x0A93-#x0AA8] | [#x0AAA-#x0AB0] | [#x0AB2-#x0AB3] | [#x0AB5-#x0AB9] | #x0ABD | #x0AE0 | [#x0B05-#x0B0C] | [#x0B0F-#x0B10] | [#x0B13-#x0B28] | [#x0B2A-#x0B30] | [#x0B32-#x0B33] | [#x0B36-#x0B39] | #x0B3D | [#x0B5C-#x0B5D] | [#x0B5F-#x0B61] | [#x0B85-#x0B8A] | [#x0B8E-#x0B90] | [#x0B92-#x0B95] | [#x0B99-#x0B9A] | #x0B9C | [#x0B9E-#x0B9F] | [#x0BA3-#x0BA4] | [#x0BA8-#x0BAA] | [#x0BAE-#x0BB5] | [#x0BB7-#x0BB9] | [#x0C05-#x0C0C] | [#x0C0E-#x0C10] | [#x0C12-#x0C28] | [#x0C2A-#x0C33] | [#x0C35-#x0C39] | [#x0C60-#x0C61] | [#x0C85-#x0C8C] | [#x0C8E-#x0C90] | [#x0C92-#x0CA8] | [#x0CAA-#x0CB3] | [#x0CB5-#x0CB9] | #x0CDE | [#x0CE0-#x0CE1] | [#x0D05-#x0D0C] | [#x0D0E-#x0D10] | [#x0D12-#x0D28] | [#x0D2A-#x0D39] | [#x0D60-#x0D61] | [#x0E01-#x0E2E] | #x0E30 | [#x0E32-#x0E33] | [#x0E40-#x0E45] | [#x0E81-#x0E82] | #x0E84 | [#x0E87-#x0E88] | #x0E8A | #x0E8D | [#x0E94-#x0E97] | [#x0E99-#x0E9F] | [#x0EA1-#x0EA3] | #x0EA5 | #x0EA7 | [#x0EAA-#x0EAB] | [#x0EAD-#x0EAE] | #x0EB0 | [#x0EB2-#x0EB3] | #x0EBD | [#x0EC0-#x0EC4] | [#x0F40-#x0F47] | [#x0F49-#x0F69] | [#x10A0-#x10C5] | [#x10D0-#x10F6] | #x1100 | [#x1102-#x1103] | [#x1105-#x1107] | #x1109 | [#x110B-#x110C] | [#x110E-#x1112] | #x113C | #x113E | #x1140 | #x114C | #x114E | #x1150 | [#x1154-#x1155] | #x1159 | [#x115F-#x1161] | #x1163 | #x1165 | #x1167 | #x1169 | [#x116D-#x116E] | [#x1172-#x1173] | #x1175 | #x119E | #x11A8 | #x11AB | [#x11AE-#x11AF] | [#x11B7-#x11B8] | #x11BA | [#x11BC-#x11C2] | #x11EB | #x11F0 | #x11F9 | [#x1E00-#x1E9B] | [#x1EA0-#x1EF9] | [#x1F00-#x1F15] | [#x1F18-#x1F1D] | [#x1F20-#x1F45] | [#x1F48-#x1F4D] | [#x1F50-#x1F57] | #x1F59 | #x1F5B | #x1F5D | [#x1F5F-#x1F7D] | [#x1F80-#x1FB4] | [#x1FB6-#x1FBC] | #x1FBE | [#x1FC2-#x1FC4] | [#x1FC6-#x1FCC] | [#x1FD0-#x1FD3] | [#x1FD6-#x1FDB] | [#x1FE0-#x1FEC] | [#x1FF2-#x1FF4] | [#x1FF6-#x1FFC] | #x2126 | [#x212A-#x212B] | #x212E | [#x2180-#x2182] | [#x3041-#x3094] | [#x30A1-#x30FA] | [#x3105-#x312C] | [#xAC00-#xD7A3]
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-BaseChar>.
	///
	///  +  Version:
	///     `0.2.0`.
	case BaseChar

	/// XML 1.0 Fourth Edition ideographic character.
	///
	/// ###  XML 1.0  ###
	///
	///     [86] Ideographic ::= [#x4E00-#x9FA5] | #x3007 | [#x3021-#x3029]
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-Ideographic>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Ideographic

	/// XML 1.0 Fourth Edition combining character.
	///
	/// ###  XML 1.0  ###
	///
	///     [87] CombiningChar ::= [#x0300-#x0345] | [#x0360-#x0361] | [#x0483-#x0486] | [#x0591-#x05A1] | [#x05A3-#x05B9] | [#x05BB-#x05BD] | #x05BF | [#x05C1-#x05C2] | #x05C4 | [#x064B-#x0652] | #x0670 | [#x06D6-#x06DC] | [#x06DD-#x06DF] | [#x06E0-#x06E4] | [#x06E7-#x06E8] | [#x06EA-#x06ED] | [#x0901-#x0903] | #x093C | [#x093E-#x094C] | #x094D | [#x0951-#x0954] | [#x0962-#x0963] | [#x0981-#x0983] | #x09BC | #x09BE | #x09BF | [#x09C0-#x09C4] | [#x09C7-#x09C8] | [#x09CB-#x09CD] | #x09D7 | [#x09E2-#x09E3] | #x0A02 | #x0A3C | #x0A3E | #x0A3F | [#x0A40-#x0A42] | [#x0A47-#x0A48] | [#x0A4B-#x0A4D] | [#x0A70-#x0A71] | [#x0A81-#x0A83] | #x0ABC | [#x0ABE-#x0AC5] | [#x0AC7-#x0AC9] | [#x0ACB-#x0ACD] | [#x0B01-#x0B03] | #x0B3C | [#x0B3E-#x0B43] | [#x0B47-#x0B48] | [#x0B4B-#x0B4D] | [#x0B56-#x0B57] | [#x0B82-#x0B83] | [#x0BBE-#x0BC2] | [#x0BC6-#x0BC8] | [#x0BCA-#x0BCD] | #x0BD7 | [#x0C01-#x0C03] | [#x0C3E-#x0C44] | [#x0C46-#x0C48] | [#x0C4A-#x0C4D] | [#x0C55-#x0C56] | [#x0C82-#x0C83] | [#x0CBE-#x0CC4] | [#x0CC6-#x0CC8] | [#x0CCA-#x0CCD] | [#x0CD5-#x0CD6] | [#x0D02-#x0D03] | [#x0D3E-#x0D43] | [#x0D46-#x0D48] | [#x0D4A-#x0D4D] | #x0D57 | #x0E31 | [#x0E34-#x0E3A] | [#x0E47-#x0E4E] | #x0EB1 | [#x0EB4-#x0EB9] | [#x0EBB-#x0EBC] | [#x0EC8-#x0ECD] | [#x0F18-#x0F19] | #x0F35 | #x0F37 | #x0F39 | #x0F3E | #x0F3F | [#x0F71-#x0F84] | [#x0F86-#x0F8B] | [#x0F90-#x0F95] | #x0F97 | [#x0F99-#x0FAD] | [#x0FB1-#x0FB7] | #x0FB9 | [#x20D0-#x20DC] | #x20E1 | [#x302A-#x302F] | #x3099 | #x309A
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-CombiningChar>.
	///
	///  +  Version:
	///     `0.2.0`.
	case CombiningChar

	/// XML 1.0 Fourth Edition digit.
	///
	/// ###  XML 1.0  ###
	///
	///     [88] Digit ::= [#x0030-#x0039] | [#x0660-#x0669] | [#x06F0-#x06F9] | [#x0966-#x096F] | [#x09E6-#x09EF] | [#x0A66-#x0A6F] | [#x0AE6-#x0AEF] | [#x0B66-#x0B6F] | [#x0BE7-#x0BEF] | [#x0C66-#x0C6F] | [#x0CE6-#x0CEF] | [#x0D66-#x0D6F] | [#x0E50-#x0E59] | [#x0ED0-#x0ED9] | [#x0F20-#x0F29]
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-Digit>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Digit

	/// XML 1.0 Fourth Edition extender.
	///
	/// ###  XML 1.0  ###
	///
	///     [89] Extender ::= #x00B7 | #x02D0 | #x02D1 | #x0387 | #x0640 | #x0E46 | #x0EC6 | #x3005 | [#x3031-#x3035] | [#x309D-#x309E] | [#x30FC-#x30FE]
	///
	/// <https://www.w3.org/TR/2008/REC-xml-20081126/#NT-Extender>.
	///
	///  +  Version:
	///     `0.2.0`.
	case Extender

}

extension X·M·L·Symbol:
	Symbolic
{

	/// The type of this `Symbolic`.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Symbol = X·M·L·Symbol

	/// XML versioning.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Version = X·M·L·Version

	/// The `Text` name of this `X·M·L·Symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public var name: Text
	{ rawValue.unicodeScalars }

	/// The reference identifier of this `X·M·L·Symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public var reference: Text? {
		switch self {
		case .document:
			return "1".unicodeScalars
		case .Char:
			return "2".unicodeScalars
		case .RestrictedChar:
			return "2a".unicodeScalars
		case .S:
			return "3".unicodeScalars
		case .NameStartChar:
			return "4".unicodeScalars
		case .NameChar:
			return "4a".unicodeScalars
		case .Name:
			return "5".unicodeScalars
		case .Names:
			return "6".unicodeScalars
		case .Nmtoken:
			return "7".unicodeScalars
		case .Nmtokens:
			return "8".unicodeScalars
		case .EntityValue:
			return "9".unicodeScalars
		case .AttValue:
			return "10".unicodeScalars
		case .SystemLiteral:
			return "11".unicodeScalars
		case .PubidLiteral:
			return "12".unicodeScalars
		case .PubidChar:
			return "13".unicodeScalars
		case .CharData:
			return "14".unicodeScalars
		case .Comment:
			return "15".unicodeScalars
		case .PI:
			return "16".unicodeScalars
		case .PITarget:
			return "17".unicodeScalars
		case .CDSect:
			return "18".unicodeScalars
		case .CDStart:
			return "19".unicodeScalars
		case .CData:
			return "20".unicodeScalars
		case .CDEnd:
			return "21".unicodeScalars
		case .prolog:
			return "22".unicodeScalars
		case .XMLDecl:
			return "23".unicodeScalars
		case .VersionInfo:
			return "24".unicodeScalars
		case .Eq:
			return "25".unicodeScalars
		case .VersionNum:
			return "26".unicodeScalars
		case .Misc:
			return "27".unicodeScalars
		case .doctypedecl:
			return "28".unicodeScalars
		case .DeclSep:
			return "28a".unicodeScalars
		case .intSubset:
			return "28b".unicodeScalars
		case .markupdecl:
			return "29".unicodeScalars
		case .extSubset:
			return "30".unicodeScalars
		case .extSubsetDecl:
			return "31".unicodeScalars
		case .SDDecl:
			return "32".unicodeScalars
		case .element:
			return "39".unicodeScalars
		case .STag:
			return "40".unicodeScalars
		case .Attribute:
			return "41".unicodeScalars
		case .ETag:
			return "42".unicodeScalars
		case .content:
			return "43".unicodeScalars
		case .EmptyElemTag:
			return "44".unicodeScalars
		case .elementdecl:
			return "45".unicodeScalars
		case .contentspec:
			return "46".unicodeScalars
		case .children:
			return "47".unicodeScalars
		case .cp:
			return "48".unicodeScalars
		case .choice:
			return "49".unicodeScalars
		case .seq:
			return "50".unicodeScalars
		case .Mixed:
			return "51".unicodeScalars
		case .AttlistDecl:
			return "52".unicodeScalars
		case .AttDef:
			return "53".unicodeScalars
		case .AttType:
			return "54".unicodeScalars
		case .StringType:
			return "55".unicodeScalars
		case .TokenizedType:
			return "56".unicodeScalars
		case .EnumeratedType:
			return "57".unicodeScalars
		case .NotationType:
			return "58".unicodeScalars
		case .Enumeration:
			return "59".unicodeScalars
		case .DefaultDecl:
			return "60".unicodeScalars
		case .conditionalSect:
			return "61".unicodeScalars
		case .includeSect:
			return "62".unicodeScalars
		case .ignoreSect:
			return "63".unicodeScalars
		case .ignoreSectContents:
			return "64".unicodeScalars
		case .Ignore:
			return "65".unicodeScalars
		case .CharRef:
			return "66".unicodeScalars
		case .Reference:
			return "67".unicodeScalars
		case .EntityRef:
			return "68".unicodeScalars
		case .PEReference:
			return "69".unicodeScalars
		case .EntityDecl:
			return "70".unicodeScalars
		case .GEDecl:
			return "71".unicodeScalars
		case .PEDecl:
			return "72".unicodeScalars
		case .EntityDef:
			return "73".unicodeScalars
		case .PEDef:
			return "74".unicodeScalars
		case .ExternalID:
			return "75".unicodeScalars
		case .NDataDecl:
			return "76".unicodeScalars
		case .TextDecl:
			return "77".unicodeScalars
		case .extParsedEnt:
			return "78".unicodeScalars
		case .EncodingDecl:
			return "80".unicodeScalars
		case .EncName:
			return "81".unicodeScalars
		case .NotationDecl:
			return "82".unicodeScalars
		case .PublicID:
			return "83".unicodeScalars
		case .Letter:
			return "84".unicodeScalars
		case .BaseChar:
			return "85".unicodeScalars
		case .Ideographic:
			return "86".unicodeScalars
		case .CombiningChar:
			return "87".unicodeScalars
		case .Digit:
			return "88".unicodeScalars
		case .Extender:
			return "89".unicodeScalars
		}
	}

	/// The `Expression` associated with this `X·M·L·Symbol` for a given `version`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public subscript (
		version: X·M·L·Version
	) -> X·M·L·Symbol.Expression? {
		switch self {

		//  Document
		case .document:
			switch version {
			case .xml10:
				return [.prolog′, .element′, .Misc*]
			case .xml11:
				return [.prolog′, .element′, .Misc*] ÷ .RestrictedChar′
			}

		//  Character Range
		case .Char:
			switch version {
			case .xml10:
				return ‖["\u{9}", "\u{A}", "\u{D}", √["\u{20}"..."\u{D7FF}"], √["\u{E000}"..."\u{FFFD}"], √["\u{10000}"..."\u{10FFFF}"]]
			case .xml11:
				return ‖[√["\u{1}"..."\u{D7FF}"], √["\u{E000}"..."\u{FFFD}"], √["\u{10000}"..."\u{10FFFF}"]]
			}
		case .RestrictedChar:
			switch version {
			case .xml10:
				return nil
			case .xml11:
				return ‖[√["\u{1}"..."\u{8}"], √["\u{B}"..."\u{C}"], √["\u{E}"..."\u{1F}"], √["\u{7F}"..."\u{84}"], √["\u{86}"..."\u{9F}"]]
			}

		//  White Space
		case .S:
			return (‖["\u{20}", "\u{9}", "\u{D}", "\u{A}"])″

		//  Names and Tokens
		case .NameStartChar:
			return ‖[":", √["A"..."Z"], "_", √["a"..."z"], √["\u{C0}"..."\u{D6}"], √["\u{D8}"..."\u{F6}"], √["\u{F8}"..."\u{2FF}"], √["\u{370}"..."\u{37D}"], √["\u{37F}"..."\u{1FFF}"], √["\u{200C}"..."\u{200D}"], √["\u{2070}"..."\u{218F}"], √["\u{2C00}"..."\u{2FEF}"], √["\u{3001}"..."\u{D7FF}"], √["\u{F900}"..."\u{FDCF}"], √["\u{FDF0}"..."\u{FFFD}"], √["\u{10000}"..."\u{EFFFF}"]]
		case .NameChar:
			return ‖[.NameStartChar′, "-", ".", √["0"..."9"], "\u{B7}", √["\u{300}"..."\u{36F}"], √["\u{203F}"..."\u{2040}"]]
		case .Name:
			return .NameStartChar′ & (.NameChar′)*
		case .Names:
			return .Name′ & ("\u{20}" & .Name′)*
		case .Nmtoken:
			return .NameChar″
		case .Nmtokens:
			return .Nmtoken′ & ("\u{20}" & .Nmtoken′)*
			
		//  Literals
		case .EntityValue:
			return ["\"", (‖[^"%&\"", .PEReference′, .Reference′])*, "\""] | ["'", (‖[^"%&'", .PEReference′, .Reference′])*, "'"]
		case .AttValue:
			return ["\"", (‖[^"<&\"", .Reference′])*, "\""] | ["'", (‖[^"<&'", .Reference′])*, "'"]
		case .SystemLiteral:
			return ["\"", (^["\""])*, "\""] | ["'", (^["'"])*, "'"]
		case .PubidLiteral:
			return ["\"", .PubidChar*, "\""] | ["'", (.PubidChar′ − "'")*, "'"]
		case .PubidChar:
			return ‖["\u{20}", "\u{D}", "\u{A}", √["a"..."z", "A"..."Z", "0"..."9"], √"-'()+,./:=?;!*#@$_%"]

		//  Character Data
		case .CharData:
			return (^["<", "&"])* ÷ "]]>"

		//  Comments
		case .Comment:
			return ["<!--", ((.Char′ − "-") | "-" & (.Char′ − "-"))*, "-->"]

		//  Processing Instructions
		case .PI:
			return ["<?", .PITarget′, (.S′ & (.Char* ÷ "?>"))°, "?>"]
		case .PITarget:
			return .Name′ − ["X" | "x", "M" | "m", "L" | "l"]

		//  CDATA Sections
		case .CDSect:
			return [.CDStart′, .CData′, .CDEnd′]
		case .CDStart:
			return "<![CDATA["
		case .CData:
			return .Char* ÷ "]]>"
		case .CDEnd:
			return "]]>"

		//  Prolog
		case .prolog:
			switch version {
			case .xml10:
				return [.XMLDecl°, .Misc*, (.doctypedecl′ & .Misc*)°]
			case .xml11:
				return [.XMLDecl′, .Misc*, (.doctypedecl′ & .Misc*)°]
			}
		case .XMLDecl:
			return ["<?xml", .VersionInfo′, .EncodingDecl°, .SDDecl°, .S°, "?>"]
		case .VersionInfo:
			return [.S′, "version", .Eq′, ["'", .VersionNum′, "'"] | ["\"", .VersionNum′, "\""]]
		case .Eq:
			return [.S°, "=", .S°]
		case .VersionNum:
			switch version {
			case .xml10:
				return "1." & (√["0"..."9"])″
			case .xml11:
				return "1.1"
			}
		case .Misc:
			return ‖[.Comment′, .PI′, .S′]

		//  Document Type Definition
		case .doctypedecl:
			return ["<!DOCTYPE", .S′, .Name′, (.S′ & .ExternalID′)°, .S°, ["[", .intSubset′, "]", .S°]°, ">"]
		case .DeclSep:
			return .PEReference′ | .S′
		case .intSubset:
			return (.markupdecl′ | .DeclSep′)*
		case .markupdecl:
			return ‖[.elementdecl′, .AttlistDecl′, .EntityDecl′, .NotationDecl′, .PI′, .Comment′]

		//  External Subset
		case .extSubset:
			return .TextDecl° & .extSubsetDecl′
		case .extSubsetDecl:
			return (‖[.markupdecl′, .conditionalSect′, .DeclSep′])*

		//  Standalone Document Declaration
		case .SDDecl:
			return [.S′, "standalone", .Eq′, ["'", "yes" | "no", "'"] | ["\"", "yes" | "no", "\""]]

		//  Element
		case .element:
			return .EmptyElemTag′ | [.STag′, .content′, .ETag′]

		//  Start‐tag
		case .STag:
			return ["<", .Name′, (.S′ & .Attribute′)*, .S°, ">"]
		case .Attribute:
			return [.Name′, .Eq′, .AttValue′]

		//  End‐tag
		case .ETag:
			return ["</", .Name′, .S°, ">"]

		//  Content of Elements
		case .content:
			return .CharData° & [‖[.element′, .Reference′, .CDSect′, .PI′, .Comment′], .CharData°]*

		//  Tags for Empty Elements
		case .EmptyElemTag:
			return ["<", .Name′, (.S′ & .Attribute′)*, .S°, "/>"]

		//  Element Type Declaration
		case .elementdecl:
			return ["<!ELEMENT", .S′, .Name′, .S′, .contentspec′, .S°, ">"]
		case .contentspec:
			return ‖["EMPTY", "ANY", .Mixed′, .children′]

		//  Element‐content Models
		case .children:
			return (.choice′ | .seq′) & (‖["?", "*", "+"])°
		case .cp:
			return ‖[.Name′, .choice′, .seq′] & (‖["?", "*", "+"])°
		case .choice:
			return ["(", .S°, .cp′, [.S°, "|", .S°, .cp′]″, .S°, ")"]
		case .seq:
			return ["(", .S°, .cp′, [.S°, ",", .S°, .cp′]*, .S°, ")"]

		//  Mixed‐content Declaration
		case .Mixed:
			return ‖[["(", .S°, "#PCDATA", [.S°, "|", .S°, .Name′]*, .S°, ")*"], ["(", .S°, "#PCDATA", .S°, ")"]]  //  `|` is much slower to typecheck here

		//  Attribute‐list Declaration
		case .AttlistDecl:
			return ["<!ATTLIST", .S′, .Name′, .AttDef*, .S°, ">"]
		case .AttDef:
			return [.S′, .Name′, .S′, .AttType′, .S′, .DefaultDecl′]

		//  Attribute Types
		case .AttType:
			return ‖[.StringType′, .TokenizedType′, .EnumeratedType′]
		case .StringType:
			return "CDATA"
		case .TokenizedType:
			return ‖["ID", "IDREF", "IDREFS", "ENTITY", "ENTITIES", "NMTOKEN", "NMTOKENS"]

		//  Enumerated Attribute Types
		case .EnumeratedType:
			return .NotationType′ | .Enumeration′
		case .NotationType:
			return ["NOTATION", .S′, "(", .S°, .Name′, [.S°, "|", .S°, .Name′]*, .S°, ")"]
		case .Enumeration:
			return ["(", .S°, .Nmtoken′, [.S°, "|", .S°, .Nmtoken′]*, .S°, ")"]

		//  Attribute Defaults
		case .DefaultDecl:
			return ‖["#REQUIRED", "#IMPLIED", ("#FIXED" & .S′)° & .AttValue′]

		//  Conditional Section
		case .conditionalSect:
			return .includeSect′ | .ignoreSect′
		case .includeSect:
			return ["<![", .S°, "INCLUDE", .S°, "[", .extSubsetDecl′, "]]>"]
		case .ignoreSect:
			return ["<![", .S°, "IGNORE", .S°, "[", .ignoreSectContents*, "]]>"]
		case .ignoreSectContents:
			return [.Ignore′, ["<![", .ignoreSectContents′, "]]>", .Ignore′]*]
		case .Ignore:
			return .Char* ÷ "<![" | "]]>"

		//  Character Reference
		case .CharRef:
			return ["&#", (√["0"..."9"])″, ";"] | ["&#x", (√["0"..."9", "a"..."f", "A"..."F"])″, ";"]

		//  Entity Reference
		case .Reference:
			return .EntityRef′ | .CharRef′
		case .EntityRef:
			return ["&", .Name′, ";"]
		case .PEReference:
			return ["%", .Name′, ";"]

		//  Entity Declaration
		case .EntityDecl:
			return .GEDecl′ | .PEDecl′
		case .GEDecl:
			return ["<!ENTITY", .S′, .Name′, .S′, .EntityDef′, .S°, ">"]
		case .PEDecl:
			return ["<!ENTITY", .S′, "%", .S′, .Name′, .S′, .PEDef′, .S°, ">"]
		case .EntityDef:
			return .EntityValue′ | [.ExternalID′, .NDataDecl°]
		case .PEDef:
			return .EntityValue′ | .ExternalID′

		//  External Entity Declaration
		case .ExternalID:
			return ["SYSTEM", .S′, .SystemLiteral′] | ["PUBLIC", .S′, .PubidLiteral′, .S′, .SystemLiteral′]
		case .NDataDecl:
			return [.S′, "NDATA", .S′, .Name′]

		//  Text Declaration
		case .TextDecl:
			return ["<?xml", .VersionInfo°, .EncodingDecl′, .S°, "?>"]

		//  Well‐Formed External Parsed Entity
		case .extParsedEnt:
			switch version {
			case .xml10:
				return .TextDecl° & .content′
			case .xml11:
				return (.TextDecl° & .content′) ÷ .RestrictedChar′
			}

		//  Encoding Declaration
		case .EncodingDecl:
			return [.S′, "encoding", .Eq′, ["\"", .EncName′, "\""] | ["'", .EncName′, "'"]]
		case .EncName:
			return [√["A"..."Z", "a"..."z"], (√["A"..."Z", "a"..."z", "0"..."9", ".", "_"] | "-")*]

		//  Notation Declarations
		case .NotationDecl:
			return ["<!NOTATION", .S′, .Name′, .S′, .ExternalID′ | .PublicID′, .S°, ">"]
		case .PublicID:
			return ["PUBLIC", .S′, .PubidLiteral′]

		//  Characters
		case .Letter:
			switch version {
			case .xml10:
				return .BaseChar′ | .Ideographic′
			case .xml11:
				return nil
			}
		case .BaseChar:
			switch version {
			case .xml10:
				return ‖[√["\u{41}"..."\u{5A}"], √["\u{61}"..."\u{7A}"], √["\u{C0}"..."\u{D6}"], √["\u{D8}"..."\u{F6}"], √["\u{F8}"..."\u{FF}"], √["\u{100}"..."\u{131}"], √["\u{134}"..."\u{13E}"], √["\u{141}"..."\u{148}"], √["\u{14A}"..."\u{17E}"], √["\u{180}"..."\u{1C3}"], √["\u{1CD}"..."\u{1F0}"], √["\u{1F4}"..."\u{1F5}"], √["\u{1FA}"..."\u{217}"], √["\u{250}"..."\u{2A8}"], √["\u{2BB}"..."\u{2C1}"], "\u{386}", √["\u{388}"..."\u{38A}"], "\u{38C}", √["\u{38E}"..."\u{3A1}"], √["\u{3A3}"..."\u{3CE}"], √["\u{3D0}"..."\u{3D6}"], "\u{3DA}", "\u{3DC}", "\u{3DE}", "\u{3E0}", √["\u{3E2}"..."\u{3F3}"], √["\u{401}"..."\u{40C}"], √["\u{40E}"..."\u{44F}"], √["\u{451}"..."\u{45C}"], √["\u{45E}"..."\u{481}"], √["\u{490}"..."\u{4C4}"], √["\u{4C7}"..."\u{4C8}"], √["\u{4CB}"..."\u{4CC}"], √["\u{4D0}"..."\u{4EB}"], √["\u{4EE}"..."\u{4F5}"], √["\u{4F8}"..."\u{4F9}"], √["\u{531}"..."\u{556}"], "\u{559}", √["\u{561}"..."\u{586}"], √["\u{5D0}"..."\u{5EA}"], √["\u{5F0}"..."\u{5F2}"], √["\u{621}"..."\u{63A}"], √["\u{641}"..."\u{64A}"], √["\u{671}"..."\u{6B7}"], √["\u{6BA}"..."\u{6BE}"], √["\u{6C0}"..."\u{6CE}"], √["\u{6D0}"..."\u{6D3}"], "\u{6D5}", √["\u{6E5}"..."\u{6E6}"], √["\u{905}"..."\u{939}"], "\u{93D}", √["\u{958}"..."\u{961}"], √["\u{985}"..."\u{98C}"], √["\u{98F}"..."\u{990}"], √["\u{993}"..."\u{9A8}"], √["\u{9AA}"..."\u{9B0}"], "\u{9B2}", √["\u{9B6}"..."\u{9B9}"], √["\u{9DC}"..."\u{9DD}"], √["\u{9DF}"..."\u{9E1}"], √["\u{9F0}"..."\u{9F1}"], √["\u{A05}"..."\u{A0A}"], √["\u{A0F}"..."\u{A10}"], √["\u{A13}"..."\u{A28}"], √["\u{A2A}"..."\u{A30}"], √["\u{A32}"..."\u{A33}"], √["\u{A35}"..."\u{A36}"], √["\u{A38}"..."\u{A39}"], √["\u{A59}"..."\u{A5C}"], "\u{A5E}", √["\u{A72}"..."\u{A74}"], √["\u{A85}"..."\u{A8B}"], "\u{A8D}", √["\u{A8F}"..."\u{A91}"], √["\u{A93}"..."\u{AA8}"], √["\u{AAA}"..."\u{AB0}"], √["\u{AB2}"..."\u{AB3}"], √["\u{AB5}"..."\u{AB9}"], "\u{ABD}", "\u{AE0}", √["\u{B05}"..."\u{B0C}"], √["\u{B0F}"..."\u{B10}"], √["\u{B13}"..."\u{B28}"], √["\u{B2A}"..."\u{B30}"], √["\u{B32}"..."\u{B33}"], √["\u{B36}"..."\u{B39}"], "\u{B3D}", √["\u{B5C}"..."\u{B5D}"], √["\u{B5F}"..."\u{B61}"], √["\u{B85}"..."\u{B8A}"], √["\u{B8E}"..."\u{B90}"], √["\u{B92}"..."\u{B95}"], √["\u{B99}"..."\u{B9A}"], "\u{B9C}", √["\u{B9E}"..."\u{B9F}"], √["\u{BA3}"..."\u{BA4}"], √["\u{BA8}"..."\u{BAA}"], √["\u{BAE}"..."\u{BB5}"], √["\u{BB7}"..."\u{BB9}"], √["\u{C05}"..."\u{C0C}"], √["\u{C0E}"..."\u{C10}"], √["\u{C12}"..."\u{C28}"], √["\u{C2A}"..."\u{C33}"], √["\u{C35}"..."\u{C39}"], √["\u{C60}"..."\u{C61}"], √["\u{C85}"..."\u{C8C}"], √["\u{C8E}"..."\u{C90}"], √["\u{C92}"..."\u{CA8}"], √["\u{CAA}"..."\u{CB3}"], √["\u{CB5}"..."\u{CB9}"], "\u{CDE}", √["\u{CE0}"..."\u{CE1}"], √["\u{D05}"..."\u{D0C}"], √["\u{D0E}"..."\u{D10}"], √["\u{D12}"..."\u{D28}"], √["\u{D2A}"..."\u{D39}"], √["\u{D60}"..."\u{D61}"], √["\u{E01}"..."\u{E2E}"], "\u{E30}", √["\u{E32}"..."\u{E33}"], √["\u{E40}"..."\u{E45}"], √["\u{E81}"..."\u{E82}"], "\u{E84}", √["\u{E87}"..."\u{E88}"], "\u{E8A}", "\u{E8D}", √["\u{E94}"..."\u{E97}"], √["\u{E99}"..."\u{E9F}"], √["\u{EA1}"..."\u{EA3}"], "\u{EA5}", "\u{EA7}", √["\u{EAA}"..."\u{EAB}"], √["\u{EAD}"..."\u{EAE}"], "\u{EB0}", √["\u{EB2}"..."\u{EB3}"], "\u{EBD}", √["\u{EC0}"..."\u{EC4}"], √["\u{F40}"..."\u{F47}"], √["\u{F49}"..."\u{F69}"], √["\u{10A0}"..."\u{10C5}"], √["\u{10D0}"..."\u{10F6}"], "\u{1100}", √["\u{1102}"..."\u{1103}"], √["\u{1105}"..."\u{1107}"], "\u{1109}", √["\u{110B}"..."\u{110C}"], √["\u{110E}"..."\u{1112}"], "\u{113C}", "\u{113E}", "\u{1140}", "\u{114C}", "\u{114E}", "\u{1150}", √["\u{1154}"..."\u{1155}"], "\u{1159}", √["\u{115F}"..."\u{1161}"], "\u{1163}", "\u{1165}", "\u{1167}", "\u{1169}", √["\u{116D}"..."\u{116E}"], √["\u{1172}"..."\u{1173}"], "\u{1175}", "\u{119E}", "\u{11A8}", "\u{11AB}", √["\u{11AE}"..."\u{11AF}"], √["\u{11B7}"..."\u{11B8}"], "\u{11BA}", √["\u{11BC}"..."\u{11C2}"], "\u{11EB}", "\u{11F0}", "\u{11F9}", √["\u{1E00}"..."\u{1E9B}"], √["\u{1EA0}"..."\u{1EF9}"], √["\u{1F00}"..."\u{1F15}"], √["\u{1F18}"..."\u{1F1D}"], √["\u{1F20}"..."\u{1F45}"], √["\u{1F48}"..."\u{1F4D}"], √["\u{1F50}"..."\u{1F57}"], "\u{1F59}", "\u{1F5B}", "\u{1F5D}", √["\u{1F5F}"..."\u{1F7D}"], √["\u{1F80}"..."\u{1FB4}"], √["\u{1FB6}"..."\u{1FBC}"], "\u{1FBE}", √["\u{1FC2}"..."\u{1FC4}"], √["\u{1FC6}"..."\u{1FCC}"], √["\u{1FD0}"..."\u{1FD3}"], √["\u{1FD6}"..."\u{1FDB}"], √["\u{1FE0}"..."\u{1FEC}"], √["\u{1FF2}"..."\u{1FF4}"], √["\u{1FF6}"..."\u{1FFC}"], "\u{2126}", √["\u{212A}"..."\u{212B}"], "\u{212E}", √["\u{2180}"..."\u{2182}"], √["\u{3041}"..."\u{3094}"], √["\u{30A1}"..."\u{30FA}"], √["\u{3105}"..."\u{312C}"], √["\u{AC00}"..."\u{D7A3}"]]
			case .xml11:
				return nil
			}
		case .Ideographic:
			switch version {
			case .xml10:
				return ‖[√["\u{4E00}"..."\u{9FA5}"], "\u{3007}", √["\u{3021}"..."\u{3029}"]]
			case .xml11:
				return nil
			}
		case .CombiningChar:
			switch version {
			case .xml10:
				return ‖[√["\u{300}"..."\u{345}"], √["\u{360}"..."\u{361}"], √["\u{483}"..."\u{486}"], √["\u{591}"..."\u{5A1}"], √["\u{5A3}"..."\u{5B9}"], √["\u{5BB}"..."\u{5BD}"], "\u{5BF}", √["\u{5C1}"..."\u{5C2}"], "\u{5C4}", √["\u{64B}"..."\u{652}"], "\u{670}", √["\u{6D6}"..."\u{6DC}"], √["\u{6DD}"..."\u{6DF}"], √["\u{6E0}"..."\u{6E4}"], √["\u{6E7}"..."\u{6E8}"], √["\u{6EA}"..."\u{6ED}"], √["\u{901}"..."\u{903}"], "\u{93C}", √["\u{93E}"..."\u{94C}"], "\u{94D}", √["\u{951}"..."\u{954}"], √["\u{962}"..."\u{963}"], √["\u{981}"..."\u{983}"], "\u{9BC}", "\u{9BE}", "\u{9BF}", √["\u{9C0}"..."\u{9C4}"], √["\u{9C7}"..."\u{9C8}"], √["\u{9CB}"..."\u{9CD}"], "\u{9D7}", √["\u{9E2}"..."\u{9E3}"], "\u{A02}", "\u{A3C}", "\u{A3E}", "\u{A3F}", √["\u{A40}"..."\u{A42}"], √["\u{A47}"..."\u{A48}"], √["\u{A4B}"..."\u{A4D}"], √["\u{A70}"..."\u{A71}"], √["\u{A81}"..."\u{A83}"], "\u{ABC}", √["\u{ABE}"..."\u{AC5}"], √["\u{AC7}"..."\u{AC9}"], √["\u{ACB}"..."\u{ACD}"], √["\u{B01}"..."\u{B03}"], "\u{B3C}", √["\u{B3E}"..."\u{B43}"], √["\u{B47}"..."\u{B48}"], √["\u{B4B}"..."\u{B4D}"], √["\u{B56}"..."\u{B57}"], √["\u{B82}"..."\u{B83}"], √["\u{BBE}"..."\u{BC2}"], √["\u{BC6}"..."\u{BC8}"], √["\u{BCA}"..."\u{BCD}"], "\u{BD7}", √["\u{C01}"..."\u{C03}"], √["\u{C3E}"..."\u{C44}"], √["\u{C46}"..."\u{C48}"], √["\u{C4A}"..."\u{C4D}"], √["\u{C55}"..."\u{C56}"], √["\u{C82}"..."\u{C83}"], √["\u{CBE}"..."\u{CC4}"], √["\u{CC6}"..."\u{CC8}"], √["\u{CCA}"..."\u{CCD}"], √["\u{CD5}"..."\u{CD6}"], √["\u{D02}"..."\u{D03}"], √["\u{D3E}"..."\u{D43}"], √["\u{D46}"..."\u{D48}"], √["\u{D4A}"..."\u{D4D}"], "\u{D57}", "\u{E31}", √["\u{E34}"..."\u{E3A}"], √["\u{E47}"..."\u{E4E}"], "\u{EB1}", √["\u{EB4}"..."\u{EB9}"], √["\u{EBB}"..."\u{EBC}"], √["\u{EC8}"..."\u{ECD}"], √["\u{F18}"..."\u{F19}"], "\u{F35}", "\u{F37}", "\u{F39}", "\u{F3E}", "\u{F3F}", √["\u{F71}"..."\u{F84}"], √["\u{F86}"..."\u{F8B}"], √["\u{F90}"..."\u{F95}"], "\u{F97}", √["\u{F99}"..."\u{FAD}"], √["\u{FB1}"..."\u{FB7}"], "\u{FB9}", √["\u{20D0}"..."\u{20DC}"], "\u{20E1}", √["\u{302A}"..."\u{302F}"], "\u{3099}", "\u{309A}"]
			case .xml11:
				return nil
			}
		case .Digit:
			switch version {
			case .xml10:
				return ‖[√["\u{30}"..."\u{39}"], √["\u{660}"..."\u{669}"], √["\u{6F0}"..."\u{6F9}"], √["\u{966}"..."\u{96F}"], √["\u{9E6}"..."\u{9EF}"], √["\u{A66}"..."\u{A6F}"], √["\u{AE6}"..."\u{AEF}"], √["\u{B66}"..."\u{B6F}"], √["\u{BE7}"..."\u{BEF}"], √["\u{C66}"..."\u{C6F}"], √["\u{CE6}"..."\u{CEF}"], √["\u{D66}"..."\u{D6F}"], √["\u{E50}"..."\u{E59}"], √["\u{ED0}"..."\u{ED9}"], √["\u{F20}"..."\u{F29}"]]
			case .xml11:
				return nil
			}
		case .Extender:
			switch version {
			case .xml10:
				return ‖["\u{B7}", "\u{2D0}", "\u{2D1}", "\u{387}", "\u{640}", "\u{E46}", "\u{EC6}", "\u{3005}", √["\u{3031}"..."\u{3035}"], √["\u{309D}"..."\u{309E}"], √["\u{30FC}"..."\u{30FE}"]]
			case .xml11:
				return nil
			}
		}
	}

}
