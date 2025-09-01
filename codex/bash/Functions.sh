# bash, functions, ensure dependency, check if command exists, local, command, direct echo to stderr

function ensure_dependency () {
    local tool=$1
    echo " * Checking for dependency: $tool"
    if ! command -v "$tool" &> /dev/null; then
        echo "Error: $tool is not installed or in PATH" >&2
        exit 1
    fi
}

ensure_dependency "curl"
echo "Yay! You have curl!"
