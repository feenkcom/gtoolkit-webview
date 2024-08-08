Class {
	#name : #GtNativeWebViewEvent,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'library path' }
GtNativeWebViewEvent class >> ffiLibrary [
	^ GtWebViewLibrary uniqueInstance
]

{ #category : #'private - ffi' }
GtNativeWebViewEvent class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_event_release(void* aHandle))
]

{ #category : #converting }
GtNativeWebViewEvent >> asWebViewEvent [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtNativeWebViewEvent >> eventType [
	^ self ffiCall: #(GtNativeWebViewEventType webview_event_get_type(self))
]

{ #category : #'private - ffi' }
GtNativeWebViewEvent >> primIntoInnerEvent [
	^ self ffiCall: #(void* webview_event_into_inner(self))
]

{ #category : #accessing }
GtNativeWebViewEvent >> webViewId [
	^ self subclassResponsibility
]
