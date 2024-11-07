Class {
	#name : #GtNativeWebViewGotFocusEvent,
	#superclass : #GtNativeWebViewEvent,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'private - ffi' }
GtNativeWebViewGotFocusEvent class >> primRelease: aHandle [
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_got_focus_event_release(void* aHandle))
]

{ #category : #converting }
GtNativeWebViewGotFocusEvent >> asWebViewEvent [
	^ GtWebViewGotFocusWindowsEvent new
]

{ #category : #accessing }
GtNativeWebViewGotFocusEvent >> eventType [
	^ GtNativeWebViewEventType GotFocus
]

{ #category : #accessing }
GtNativeWebViewGotFocusEvent >> webViewId [
	^ self ffiCall: #(uint64 webview_got_focus_event_get_id(self))
]
