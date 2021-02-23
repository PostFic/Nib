// swift-tools-version:4.2
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(
			name: "Nib",
			targets: ["Core", "EBNF"]
		)
	],

	dependencies: [

	],

	targets: [
		.target(
			name: "Core",
			dependencies: []
		),
		.target(
			name: "EBNF",
			dependencies: ["Core"]
		)
	],

	swiftLanguageVersions: [.v4_2]

)
