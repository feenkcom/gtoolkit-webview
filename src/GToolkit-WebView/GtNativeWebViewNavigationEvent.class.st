Class {
	#name : #GtNativeWebViewNavigationEvent,
	#superclass : #GtNativeWebViewEvent,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'private - ffi' }
GtNativeWebViewNavigationEvent class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_navigation_event_release(void* aHandle))
]

{ #category : #converting }
GtNativeWebViewNavigationEvent >> asWebViewEvent [
	^ GtWebViewNavigationEvent new
]

{ #category : #accessing }
GtNativeWebViewNavigationEvent >> eventType [
	^ GtNativeWebViewEventType Navigation
]

{ #category : #accessing }
GtNativeWebViewNavigationEvent >> webViewId [
	^ self ffiCall: #(uint64 webview_navigation_event_get_id(self))
]
