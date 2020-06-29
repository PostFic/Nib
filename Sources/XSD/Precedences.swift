/// Cross‐conversion precedence.
precedencegroup CrossConversionPrecedence {
	higherThan: BitwiseShiftPrecedence
	associativity: right
	assignment: true
}
