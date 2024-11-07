Class {
	#name : #GtNativeWebViewEventType,
	#superclass : #FFIExternalEnumeration,
	#classVars : [
		'GotFocus',
		'LostFocus',
		'Navigation',
		'PageLoad',
		'Request',
		'Unknown'
	],
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'accessing enum' }
GtNativeWebViewEventType class >> GotFocus [
	"This method was automatically generated"
	^ GotFocus
]

{ #category : #'accessing enum' }
GtNativeWebViewEventType class >> LostFocus [
	"This method was automatically generated"
	^ LostFocus
]

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
		GotFocus 4
		LostFocus 5
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
