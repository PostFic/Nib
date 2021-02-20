import Core

/// A start‐tag, end‐tag, empty‐element tag, entity reference, character reference, comment, CDATA section delimiter, document type declaration, processing instruction, XML declaration, text declaration, or white space at the top level of the document.
///
/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-markup>.
///
///  +  Version:
///     `0.2.0`.
public enum Markup {

	/// A tag which marks the beginning of every nonempty XML element.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-stag>.
	///
	///  +  Version:
	///     `0.2.0`.
	case start·tag (
		type: Text,
		attributeSpecifications: [(
			attributeName: Text,
			attributeValue: Text
		)]
	)

	/// A tag which marks the end of every XML element which begins with a start‐tag.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-etag>.
	///
	///  +  Version:
	///     `0.2.0`.
	case end·tag (
		type: Text
	)

	/// A special form which can be used to represent empty elements.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-eetag>.
	///
	///  +  Version:
	///     `0.2.0`.
	case empty·elementTag (
		type: Text,
		attributeSpecifications: [(
			attributeName: Text,
			attributeValue: Text
		)]
	)

	/// A reference to the content of a named entity.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-entref>.
	///
	///  +  Version:
	///     `0.2.0`.
	case entityReference (
		Text
	)

	/// A reference to a specific character in the ISO/IEC 10646 character set.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-charref>.
	///
	///  +  Version:
	///     `0.2.0`.
	case characterReference (
		Text
	)

	/// A comment, appearing anywhere inside a document outside other markup.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-comment>.
	///
	///  +  Version:
	///     `0.2.0`.
	case comment (Text)

	/// The start delimiter of a CDATA section.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-cdsection>.
	///
	///  +  Version:
	///     `0.2.0`.
	case c·d·a·t·a·Start

	/// The end delimiter of a CDATA section.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-cdsection>.
	///
	///  +  Version:
	///     `0.2.0`.
	case c·d·a·t·a·End

	/// A declaration which contains or points to markup declarations to provide a grammar for the XML document.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-doctype>.
	///
	///  +  Version:
	///     `0.2.0`.
	case documentTypeDeclaration (
		type: Text,
		externalSubset: (
			publicIdentifier: Text?,
			systemIdentifier: Text
		)?,
		internalSubset: Text?
	)

	/// An instruction for applications.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-pi>.
	///
	///  +  Version:
	///     `0.2.0`.
	case processingInstruction (
		target: Text,
		Text?
	)

	/// A declaration which specifies the version of XML being used, and optionally an encoding name and a standalone document declaration.
	///
	/// The XML declaration is required in XML 1.1 documents and optional in XML 1.0 documents.
	///
	/// As documents are processed as Unicode `Text`, the presence or absence of an `encodingName` does not affect processing; however this information is preserved if given.
	///
	/// If present, the `standaloneDocumentDeclaration` should be either `"yes"` or `"no"`.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-xmldecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case x·m·l·Declaration (
		version: Text,
		encodingName: Text?,
		standaloneDocumentDeclaration: Text?
	)

	/// A declaration which should begin external parsed entities.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#sec-TextDecl>.
	///
	///  +  Version:
	///     `0.2.0`.
	case textDeclaration (
		version: Text?,
		encodingName: Text
	)

	/// One or more space characters, carriage returns, line feeds, or tabs, outside the document element and not inside any other markup.
	///
	///  +  Note:
	///     In XML 1.1 documents, all literal carriage·returns are either removed or replaced by linefeeds before any other processing is done.
	///
	///  +  Version:
	///     `0.2.0`.
	case top·levelWhiteSpace (
		Text
	)

}

