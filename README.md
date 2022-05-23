# Python-Robot-Framework-Trello

# Setup Instructions
## Python Setup

This project requires Python 3.10 or higher.
You can download the latest Python version from [Python.org](https://www.python.org/downloads/).
```zsh
python --version
```
This project also requires [pipenv](https://docs.pipenv.org/).
To install pipenv, run the following command from the command line:
```zsh
 pip install pipenv
```
Check if it was installed correctly
```zsh
pipenv --version
```
You should also have a Python editor/IDE of your choice.
Good choices include [PyCharm](https://www.jetbrains.com/pycharm/)
and [Visual Studio Code](https://code.visualstudio.com/docs/languages/python).

You will also need [Git](https://git-scm.com/) to copy this project code.

## Initialize project
```zsh
# Activate virtualenv
pipenv shell
# Install all dependencies in your virtualenv
pipenv install
```

## Run tests
Environment examples:
- development
- testing
- staging
- production

```zsh
robot -d Results --variable environment:testing Test/
```
Tags examples:
- smoke
- acceptance
- functional
- e2e
- negative
- boundary
 
```zsh
robot -d Results --variable environment:testing --include=functional Test/
```
