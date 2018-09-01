public protocol XSDAnnotated {

	var annotations: [XSDAnnotation] { get }

}

public extension XSDAnnotated {

	var annotations: [XSDAnnotation] {
		return []
	}

}
