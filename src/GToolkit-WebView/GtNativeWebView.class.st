Class {
	#name : #GtNativeWebView,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'instance creation' }
GtNativeWebView class >> new: nativeWebViewAttributes windowHandle: aWindowHandle [
	^ self fromHandle: (self primNew: nativeWebViewAttributes windowHandle: aWindowHandle)
]

{ #category : #'private - ffi' }
GtNativeWebView class >> primNew: nativeWebViewAttributes windowHandle: aWindowHandle [
]

{ #category : #'private - ffi' }
GtNativeWebView class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_release(void* aHandle))
]
