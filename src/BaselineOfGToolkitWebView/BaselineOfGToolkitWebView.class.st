Class {
	#name : #BaselineOfGToolkitWebView,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitWebView
}

{ #category : #baseline }
BaselineOfGToolkitWebView >> baseline: spec [
	<baseline>
	^ spec
		for: #common
		do: [ spec
				baseline: 'GToolkitBoxer'
					with: [ spec repository: 'github://feenkcom/gtoolkit-boxer:main/boxer-bindings' ];
				baseline: 'Brick'
					with: [ spec repository: 'github://feenkcom/Brick:main/src' ].
			spec package: 'GToolkit-WebView' with: [ spec requires: #(GToolkitBoxer Brick) ] ]
]
