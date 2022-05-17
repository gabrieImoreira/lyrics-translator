*** Settings ***
Documentation       Google Translate song lyris from source to target language.
...                 Saves the original and the translated lyrics as text files.
Library             RPA.Browser.Selenium    #auto_close=${FALSE}
Library             OperatingSystem
Library             String

*** Variables ***
${SONG_NAME}=    %{SONG_NAME=Mistério - Mc Kevin}
${SOURCE_LANG}=    %{SOURCE_LANG=pt}
${TARGET_LANG}=    %{TARGET_LANG=en}
${ORIGINAL_FILE}=    ${OUTPUT_DIR}${/}${SONG_NAME}-${SOURCE_LANG}-original.txt
${TRANSLATION_FILE}=    ${OUTPUT_DIR}${/}${SONG_NAME}-${TARGET_LANG}-translation.txt


*** Keywords ***
Get lyrics
    Open Available Browser    https://m.letras.mus.br/?q=${SONG_NAME}
    Click Element If Visible    xpath=//*[@id="___gcse_0"]/div/div/div/div[5]/div[2]/div/div/div[1]/div[1]/div[1]/div[1]/div/a
    ${lyrics_element}=    Set Variable    xpath=//*[@id="js-lyric-cnt"]/article/div[2]/div[2]
    Wait Until Element Is Visible    ${lyrics_element}
    ${lyrics}=    Get Text    ${lyrics_element}
    [Return]    ${lyrics}


*** Keywords ***
Translate
    [Arguments]    ${lyrics}
    ${lyrics}=    Replace String    ${lyrics}  \n    %0A  
    Go To    https://translate.google.com.br/?hl=pt-BR&sl=${SOURCE_LANG}&tl=${TARGET_LANG}&text=${lyrics}&op=translate
    ${translate_element}=    Set Variable    xpath=//*[@id="yDmH0d"]/c-wiz/div/div[2]/c-wiz/div[2]/c-wiz/div[1]/div[2]/div[3]/c-wiz[2]/div[8]/div/div[1]
    Wait Until Element Is Visible    ${translate_element}
    ${translation}=    Get Text    ${translate_element}
    [Return]    ${translation}
    

*** Keywords ***
Save lyrics
    [Arguments]    ${lyrics}    ${translation}
    Create File    ${ORIGINAL_FILE}    ${lyrics}
    Create File    ${TRANSLATION_FILE}    ${translation}


*** Tasks ***
Google Translate song lyris from source to target language
   ${lyrics}=    Get lyrics
   ${translation}=    Translate    ${lyrics}
   Save lyrics    ${lyrics}    ${translation}
