Class {
	#name : #GtNativeWebViewScriptToEvaluate,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'library path' }
GtNativeWebViewScriptToEvaluate class >> ffiLibrary [
	^ GtWebViewLibrary uniqueInstance
]

{ #category : #'private - ffi' }
GtNativeWebViewScriptToEvaluate class >> primCreate: aStringBox semaphoreIndex: aSemaphoreIndex signaller: aSemaphoreSignaller [
	^ self ffiCall: #(void* webview_script_to_evaluate_new(
		void* aStringBox,
		size_t aSemaphoreIndex,
		void* aSemaphoreSignaller))
]

{ #category : #'private - ffi' }
GtNativeWebViewScriptToEvaluate class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_script_to_evaluate_release(void* aHandle))
]

{ #category : #'instance creation' }
GtNativeWebViewScriptToEvaluate class >> script: aScript semaphoreIndex: aSemaphoreIndex signaller: aSignaller [
	^ self ffiLibrary newString: aScript during: [ :aStringBox |
		self fromNativeHandle: (self
			primCreate: aStringBox
			semaphoreIndex: aSemaphoreIndex
			signaller: aSignaller) ]
]

{ #category : #accessing }
GtNativeWebViewScriptToEvaluate >> pollResult [
	<return: #GtWebViewEvaluationResult>
	
	^ self ffiLibrary
		newString: ''
		during: [ :aStringBox |
			| aState aString |
			
			aState := self primGetResult: aStringBox.
			aString := aStringBox string.
			GtWebViewEvaluationResult new
				value: aString;
				state: aState ]
]

{ #category : #'private - ffi' }
GtNativeWebViewScriptToEvaluate >> primGetResult: aStringBox [
	self ffiCall: #(GtNativeWebViewScriptEvaluationState webview_script_to_evaluate_get_result(
		self,
		void* aStringBox))
]
