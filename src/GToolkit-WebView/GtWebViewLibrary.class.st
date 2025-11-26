Class {
	#name : #GtWebViewLibrary,
	#superclass : #FFILibrary,
	#traits : 'TGtWithStringBox',
	#classTraits : 'TGtWithStringBox classTrait',
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'examples - string' }
GtWebViewLibrary class >> exampleStringNewByteString [
	<gtExample>
	<noTest>
	| byteString stringBox boxedString |
	
	byteString := String withAll: 'Hello'.

	self assert: byteString isPinnedInMemory not.
	stringBox := self uniqueInstance newString: byteString.
	self assert: byteString isPinnedInMemory not.
	
	boxedString := stringBox string.
	self assert: boxedString equals: byteString.
	self assert: boxedString isPinnedInMemory not.
	
	^ stringBox
]

{ #category : #'library path' }
GtWebViewLibrary class >> ffiLibrary [
	^ self
]

{ #category : #initialization }
GtWebViewLibrary class >> hasModule [
	^ self uniqueInstance hasModule
]

{ #category : #logger }
GtWebViewLibrary class >> initEnvLogger [
	self uniqueInstance initEnvLogger
]

{ #category : #initialization }
GtWebViewLibrary class >> initGtk [
	"Does nothing on platforms except linux"
	self uniqueInstance initGtk
]

{ #category : #initialization }
GtWebViewLibrary class >> initialize [
	SessionManager default registerUserClassNamed: self name
]

{ #category : #'system startup' }
GtWebViewLibrary class >> startUp: isANewSession [
	(isANewSession and: [ self hasModule ])
		ifTrue: [
			self initEnvLogger.
			self initGtk ]
]

{ #category : #'accessing platform' }
GtWebViewLibrary >> androidLibraryName [
	^ 'libWebView.so'
]

{ #category : #testing }
GtWebViewLibrary >> hasModule [
	"Return if there is a loadable and working Glutin library installed, false otherwise"
	<return: #Boolean>
	| aResult |

	aResult := nil.
	
	[ aResult := self primTest ]
		on: Error
		do: [ :e | aResult := false ].

	^ aResult ifNil: [ false ]
]

{ #category : #logger }
GtWebViewLibrary >> initEnvLogger [
	[ self primInitEnvLogger ]
		on: Error
		do: [ :e | NonInteractiveTranscript stdout nextPutAll: '[WebView] Could not init env logger'; cr ]
]

{ #category : #logger }
GtWebViewLibrary >> initGtk [
	[ self primInitGtk ]
		on: Error
		do: [ :e | NonInteractiveTranscript stdout nextPutAll: '[WebView] Could not init gtk'; cr ]
]

{ #category : #'accessing platform' }
GtWebViewLibrary >> macLibraryName [
	^ FFIMacLibraryFinder findLibrary: 'libWebView.dylib'
]

{ #category : #'private - ffi' }
GtWebViewLibrary >> primInitEnvLogger [
	^ self ffiCall: #(void webview_init_logger())
]

{ #category : #'private - ffi' }
GtWebViewLibrary >> primInitGtk [
	^ self
		ffiCall: #(void webview_init_gtk())
		options: #(optEventLoop)
]

{ #category : #'private - ffi' }
GtWebViewLibrary >> primTest [
	^ self ffiCall: #(bool webview_test())
]

{ #category : #'accessing platform' }
GtWebViewLibrary >> unix32LibraryName [
	^ FFIUnix32LibraryFinder findLibrary: 'libWebView.so'
]

{ #category : #'accessing platform' }
GtWebViewLibrary >> unix64LibraryName [
	^ FFIUnix64LibraryFinder findLibrary: 'libWebView.so'
]

{ #category : #'accessing platform' }
GtWebViewLibrary >> win32LibraryName [
	^ FFIWindowsLibraryFinder findLibrary: 'WebView.dll'
]
