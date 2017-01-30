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
!include TextFunc.nsh

Var /GLOBAL SexyLogsLogPath

Var /GLOBAL SexyLogsDay    
Var /GLOBAL SexyLogsMonth
Var /GLOBAL SexyLogsYear
Var /GLOBAL SexyLogsDayOfWeekName
Var /GLOBAL SexyLogsHour
Var /GLOBAL SexyLogsMinute
Var /GLOBAL SexyLogsSeconds

!macro logInit filePath
  StrCpy $SexyLogsLogPath ${filePath} 
!macroend

!macro log message
  nsislog::log "$SexyLogsLogPath" "${message}"
!macroend

!macro logInfo message
  ${GetTime} "" "LS" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  IntFmt $SexyLogsHour "%0.2u" $SexyLogsHour
  nsislog::log "$SexyLogsLogPath" "$SexyLogsYear-$SexyLogsMonth-$SexyLogsDay $SexyLogsHour:$SexyLogsMinute:$SexyLogsSeconds INFO  ${message}"
!macroend

!macro logDebug message
  ${GetTime} "" "LS" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  IntFmt $SexyLogsHour "%0.2u" $SexyLogsHour
  nsislog::log "$SexyLogsLogPath" "$SexyLogsYear-$SexyLogsMonth-$SexyLogsDay $SexyLogsHour:$SexyLogsMinute:$SexyLogsSeconds DEBUG ${message}"
!macroend

!macro logWarning message
  ${GetTime} "" "LS" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  IntFmt $SexyLogsHour "%0.2u" $SexyLogsHour
  nsislog::log "$SexyLogsLogPath" "$SexyLogsYear-$SexyLogsMonth-$SexyLogsDay $SexyLogsHour:$SexyLogsMinute:$SexyLogsSeconds WARN  ${message}"
!macroend

!macro logError message
  ${GetTime} "" "LS" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  IntFmt $SexyLogsHour "%0.2u" $SexyLogsHour
  nsislog::log "$SexyLogsLogPath" "$SexyLogsYear-$SexyLogsMonth-$SexyLogsDay $SexyLogsHour:$SexyLogsMinute:$SexyLogsSeconds ERROR ${message}"
!macroend


;
; Copy the log file to another destination. If the target file
; already exist then just append the content of the log to the
; end of the file.
;
Var SexyLogs_fileExists
!macro logCopyTo targetLogPath
  StrCpy $SexyLogs_fileExists "false"
  IfFileExists "$INSTDIR\logs\${LOG_FILE_NAME}" 0 +2
    StrCpy $SexyLogs_fileExists "true"
  
  ${If} $SexyLogs_fileExists == "true"
    ${FileJoin} '${targetLogPath}' '$SexyLogsLogPath' '${targetLogPath}'
  ${Else}
    CopyFiles "$SexyLogsLogPath" "${targetLogPath}"
  ${EndIf}  
!macroend
