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
]

{ #category : #'hooks - children' }
GtWebViewElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
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
	
	webView hide
]

{ #category : #accessing }
GtWebViewElement >> url: aString [
	webView url: aString
]

{ #category : #accessing }
GtWebViewElement >> webView [
	^ webView
]
