Class {
	#name : #GtWebViewNavigationEvent,
	#superclass : #GtWebViewEvent,
	#instVars : [
		'url'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #accessing }
GtWebViewNavigationEvent >> url [
	^ url
]

{ #category : #accessing }
GtWebViewNavigationEvent >> url: anObject [
	url := anObject
]
