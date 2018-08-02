// swift-tools-version:4.2
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(name: "Nib", targets: [/*"Values", "Datatypes", "Literals"*/]),
	],

	dependencies: [

	],

	targets: [
		.target(name: "Common", dependencies: []),
		/*
		.target(name: "Values", dependencies: ["Common"]),
		.target(name: "Datatypes", dependencies: ["Common"]),
		.target(name: "Literals", dependencies: ["Common"]),
		.testTarget(name: "ValueTests", dependencies: ["Values"]),
		.testTarget(name: "DatatypeTests", dependencies: ["Datatypes"]),
		.testTarget(name: "LiteralTests", dependencies: ["Literals"]),
		*/
	],

	swiftLanguageVersions: [.v4_2]

)
