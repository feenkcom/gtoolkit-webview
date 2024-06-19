Class {
	#name : #GtNativeWebViewAttributes,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'library path' }
GtNativeWebViewAttributes class >> ffiLibrary [
	^ GtWebViewLibrary
]

{ #category : #'private - ffi' }
GtNativeWebViewAttributes class >> primCreate [
	^ self ffiCall: #(void* webview_attributes_default())
]

{ #category : #'private - ffi' }
GtNativeWebViewAttributes class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_attributes_release(void* aHandle))
]

{ #category : #'private - ffi' }
GtNativeWebViewAttributes >> primSetUrl: aStringBox [
	self ffiCall: #(void webview_attributes_set_url(self, void* aStringBox))
]

{ #category : #accessing }
GtNativeWebViewAttributes >> url: aString [
	self ffiLibrary
		newString: aString
		during: [ :aStringBox | self primSetUrl: aStringBox ]
]
