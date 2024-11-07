Class {
	#name : #GtNativeWebViewLostFocusEvent,
	#superclass : #GtNativeWebViewEvent,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'private - ffi' }
GtNativeWebViewLostFocusEvent class >> primRelease: aHandle [
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_lost_focus_event_release(void* aHandle))
]

{ #category : #converting }
GtNativeWebViewLostFocusEvent >> asWebViewEvent [
	^ GtWebViewLostFocusWindowsEvent new
]

{ #category : #accessing }
GtNativeWebViewLostFocusEvent >> eventType [
	^ GtNativeWebViewEventType LostFocus
]

{ #category : #accessing }
GtNativeWebViewLostFocusEvent >> webViewId [
	^ self ffiCall: #(uint64 webview_lost_focus_event_get_id(self))
]
