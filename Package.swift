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
		.target(name: "Common", dependencies: []),
		.target(name: "XSD", dependencies: ["Common"]),
		.testTarget(name: "CommonTests", dependencies: ["Common"]),
		//.testTarget(name: "XSDTests", dependencies: ["XSD"]),
	],

	swiftLanguageVersions: [.v4_2]

)
