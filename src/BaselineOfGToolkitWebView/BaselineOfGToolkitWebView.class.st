Class {
	#name : #BaselineOfGToolkitWebView,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitWebView
}

{ #category : #baseline }
BaselineOfGToolkitWebView >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GToolkit-WebView'
		]
]
