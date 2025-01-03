Class {
	#name : #GtAbstractWebViewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWebView',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWebView classTrait',
	#instVars : [
		'protoWebView',
		'navigationHeader'
	],
	#category : #'GToolkit-WebView-Core - UI'
}

{ #category : #initialization }
GtAbstractWebViewElement >> buildNavigationHeader [
	self subclassResponsibility
]

{ #category : #initialization }
GtAbstractWebViewElement >> initialize [
	super initialize.

	self layout: BlLinearLayout vertical.
	self matchParent.

	protoWebView := GtProtoWebViewElement new.
	self buildNavigationHeader.
	self addChild: protoWebView.
]

{ #category : #initialization }
GtAbstractWebViewElement >> onWebViewNavigated: anEvent [
	navigationHeader updateUrl: anEvent url
]

{ #category : #'api - webview' }
GtAbstractWebViewElement >> webView [
	^ protoWebView webView
]
