#!/bin/bash
echo 'Running generate_proof'

# Navigate to the ZoKrates program directory
SCRIPT_DIR=$(dirname "$0")
cd "${SCRIPT_DIR}/../zokrates"

# List of verifications
VERIFICATIONS=("accreditedInvestor")

# Generate proof for each verification
for VERIFICATION in "${VERIFICATIONS[@]}"
do
    echo "Generating proof for ${VERIFICATION}..."
    zokrates generate-proof -i ${VERIFICATION}/compiled/${VERIFICATION}.out -w ${VERIFICATION}/out/${VERIFICATION}.witness -j ${VERIFICATION}/out/proof.json -p ${VERIFICATION}/out/proving.key
done

echo "Proof generation completed."
