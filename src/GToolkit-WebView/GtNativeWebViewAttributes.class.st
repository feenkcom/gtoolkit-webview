Class {
	#name : #GtNativeWebViewAttributes,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'library path' }
GtNativeWebViewAttributes class >> ffiLibrary [
	^ GtWebViewLibrary uniqueInstance
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

{ #category : #accessing }
GtNativeWebViewAttributes >> extent: aPoint [
	self primSetWidth: aPoint x height: aPoint y
]

{ #category : #accessing }
GtNativeWebViewAttributes >> position: aPoint [
	self primSetX: aPoint x y: aPoint y
]

{ #category : #'private - ffi' }
GtNativeWebViewAttributes >> primSetUrl: aStringBox [
	self ffiCall: #(void webview_attributes_set_url(self, void* aStringBox))
]

{ #category : #'private - ffi' }
GtNativeWebViewAttributes >> primSetWidth: aWidth height: aHeight [
	self ffiCall: #(void webview_attributes_set_size(
		self,
		float64 aWidth,
		float64 aHeight))
]

{ #category : #'private - ffi' }
GtNativeWebViewAttributes >> primSetX: aX y: aY [
	self ffiCall: #(void webview_attributes_set_position(
		self,
		float64 aX,
		float64 aY))
]

{ #category : #accessing }
GtNativeWebViewAttributes >> url: aString [
	self ffiLibrary
		newString: aString
		during: [ :aStringBox | self primSetUrl: aStringBox ]
]
