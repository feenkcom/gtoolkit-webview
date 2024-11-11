Class {
	#name : #GtWebViewElement,
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
GtWebViewElement >> initialize [
	super initialize.
	
	self layout: BlLinearLayout vertical.
	self matchParent.

	protoWebView := GtProtoWebViewElement new.
	navigationHeader := GtWebViewNavigationElement new
		webView: protoWebView webView.

	self addChildren: { navigationHeader . protoWebView }.
	
	self
		when: GtWebViewNavigationEvent
		do: [ :anEvent | self onWebViewNavigated: anEvent ].
]

{ #category : #initialization }
GtWebViewElement >> onWebViewNavigated: anEvent [
	navigationHeader updateUrl: anEvent url
]

{ #category : #'api - webview' }
GtWebViewElement >> webView [
	^ protoWebView webView
]
