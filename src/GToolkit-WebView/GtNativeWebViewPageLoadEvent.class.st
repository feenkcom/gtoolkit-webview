Class {
	#name : #GtNativeWebViewPageLoadEvent,
	#superclass : #GtNativeWebViewEvent,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'private - ffi' }
GtNativeWebViewPageLoadEvent class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_page_load_event_release(void* aHandle))
]

{ #category : #converting }
GtNativeWebViewPageLoadEvent >> asWebViewEvent [
	^ GtWebViewPageLoadEvent new
]

{ #category : #accessing }
GtNativeWebViewPageLoadEvent >> eventType [
	^ GtNativeWebViewEventType PageLoad
]

{ #category : #accessing }
GtNativeWebViewPageLoadEvent >> webViewId [
	^ self ffiCall: #(uint64 webview_page_load_event_get_id(self))
]
