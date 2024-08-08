Class {
	#name : #GtWebViewUniqueIdGenerator,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'nextUniqueId'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #accessing }
GtWebViewUniqueIdGenerator >> generateUniqueId [
	^ mutex critical: [
		| uniqueId |
		
		uniqueId := nextUniqueId.
		nextUniqueId := nextUniqueId + 1.
		uniqueId ]
]

{ #category : #initialization }
GtWebViewUniqueIdGenerator >> initialize [
	super initialize.
	
	mutex := Mutex new.
	nextUniqueId := 1
]
