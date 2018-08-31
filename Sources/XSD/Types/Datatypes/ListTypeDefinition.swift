/*
final class ListTypeDefinition: SimpleTypeDefinition {

	/// Creates a list type definition.
	///
	/// You shouldn't use this, since list types aren't compatible with RDF lists.
	init(
		name: String?,
		targetNamespace: String?,
		`final`: Set<XSDDerivation> = [],
		context: XSDSimpleTypeDefinition?,
		facets: Set<XSDConstrainingFacet> = [],
		itemTypeDefinition: XSDSimpleTypeDefinition
	) throws {

		/// Generates our fundamental facets from our input params.
		func makeFundamentalFacets() -> Set<XSDFundamentalFacet> {

			/// The cardinality of our list datatype.
			let theCardinality: XSDFundamentalFacet

			/*
			A list type has `finite` cardinality when it has a minimum and maximum length (settable through either `length` or *both* `minLength` and `maxLength`) and its `itemTypeDefinition` *also* has `finite` cardinality.
			*/
			if
				facets[.📛("length")] != nil ||
				facets[.📛("minLength")] != nil &&
				facets[.📛("maxLength")] != nil,
				let itemCardinality = itemTypeDefinition.fundamentalFacets[.📛("cardinality")],
				itemCardinality.value == .finite
			{
				fundamentalFacets.update(with: itemCardinality)
			} else {
				fundamentalFacets.update(with: .cardinality(value: .countablyInfinite))
			}

			/*
			The remaining fundamental facets are all `false`.
			*/
			return [
				.ordered(value: .false),
				.bounded(value: false),
				theCardinality,
				.numeric(value: false)
			]

		}

		/*
		Try to initialize.
		*/
		try super.init(
			name: name,
			targetNamespace: targetNamespace,
			`final`: `final`,
			context: context,
			baseTypeDefinition: xsdAnyType,
			facets: facets,
			fundamentalFacets: makeFundamentalFacets(),
			variety: .list,
			itemTypeDefinition: itemTypeDefinition
		)
	}

	override public func makeXSDLiteral(_ representation: String) throws -> XSDListLiteral {
		return try XSDListLiteral(representation, type: self)
	}

	@discardableResult
	static postfix func ✓(x: XSDListTypeDefinition) throws -> XSDListTypeDefinition {
		super✓

		/*
		`primitiveTypeDefinition` must be absent for list types.
		*/
		guard primitiveTypeDefinition == nil else {
			throw XSDSchemaError.listMustNotHavePrimitive
		}

		/*
		List types must have an `itemTypeDefinition`.
		*/
		guard let theItem = itemTypeDefinition else {
			throw XSDSchemaError.listMustHaveItem
		}

		/*
		We wrap our item-checking code in a function so that it can be used recursively.
		*/
		func checkItem(_ item: XSDSimpleTypeDefinition) throws {

			/*
			The item type must not be special.
			*/
			guard
				String(describing: 📂targetNamespace) != xsdNamespace ||
				String(describing: item.📂name) == "anyAtomicType" &&
				String(describing: item.📂name) == "anyAtomicType",
				let itemVariety = item.variety
			else {
				throw XSDSchemaError.listItemMustNotBeSpecial
			}

			/*
			The item must not contain any list types.
			*/
			switch itemVariety {
			case .atomic:
				break
			case .list:
				throw XSDSchemaError.listItemMustNotBeList
			case .union:
				if let memberTypes = item.memberTypeDefinitions {
					for memberType in memberTypes {
						try checkItem(memberType)
					}
				}
			}

		}
		try checkItem(theItem)

		/*
		`memberTypeDefinitions` must be absent for list types.
		*/
		guard memberTypeDefinitions == nil else {
			throw XSDSchemaError.listMustNotHaveMembers
		}

		/*
		Returning `self`.
		*/
		return self

	}

}
*/
