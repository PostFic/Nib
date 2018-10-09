// swift-tools-version:4.2
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(name: "Nib", targets: ["XSDValues"]),
	],

	dependencies: [

	],

	targets: [
		.target(name: "XSD", dependencies: []),
		.target(name: "XSDValues", dependencies: ["XSD"])//,
		//.target(name: "XSDFunctions", dependencies: ["XSDValues"]),
		//.target(name: "XSDStructures", dependencies: ["XSDFunctions"]),
		//.target(name: "XSDDatatypes", dependencies: ["XSDStructures"]),
		//.testTarget(name: "XSDFunctionTests", dependencies: ["XSDFunctions"]),
		//.testTarget(name: "XSDStructureTests", dependencies: ["XSDStructures"])//,
		//.testTarget(name: "XSDDatatypeTests", dependencies: ["XSDDatatypes"])
	],

	swiftLanguageVersions: [.v4_2]

)
