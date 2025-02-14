Class {
	#name : #GtWebViewScriptFuture,
	#superclass : #Object,
	#traits : 'TAsyncFuture',
	#classTraits : 'TAsyncFuture classTrait',
	#instVars : [
		'waker',
		'script',
		'semaphore',
		'webView',
		'scriptToEvaluate',
		'wakerProcess'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #'instance creation' }
GtWebViewScriptFuture class >> webView: aWebView script: aString [
	^ self new
		webView: aWebView
		script: aString
]

{ #category : #'api - future' }
GtWebViewScriptFuture >> poll: anAsynchronousContext [
	<return: #AsyncPoll>
	| aResult |

	(scriptToEvaluate isNil or: [ scriptToEvaluate isNull ])
		ifTrue: [
			| aSemaphoreIndex |
			(webView isNil or: [ webView isNull ])
				ifTrue: [ ^ AsyncPoll ready: (GtWebViewEvaluationResult released) ].
			
			aSemaphoreIndex := Smalltalk registerExternalObject: semaphore.
			
			scriptToEvaluate := GtNativeWebViewScriptToEvaluate
				script: script
				semaphoreIndex: aSemaphoreIndex
				signaller: self primitiveGetSemaphoreSignaller.

			webView scheduleScriptToEvaluate: scriptToEvaluate ].	

	aResult := scriptToEvaluate pollResult.
	aResult isPending ifTrue: [
		wakerProcess lock: [ :aProcess |
			aProcess ifNil: [
				wakerProcess value: ([
					semaphore wait.
					wakerProcess value: nil.
					waker wakeUp	 ] forkAt: Processor activeProcess priority) ] ].
	
		^ AsyncPoll pending ].
	
	^ AsyncPoll ready: aResult
]

{ #category : #'api - future copy' }
GtWebViewScriptFuture >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"
	
	self
		webView: webView
		script: script
]

{ #category : #'api - future' }
GtWebViewScriptFuture >> primitiveGetSemaphoreSignaller [
	<primitive: 'primitiveGetSemaphoreSignaller'>
	
	^ self error: 'Only supported by GT virtual machine'
]

{ #category : #initialization }
GtWebViewScriptFuture >> webView: aWebView script: aString [
	waker := AsyncFutureExecutionAtomicWaker new.
	wakerProcess := AsyncMutex new.
	semaphore := Semaphore new.

	webView := aWebView.
	script := aString.
	
	"initialized on the first poll"
	scriptToEvaluate := nil
]
