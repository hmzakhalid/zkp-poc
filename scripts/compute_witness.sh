#!/bin/bash

# Check if at least two arguments are provided (verification type and one input)
if [ $# -lt 2 ]; then
    echo "Usage: $0 <verification_type> <input1> [input2] ..."
    echo "Example: $0 income 50000"
    exit 1
fi

# First argument is the verification type
VERIFICATION_TYPE=$1

# Remove the first argument and keep the rest as inputs
shift
INPUTS=("$@")

# Navigate to the ZoKrates program directory for the given verification type
cd zokrates/${VERIFICATION_TYPE}

# Prepare the inputs for the compute-witness command
INPUT_ARGS=""
for INPUT in "${INPUTS[@]}"; do
    INPUT_ARGS+="-a ${INPUT} "
done

# Compute the witness using the provided inputs
echo "Computing witness for ${VERIFICATION_TYPE} verification with inputs: ${INPUTS[*]}..."
zokrates compute-witness -i compiled/${VERIFICATION_TYPE}.out ${INPUT_ARGS} -o out/${VERIFICATION_TYPE}.witness --circom-witness out/${VERIFICATION_TYPE}.wtns

echo "Witness computation completed for ${VERIFICATION_TYPE}."
