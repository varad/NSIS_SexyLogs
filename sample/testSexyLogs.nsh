; you have to include NSISLog plugin to use SexyLogs
; download it at http://nsis.sourceforge.net/NSISLog_plug-in and put
; in some folder then import it as follows
!addplugindir "plugins"

!include "WinMessages.nsh"
!include "MUI2.nsh"
!include "nsDialogs.nsh"

; you have to include SexyLogs
!include "..\sexyLogs.nsh"
 
OutFile "testSexyLogs.exe"
 
Section "EveryNsisScriptRequiresAtLeastOneSection"
SectionEnd

!insertmacro MUI_LANGUAGE "English"    
 
Page Custom page.custom
Function page.custom
                
  ; Create dialog. We have to pop the value from the stack
  nsDialogs::Create 1018
  Pop $0
  
  ; This is how to use SexyLogs
  !insertmacro logInit "$PLUGINSDIR\sampleLog.log"
  !insertmacro log "+---------------------------------------+"
  !insertmacro log "| SexyLogs - Make NSIS logs sexy again! |"
  !insertmacro log "+---------------------------------------+"
  !insertmacro logInfo "Hello World!"
  !insertmacro logDebug "Hello World!"
  !insertmacro logWarning "Hello World!"
  !insertmacro logError "Hello World!"
  !insertmacro logCopyTo "$PLUGINSDIR\sampleLogCopy.log"
 
  ; Create a label - x,y,width,height,text
	${NSD_CreateLabel} 0 0 100% 30 "Check out the log file at $PLUGINSDIR\sampleLog.log"
  
  ; Show GUI
  nsDialogs::Show
  
FunctionEnd 

; It may be useful to copy the log to the installation folder
; if the installer successfully finishes
;Function .onInstSuccess
;  !insertmacro logCopyTo "$PLUGINSDIR\sampleLogCopy.log"
;FunctionEnd

; It may be useful to copy the log to the installation folder
; if the installer failed
;Function .onInstFailed
;  !insertmacro logCopyTo "$PLUGINSDIR\sampleLogCopy.log"
;FunctionEnd