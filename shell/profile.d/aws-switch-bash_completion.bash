#/usr/bin/env bash

_aws-switch_completions()
{
    if [ "${#COMP_WORDS[@]}" != "2" ]; then
        return
    fi
    COMPREPLY=($(compgen -W "$( grep '\[profile' ~/.aws/config | awk '{sub(/]/, "", $2); print $2}' | while read -r profile; do echo -n "$profile "; done )" -- "${COMP_WORDS[1]}" ))
}

complete -F _aws-switch_completions aws-switch 



#compdef aws-switch
#description Switch the AWS profile

#_aws-switch() {
#
#    local -a aws_profiles
#
#    aws_profiles=$( \
#        grep '\[profile' ~/.aws/config \
#        | awk '{sub(/]/, "", $2); print $2}' \
#        | while read -r profile; do echo -n "$profile "; done \
#    )
#
#    _arguments \
#        ':Aws profile:($(echo ${aws_profiles}) clear)'
#}
#
#_aws-switch "$@"
