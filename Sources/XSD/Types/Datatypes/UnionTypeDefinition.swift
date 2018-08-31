/*
final class UnionTypeDefinition: SimpleTypeDefinition {

	/// Creates a union type definition.
	init(
		name: String?,
		targetNamespace: String?,
		`final`: Set<XSDDerivation> = [],
		context: XSDSimpleTypeDefinition?,
		facets: Set<XSDConstrainingFacet> = [],
		memberTypeDefinitions: [XSDSimpleTypeDefinition] = []
	) throws {

		/// Generates our fundamental facets from our input params.
		func makeFundamentalFacets() -> Set<XSDFundamentalFacet> {

			/// Indicates whether the type might inherit its ordering from its member types' primitives.
			var mightInheritOrderingFromPrimitive = true

			/// Indicates whether the type might not be `ordered`.
			var mightNotBeOrdered = true

			/// Indicates whether the type might be `bounded`.
			var mightBeBounded = true

			/// Indicates whether the type might have `finite` `cardinality`.
			var mightBeFinite = true

			/// Indicates whether the type might be `numeric`.
			var mightBeNumeric = true

			/// The primitive type definition of the first member type.
			var firstMemberPrimitive: XSDSimpleTypeDefinition? = nil

			/*
			The facets of a union type depend on its member type definitions:
			*/
			func handle(members: [XSDSimpleTypeDefinition]) {
				for member in members {

					/*
					If our `member` is a `union`, then we handle *its* members instead.
					*/
					if
						let memberVariety = member.variety,
						memberVariety = .union
					{
						handle(members: member.memberTypeDefinitions)
						continue
					}

					/*
					If our `firstMemberPrimitive` isn't set, we set it.
					It is possible that this won't *actually* be the primitive of the first member (if the first member *didn't have* a primitive), but in that case, `mightInheritOrderingFromPrimitive` will be false.
					*/
					if firstMemberPrimitive == nil {
						firstMemberPrimitive = memberTypeDefinition.primitiveTypeDefinition
					}

					/*
					If our `member` isn't `atomic` or doesn't have the same primitive type as the first, it can't be totally ordered.
					*/
					if
						mightInheritOrderingFromPrimitive,
						member.variety != .atomic ||
						member.primitiveTypeDefinition != firstMemberPrimitive
					{
						mightInheritOrderingFromPrimitive = false
					}

					/*
					If the ordering of our `member` isn't `false`, then the union type must have *some* ordering.
					*/
					if
						mightNotBeOrdered,
						member.fundamentalFacets[.📛("ordered")] != .false
					{
						mightNotBeOrdered = false
					}

					/*
					If our `member` isn't `bounded`, then our union must not be.
					*/
					if
						mightBeBounded,
						let memberIsBounded = member.fundamentalFacets[.📛("bounded")],
						Bool(memberIsBounded)
					{
						mightBeBounded = false
					}

					/*
					If our `member` isn't `finite`, then our union must not be.
					*/
					if
						mightBeFinite,
						member.fundamentalFacets[.📛("ordered")] != .finite
					{
						mightBeFinite = false
					}

					/*
					If our `member` isn't `numeric`, then our union must not be.
					*/
					if
						mightBeNumeric,
						let memberIsNumeric = member.fundamentalFacets[.📛("numeric")],
						Bool(memberIsNumeric)
					{
						mightBeNumeric = false
					}

				}
			}

			/*
			Beginning our member type handling:
			*/
			handle(members: memberTypeDefinitions)

			/*
			Determining our ordering takes a little bit of processing.
			*/
			let theOrdering: XSDFundamentalFacet
			if mightInheritOrderingFromPrimitive {
				if let thePrimitive = firstMemberPrimitive {
					theOrdering = firstMemberPrimitive.fundamentalFacets[.📛("ordering")]
				} else {
					theOrdering = .ordering(value: .partial)
				}
			} else if mightNotBeOrdered {
				theOrdering = .ordering(value: .false)
			}

			/*
			We can now determine all of our fundamental facets.
			*/
			return [
				theOrdering,
				mightBeBounded ? .bounded(value: true) : .bounded(value: false),
				mightBeFinite ? .cardinality(value: .finite) : .cardinality(value: .countablyInfinite),
				mightBeNumeric ? .numeric(value: true) : .numeric(value: false),
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
			fundamentalFacets: fundamentalFacets,
			variety: .union,
			memberTypeDefinitions: memberTypeDefinitions
		)
	}

	override func makeXSDLiteral(_ representation: String) throws -> XSDUnionLiteral {
		return try XSDUnionLiteral(representation, type: self)
	}

	override func makeXSDValue(_ representation: String) throws -> XSDValue {
		var index = 0
		var result: XSDValue?
		while result == nil && index < memberTypeDefinitions.count {
			result = try? memberTypeDefinitions[index].makeXSDValue(representation)
			index += 1
		}
		guard let theResult = result else {
			throw XSDValidationError.noApplicableMemberType
		}
		return theResult
	}

	@discardableResult
	override class postfix func ✓(x: XSDUnionTypeDefinition) throws -> XSDUnionTypeDefinition {
		super✓

		/*
		`primitiveTypeDefinition` must be absent for union types.
		*/
		guard primitiveTypeDefinition == nil else {
			throw XSDSchemaError.unionMustNotHavePrimitive
		}

		/*
		`primitiveTypeDefinition` must be absent for union types.
		*/
		guard itemTypeDefinition == nil else {
			throw XSDSchemaError.unionMustNotHaveItem
		}

		/*
		Union types must have `memberTypeDefinitions`.
		*/
		guard let theMembers = memberTypeDefinitions else {
			throw XSDSchemaError.unionMustHaveMembers
		}

		/*
		We wrap our member-checking code in a function so that it can be used recursively.
		*/
		func checkMember(_ member: XSDSimpleTypeDefinition) throws {

			/*
			The member type must not be special.
			*/
			guard
				String(describing: 📂targetNamespace) != xsdNamespace ||
				String(describing: member.📂name) == "anyAtomicType" &&
				String(describing: member.📂name) == "anyAtomicType",
				let memberVariety = member.variety
			{
				throw XSDSchemaError.unionMembersMustNotBeSpecial
			}

			/*
			The `member` must not contain be `self`, or we'll recurse forever.
			*/
			switch memberVariety {
			case .union:
				guard member !== self else {
					throw XSDSchemaError.unionMembersMustNotBeSelf
				}
				if let memberTypes = item.memberTypeDefinitions {
					for memberType in memberTypes {
						try checkMember(memberType)
					}
				}
			default:
				break
			}

		}
		for theMember in theMembers {
			try checkMember(theMember)
		}

		/*
		Returning `self`.
		*/
		return self

	}

}
*/
