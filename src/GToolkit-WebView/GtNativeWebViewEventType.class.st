Class {
	#name : #GtNativeWebViewEventType,
	#superclass : #FFIExternalEnumeration,
	#classVars : [
		'Navigation',
		'PageLoad',
		'Request',
		'Unknown'
	],
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'accessing enum' }
GtNativeWebViewEventType class >> Navigation [
	"This method was automatically generated"
	^ Navigation
]

{ #category : #'accessing enum' }
GtNativeWebViewEventType class >> PageLoad [
	"This method was automatically generated"
	^ PageLoad
]

{ #category : #'accessing enum' }
GtNativeWebViewEventType class >> Request [
	"This method was automatically generated"
	^ Request
]

{ #category : #'accessing enum' }
GtNativeWebViewEventType class >> Unknown [
	"This method was automatically generated"
	^ Unknown
]

{ #category : #'class initialization' }
GtNativeWebViewEventType class >> enumDecl [
	"Auto generated declarations"

	^ #(
		Unknown 0
		Request 1
		Navigation 2
		PageLoad 3
	)
]

{ #category : #'class initialization' }
GtNativeWebViewEventType class >> initialize [
	"Auto-generated class initialisation"

	self initializeEnumeration.
	Author
		useAuthor: 'UFFI'
		during: [ self rebuildEnumAccessors ]
]
