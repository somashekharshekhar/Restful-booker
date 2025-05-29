*** Settings ***
Resource          ../resources/booking_keywords.robot
Library           OperatingSystem
Library           Collections

Suite Setup       Initialize Session

*** Variables ***
${LOG_FILE}       ./output/log.html

*** Test Cases ***
Generate 3 New Bookings
    ${testdata1}=    Evaluate    dict(firstname="Test1", lastname="User", totalprice=500, depositpaid=True, bookingdates={"checkin": "2025-05-28", "checkout": "2025-05-31"}, additionalneeds="Lunch")
    ${testdata2}=    Evaluate    dict(firstname="Test2", lastname="User", totalprice=1000, depositpaid=False, bookingdates={"checkin": "2025-05-29", "checkout": "2025-06-10"})
    ${testdata3}=    Evaluate    dict(firstname="Test3", lastname="User", totalprice=700, depositpaid=True, bookingdates={"checkin": "2025-05-29", "checkout": "2025-06-20"}, additionalneeds="Dinner")

    ${booking1}=    Create Booking    ${testdata1}
    ${booking2}=    Create Booking    ${testdata2}
    ${booking3}=    Create Booking    ${testdata3}

    ${all_ids}=     Get All Booking IDs
    log to console  ${all_ids}

    Set Suite Variable    ${ID1}    ${booking1['bookingid']}
    Set Suite Variable    ${ID2}    ${booking2['bookingid']}
    Set Suite Variable    ${ID3}    ${booking3['bookingid']}
    log to console  ${ID1}
    log to console  ${ID2}
    log to console  ${ID3}

Modify Booking Prices
    ${testdata1_updated}=    Evaluate    dict(firstname="Test1", lastname="User", totalprice=1000, depositpaid=True, bookingdates={"checkin": "2025-05-28", "checkout": "2025-05-31"}, additionalneeds="Lunch")
    ${testdata2_updated}=    Evaluate    dict(firstname="Test2", lastname="User", totalprice=1500, depositpaid=False, bookingdates={"checkin": "2025-05-29", "checkout": "2025-06-10"})

    ${resp1}=    Update Booking    ${ID1}    ${testdata1_updated}
    ${resp2}=    Update Booking    ${ID2}    ${testdata2_updated}

    log to console  ${resp1}
    log to console  ${resp2}

Delete One Booking
    ${delete_resp}=    Delete Booking    ${ID3}
    log to console    Deleted Booking ID: ${ID3} Status: ${delete_resp.status_code}


