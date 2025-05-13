Class {
	#name : #BaselineOfGToolkitWebView,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitWebView
}

{ #category : #baseline }
BaselineOfGToolkitWebView >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitBoxer' with: [
				spec repository: 'github://feenkcom/gtoolkit-boxer:v0.8.55/boxer-bindings' ].
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.1535/src' ].

		spec package: 'GToolkit-WebView' with: [
			spec requires: #(#GToolkitBoxer #Brick) ].
	]
]
