Class {
	#name : #GtWebView,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #accessing }
GtWebView >> url [
	^ url
]

{ #category : #accessing }
GtWebView >> url: anObject [
	url := anObject
]
