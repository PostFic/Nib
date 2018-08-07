import XCTest
@testable import Common

final class XSDFacetTests: XCTestCase {

	/// Tests to ensure that the behaviour of `XSDFacet`s in sets is as desired.
	func testXSDFacetSetInclusion() {
		let facet = XSDFacet(📛: "aFacet")
		let facetSet: Set<XSDFacet> = [facet]
		let selectedFacet = facetSet["aFacet"]
		XCTAssertNotNil(selectedFacet)
		XCTAssert(facet === selectedFacet)
	}

}
