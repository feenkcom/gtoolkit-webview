Class {
	#name : #GtWebView,
	#superclass : #Object,
	#instVars : [
		'session',
		'url',
		'html',
		'position',
		'extent',
		'nativeWebView',
		'spaceId',
		'id',
		'announcer',
		'currentUrl'
	],
	#classVars : [
		'UniqueIdGenerator'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #'class initialization' }
GtWebView class >> initialize [
	UniqueIdGenerator := GtWebViewUniqueIdGenerator new
]

{ #category : #accessing }
GtWebView >> announcer [
	^ announcer
]

{ #category : #'geometry bounds' }
GtWebView >> boundsInSpace: aRectangle [
	position := aRectangle origin.
	extent := aRectangle extent.
	self isValid
		ifTrue: [ nativeWebView bounds: aRectangle ]
]

{ #category : #accessing }
GtWebView >> currentUrl [
	^ currentUrl ifNil: [ url ]
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

{ #category : #'api - event managing' }
GtWebView >> handleEvent: aWebViewEvent [
	announcer announce: aWebViewEvent
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

{ #category : #accessing }
GtWebView >> id [
	^ id
]

{ #category : #initialization }
GtWebView >> initialize [
	super initialize.
	
	id := UniqueIdGenerator generateUniqueId.
	url := 'https://gtoolkit.com'.
	html := nil.
	position := 0@0.
	extent := 600@400.

	announcer := Announcer new.
	announcer when: GtWebViewNavigationEvent send: #onUrlChanged: to: self.
]

{ #category : #testing }
GtWebView >> isValid [
	^ session == Smalltalk session
		and: [ nativeWebView isNotNil 
			and: [ nativeWebView isNull not ] ]
]

{ #category : #'api - event managing' }
GtWebView >> onUrlChanged: anEvent [
	currentUrl := anEvent url
]

{ #category : #accessing }
GtWebView >> position [
	^ position
]

{ #category : #private }
GtWebView >> privateEnsureCreateInSpace: aSpace [
	self isValid
		ifTrue: [ ^ self ].

	GtWebViewEventLoop registerWebView: self.

	GtNativeWebViewAttributes newDuring: [ :theAttributes |
		| aWindowHandle |
		
		html
			ifNil: [ theAttributes url: url ]
			ifNotNil: [ :anHTML | theAttributes html: anHTML ].
		
		theAttributes
			position: position;
			extent: extent;
			eventsHandle: GtWebViewEventLoop eventsHandler id: self id.

		aWindowHandle := aSpace hostSpace window rawWindowHandle.
		nativeWebView := GtNativeWebView new: theAttributes windowHandle: aWindowHandle.
		nativeWebView
			setEventsHandler: GtWebViewEventLoop eventsHandler
			id: self id.
		spaceId := aSpace id.
		session := Smalltalk session ]
]

{ #category : #private }
GtWebView >> privateEnsureRelease [
	self isValid
		ifFalse: [ ^ self ].
		
	nativeWebView release.
	nativeWebView := nil.
	
	GtWebViewEventLoop unregisterWebView: self
]

{ #category : #accessing }
GtWebView >> reloadUrl [
	self currentUrl ifNotNil: [ :aUrl |
		self isValid
			ifTrue: [ nativeWebView loadUrl: aUrl ] ]
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
GtWebView >> url: aString [
	url := aString asString.
	self isValid
		ifTrue: [ nativeWebView loadUrl: url ]
]
