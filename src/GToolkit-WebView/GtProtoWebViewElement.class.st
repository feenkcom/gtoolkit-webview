Class {
	#name : #GtProtoWebViewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWebView',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWebView classTrait',
	#instVars : [
		'webView',
		'mainWindowHwnd'
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
	
	"on Windows we should remember the HWND of the main window to transfer focus to it
	when a webview is removed from the graph scene. We can't get HWND when handling
	#onRemovedFromSceneGraph because the webview element is no longer added to the space"
	OSPlatform current isWindows
		ifTrue: [
			self spaceDo: [ :aSpace | aSpace hostSpaceDo: [ :aHostSpace |
				mainWindowHwnd := aHostSpace window hwnd ] ] ].
	
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
	webView transferFocusToMainWindow
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
	
	webView transferFocusToMainWindow.
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
