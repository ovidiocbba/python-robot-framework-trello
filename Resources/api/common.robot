*** Settings ***
Resource    ../../global_resource.robot
Library     ../../Core/RequestManager.py
Library     OperatingSystem
Library     jsonschema

*** Keywords ***
Starting API session
    Set Url        ${base_url}      ${credentials}

Closing API session
    Close Session

Read expected json
    [Arguments]  ${json_filename}
    ${body}     Get Binary File  ./Resources/api/json/${json_filename}
    ${body}     evaluate    json.loads('''${body}''')    json
    [return]  ${body}

# Validations.
Verify schema
    [Arguments]     ${response}     ${schema_filename}
    ${schema}  Get Binary File  ./Resources/api/schemas/${schema_filename}
    ${schema}  evaluate  json.loads('''${schema}''')    json
    Validate  instance=${response.json()}  schema=${schema}

Verify body response
    [Arguments]  ${response}  ${body_filename}
    Dictionary Should Contain Sub Dictionary  ${response.json()}  ${body_filename}

Verify status code
    [Arguments]     ${response}     ${expected_status_code}
    ${actual_status_code}=     Convert to string       ${response.status_code}
    Should be equal as strings      ${actual_status_code}       ${expected_status_code}
