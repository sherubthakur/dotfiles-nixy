function dce() {
    docker-compose exec $1 /bin/bash -c "$2"
}

function dcpytest() {
    docker-compose exec $1 /bin/bash -c 'pytest'
}

function dcpytestcov() {
    docker-compose exec $1 /bin/bash -c 'pytest --cov='$2
}

function dcpytestcovhtml() {
    docker-compose exec $1 /bin/bash -c 'pytest --cov-report html --cov='$2
}

function dcpytestlf() {
    docker-compose exec $1 /bin/bash -c 'pytest --lf'
}

function dcpytestni() {
    docker-compose exec $1 /bin/bash -c "pytest -m 'not integration'"
}

function dcpytestnicov() {
    docker-compose exec $1 /bin/bash -c "pytest --cov='$2' -m 'not integration'"
}

function dcpytestnicovhtml() {
    docker-compose exec $1 /bin/bash -c "pytest -m 'not integartion' --cov-report html --cov='$2'"
}

function gfix() {
    git commit --fixup=$1
    git rebase -i --autosquash $1~1
}

function gstashnfix() {
    git commit --fixup=$1
    git stash
    git rebase -i --autosquash $1~1
    git stash pop
} 

# Clean up python project of cache and stuff
function pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

# Recursive execution
function recursive() {
    for d in ./*/ ; do /bin/zsh -c "(cd "$d" && "$@")"; done
}

function recursivep() {
    for d in ./*/ ; do /bin/zsh -c "(cd "$d" && "$@") &"; done
}
