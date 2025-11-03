#! /bin/bash
set -e

# Expects Environment variables:
# TF_VAR_FILES: ${{ inputs.var-files }}
# TF_VARS: ${{ inputs.vars }}
# REQUIRE_APPROVAL: ${{ inputs.require-approval }}
# APPROVERS: ${{ inputs.required-approvers }}
# WORKING_DIRECTORY: ${{ inputs.working-directory }}

# Writes github outputs if GITHUB_ACTIONS is set (this is set automatically by github actions)
# Outputs:
# tfvar-files: -var-file file1.tfvars -var-file file2.tfvars
# tfvars: -var value1=abc -var value2={"map_key": "map_value"}
# require-approval: true | false
# required-approvers: username1,username2 | empty

main() {
    assert_inputs_are_valid "$@"
    assign_outputs
}

assert_inputs_are_valid() {

    if [[ "${REQUIRE_APPROVAL^^}" == 'TRUE' ]]; then
        if [[ -z ${APPROVERS+x} ]]; then
            echo '`required-approvers` must be set to a list of approvers when `require-approval` is enabled.'
            exit 1
        fi
    fi

    if [[ "${INIT_VARS_ENABLED^^}" != 'TRUE' ]] && [[ "${INIT_VARS_ENABLED^^}" != 'FALSE' ]]; then
        echo "Invalid value \"${INIT_VARS_ENABLED}\" set for `init-vars-enabled`. Valid values are true or false."
        exit 1
    fi

    if [[ -n ${WORKING_DIRECTORY+x} ]]; then
        if [[ ! -d "$WORKING_DIRECTORY" ]]; then
            echo "Working Directory '$WORKING_DIRECTORY' not found. Input \`working-directory\` must be set to a valid directory."
            exit 1
        fi
    fi
}

trim() {
    local _var_to_trim="$*"
    # remove leading whitespace characters
    var="${_var_to_trim#"${_var_to_trim%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${_var_to_trim%"${_var_to_trim##*[![:space:]]}"}"
    printf '%s' "$_var_to_trim"
}

output_value() {
    local _output_name="$1"
    local _output_value="${@:2}"

    if [[ -z ${GITHUB_ACTIONS+x} ]]; then
        # If not in a workflow, replace the dashes and export with an uppercase variable name
        export_name="${_output_name/-/_}"
        export ${export_name^^}="$_output_value"
    else
        echo $_output_name="$_output_value" >> $GITHUB_OUTPUT
    fi
}

assign_outputs() {
    local _var_files=()
    local _var_file_line
    local _var_values=()
    local _var_line
    if [[ -n "${TF_VAR_FILES}" ]]; then
        while read _var_file_line; do
            local _var_file=$(trim "$_var_file_line")
            _var_files+=(-var-file "$_var_file")
        done <<< "$TF_VAR_FILES"
        output_value 'tfvar-files' "${_var_files[@]}"
    fi
    
    if [[ -n "${TF_VARS}" ]]; then
        while read _var_line; do
            local _var_value=$(trim "$_var_line")
            _var_values+=("-var $_var_value")
        done <<< "$TF_VARS"
        output_value 'tfvars' "${_var_values[@]}"
    fi

    if [[ -z ${INIT_VARS_ENABLED+x} ]]; then
        output_value 'init-vars-enabled' '.'
    else
        output_value 'init-vars-enabled' "$INIT_VARS_ENABLED"
    fi

    if [[ -z ${REQUIRE_APPROVAL+x} ]]; then
        output_value 'require-approval' "false"
    else
        output_value 'require-approval' "$REQUIRE_APPROVAL"
    fi

    if [[ -z ${APPROVERS+x} ]]; then
        output_value 'required-approvers' ''
    else
        output_value 'required-approvers' "$APPROVERS"
    fi

    if [[ -z ${WORKING_DIRECTORY+x} ]]; then
        output_value 'working-directory' '.'
    else
        output_value 'working-directory' "$WORKING_DIRECTORY"
    fi
}

main "$@"