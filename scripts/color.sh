#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
nc=$(tput sgr0) # No Color


highlightOutput()
{
    cat <<EOF
${yellow}>> ${1} ${3}: ${2} <<${nc}
EOF
}

printBlockStartOutput()
{
    cat <<EOF
${blue}>> ${1} <<${nc}
EOF
}


printBlockFinishOutput()
{
    cat <<EOF
${green}<< ${1}! >>${nc}
EOF
}

printInsideBlockOutput()
{
    cat <<EOF
${yellow}--> ${1}${nc}
EOF
}

printBlockErrort()
{
    cat <<EOF
${red}ERROR: ${1}${nc}
EOF
}

printImportantMessage()
{
    cat <<EOF
${red}IMPORTANT: ${1}${nc}
EOF
}