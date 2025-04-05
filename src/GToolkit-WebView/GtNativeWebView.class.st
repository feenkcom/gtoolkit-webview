Class {
	#name : #GtNativeWebView,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'library path' }
GtNativeWebView class >> ffiLibrary [
	^ GtWebViewLibrary uniqueInstance
]

{ #category : #'instance creation' }
GtNativeWebView class >> new: nativeWebViewAttributes windowHandle: aWindowHandle [
	^ self fromHandle: (self primNew: nativeWebViewAttributes windowHandle: aWindowHandle)
]

{ #category : #'private - ffi' }
GtNativeWebView class >> primNew: theAttributes windowHandle: aWindowHandle [
	^ self ffiCall: #(void* webview_build(
		void* theAttributes,
		void* aWindowHandle)) options: #(optEventLoop)
]

{ #category : #'private - ffi' }
GtNativeWebView class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_release(void* aHandle)) options: #(optEventLoop)
]

{ #category : #accessing }
GtNativeWebView >> bounds: aRectangle [
	self
		primSetX: aRectangle left
		y: aRectangle top
		width: aRectangle width
		height: aRectangle height
]

{ #category : #accessing }
GtNativeWebView >> hide [
	self primSetVisible: false
]

{ #category : #accessing }
GtNativeWebView >> loadUrl: aString [
	self ffiLibrary
		newString: aString
		during: [ :aStringBox | self primLoadUrl: aStringBox ]
]

{ #category : #'private - ffi' }
GtNativeWebView >> primEvaluate: aScriptToEvaluate [
	self
		ffiCall: #(void webview_evaluate_script_with_result(
			self,
			void* aScriptToEvaluate))
		options: #(optEventLoop)
]

{ #category : #'private - ffi' }
GtNativeWebView >> primFocusParent [
	self
		ffiCall: #(void webview_focus_parent(self))
		options: #(optEventLoop)
]

{ #category : #'private - ffi' }
GtNativeWebView >> primLoadUrl: aStringBox [
	self
		ffiCall: #(void webview_load_url(self, void* aStringBox))
		options: #(optEventLoop)
]

{ #category : #'private - ffi' }
GtNativeWebView >> primSetEventsHandler: aNativeWebViewEventHandle id: aWebViewId [
	self ffiCall: #(void webview_set_event_handler(
		self,
		void* aNativeWebViewEventHandle,
		uint64 aWebViewId))
	options: #(optEventLoop)
]

{ #category : #'private - ffi' }
GtNativeWebView >> primSetVisible: aBoolean [
	self
		ffiCall: #(void webview_set_visible(self, bool aBoolean))
		options: #(optEventLoop)
]

{ #category : #'private - ffi' }
GtNativeWebView >> primSetX: aX y: aY width: aWidth height: aHeight [
	self
		ffiCall: #(void webview_set_bounds(
			self,
			float64 aX,
			float64 aY,
			float64 aWidth,
			float64 aHeight))
		options: #(optEventLoop)
]

{ #category : #accessing }
GtNativeWebView >> scheduleScriptToEvaluate: aScriptToEvaluate [
	self primEvaluate: aScriptToEvaluate
]

{ #category : #accessing }
GtNativeWebView >> setEventsHandler: aNativeWebViewEventHandle id: aWebViewId [
	self
		primSetEventsHandler: aNativeWebViewEventHandle
		id: aWebViewId
]

{ #category : #accessing }
GtNativeWebView >> show [
	self primSetVisible: true
]

{ #category : #accessing }
GtNativeWebView >> transferFocusToMainWindow [
	self primFocusParent
]
