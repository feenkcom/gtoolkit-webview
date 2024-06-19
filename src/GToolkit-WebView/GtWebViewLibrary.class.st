Class {
	#name : #GtWebViewLibrary,
	#superclass : #FFILibrary,
	#traits : 'TGtWithStringBox',
	#classTraits : 'TGtWithStringBox classTrait',
	#category : #'GToolkit-WebView-Bindings'
}

{ #category : #'library path' }
GtWebViewLibrary class >> ffiLibrary [
	^ self
]

{ #category : #logger }
GtWebViewLibrary class >> initEnvLogger [
	self uniqueInstance initEnvLogger
]

{ #category : #initialization }
GtWebViewLibrary class >> initialize [
	SessionManager default registerUserClassNamed: self name
]

{ #category : #'system startup' }
GtWebViewLibrary class >> startUp: isANewSession [
	isANewSession
		ifTrue: [ self initEnvLogger ]
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

{ #category : #'accessing platform' }
GtWebViewLibrary >> macLibraryName [
	^ FFIMacLibraryFinder findLibrary: 'libwebview.dylib'
]

{ #category : #'private - ffi' }
GtWebViewLibrary >> primInitEnvLogger [
	^ self ffiCall: #(void webview_init_logger())
]

{ #category : #'private - ffi' }
GtWebViewLibrary >> primTest [
	^ self ffiCall: #(bool webview_test())
]

{ #category : #'accessing platform' }
GtWebViewLibrary >> unix32LibraryName [
	^ FFIUnix32LibraryFinder findLibrary: 'libwebview.so'
]

{ #category : #'accessing platform' }
GtWebViewLibrary >> unix64LibraryName [
	^ FFIUnix64LibraryFinder findLibrary: 'libwebview.so'
]

{ #category : #'accessing platform' }
GtWebViewLibrary >> win32LibraryName [
	^ FFIWindowsLibraryFinder findLibrary: 'webview.dll'
]
