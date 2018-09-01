public extension XSD.FundamentalFacet {

	final class Bounded: XSDFundamentalFacet, XSDAnnotated {

		public let value: XSDValue

		public init(value: Bool) {
			self.value = [🌌Boolean(value)]
			super.init(📛: "bounded")
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			primitiveTypeDefinition: XSDSimpleTypeDefinition
		) throws {
			if
				facets[.minInclusive] is XSD.ConstrainingFacet.MinInclusive ||
				facets[.minExclusive] is XSD.ConstrainingFacet.MinExclusive,
				facets[.maxInclusive] is XSD.ConstrainingFacet.MaxInclusive ||
				facets[.maxExclusive] is XSD.ConstrainingFacet.MaxExclusive
			{
				self.init(value: true)
			} else {
				self.init(value: false)
			}
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			itemTypeDefinition: XSDSimpleTypeDefinition
		) throws {
			self.init(value: false)
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			memberTypeDefinitions: [XSDSimpleTypeDefinition]
		) throws {
			var firstMemberPrimitive: XSDSimpleTypeDefinition? = nil

			/// Processes members, returning a value.
			func handle(_ members: [XSDSimpleTypeDefinition]) throws -> Bool {
				for member in members {

					/*
					If our `member` is a `union`, then we handle *its* members instead.
					*/
					if
						let memberVariety = member.variety,
						memberVariety == .union
					{
						if try !handle(member.memberTypeDefinitions ?? []) {
							return false
						}
						continue
					}

					/*
					If our `firstMemberPrimitive` isn't set, we set it.
					It is possible that this won't *actually* be the primitive of the first member (if the first member *didn't have* a primitive).
					*/
					if firstMemberPrimitive == nil {
						firstMemberPrimitive = member.primitiveTypeDefinition
					}

					/*
					If our basic members aren't all of the same primitive type, then our union is not `bounded`.

					This check essentially doesn't bother checking the items of list members, since list types are never `bounded`.
					*/
					if
						member.variety != .atomic ||
						member.primitiveTypeDefinition !== firstMemberPrimitive
					{
						return false
					}

					/*
					If our `member` isn't `bounded`, then our union must not be.
					*/
					guard let bounded = (
						member.fundamentalFacets[.bounded] as? Bounded
					)?.value else {
						throw XSD.ConstraintOnSchemasError.memberTypeMustHaveFacet("bounded")
					}
					if !bounded.bool! {
						return false
					}

				}
				return true
			}

			self.init(value: try handle(memberTypeDefinitions))
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? Bounded)?.value else {
				return false
			}
			return value ≍ otherValue
		}

	}

}
