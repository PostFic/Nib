// swift-tools-version:4.2
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(name: "Nib", targets: ["Common"/*, "Datatypes"*/]),
	],

	dependencies: [

	],

	targets: [
		.target(name: "Common", dependencies: []),
		/*
		.target(name: "Values", dependencies: ["Common"]),
		.target(name: "Datatypes", dependencies: ["Values"])
		*/
		.testTarget(name: "CommonTests", dependencies: ["Common"]),
		/*
		.testTarget(name: "ValueTests", dependencies: ["Values"]),
		.testTarget(name: "DatatypeTests", dependencies: ["Datatypes"]),
		*/
	],

	swiftLanguageVersions: [.v4_2]

)
