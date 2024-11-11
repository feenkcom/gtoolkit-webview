Class {
	#name : #GtProtoWebViewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWebView',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWebView classTrait',
	#instVars : [
		'webView'
	],
	#category : #'GToolkit-WebView-Core - UI'
}

{ #category : #initialization }
GtProtoWebViewElement >> initialize [
	super initialize.
	
	self matchParent.
	self beFocusable.

	webView := GtWebView new.
	webView announcer weak
		when: GtWebViewEvent
		send: #onWebViewEvent:
		to: self.
		
	self
		when: GtWebViewGotFocusWindowsEvent
		do: [ :anEvent | self requestFocus].
		
	self
		when: GtWebViewLostFocusWindowsEvent
		do: [ :anEvent | self loseFocus ].

	self
		when: BlBlurEvent
		do: [ :anEvent | self onLoseFocus ].
]

{ #category : #'hooks - children' }
GtProtoWebViewElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	OSPlatform current isLinux ifTrue: [ ^ self ].
	
	webView boundsInSpace: self boundsInSpace.
	webView showInSpace: self space
]

{ #category : #'hooks - geometry' }
GtProtoWebViewElement >> onExtentChanged [
	super onExtentChanged.
	
	webView boundsInSpace: self boundsInSpace
]

{ #category : #'private - event handling' }
GtProtoWebViewElement >> onLoseFocus [
	OSPlatform current isWindows
		ifFalse: [ ^ self ].

	self spaceDo: [ :aSpace | aSpace hostSpaceDo: [ :aHostSpace |
		GtNativeWebView primWindowsSetFocus: aHostSpace window hwnd ] ]
]

{ #category : #'hooks - geometry' }
GtProtoWebViewElement >> onPositionInSpaceChanged [
	super onPositionInSpaceChanged.
	
	webView boundsInSpace: self boundsInSpace
]

{ #category : #'hooks - children' }
GtProtoWebViewElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	OSPlatform current isLinux ifTrue: [ ^ self ].
	
	webView hide
]

{ #category : #'private - event handling' }
GtProtoWebViewElement >> onWebViewEvent: aWebViewEvent [
	self enqueueTask: (BlTaskAction new action: [ self fireEvent: aWebViewEvent ])
]

{ #category : #'api - webview' }
GtProtoWebViewElement >> webView [
	^ webView
]
