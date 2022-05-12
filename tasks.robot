*** Settings ***
Documentation       Google Translate song lyris from source to target language.
...                 Saves the original and the translated lyrics as text files.
Library             RPA.Browser.Selenium    auto_close=${FALSE}

*** Keywords ***
Get lyrics
    Open Available Browser    https://www.lyrics.com/lyrics/Peaches
    Click Element If Visible    css:.best-matches a
    ${lyrics_element}=    Set Variable    id:lyric-body-text
    Wait Until Element Is Visible    ${lyrics_element}
    Sleep    5
    ${lyrics}=    Get Text    ${lyrics_element}
    [Return]    ${lyrics}


*** Keywords ***
Translate
    [Arguments]    ${lyrics}
    Go To    https://translate.google.com.br/?hl=pt-BR&sl=en&tl=pt&text=${lyrics}
    ${translate_element}=    Set Variable    css.:Q4iAWc
    Wait Until Element Is Visible    ${translate_element}
    ${translation}=    Get Text    ${translate_element}
    [Return] ${translation}
    

*** Keywords ***
Save lyrics
    No Operation 

*** Tasks ***
Google Translate song lyris from source to target language
   ${lyrics}=    Get lyrics
   ${translation}=    Translate    ${lyrics}
   Save lyrics
