; A set of macros which make logging in NSIS easier.
; 
; It's basically wrapper around NSISLog plugin and adds a date and time
; to every logger call. Allows you to log at DEBUG, INFO, WARN or ERROR level.
;
; NSISLog plugin: http://nsis.sourceforge.net/NSISLog_plug-in
;
; Sample call: 
; !insertmacro logInfo "Hello World!"
; 
; The "sampleLog.log" in $PLUGINSDIR folder then contains:
; 2017-01-29 21:14:17 INFO  Hello World! 
;
; See sample installer in "sample\testSexyLogs.nsh".
;
!include FileFunc.nsh

Var /GLOBAL SexyLogsLogName

!macro logInit filePath
  StrCpy $SexyLogsLogName ${filePath} 
!macroend

!macro log message
  nsislog::log "$SexyLogsLogName" "${message}"
!macroend

!macro logInfo message
  ${GetTime} "" "LS" $0 $1 $2 $3 $4 $5 $6
  IntFmt $4 "%0.2u" $4
  nsislog::log "$SexyLogsLogName" "$2-$1-$0 $4:$5:$6 INFO  ${message}"
!macroend

!macro logDebug message
  ${GetTime} "" "LS" $0 $1 $2 $3 $4 $5 $6
  IntFmt $4 "%0.2u" $4
  nsislog::log "$SexyLogsLogName" "$2-$1-$0 $4:$5:$6 DEBUG ${message}"
!macroend

!macro logWarning message
  ${GetTime} "" "LS" $0 $1 $2 $3 $4 $5 $6
  IntFmt $4 "%0.2u" $4
  nsislog::log "$SexyLogsLogName" "$2-$1-$0 $4:$5:$6 WARN  ${message}"
!macroend

!macro logError message
  ${GetTime} "" "LS" $0 $1 $2 $3 $4 $5 $6
  IntFmt $4 "%0.2u" $4
  nsislog::log "$SexyLogsLogName" "$2-$1-$0 $4:$5:$6 ERROR ${message}"
!macroend