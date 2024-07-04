Class {
	#name : #GtWebView,
	#superclass : #Object,
	#instVars : [
		'session',
		'url',
		'position',
		'extent',
		'nativeWebView',
		'spaceId',
		'html'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #'geometry bounds' }
GtWebView >> boundsInSpace: aRectangle [
	position := aRectangle origin.
	extent := aRectangle extent.
	self isValid
		ifTrue: [ nativeWebView bounds: aRectangle ]
]

{ #category : #accessing }
GtWebView >> evaluate: aScript [
	^ GtWebViewScriptFuture
		webView: nativeWebView
		script: aScript
]

{ #category : #accessing }
GtWebView >> extent [
	^ extent
]

{ #category : #'host space - displaying' }
GtWebView >> hide [
	self isValid
		ifTrue: [ nativeWebView hide ]
]

{ #category : #accessing }
GtWebView >> html: aString [
	html := aString
]

{ #category : #initialization }
GtWebView >> initialize [
	super initialize.
	
	url  := 'https://gtoolkit.com'.
	html := nil.
	position := 0@0.
	extent := 600@400.
]

{ #category : #testing }
GtWebView >> isValid [
	^ session == Smalltalk session
		and: [ nativeWebView isNotNil 
			and: [ nativeWebView isNull not ] ]
]

{ #category : #accessing }
GtWebView >> position [
	^ position
]

{ #category : #private }
GtWebView >> privateEnsureCreateInSpace: aSpace [
	self isValid
		ifTrue: [ ^ self ].

	GtNativeWebViewAttributes newDuring: [ :theAttributes |
		| aWindowHandle |
		
		html
			ifNil: [ theAttributes url: url ]
			ifNotNil: [ :anHTML | theAttributes html: anHTML ].
		
		theAttributes
			position: position;
			extent: extent.
		
		aWindowHandle := aSpace hostSpace window rawWindowHandle.
		nativeWebView := GtNativeWebView new: theAttributes windowHandle: aWindowHandle.
		spaceId := aSpace id.
		session := Smalltalk session ]
]

{ #category : #private }
GtWebView >> privateEnsureRelease [
	self isValid
		ifFalse: [ ^ self ].
		
	nativeWebView release.
	nativeWebView := nil
]

{ #category : #'host space - displaying' }
GtWebView >> showInSpace: aSpace [
	(aSpace host isKindOf: BlRustWindowingHost)
		ifFalse: [ ^ self privateEnsureRelease ].

	(spaceId == aSpace id)
		ifFalse: [ self privateEnsureRelease ].

	self isValid
		ifTrue: [ nativeWebView show ]
		ifFalse: [ self privateEnsureCreateInSpace: aSpace ]
]

{ #category : #accessing }
GtWebView >> url [
	^ url
]

{ #category : #accessing }
GtWebView >> url: anObject [
	url := anObject
]
