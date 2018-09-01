public extension XSD.FundamentalFacet {

	final class Ordered: XSDFundamentalFacet, XSDAnnotated {

		public enum Keyword: String {

			case `false`

			case partial

			case total

		}

		public let value: Keyword

		public init(value: Keyword) {
			self.value = value
			super.init(📛: "ordered")
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			primitiveTypeDefinition: XSDSimpleTypeDefinition
		) throws {
			guard
				let value = (
					baseTypeDefinition.fundamentalFacets[.ordered] as? Ordered
				)?.value
			else {
				throw XSD.ConstraintOnSchemasError.baseTypeMustHaveFacet("ordered")
			}
			self.init(value: value)
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			itemTypeDefinition: XSDSimpleTypeDefinition
		) throws {
			self.init(value: .false)
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			memberTypeDefinitions: [XSDSimpleTypeDefinition]
		) throws {
			var mightInheritOrderingFromPrimitive = true
			var mightNotBeOrdered = true
			var firstMemberPrimitive: XSDSimpleTypeDefinition? = nil

			/// Processes members, setting our vars based on their properties.
			func handle(_ members: [XSDSimpleTypeDefinition]) throws {
				for member in members {

					/*
					If our `member` is a `union`, then we handle *its* members instead.
					*/
					if
						let memberVariety = member.variety,
						memberVariety == .union
					{
						try handle(member.memberTypeDefinitions ?? [])
						continue
					}

					/*
					If our `firstMemberPrimitive` isn't set, we set it.
					It is possible that this won't *actually* be the primitive of the first member (if the first member *didn't have* a primitive), but in that case, `mightInheritOrderingFromPrimitive` will be false.
					*/
					if firstMemberPrimitive == nil {
						firstMemberPrimitive = member.primitiveTypeDefinition
					}

					/*
					If our `member` isn't `atomic` or doesn't have the same primitive type as the first, it can't be totally ordered.
					*/
					if
						mightInheritOrderingFromPrimitive,
						member.variety != .atomic ||
						member.primitiveTypeDefinition !== firstMemberPrimitive
					{
						mightInheritOrderingFromPrimitive = false
					}

					/*
					If the ordering of our `member` isn't `false`, then the union type must have *some* ordering.
					*/
					guard let ordered = (
						member.fundamentalFacets[.ordered] as? Ordered
					)?.value else {
						throw XSD.ConstraintOnSchemasError.memberTypeMustHaveFacet("ordered")
					}
					if mightNotBeOrdered && ordered != .false {
						mightNotBeOrdered = false
					}

				}
			}

			/*
			Beginning our member type handling:
			*/
			try handle(memberTypeDefinitions)

			/*
			Determining our ordering takes a little bit of processing.
			*/
			let value: Keyword
			if mightInheritOrderingFromPrimitive {
				if let thePrimitive = firstMemberPrimitive {
					guard let ordered = (
						thePrimitive.fundamentalFacets[.ordered] as? Ordered
					)?.value else {
						throw XSD.ConstraintOnSchemasError.memberTypeMustHaveFacet("ordered")
					}
					value = ordered
				} else {
					value = .partial
				}
			} else if mightNotBeOrdered {
				value = .false
			} else {
				value = .partial
			}
			self.init(value: value)
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? Ordered)?.value else {
				return false
			}
			return value == otherValue
		}

	}

}
