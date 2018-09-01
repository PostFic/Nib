// swift-tools-version:4.2
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(name: "Nib", targets: ["XSD"]),
	],

	dependencies: [

	],

	targets: [
		.target(name: "XSD", dependencies: []),
		.testTarget(name: "XSDTests", dependencies: ["XSD"]),
	],

	swiftLanguageVersions: [.v4_2]

)
