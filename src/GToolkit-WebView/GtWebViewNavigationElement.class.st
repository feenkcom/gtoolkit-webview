Class {
	#name : #GtWebViewNavigationElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'backButton',
		'forwardButton',
		'urlEditor',
		'refreshButton',
		'webView'
	],
	#category : #'GToolkit-WebView-Core - UI'
}

{ #category : #initialization }
GtWebViewNavigationElement >> initialize [
	| scrollable |
	super initialize.

	self hMatchParent.
	self vFitContent.
	self alignCenterLeft.
	self cellSpacing: 5.

	self background: self theme status neutralBackgroundColor.
	self padding: (BlInsets all: 5).

	urlEditor := BrEditor new
			beMode: BrTextEditorEditableSingleLineMode new;
			hFitContent;
			vFitContent;
			aptitude: BrGlamorousRegularEditorAptitude;
			text: 'about:blank';
			padding: (BlInsets
					top: 5
					right: 10
					bottom: 5
					left: 10);
			yourself.

	urlEditor
		addEditorShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination enter;
				action: [ :aShortcutEvent | self webView url: aShortcutEvent currentTarget text asString trimmed ]).

	refreshButton := BrButton new
			icon: BrGlamorousVectorIcons refresh;
			label: 'Reload this page';
			aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousButtonWithLabelTooltipAptitude2;
			action: [ self webView reloadUrl ].

	self addChild: refreshButton.

	scrollable := BlScrollableElement new.
	scrollable
		addAptitude: BrGlamorousEditorSpacingAptitude;
		geometry: BlStadiumGeometry new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	scrollable addChild: urlEditor.

	self addChild: scrollable
]

{ #category : #accessing }
GtWebViewNavigationElement >> updateUrl: aString [
	urlEditor text: aString.
	urlEditor navigator moveToEnd apply
]

{ #category : #accessing }
GtWebViewNavigationElement >> webView [
	^ webView
]

{ #category : #accessing }
GtWebViewNavigationElement >> webView: anObject [
	webView := anObject
]
