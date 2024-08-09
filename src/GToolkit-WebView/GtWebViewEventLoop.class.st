Class {
	#name : #GtWebViewEventLoop,
	#superclass : #Object,
	#instVars : [
		'semaphore',
		'semaphoreIndex',
		'externalEventHandler',
		'session',
		'eventLoopProcess',
		'processMutex',
		'webViewRegistry',
		'registryMutex'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-WebView-Core'
}

{ #category : #cleanup }
GtWebViewEventLoop class >> cleanUp [
	uniqueInstance ifNotNil: [ :anInstance | anInstance stop ].
	uniqueInstance := nil
]

{ #category : #accessing }
GtWebViewEventLoop class >> eventsHandler [
	<return: #GtNativeWebViewEventHandler>
	
	^ self uniqueInstance ensureEventsHandler
]

{ #category : #'class initialization' }
GtWebViewEventLoop class >> initialize [
	SessionManager default registerUserClassNamed: self name.
]

{ #category : #accessing }
GtWebViewEventLoop class >> registerWebView: aWebView [
	self uniqueInstance registerWebView: aWebView
]

{ #category : #'system startup' }
GtWebViewEventLoop class >> shutDown: quitting [
	quitting ifTrue: [ self stop ]
]

{ #category : #accessing }
GtWebViewEventLoop class >> start [
	self uniqueInstance start
]

{ #category : #'system startup' }
GtWebViewEventLoop class >> startUp: isImageStarting [
	"Pharo is starting up. If this platform requires specific intialization, this is a great place to put it."
	isImageStarting
		ifTrue: [ self start ]
]

{ #category : #accessing }
GtWebViewEventLoop class >> stop [
	uniqueInstance ifNotNil: [ :anInstance | anInstance stop ]
]

{ #category : #accessing }
GtWebViewEventLoop class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GtWebViewEventLoop class >> unregisterWebView: aWebView [
	self uniqueInstance unregisterWebView: aWebView
]

{ #category : #private }
GtWebViewEventLoop >> deliverEvent: aNativeWebViewEvent [
	
	webViewRegistry
		at: aNativeWebViewEvent webViewId
		ifPresent: [ :aWebView | aWebView handleEvent: aNativeWebViewEvent asWebViewEvent ]
]

{ #category : #private }
GtWebViewEventLoop >> deliverEvents: polledWebViewEvents [
	
	polledWebViewEvents
		ifEmpty: [ ^ self ].
		
	self
		deliverEvents: polledWebViewEvents
		startingAt: 1
]

{ #category : #private }
GtWebViewEventLoop >> deliverEvents: polledWebViewEvents startingAt: startIndex [
	startIndex to: polledWebViewEvents size do: [ :index |
		| eachEvent |
		eachEvent := polledWebViewEvents at: index.
		[ self deliverEvent: eachEvent ] 
			"Ensure processing of the rest of events"
			ifCurtailed: [
				self deliverEvents: polledWebViewEvents startingAt: index + 1 ] ]
]

{ #category : #private }
GtWebViewEventLoop >> ensureEventsHandler [
	<return: #GtNativeWebViewEventHandler>
	(externalEventHandler notNil and: [ session == Smalltalk session and: [ externalEventHandler isNull not ] ])
		ifTrue: [ ^ externalEventHandler ].
	
	semaphoreIndex := Smalltalk registerExternalObject: semaphore.

	externalEventHandler := GtWebViewLibrary hasModule
		ifTrue: [ GtNativeWebViewEventHandler
				semaphoreIndex: semaphoreIndex
				signaller: self primitiveGetSemaphoreSignaller ]
		ifFalse: [ GtNativeWebViewEventHandler null ].

	session := Smalltalk session.
	^ externalEventHandler
]

{ #category : #private }
GtWebViewEventLoop >> eventLoopProcess [
	[
		[
			self pollAndDeliverEvents.
			semaphore wait
		] on: UnhandledError fork: [ :anError |
			NonInteractiveTranscript stdout
				nextPut: $[;
				nextPutAll: self class name;
				nextPut: $];
				space;
				print: anError;
				cr.
			anError pass ]
	] repeat
]

{ #category : #accessing }
GtWebViewEventLoop >> eventsHandlerDo: aBlock [
	<return: #GtNativeWebViewEventHandler>

	(externalEventHandler notNil and: [ session == Smalltalk session and: [ externalEventHandler isNull not ] ])
		ifTrue: [ aBlock value: externalEventHandler ]
]

{ #category : #initialization }
GtWebViewEventLoop >> initialize [
	super initialize.
	
	semaphore := Semaphore new.

	session := nil.
	eventLoopProcess := nil.
	processMutex := Mutex new.

	webViewRegistry := WeakValueDictionary new.
	registryMutex := Mutex new
]

{ #category : #private }
GtWebViewEventLoop >> pollAndDeliverEvents [
	| polledEvents |
	
	polledEvents := OrderedCollection new: 5.
	[
		| newEvent shouldContinue |
		
		newEvent := nil.
		self eventsHandlerDo: [ :anEventsHandler | newEvent := anEventsHandler pollEvent ].
		shouldContinue := newEvent
			ifNil: [ false ]
			ifNotNil: [ polledEvents add: newEvent . true ].
			
		shouldContinue
	] whileTrue.

	self deliverEvents: polledEvents
]

{ #category : #private }
GtWebViewEventLoop >> primitiveGetSemaphoreSignaller [
	<primitive: 'primitiveGetSemaphoreSignaller'>

	^ ExternalAddress null
]

{ #category : #accessing }
GtWebViewEventLoop >> registerWebView: aWebView [
	registryMutex critical: [ webViewRegistry at: aWebView id put: aWebView ]
]

{ #category : #accessing }
GtWebViewEventLoop >> start [
	processMutex critical: [
		self ensureEventsHandler.
		eventLoopProcess := [ self eventLoopProcess ] newProcess
			priority: Processor userInterruptPriority;
			name: 'WebView event loop';
			yourself.
		eventLoopProcess resume ]
]

{ #category : #accessing }
GtWebViewEventLoop >> stop [
	processMutex critical: [
		eventLoopProcess ifNotNil: [ :aProcess | aProcess terminate ].
		eventLoopProcess := nil.
		externalEventHandler ifNotNil: [ :anEventsHandler | anEventsHandler release ].
		externalEventHandler := nil ]
]

{ #category : #accessing }
GtWebViewEventLoop >> unregisterWebView: aWebView [
	registryMutex critical: [ webViewRegistry removeKey: aWebView id ifAbsent: [ ] ]
]
