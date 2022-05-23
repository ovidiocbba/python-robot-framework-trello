*** Settings ***
Library     Collections
Library     ../../Core/RequestManager.py
Resource    ../../Resources/api/common.robot
Resource    ../../Resources/api/workspace_steps.robot
Resource    ../../Resources/api/board_steps.robot

Suite Setup     Starting API session
Suite Teardown  Closing API session

Test Teardown   Delete a workspace  ${id_organization}

*** Variables ***
${id_organization}     ${EMPTY}
${boards_endpoint}     boards

*** Test Cases ***
Verify that a board can be created in a workspace
    [Tags]  smoke       functional
    ${id_organization}=    Create a workspace
    ${board_name}=         Set Variable        AUT Board 1
    ${body}=               Create dictionary   idOrganization=${id_organization}   name=${board_name}
    ${actual_response}=    Send request  POST      ${boards_endpoint}      ${body}

    # Create the expected response.
    ${expected_response}   Read expected json    create_board_response.json
    ${id_board}=           Set Variable        ${actual_response.json()["id"]}
    Set to dictionary  ${expected_response}   id                ${id_board}
    Set to dictionary  ${expected_response}   name              ${board_name}
    Set to dictionary  ${expected_response}   idOrganization    ${id_organization}

    # Validations.
    Verify status code      ${actual_response}     200
    Verify schema           ${actual_response}     create_board_schema.json
    Verify body response    ${actual_response}     ${expected_response}

    # Circling verification.
    ${board_response}       Get a Board          ${id_board}
    Verify body response    ${board_response}    ${expected_response}

Create a new Board with one character for the name
    [Tags]  acceptance
    ${board_name}=         Set Variable        A
    ${id_organization}  ${id_board}  ${actual_response}=    Create a board with the following name   ${board_name}

    # Create the expected response.
    ${expected_response}   Read expected json    create_board_response.json
    ${id_board}=           Set Variable        ${actual_response.json()["id"]}
    Set to dictionary  ${expected_response}   id                ${id_board}
    Set to dictionary  ${expected_response}   name              ${board_name}
    Set to dictionary  ${expected_response}   idOrganization    ${id_organization}

    # Validations.
    Verify status code      ${actual_response}     200
    Verify schema           ${actual_response}     create_board_schema.json
    Verify body response    ${actual_response}     ${expected_response}

    # Circling verification.
    ${board_response}       Get a Board          ${id_board}
    Verify body response    ${board_response}    ${expected_response}
