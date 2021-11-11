*** Settings ***
Library     Collections
Resource    ../requests/clients/CreateClient.robot
Resource    ../requests/clients/ListClients.robot
Resource    ../requests/clients/GetClient.robot
Resource    ../requests/clients/UpdateClient.robot
Resource    ../requests/clients/DeleteClient.robot
Resource    ../requests/Authentication.robot
Suite Setup    suite setup


*** Keywords ***
suite setup
    ${token}        Authentication.Get Token for    mifos       password
    set suite variable    ${tkn}        ${token}

create client and get id
    [Arguments]    ${oid}   ${fn}   ${ln}
    ${res}      CreateClient.create an inactive client    ${oid}   ${fn}   ${ln}        ${tkn}
    ${id}   CreateClient.resource id from ${res}
    [Return]    ${id}

*** Test Cases ***
Client created should be in client list
    ${office_id}        set variable    1
    ${first_name}       set variable    clientfn1
    ${last_name}       set variable    clientln1

#    Create the client
    ${id}   create client and get id    ${office_id}         ${first_name}       ${last_name}

#    List the clients
    ${clients}      ListClients.list clients    ${tkn}
    ${fn_in_list}   ListClients.get first name of client with id of ${id} from ${clients}
    ${ln_in_list}   ListClients.get last name of client with id of ${id} from ${clients}

    run keyword and continue on failure    should be equal    ${fn_in_list}     ${first_name}
    run keyword and continue on failure    should be equal    ${ln_in_list}     ${last_name}

Created client details should be correct
    ${office_id}        set variable    1
    ${first_name}       set variable    clientfn2
    ${last_name}       set variable    clientln2

#    Create the client
    ${id}   create client and get id    ${office_id}         ${first_name}       ${last_name}

#    Get client details
    ${client_details}       GetClient.get client    ${id}       ${tkn}
    ${fn_from_details}      GetClient.get first name from ${client_details}
    ${ln_from_details}      GetClient.get last name from ${client_details}
    ${oid_from_details}      GetClient.get office id from ${client_details}

    run keyword and continue on failure    should be equal      ${fn_from_details}       ${first_name}
    run keyword and continue on failure    should be equal      ${ln_from_details}       ${last_name}
    run keyword and continue on failure    should be equal      ${oid_from_details}         ${office_id}

User can update client details
    ${office_id}        set variable    1
    ${first_name}       set variable    clientfn3
    ${last_name}       set variable    clientln3
    ${new_last_name}        set variable    newclientln3

    #    Create the client
    ${id}   create client and get id    ${office_id}         ${first_name}       ${last_name}


    #   Update a client last name
    ${body}     set variable    {'firstname':'${first_name}','lastname':'${new_last_name}'}
    UpdateClient.update client    ${id}     ${body}     ${tkn}

    #    Get client details
    ${res}     GetClient.get client    ${id}    ${tkn}
    ${updated_last_name}     GetClient.get last name from ${res}
    should be equal     ${new_last_name}        ${updated_last_name}

Deleted client should no longer be in the list of clients
    ${office_id}        set variable    1
    ${first_name}       set variable    clientfn4
    ${last_name}       set variable    clientln4

    #    Create the client
    ${id}   create client and get id    ${office_id}         ${first_name}       ${last_name}

    #    Delete Create client
    delete client    ${id}    ${tkn}

    #    Get client list
    ${clients}      ListClients.list clients    ${tkn}
    ${ids_in_list}      ListClients.get all resource ids for ${clients}

    #    Check if the id of the deleted client is no longer in the client list
    ${value}        convert to integer    ${id}
    list should not contain value    ${ids_in_list}     ${value}


User should not be able to update a client that was deleted
    ${office_id}        set variable    1
    ${first_name}       set variable    clientfn5
    ${last_name}       set variable    clientln5
    ${new_last_name}        set variable    newclientln5

    #    Create the client
    ${id}   create client and get id    ${office_id}         ${first_name}       ${last_name}

    #    Delete Create client
    delete client    ${id}    ${tkn}

    #     Update deleted client
    ${body}     set variable    {'firstname':'${first_name}','lastname':'${new_last_name}'}
    ${res}      UpdateClient.update deleted client    ${id}     ${body}     ${tkn}
    ${developer_message}        UpdateClient.get error message from ${res}
    should be equal     The requested resource is not available.        ${developer_message}