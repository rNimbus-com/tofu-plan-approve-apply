#! /bin/bash
set -e

if [[ -z "$1" ]]; then
    echo "ERROR: Step number argument is required." >&2
    echo "         usage: ./print_step.sh {step_number}" >&2
    exit 1
fi

step_number=$1

case $step_number in
    1)
        echo "🔬 Validate and Parse Inputs"
        ;;
    2)
        echo "🟨 Tofu Init"
        ;;
    3)
        echo "🟨 Tofu Validate"
        ;;
    4)
        echo "🟨 Tofu Plan"
        ;;
    6)
        echo "🟨 Tofu Apply"
        ;;
    7)
        echo "🧾Job Summary"
        ;;
    *)
        echo "WARN: Unknown step number $$step_number. Valid values: [1, 2, 3, 4, 6, 7]."
        ;;
esac