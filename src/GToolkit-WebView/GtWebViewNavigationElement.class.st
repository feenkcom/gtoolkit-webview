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
	super initialize.
	
	self hMatchParent.
	self vFitContent.
	self alignCenterLeft.
	self cellSpacing: 5.

	self background: self theme status neutralBackgroundColor.
	self padding: (BlInsets all: 5).

	urlEditor := BrEditor new
		beMode: BrTextEditorEditableSingleLineMode new;
		hMatchParent;
		vFitContent;
		aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousEditorSpacingAptitude;
		text: 'about:blank';
		geometry: BlStadiumGeometry new;
		background: self theme default contentBackground;
		padding: (BlInsets top: 5 right: 10 bottom: 5 left: 10);
		yourself.

	urlEditor addEditorShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination enter;
		action: [ :aShortcutEvent | self webView url: aShortcutEvent currentTarget text asString trimmed ]).

	refreshButton := BrButton new
		icon: BrGlamorousVectorIcons refresh;
		label: 'Reload this page';
		aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousButtonWithLabelTooltipAptitude2;
		action: [ self webView reloadUrl ].
	
	self addChild: refreshButton.
	self addChild: urlEditor.
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
