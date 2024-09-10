Class {
	#name : #GtWebViewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'webView'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #accessing }
GtWebViewElement >> html: aString [
	webView html: aString
]

{ #category : #initialization }
GtWebViewElement >> initialize [
	super initialize.
	
	self matchParent.

	webView := GtWebView new.
	webView announcer weak
		when: GtWebViewEvent
		send: #onWebViewEvent:
		to: self
]

{ #category : #'hooks - children' }
GtWebViewElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	OSPlatform current isLinux ifTrue: [ ^ self ].
	
	webView boundsInSpace: self boundsInSpace.
	webView showInSpace: self space
]

{ #category : #'hooks - geometry' }
GtWebViewElement >> onExtentChanged [
	super onExtentChanged.
	
	webView boundsInSpace: self boundsInSpace
]

{ #category : #'hooks - geometry' }
GtWebViewElement >> onPositionInSpaceChanged [
	super onPositionInSpaceChanged.
	
	webView boundsInSpace: self boundsInSpace
]

{ #category : #'hooks - children' }
GtWebViewElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	OSPlatform current isLinux ifTrue: [ ^ self ].
	
	webView hide
]

{ #category : #'event handling' }
GtWebViewElement >> onWebViewEvent: aWebViewEvent [
	self enqueueTask: (BlTaskAction new action: [ self dispatchEvent: aWebViewEvent ])
]

{ #category : #accessing }
GtWebViewElement >> url: aString [
	webView url: aString
]

{ #category : #accessing }
GtWebViewElement >> webView [
	^ webView
]
