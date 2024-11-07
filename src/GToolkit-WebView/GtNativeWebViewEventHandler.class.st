Class {
	#name : #GtNativeWebViewEventHandler,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'library path' }
GtNativeWebViewEventHandler class >> ffiLibrary [
	^ GtWebViewLibrary uniqueInstance
]

{ #category : #'private - ffi' }
GtNativeWebViewEventHandler class >> primCreate: aSemaphoreIndex signaller: aSemaphoreSignaller [
	self ffiCall: #(void* webview_events_handler_new(size_t aSemaphoreIndex, void* aSemaphoreSignaller))
]

{ #category : #'private - ffi' }
GtNativeWebViewEventHandler class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void webview_events_handler_release(void* aHandle))
]

{ #category : #'instance creation' }
GtNativeWebViewEventHandler class >> semaphoreIndex: aSemaphoreIndex signaller: aSemaphoreSignaller [
	^ self fromNativeHandle: (self primCreate: aSemaphoreIndex signaller: aSemaphoreSignaller)
]

{ #category : #initialization }
GtNativeWebViewEventHandler >> pollEvent [
	| anEventAddress availableEventTypes |

	anEventAddress := self primPollEvent.
	anEventAddress isNull ifTrue: [ ^ nil ].

	availableEventTypes := { 
		GtNativeWebViewEventType Navigation -> GtNativeWebViewNavigationEvent.
		GtNativeWebViewEventType PageLoad -> GtNativeWebViewPageLoadEvent.
		GtNativeWebViewEventType Request -> GtNativeWebViewRequestEvent.
		GtNativeWebViewEventType GotFocus -> GtNativeWebViewGotFocusEvent.
		GtNativeWebViewEventType LostFocus -> GtNativeWebViewLostFocusEvent
	} asDictionary.
	
	^ GtNativeWebViewEvent
		fromNativeHandle: anEventAddress
		during: [ :anAbstractEvent |
			| anEventType |		
			anEventType := anAbstractEvent eventType.
			availableEventTypes
				at: anEventType
				ifPresent: [ :anEventClass | anEventClass fromNativeHandle: anAbstractEvent primIntoInnerEvent ]
				ifAbsent: [ GtNativeWebViewUnknownEvent new ] ]
]

{ #category : #'private - ffi' }
GtNativeWebViewEventHandler >> primPollEvent [
	^ self ffiCall: #(void* webview_events_handler_pop_event(self))
]
