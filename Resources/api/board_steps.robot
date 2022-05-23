*** Settings ***
Library     Collections
Library     String
Library     ../../Core/RequestManager.py
Resource    ../../Resources/api/workspace_steps.robot

*** Variables ***
${boards_endpoint}         boards
${lists_endpoint}          lists

*** Keywords ***
Create a board
    ${random_string}     Generate Random String  3  [NUMBERS]
    ${board_name}=       Set Variable        AUT Board ${random_string}
    ${id_organization}  ${id_board}  ${actual_response}=    Create a board with the following name  ${board_name}
    [return]  ${id_organization}  ${id_board}

Create a board with the following name
    [Arguments]     ${board_name}
    ${id_organization}=  Create a workspace
    ${body}=             Create dictionary   idOrganization=${id_organization}   name=${board_name}
    ${actual_response}=         Send request  POST      ${boards_endpoint}      ${body}
    ${id_board}=         Set Variable        ${actual_response.json()['id']}
    [return]  ${id_organization}  ${id_board}   ${actual_response}

Get a Board
    [Arguments]     ${id_board}
    ${response}     Send request  GET  ${boards_endpoint}/${id_board}
    [return]    ${response}