extension Markup:
	Equatable
{

	/// Returns whether two `Markup`s are equivalent.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Markup`.
	///      +  r·h·s:
	///         A `Markup`.
	///
	///  +  Returns:
	///     `true` if `l·h·s` and `r·h·s` are equivalent pieces of markup; `false` otherwise.
	public static func == (
		_ l·h·s: Markup,
		_ r·h·s: Markup
	) -> Bool {
		switch l·h·s {
			case .start·tag (
				type: let l·h·s·type,
				attributeSpecifications: let l·h·s·attributes
			):
				guard case .start·tag (
					type: let r·h·s·type,
					attributeSpecifications: let r·h·s·attributes
				) = r·h·s
				else { return false }
				return l·h·s·type.elementsEqual(r·h·s·type) && l·h·s·attributes.elementsEqual(r·h·s·attributes) { $0.attributeName.elementsEqual($1.attributeName) && $0.attributeValue.elementsEqual($1.attributeValue) }
			case .end·tag (
				type: let l·h·s·type
			):
				guard case .end·tag (
					type: let r·h·s·type
				) = r·h·s
				else { return false }
				return l·h·s·type.elementsEqual(r·h·s·type)
			case .empty·elementTag (
				type: let l·h·s·type,
				attributeSpecifications: let l·h·s·attributes
			):
				guard case .empty·elementTag (
					type: let r·h·s·type,
					attributeSpecifications: let r·h·s·attributes
				) = r·h·s
				else { return false }
				return l·h·s·type.elementsEqual(r·h·s·type) && l·h·s·attributes.elementsEqual(r·h·s·attributes) { $0.attributeName.elementsEqual($1.attributeName) && $0.attributeValue.elementsEqual($1.attributeValue) }
			case .entityReference (
				let l·h·s·text
			):
				guard case .entityReference (
					let r·h·s·text
				) = r·h·s
				else { return false }
				return l·h·s·text.elementsEqual(r·h·s·text)
			case .characterReference (
				let l·h·s·text
			):
				guard case .characterReference (
					let r·h·s·text
				) = r·h·s
				else { return false }
				return l·h·s·text.elementsEqual(r·h·s·text)
			case .comment (
				let l·h·s·text
			):
				guard case .comment (
					let r·h·s·text
				) = r·h·s
				else { return false }
				return l·h·s·text.elementsEqual(r·h·s·text)
			case
				.c·d·a·t·a·Start,
				.c·d·a·t·a·End
			: return l·h·s == r·h·s
			case .documentTypeDeclaration (
				type: let l·h·s·type,
				externalSubset: let l·h·s·externalSubset,
				internalSubset: let l·h·s·internalSubset
			):
				guard case .documentTypeDeclaration (
					type: let r·h·s·type,
					externalSubset: let r·h·s·externalSubset,
					internalSubset: let r·h·s·internalSubset
				) = r·h·s
				else { return false }
				guard let (
					publicIdentifier: l·h·s·publicIdentifier,
					systemIdentifier: l·h·s·systemIdentifier
				) = l·h·s·externalSubset
				else { return l·h·s·type.elementsEqual(r·h·s·type) && r·h·s·externalSubset == nil && (l·h·s·internalSubset.map { r·h·s·internalSubset?.elementsEqual($0) ?? false } ?? (r·h·s·internalSubset == nil)) }
				guard let (
					publicIdentifier: r·h·s·publicIdentifier,
					systemIdentifier: r·h·s·systemIdentifier
				) = r·h·s·externalSubset
				else { return false }
				return l·h·s·type.elementsEqual(r·h·s·type) && (l·h·s·publicIdentifier.map { r·h·s·publicIdentifier?.elementsEqual($0) ?? false } ?? (r·h·s·publicIdentifier == nil)) && l·h·s·systemIdentifier.elementsEqual(r·h·s·systemIdentifier) && (l·h·s·internalSubset.map { r·h·s·internalSubset?.elementsEqual($0) ?? false } ?? (r·h·s·internalSubset == nil))
			case .processingInstruction (
				target: let l·h·s·target,
				let l·h·s·text
			):
				guard case .processingInstruction (
					target: let r·h·s·target,
					let r·h·s·text
				) = r·h·s
				else { return false }
				return l·h·s·target.elementsEqual(r·h·s·target) && (l·h·s·text.map { r·h·s·text?.elementsEqual($0) ?? false } ?? (r·h·s·text == nil))
			case .x·m·l·Declaration (
				version: let l·h·s·version,
				encodingName: let l·h·s·encodingName,
				standaloneDocumentDeclaration: let l·h·s·standaloneDocumentDeclaration
			):
				guard case .x·m·l·Declaration (
					version: let r·h·s·version,
					encodingName: let r·h·s·encodingName,
					standaloneDocumentDeclaration: let r·h·s·standaloneDocumentDeclaration
				) = r·h·s
				else { return false }
				return l·h·s·version.elementsEqual(r·h·s·version) && (l·h·s·encodingName.map { r·h·s·encodingName?.elementsEqual($0) ?? false } ?? (r·h·s·encodingName == nil)) && (l·h·s·standaloneDocumentDeclaration.map { r·h·s·standaloneDocumentDeclaration?.elementsEqual($0) ?? false } ?? (r·h·s·standaloneDocumentDeclaration == nil))
			case .textDeclaration (
				version: let l·h·s·version,
				encodingName: let l·h·s·encodingName
			):
				guard case .textDeclaration (
					version: let r·h·s·version,
					encodingName: let r·h·s·encodingName
				) = r·h·s
				else { return false }
				return (l·h·s·version.map { r·h·s·version?.elementsEqual($0) ?? false } ?? (r·h·s·version == nil)) && l·h·s·encodingName.elementsEqual(r·h·s·encodingName)
			case .top·levelWhiteSpace (
				let l·h·s·text
			):
				guard case .top·levelWhiteSpace (
					let r·h·s·text
				) = r·h·s
				else { return false }
				return l·h·s·text.elementsEqual(r·h·s·text)
		}
	}

}
