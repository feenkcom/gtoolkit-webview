Class {
	#name : #GtNativeWebViewUnknownEvent,
	#superclass : #GtNativeWebViewEvent,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'private - ffi' }
GtNativeWebViewUnknownEvent class >> primRelease: aHandle [
]

{ #category : #converting }
GtNativeWebViewUnknownEvent >> asWebViewEvent [
	^ self shouldNotImplement
]

{ #category : #accessing }
GtNativeWebViewUnknownEvent >> webViewId [
	^ 0
]
