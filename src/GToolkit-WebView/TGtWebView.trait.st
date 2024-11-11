Trait {
	#name : #TGtWebView,
	#category : #'GToolkit-WebView-Core'
}

{ #category : #'api - webview' }
TGtWebView >> evaluate: aJavaScript [
	"Create a Future that will be resolved with an evaluation result when awaited.
	Does nothing unless `await`ed"
	<return: #TAsyncFuture>

	^ self webView
		evaluate: aJavaScript
]

{ #category : #'api - webview' }
TGtWebView >> evaluateNow: aJavaScript [
	"Schedule an evaluation of a given JavaScript and return a promise that will be resolved
	with a result of the evaluation"
	<return: #TAsyncPromise>
	| aPromise |
	aPromise := (self evaluate: aJavaScript) await.
	self enqueueTask: (BlPromiseTask new promise: aPromise).
	^ aPromise
]

{ #category : #'api - webview' }
TGtWebView >> html: aString [
	"Replace the WebView content with a given HTML.
	Limitation: The string must not exceed 2Mb in size"

	self webView html: aString
]

{ #category : #'api - webview' }
TGtWebView >> url: aString [
	"Navigate to a given url. The URL must contain a protocol (https://, ftp://, http://)"

	self webView url: aString
]

{ #category : #'api - webview' }
TGtWebView >> webView [
	^ self explicitRequirement
]
