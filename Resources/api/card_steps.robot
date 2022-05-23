*** Settings ***
Library     Collections
Library     String
Library     ../../Core/RequestManager.py

*** Variables ***
${cards_endpoint}      cards

*** Keywords ***
Create a card
    [Arguments]     ${id_list}        ${card_name}
    ${body}=             Create dictionary   idList=${id_list}   name=${card_name}
    ${actual_response}=  Send request  POST      ${cards_endpoint}      ${body}
    ${id_card}=          Set Variable        ${actual_response.json()['id']}
    [return]  ${id_card}

Get a card
    [Arguments]     ${id_card}
    ${response}     Send request  GET  ${cards_endpoint}/${id_card}
    [return]    ${response}

