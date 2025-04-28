#NoEnv  ; 스크립트 성능 및 호환성을 위해 권장됩니다.
SendMode Input  ; 키 입력 전송 방식을 Input으로 설정하여 안정성을 높입니다.
SetWorkingDir %A_ScriptDir%  ; 스크립트가 있는 폴더를 작업 폴더로 설정합니다.

; --- IME 제어용 상수 정의 ---
global IME_CMODE_NATIVE := 0x1       ; 한글 모드 플래그 (비트 0)
global IMC_GETCONVERSIONMODE := 0x001 ; 변환 모드를 가져오는 메시지
global WM_IME_CONTROL := 0x283      ; IME 제어 메시지 ID

; --- Esc 키 설정 ---
$Esc::
    ; 활성 창의 현재 IME 변환 모드를 가져옵니다.
    currentMode := IME_GetConversionMode("A") ; "A"는 활성 창을 의미합니다.

    ; 현재 모드 값에서 한글 플래그(IME_CMODE_NATIVE)가 설정되어 있는지 확인합니다.
    ; (currentMode & IME_CMODE_NATIVE) 결과가 0이 아니면 한글 모드입니다.
    if (currentMode & IME_CMODE_NATIVE)
    {
        Send, {Esc}  ; 먼저 Esc 키를 보냅니다.
        Sleep, 30    ; 짧은 지연 시간 (필요에 따라 조절)
        Send, {vk15} ; 한/영 전환 키를 보냅니다. (한글 -> 영어)
        ; ToolTip, Esc: 한글 -> 영문 전환 ; 디버깅용 툴팁 (필요하면 주석 해제)
    }
    else ; 한글 모드가 아니라면 (영어 또는 다른 상태)
    {
        Send, {Esc}  ; Esc 키만 보냅니다. (영어 유지)
        ; ToolTip, Esc: 영문 유지 ; 디버깅용 툴팁 (필요하면 주석 해제)
    }
    ; SetTimer, RemoveToolTip, -1000 ; 1초 후 툴팁 제거 (툴팁 사용 시 주석 해제)
    return

; --- Ctrl+[ 키 설정 ---
; v1에서는 ^[ 기호가 Ctrl+[ 를 잘 나타냅니다.
; 만약 AltGr 키 등과 충돌하면 ^vkDB (vkDB는 [ 키의 가상 키코드)를 사용해 보세요.
$^[:: ; 또는 $^vkDB::
    currentMode := IME_GetConversionMode("A")
    if (currentMode & IME_CMODE_NATIVE)
    {
        Send, ^[ ; Ctrl+[ 를 보냅니다. (또는 Send, ^{vkDB})
        Sleep, 30
        Send, {vk15}
        ; ToolTip, Ctrl+[: 한글 -> 영문 전환
    }
    else
    {
        Send, ^[ ; Ctrl+[ 를 보냅니다. (또는 Send, ^{vkDB})
        ; ToolTip, Ctrl+[: 영문 유지
    }
    ; SetTimer, RemoveToolTip, -1000
    return

; --- IME 변환 모드를 가져오는 함수 ---
IME_GetConversionMode(WinTitle) {
    global WM_IME_CONTROL, IMC_GETCONVERSIONMODE
    ; WinExist 함수로 창 핸들(hWnd)을 얻는 것이 조금 더 안정적입니다.
    hWnd := WinExist(WinTitle)
    if !hWnd
        return -1 ; 창을 찾을 수 없으면 오류 (-1) 반환

    ; 해당 창의 기본 IME 핸들을 가져옵니다.
    DefaultIMEWnd := ImmGetDefaultIMEWnd(hWnd)
    if !DefaultIMEWnd
        return -1 ; IME 핸들을 찾을 수 없으면 오류 (-1) 반환

    ; IME 핸들에 IMC_GETCONVERSIONMODE 메시지를 보내 현재 모드 값을 요청합니다.
    return Send_ImeControl(DefaultIMEWnd, IMC_GETCONVERSIONMODE, 0) ; lParam은 0으로 전달
}

; --- IME 제어 메시지를 보내는 도우미 함수 ---
Send_ImeControl(DefaultIMEWnd, wParam, lParam) {
    global WM_IME_CONTROL
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows, ON ; 숨겨진 IME 창과 통신하기 위해 잠시 켭니다.

    ; SendMessage 실행, v1에서는 결과가 ErrorLevel 변수에 저장됩니다.
    SendMessage, %WM_IME_CONTROL%, %wParam%, %lParam%,, ahk_id %DefaultIMEWnd%
    returnValue := ErrorLevel ; ErrorLevel 값을 변수에 저장

    ; 원래 DetectHiddenWindows 설정을 복원합니다.
    if (DetectSave <> A_DetectHiddenWindows)
        DetectHiddenWindows, %DetectSave%

    ; SendMessage가 실패하면 ErrorLevel에 "FAIL" 문자열이 들어갑니다.
    if (returnValue = "FAIL") {
        return -1 ; 실패 시 오류 (-1) 반환
    }
    ; 성공 시, IME로부터 받은 모드 값을 반환합니다.
    return returnValue
}

; --- 기본 IME 창 핸들을 가져오는 도우미 함수 ---
ImmGetDefaultIMEWnd(hWnd) {
    ; DllCall에서 핸들(포인터)을 반환받을 때는 "UPtr" 또는 "Ptr" 타입을 사용합니다. (v1 기준)
    return DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hWnd, "UPtr") ; UPtr 사용 권장
}

; --- 툴팁 제거용 함수 (디버깅 툴팁 사용 시 필요) ---
RemoveToolTip:
    ToolTip
    return

; --- 스크립트 종료 단축키 (선택 사항) ---
^!x::ExitApp ; Ctrl+Alt+X 를 누르면 스크립트를 종료합니다.
