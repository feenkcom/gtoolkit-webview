Class {
	#name : #GtWebViewEvaluationResult,
	#superclass : #Object,
	#instVars : [
		'value',
		'state'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #'instance creation' }
GtWebViewEvaluationResult class >> released [
	^ self new
		value: '';
		state: GtNativeWebViewScriptEvaluationState Released
]

{ #category : #'instance creation' }
GtWebViewEvaluationResult class >> success: aString [
	^ self new
		value: aString;
		state: GtNativeWebViewScriptEvaluationState Finished
]

{ #category : #testing }
GtWebViewEvaluationResult >> isPending [
	^ state = GtNativeWebViewScriptEvaluationState Pending
]

{ #category : #accessing }
GtWebViewEvaluationResult >> state [
	^ state
]

{ #category : #accessing }
GtWebViewEvaluationResult >> state: anObject [
	state := anObject
]

{ #category : #accessing }
GtWebViewEvaluationResult >> value [
	^ value
]

{ #category : #accessing }
GtWebViewEvaluationResult >> value: anObject [
	value := anObject
]
