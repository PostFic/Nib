docs: XSD·Docs XSDRegularExpressionDocs XSDLiteralDocs XSDValueDocs

XSD·Docs: Docs/XSD/index.html
Docs/XSD/index.html:
	jazzy --clean --module XSD --output Docs/Source/XSD --root_url https://go.KIBI.family/Nib/Docs/Source/XSD

XSDRegularExpressionDocs: Docs/XSDRegularExpressions/index.html
Docs/XSDRegularExpressions/index.html:
	jazzy --clean --module XSDRegularExpressions --output Docs/Source/XSDRegularExpressions --root_url https://go.KIBI.family/Nib/Docs/Source/XSDRegularExpressions

XSDLiteralDocs: Docs/XSDLiterals/index.html
Docs/XSDLiterals/index.html:
	jazzy --clean --module XSDLiterals --output Docs/Source/XSDLiterals --root_url https://go.KIBI.family/Nib/Docs/Source/XSDLiterals

XSDValueDocs: Docs/XSDValues/index.html
Docs/XSDValues/index.html:
	jazzy --clean --module XSDValues --output Docs/Source/XSDValues --root_url https://go.KIBI.family/Nib/Docs/Source/XSDValues

.PHONY: docs XSD·Docs XSDLiteralDocs XSDValueDocs
