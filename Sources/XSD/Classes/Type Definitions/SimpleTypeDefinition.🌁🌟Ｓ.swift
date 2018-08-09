import Common

extension SimpleTypeDefinition {

	/// A "foggy" XSD Simple Type Definition.
	///
	/// This is used as the type of our "foggy" `SimpleTypeDefinition` instances.
	/// It approximates the behaviours of `SimpleTypeDefinition` for purposes of validation but is otherwise lacking in many respects.
	/// Instances of this class are used in places where builtin types are needed in order to avoid recursive type definition.
	final class 🌁🌟Ｓ<ValueSpace: 🌌Value>: TypeDefinition.🌁, XSDSimpleTypeDefinition {

		/// The datatype, as a case of `XSD`.
		private let datatype: XSD

		/// The datatype definition.
		var definition: XSDSimpleTypeDefinition {
			return datatype.definition
		}

		/// The base type, as a case of `XSD`.
		private let baseType: XSD

		/// The base type definition.
		var baseTypeDefinition: XSDTypeDefinition {
			return baseType.definition
		}

		/// The constraining facets for the type.
		let facets: XSDConstrainingFacets

		/// The fundamental facets for the type.
		var fundamentalFacets: XSDFundamentalFacets {
			return datatype.definition.fundamentalFacets
		}

		/// The type variety.
		///
		/// We only ever define atomic "foggy" types.
		let variety: XSDSimpleTypeVariety? = .atomic

		private let primitiveType: XSD

		/// The primitive type definition
		var primitiveTypeDefinition: XSDSimpleTypeDefinition? {
			return primitiveType.definition
		}

		/// The item type for a list.
		///
		/// Always `nil`, since all "foggy" types are atomic (and not lists).
		let itemTypeDefinition: XSDSimpleTypeDefinition? = nil

		/// The member types for a union.
		///
		/// Always `nil`, since all "foggy" types are atomic (and not unions).
		let memberTypeDefinitions: [XSDSimpleTypeDefinition]? = nil

		/// Creates a "foggy" type to take the place of the `XSD` case given as the `datatype`.
		init(
			approximating type: XSD,
			name: String,
			base: XSD,
			facets: XSDConstrainingFacets = [],
			primitive: XSD
		) throws {
			datatype = type
			baseType = base
			self.facets = facets
			primitiveType = primitive
			super.init(name)
			if datatype == .anySimpleType || datatype == .anyAtomicType {
				fatalError("\"Foggy\" types must not be special")
			}
			guard primitiveType.isPrimitive else {
				throw XSD.ConstraintOnSchemasError.primitiveMustBePrimitive
			}
		}

		func makeValue(_ representation: String) throws -> XSDValue {
			var normalizedRepresentation = representation
			for facet in facets.prelexical {
				try (facet as! XSDPrelexicalFacet).🆗(&normalizedRepresentation)
			}
			for facet in facets.lexical {
				try (facet as! XSDLexicalFacet).🆗(normalizedRepresentation)
			}
			let value = try [ValueSpace(normalizedRepresentation)]
			for facet in facets.valuebased {
				try (facet as! XSDValuebasedFacet).🆗(value)
			}
			return value
		}

	}

}
