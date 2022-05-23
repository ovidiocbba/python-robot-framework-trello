*** Settings ***
Library     Collections
Library     ../../Core/RequestManager.py
Resource    ../../Resources/api/common.robot
Resource    ../../Resources/api/workspace_steps.robot

Suite Setup     Starting API session
Suite Teardown  Closing API session

*** Variables ***
${organizations_endpoint}     organizations

*** Test Cases ***
Verify that a workspace can be created
    [Tags]  smoke       functional
    ${workspace_name}=      Set Variable            AUT Workspace 1
    ${body}=                Create dictionary       displayName=${workspace_name}
    ${actual_response}      Send request  POST  ${organizations_endpoint}  ${body}

    # Create the expected response.
    ${expected_response}    Read expected json    create_workspace_response.json
    ${id_organization}=     Set Variable          ${actual_response.json()['id']}
    Set to dictionary  ${expected_response}   id            ${id_organization}
    Set to dictionary  ${expected_response}   displayName   ${workspace_name}

    # Validations.
    Verify status code      ${actual_response}     200
    Verify schema           ${actual_response}     create_workspace_schema.json
    Verify body response    ${actual_response}     ${expected_response}

    # Circling verification.
    ${workspace_response}    Get information about a workspace     ${id_organization}
    Verify body response    ${workspace_response}   ${expected_response}

    # Delete Workspace previously created.
    Delete a workspace      ${id_organization}

Verify that a Workspace can't be created with an empty display name
    [Tags]  negative
    ${body}=                Create dictionary       displayName=${EMPTY}
    ${actual_response}      Send request  POST  ${organizations_endpoint}  ${body}

    # Create the expected response.
    ${expected_response}    Read expected json    error_empty_display_name_respone.json

    # Validations.
    Verify status code      ${actual_response}     400
    Verify schema           ${actual_response}     error_response_schema.json
    Verify body response    ${actual_response}     ${expected_response}
