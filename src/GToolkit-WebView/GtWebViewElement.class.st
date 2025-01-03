Class {
	#name : #GtWebViewElement,
	#superclass : #GtAbstractWebViewElement,
	#category : #'GToolkit-WebView-Core - UI'
}

{ #category : #initialization }
GtWebViewElement >> buildNavigationHeader [
	navigationHeader := GtWebViewNavigationElement new
			webView: protoWebView webView.
	self addChild: navigationHeader
]

{ #category : #initialization }
GtWebViewElement >> initialize [
	super initialize.
	self
		when: GtWebViewNavigationEvent
		do: [ :anEvent | self onWebViewNavigated: anEvent ]
]

{ #category : #initialization }
GtWebViewElement >> onWebViewNavigated: anEvent [
	navigationHeader updateUrl: anEvent url
]
