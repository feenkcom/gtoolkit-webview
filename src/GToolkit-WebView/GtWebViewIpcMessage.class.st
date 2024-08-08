Class {
	#name : #GtWebViewIpcMessage,
	#superclass : #GtWebViewEvent,
	#instVars : [
		'content'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #accessing }
GtWebViewIpcMessage >> content [
	^ content
]

{ #category : #accessing }
GtWebViewIpcMessage >> content: anObject [
	content := anObject
]
