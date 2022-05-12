*** Settings ***
Documentation       Google Translate song lyris from source to target language.
...                 Saves the original and the translated lyrics as text files.
Library             RPA.Browser.Selenium

*** Keywords ***
Get lyrics
    Open Available Browser    https://www.lyrics.com/lyrics/Peaches
    Click Element If Visible    css:.best-matches a

*** Keywords ***
Translate
    No Operation 

*** Keywords ***
Save lyrics
    No Operation 


*** Tasks ***
Google Translate song lyris from source to target language
   Get lyrics
   Translate
   Save lyrics
