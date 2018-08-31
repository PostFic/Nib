import Common

public extension XSD.FundamentalFacet {

	final class Numeric: XSDFundamentalFacet, XSDAnnotated {

		public let value: XSDValue

		public init(value: Bool) {
			self.value = [🌌Boolean(value)]
			super.init(📛: "numeric")
		}

		public convenience init(
			baseTypeDefinition: XSDSimpleTypeDefinition,
			facets: XSDConstrainingFacets,
			primitiveTypeDefinition: XSDSimpleTypeDefinition
		) throws {
			guard
				let value = (
					baseTypeDefinition.fundamentalFacets[.numeric] as? Numeric
				)?.value
			else {
				throw XSD.ConstraintOnSchemasError.baseTypeMustHaveFacet("numeric")
			}
			self.init(value: value.bool!)
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
					If our `member` isn't `bounded`, then our union must not be.
					*/
					guard let numeric = (
						member.fundamentalFacets[.numeric] as? Numeric
					)?.value else {
						throw XSD.ConstraintOnSchemasError.memberTypeMustHaveFacet("numeric")
					}
					if !numeric.bool! {
						return false
					}

				}
				return true
			}

			self.init(value: try handle(memberTypeDefinitions))
		}

		public override func equivalent(to other: XSDFacet) -> Bool {
			guard let otherValue = (other as? Numeric)?.value else {
				return false
			}
			return value ≍ otherValue
		}

	}

}
