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

# Test cases
List of test cases implemented in the Framework.
<table>
  <tr>
    <th>Test case</th>
    <th>Title</th>
    <th>Area</th>
    <th>Tag</th>
  </tr>
  <tr>
    <td><b>TC-00001</b></td>
    <td>Verify that a workspace can be created</td>
    <td><code>workspace</code></td>
    <td align = 'center'><code> smoke, functional</code></td>
  </tr>
  <tr>
    <td><b>TC-00002</b></td>
    <td>Verify that a Workspace can't be created with an empty display name</td>
    <td><code>workspace</code></td>
    <td align = 'center'><code>negative</code></td>
  </tr>
  <tr>
    <td><b>TC-00003</b></td>
    <td>Verify that a board can be created in a workspace</td>
    <td><code>board</code></td>
    <td align = 'center'><code>smoke, functional</code></td>
  </tr>
  <tr>
    <td><b>TC-00004</b></td>
    <td>Create a new Board with one character for the name</td>
    <td><code>board</code></td>
    <td align = 'center'><code>acceptance</code></td>
  </tr>
  <tr>
    <td><b>TC-00005</b></td>
    <td>Verify that a list can be created in a Board</td>
    <td><code>list</code></td>
    <td align = 'center'><code>smoke, functional</code></td>
  </tr>
  <tr>
    <td><b>TC-00006</b></td>
    <td>Verify that a list can be archived</td>
    <td><code>list</code></td>
    <td align = 'center'><code>functional</code></td>
  </tr>
  <tr>
    <td><b>TC-00007</b></td>
    <td>Verify that a card can be created</td>
    <td><code>card</code></td>
    <td align = 'center'><code>functional</code></td>
  </tr>
  <tr>
    <td><b>TC-00008</b></td>
    <td>Verify that a card can be moved to another list</td>
    <td><code>card</code></td>
    <td align = 'center'><code>e2e</code></td>
  </tr>
  <tr>
    <td><b>TC-00009</b></td>
    <td>Verify that an attachment with a 256-character name can be created on a Card</td>
    <td><code>card</code></td>
    <td align = 'center'><code>boundary</code></td>
  </tr>
  <!--Footer section-->
  <tr>
    <td align = 'center' colspan="3"><b>Total</b></td>
    <td align = 'center'>9</td>
  </tr>
</table>