#Requires AutoHotkey v2.0  ; 이 스크립트는 v2 환경에서 실행되어야 함을 명시해요.

;====================================
; Hotkey 정의 부분
;====================================

; $ 접두사는 Esc 키의 원래 기능을 막고 우리가 정의한 새 기능을 사용하게 해줘요.
$Esc::
{
    ; 현재 활성 창의 입력 모드가 한글인지 확인하는 함수를 호출해요.
    if IsHangulMode("A") ; "A"는 현재 활성 창(Active window)을 의미해요.
    {
        Send("{Esc}")      ; Send 명령어를 함수처럼 Send() 로 사용해요.
        Send("{vk15}")     ; vk15는 한/영 전환 키의 가상 키 코드예요. 한글 모드일 때 Esc 누르고 한/영 키 누르기! 🇰🇷 -> 🇺🇸
        ; Tooltip("Esc: 한글 모드 감지 -> Esc + 한/영 전환 전송") ; 테스트용 툴팁
        ; SetTimer () => Tooltip(), -1000
    }
    else
    {
        Send("{Esc}")      ; 영어 모드일 때는 그냥 Esc 키만 눌러요. 🇺🇸
        ; Tooltip("Esc: 영어 모드 감지 -> Esc 전송") ; 테스트용 툴팁
        ; SetTimer () => Tooltip(), -1000
    }
    return ; Hotkey의 실행을 여기서 마칩니다.
}

; Ctrl + [ 를 누르면 영어 입력 모드로 전환하는 Hotkey
^[:: ; '^'는 Ctrl 키를 의미해요. '['는 문자 그대로 [ 키를 의미하고요.
{
    ; 현재 활성 창이 한글 입력 모드인지 확인해요.
    if IsHangulMode("A")
    {
        ; 한글 모드라면, 한/영 전환 키(vk15)를 눌러 영어로 바꿔요.
        Send("{vk15}")
        ; Tooltip("Ctrl+[: 한글 -> 영어 전환!") ; 테스트용 툴팁
        ; SetTimer () => Tooltip(), -1000
    }
    ; else ; 영어 모드일 때는 아무것도 할 필요가 없어요. 이미 영어니까요! 😄
    ; {
    ;     Tooltip("Ctrl+[: 이미 영어 모드!") ; 테스트용 툴팁
    ;     SetTimer () => Tooltip(), -1000
    ; }
    return ; Hotkey 실행을 여기서 마칩니다.
}

;====================================
; Helper 함수 정의 부분 (이전과 동일)
;====================================

; 특정 창의 입력 모드가 한글인지 확인하는 함수예요.
IsHangulMode(WinTitle) {
    hWnd := WinGetID(WinTitle) ; v1의 WinGet, , ID 와 비슷해요. 창의 고유 ID(HWND)를 가져와요.
    if !hWnd ; 창 ID를 가져오지 못하면 그냥 영어 모드로 간주해요 (오류 방지).
        return false

    defaultIMEWnd := ImmGetDefaultIMEWnd(hWnd) ; 해당 창의 기본 입력기(IME) 창 핸들을 가져와요.
    if !defaultIMEWnd ; IME 핸들을 못 가져오면 영어 모드로 간주해요.
        return false

    ; 입력기 제어 관련 메시지 및 상태 값 정의 (가독성을 위해!)
    WM_IME_CONTROL := 0x283         ; IME 제어 메시지 번호
    IMC_GETCONVERSIONMODE := 0x005  ; 현재 변환 모드(한글/영어 등)를 가져오는 명령
    IME_CMODE_NATIVE := 0x1         ; 네이티브 모드 (한글 같은 자국어 입력 모드) 플래그 값

    ; IME 창에 메시지를 보내 현재 변환 모드를 얻어와요.
    conversionMode := SendImeMessage(defaultIMEWnd, WM_IME_CONTROL, IMC_GETCONVERSIONMODE, 0)

    ; 반환된 값(conversionMode)과 한글 모드 플래그(IME_CMODE_NATIVE)를 비교해요.
    ; 비트 단위 AND(&) 연산을 사용해서, 결과에 한글 모드 비트가 켜져 있는지 확인해요.
    return (conversionMode & IME_CMODE_NATIVE) != 0
}

; IME 창에 안전하게 메시지를 보내는 도우미 함수예요.
SendImeMessage(targetWnd, msg, wParam, lParam) {
    DetectSave := A_DetectHiddenWindows ; 현재 숨겨진 창 감지 설정을 저장해요.
    DetectHiddenWindows(true)           ; 숨겨진 창도 감지하도록 설정을 잠시 켜요 (IME 창이 숨겨져 있을 수 있어서!). v1의 DetectHiddenWindows, On 과 같아요.
    ; SendMessage 함수로 targetWnd 핸들을 가진 창에 메시지를 보내요.
    result := SendMessage(msg, wParam, lParam, , targetWnd)
    DetectHiddenWindows(DetectSave)     ; 원래 설정으로 되돌려 놓아요. v1의 DetectHiddenWindows, %DetectSave% 와 같아요.
    Return result                       ; SendMessage의 결과를 반환해요 (여기서는 conversionMode 값).
}

; 창 핸들(hWnd)을 이용해 기본 IME 창 핸들을 얻는 함수예요 (WinAPI 호출).
ImmGetDefaultIMEWnd(hWnd) {
    ; DllCall 함수를 사용해 Windows API(imm32.dll 라이브러리의 ImmGetDefaultIMEWnd 함수)를 호출해요.
    Return DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hWnd, "Ptr")
}