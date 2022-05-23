*** Settings ***
Library     Collections
Library     ../../Core/RequestManager.py
Resource    ../../Resources/api/common.robot
Resource    ../../Resources/api/workspace_steps.robot
Resource    ../../Resources/api/board_steps.robot
Resource    ../../Resources/api/list_steps.robot

Suite Setup     Starting API session
Suite Teardown  Closing API session

Test Teardown   Delete a workspace  ${id_organization}

*** Variables ***
${id_organization}     ${EMPTY}
${organizations_endpoint}  organizations
${boards_endpoint}         boards
${lists_endpoint}          lists

*** Test Cases ***
Verify that a list can be created in a Board
    [Tags]  smoke       functional
    ${id_organization}  ${id_board}=    Create a board
    ${list_name}=         Set Variable        AUT List
    ${body}=              Create dictionary   name=${list_name}
    ${actual_response}=   Send request  POST  ${boards_endpoint}/${id_board}/${lists_endpoint}    ${body}

    # Create the expected response.
    ${expected_response}   Read expected json  create_list_response.json
    Set to dictionary  ${expected_response}   id         ${actual_response.json()["id"]}
    Set to dictionary  ${expected_response}   name       ${list_name}
    Set to dictionary  ${expected_response}   idBoard    ${id_board}

    # Validations.
    Verify status code      ${actual_response}     200
    Verify schema           ${actual_response}     create_list_schema.json
    Verify body response    ${actual_response}     ${expected_response}

Verify that a list can be archived
    [Tags]  functional
    ${id_organization}   ${id_board}=       Create a board
    ${list_name}=        Set Variable       AUT List 1
    ${id_list}=          Create a list on a board  ${id_organization}   ${id_board}     ${list_name}
    ${body}=             Create Dictionary  value=true
    ${endpoint}=         Set Variable  ${lists_endpoint}/${id_list}/closed
    ${actual_response}=  Send request  PUT  ${endpoint}    ${body}

    # Create the expected response.
    ${expected_response}   Read expected json  archive_list_response.json
    Set to dictionary  ${expected_response}   id         ${id_list}
    Set to dictionary  ${expected_response}   name       ${list_name}
    Set to dictionary  ${expected_response}   idBoard    ${id_board}

    # Validations.
    Verify status code      ${actual_response}     200
    Verify schema           ${actual_response}     archive_or_unarchive_list_schema.json
    Verify body response    ${actual_response}     ${expected_response}
