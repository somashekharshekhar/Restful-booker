*** Settings ***
Library           RequestsLibrary
Library           OperatingSystem
Library           Collections
Library           ../utils/logger.py

*** Variables ***
${BASE_URL}       https://restful-booker.herokuapp.com
@{BOOKINGS}
${SESSION}        booking

*** Keywords ***
Initialize Session
    Create Session    ${SESSION}    ${BASE_URL}

Create Booking
    [Arguments]    ${payload}
    ${response}=    POST On Session    ${SESSION}    /booking    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    [Return]    ${response.json()}

Get All Booking IDs
    ${response}=    GET On Session    ${SESSION}    /booking
    ${ids}=    Evaluate    [item['bookingid'] for item in ${response.json()}]
    [Return]    ${ids}

Update Booking
    [Arguments]    ${booking_id}    ${payload}
    ${token_response}=    Create Auth Token
    ${token}=    Set Variable    ${token_response['token']}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    PUT On Session    ${SESSION}    /booking/${booking_id}    headers=${headers}    json=${payload}
    [Return]    ${response}

Create Auth Token
    ${data}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST On Session    ${SESSION}    /auth    json=${data}
    [Return]    ${response.json()}
