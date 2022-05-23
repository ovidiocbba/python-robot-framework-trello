*** Settings ***
Library     Collections
Library     String
Library     ../../Core/RequestManager.py

*** Variables ***
${cards_endpoint}        cards
${attachments_endpoint}  attachments

*** Keywords ***
Get an Attachment on a Card
    [Arguments]     ${id_card}      ${id_attachment}
    ${endpoint}=    Set Variable  ${cards_endpoint}/${id_card}/${attachments_endpoint}/${id_attachment}
    ${response}     Send request  GET  ${endpoint}
    [return]    ${response}
