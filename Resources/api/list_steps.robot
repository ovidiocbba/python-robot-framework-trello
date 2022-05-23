*** Settings ***
Library     Collections
Library     String
Library     ../../Core/RequestManager.py

*** Variables ***
${boards_endpoint}         boards
${lists_endpoint}          lists

*** Keywords ***
Create a list on a board
    [Arguments]     ${id_organization}      ${id_board}     ${list_name}
    ${body}=             Create dictionary   name=${list_name}
    ${endpoint}=         Set Variable  ${boards_endpoint}/${id_board}/${lists_endpoint}
    ${actual_response}=  Send request  POST     ${endpoint}     ${body}
    ${id_list}=          Set Variable        ${actual_response.json()['id']}
    [return]  ${id_list}
