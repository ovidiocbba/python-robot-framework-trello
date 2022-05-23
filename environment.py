def get_variables(environment):
    if environment == 'development':
        data = {
            'credentials': {
                "key": "",
                "token": ""
            },
            'base_url': 'https://api.trello.com/1/'
        }
    elif environment == 'testing':
        data = {
            'credentials': {
                "key": ".......",
                "token": "....................."
            },
            'base_url': 'https://api.trello.com/1/'
        }
    elif environment == 'staging':
        data = {
            'credentials': {
                "key": "",
                "token": ""
            },
            'base_url': 'https://api.trello.com/1/'
        }
    elif environment == 'production':
        data = {
            'credentials': {
                "key": "",
                "token": ""
            },
            'base_url': 'https://api.trello.com/1/'
        }

    return data
