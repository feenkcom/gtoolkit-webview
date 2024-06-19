Class {
	#name : #BaselineOfGToolkitWebview,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitWebview
}

{ #category : #baseline }
BaselineOfGToolkitWebview >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GToolkit-Webview'
		]
]
