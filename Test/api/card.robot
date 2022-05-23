*** Settings ***
Library     Collections
Library     ../../Core/RequestManager.py
Resource    ../../Resources/api/common.robot
Resource    ../../Resources/api/workspace_steps.robot
Resource    ../../Resources/api/board_steps.robot
Resource    ../../Resources/api/list_steps.robot
Resource    ../../Resources/api/card_steps.robot
Resource    ../../Resources/api/attachment_steps.robot

Suite Setup     Starting API session
Suite Teardown  Closing API session

Test Teardown   Delete a workspace  ${id_organization}

*** Variables ***
${id_organization}     ${EMPTY}
${cards_endpoint}      cards

*** Test Cases ***
Verify that a card can be created
    [Tags]  functional
    ${id_organization}   ${id_board}=       Create a board
    ${list_name}=        Set Variable       AUT List 1
    ${id_list}=          Create a list on a board  ${id_organization}   ${id_board}     ${list_name}
    ${card_name}=        Set Variable       AUT Card 1
    ${body}=             Create dictionary  idList=${id_list}   name=${card_name}
    ${actual_response}=  Send request  POST     ${cards_endpoint}      ${body}

    # Create the expected response.
    ${expected_response}   Read expected json    create_or_update_card_response.json
    ${id_card}=     Set Variable          ${actual_response.json()["id"]}
    Set to dictionary  ${expected_response}   id        ${id_card}
    Set to dictionary  ${expected_response}   name      ${card_name}
    Set to dictionary  ${expected_response}   idBoard   ${id_board}
    Set to dictionary  ${expected_response}   idList    ${id_list}
    Set to dictionary  ${expected_response}   url       ${actual_response.json()["url"]}

    # Validations.
    Verify status code      ${actual_response}     200
    Verify schema           ${actual_response}     create_card_schema.json
    Verify body response    ${actual_response}     ${expected_response}

    # Circling verification.
    ${card_response}        Get a card          ${id_card}
    Verify body response    ${card_response}    ${expected_response}

Verify that a card can be moved to another list
    [Tags]  e2e
    ${id_organization}   ${id_board}=       Create a board
    # Create the list 1.
    ${list_name_1}=      Set Variable       AUT List 1
    ${id_list_1}=        Create a list on a board  ${id_organization}   ${id_board}     ${list_name_1}
    # Add a card to the list 1.
    ${card_name}=        Set Variable       AUT Card 1
    ${id_card}=          Create a card  ${id_list_1}    ${card_name}

    # Create the list 2.
    ${list_name_2}=      Set Variable       AUT List 2
    ${id_list_2}=        Create a list on a board  ${id_organization}   ${id_board}     ${list_name_2}
    # Move the card from the list 1 to the list 2.
    ${body}=             Create dictionary  idList=${id_list_2}
    ${endpoint}=         Set Variable       ${cards_endpoint}/${id_card}
    ${actual_response}=  Send request  PUT  ${endpoint}     ${body}

    # Create the expected response.
    ${expected_response}   Read expected json    create_or_update_card_response.json
    Set to dictionary  ${expected_response}   id        ${id_card}
    Set to dictionary  ${expected_response}   name      ${card_name}
    Set to dictionary  ${expected_response}   idBoard   ${id_board}
    Set to dictionary  ${expected_response}   idList    ${id_list_2}
    Set to dictionary  ${expected_response}   url       ${actual_response.json()["url"]}

    # Validations.
    Verify status code      ${actual_response}     200
    Verify schema           ${actual_response}     update_card_schema.json
    Verify body response    ${actual_response}     ${expected_response}

    # Circling verification.
    ${card_response}        Get a card          ${id_card}
    Verify body response    ${card_response}    ${expected_response}

Verify that an attachment with a 256-character name can be created on a Card
    [Tags]  boundary
    ${id_organization}   ${id_board}=       Create a board
    ${list_name}=      Set Variable       AUT List 1
    ${id_list}=        Create a list on a board  ${id_organization}   ${id_board}     ${list_name}
    # Add a card to the list
    ${card_name}=      Set Variable       AUT Card 1
    ${id_card}=        Create a card  ${id_list}    ${card_name}

    ${random_attachment_name}=     Generate Random String  256  [LETTERS]
    ${attachment_url}=   Set Variable  https://blog.trello.com/hubfs/Cars-covers-and-colors-2%20%281%29.png
    ${body}=             Create dictionary  name=${random_attachment_name}  url=${attachment_url}
    ${endpoint}=         Set Variable       ${cards_endpoint}/${id_card}/attachments
    ${actual_response}=  Send request       POST     ${endpoint}      ${body}

    # Create the expected response.
    ${expected_response}  Read expected json    create_an_attachment_for_a_board.json
    ${id_attachment}=     Set Variable          ${actual_response.json()["id"]}
    Set to dictionary  ${expected_response}   id        ${id_attachment}
    Set to dictionary  ${expected_response}   url       ${actual_response.json()["url"]}
    Set to dictionary  ${expected_response}   fileName  ${actual_response.json()["fileName"]}
    Set to dictionary  ${expected_response}   bytes     ${actual_response.json()["bytes"]}
    Set to dictionary  ${expected_response}   pos       ${actual_response.json()["pos"]}

    # Validations.
    Verify status code      ${actual_response}     200
    Verify schema           ${actual_response}     create_an_attachment_for_a_board_schema.json
    Verify body response    ${actual_response}     ${expected_response}

    # Circling verification.
    ${card_response}        Get an Attachment on a Card          ${id_card}     ${id_attachment}
    Verify body response    ${card_response}    ${expected_response}
