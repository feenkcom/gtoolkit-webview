Class {
	#name : #GtNativeWebViewScriptEvaluationState,
	#superclass : #FFIExternalEnumeration,
	#classVars : [
		'Errored',
		'Finished',
		'Pending',
		'Released'
	],
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'accessing enum' }
GtNativeWebViewScriptEvaluationState class >> Errored [
	"This method was automatically generated"
	^ Errored
]

{ #category : #'accessing enum' }
GtNativeWebViewScriptEvaluationState class >> Finished [
	"This method was automatically generated"
	^ Finished
]

{ #category : #'accessing enum' }
GtNativeWebViewScriptEvaluationState class >> Pending [
	"This method was automatically generated"
	^ Pending
]

{ #category : #'accessing enum' }
GtNativeWebViewScriptEvaluationState class >> Released [
	"This method was automatically generated"
	^ Released
]

{ #category : #'class initialization' }
GtNativeWebViewScriptEvaluationState class >> enumDecl [
	"Auto generated declarations"

	^ #(
		Pending 0
		Finished 1
		Errored 2
		Released 3)
]

{ #category : #'class initialization' }
GtNativeWebViewScriptEvaluationState class >> initialize [
	"Auto-generated class initialisation"

	self initializeEnumeration.
	Author
		useAuthor: 'UFFI'
		during: [ self rebuildEnumAccessors ]
]
