Class {
	#name : #GtProtoWebViewVideoFileElement,
	#superclass : #GtProtoWebViewElement,
	#instVars : [
		'tmpFile'
	],
	#category : #'GToolkit-WebView-Core - UI'
}

{ #category : #'as yet unclassified' }
GtProtoWebViewVideoFileElement >> file: aFile [
	tmpFile := FileLocator temp / UUID new asString.
	tmpFile
		writeStreamDo: [ :s | 
			s
				nextPutAll: '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
        <video id="myVideo" src="file://' , aFile pathString
						, '" style="max-width: 90%; max-height: 90%;" controls></video>
    </div>
</body>
</html>
' ].

	self url: 'file://' , tmpFile pathString.
	
	self finalizationRegistry add: self
]

{ #category : #'as yet unclassified' }
GtProtoWebViewVideoFileElement >> finalize [
	tmpFile ifNotNil: [ tmpFile ensureDelete ].
	
	super finalize
]
