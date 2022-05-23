*** Settings ***
Library     Collections
Library     String
Library     ../../Core/RequestManager.py

*** Variables ***
${organizations_endpoint}  organizations
${boards_endpoint}         boards
${lists_endpoint}          lists

*** Keywords ***
Create a workspace
    ${random_string}        Generate Random String  4  [NUMBERS]
    ${workspace_name}=      Set Variable        AUT Workspace ${random_string}
    ${body}=        Create dictionary       displayName=${workspace_name}
    ${response}  Send request  POST  ${organizations_endpoint}  ${body}
    ${id_organization}=     Set Variable        ${response.json()['id']}
    [return]  ${id_organization}

Get information about a workspace
    [Arguments]     ${id_organization}
    ${response}     Send request  GET  ${organizations_endpoint}/${id_organization}
    [return]    ${response}

Delete a workspace
    [Arguments]     ${id_organization}
    Send request     DELETE      ${organizations_endpoint}/${id_organization}
