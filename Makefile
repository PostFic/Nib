docs: XSD·Docs XSDLiteralDocs

XSD·Docs: Docs/XSD/index.html
Docs/XSD/index.html:
	jazzy --module XSD --output Docs/Source/XSD

XSDLiteralDocs: Docs/XSDLiterals/index.html
Docs/XSDLiterals/index.html:
	jazzy --module XSDLiterals --output Docs/Source/XSDLiterals

.PHONY: docs XSD·Docs XSDLiteralDocs
