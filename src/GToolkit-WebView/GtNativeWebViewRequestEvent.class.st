Class {
	#name : #GtNativeWebViewRequestEvent,
	#superclass : #GtNativeWebViewEvent,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'private - ffi' }
GtNativeWebViewRequestEvent class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_request_event_release(void* aHandle))
]

{ #category : #converting }
GtNativeWebViewRequestEvent >> asWebViewEvent [
	^ GtWebViewIpcMessage new
		content: self content
]

{ #category : #accessing }
GtNativeWebViewRequestEvent >> content [
	<return: #String>

	^ self ffiLibrary getStringFrom: [ :aStringBox | self primGetContent: aStringBox ]
]

{ #category : #accessing }
GtNativeWebViewRequestEvent >> eventType [
	^ GtNativeWebViewEventType Request
]

{ #category : #'private - ffi' }
GtNativeWebViewRequestEvent >> primGetContent: aStringBox [
	self ffiCall: #(void webview_request_event_get_content(self, void* aStringBox))
]

{ #category : #accessing }
GtNativeWebViewRequestEvent >> webViewId [
	^ self ffiCall: #(uint64 webview_request_event_get_id(self))
]
