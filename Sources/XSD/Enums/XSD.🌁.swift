import Common

/// An enumeration representing our "foggy" types.
///
/// Only those datatypes for which "foggy" versions are required are listed.
extension XSD {

	enum 🌁: String, XSDDatatype, CrossConvertibleToLiteral, CrossConvertibleToValue {

		/// "Foggy" `xsd:NCName`.
		case NCName

		/// "Foggy" `xsd:anyURI`.
		case anyURI

		/// "Foggy" `xsd:boolean`.
		case boolean

		/*
		/// "Foggy" `xsd:nonNegativeInteger`.
		case nonNegativeInteger

		/// "Foggy" `xsd:positiveInteger`.
		case positiveInteger
		*/

		/// Provides the `SimpleTypeDefinition.🌁` corresponding to the given case.
		var definition: XSDSimpleTypeDefinition {
			switch self {
			case .NCName:
				return 🌁NCName
			case .anyURI:
				return 🌁anyURI
			case .boolean:
				return 🌁boolean
			/*
			case .nonNegativeInteger:
				return 🌁nonNegativeInteger
			case .positiveInteger:
				return 🌁positiveInteger
			*/
			}
		}

		/// The name of the datatype.
		var name: String {
			return self.rawValue
		}

		/// The target namespace of the datatype.
		var targetNamespace: String {
			return xsdTargetNamespace
		}

	}

}
