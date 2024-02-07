#!/bin/bash

# Define the base directory for ZoKrates verifications
BASE_DIR="zokrates"

# Define verification types for which to export verifiers
VERIFICATIONS=("income" "assets" "debtIncomeRatio" "accreditedInvestor")

# Loop through each verification type
for VERIFICATION in "${VERIFICATIONS[@]}"
do
    echo "Exporting verifier for ${VERIFICATION}..."

    # Navigate to the verification directory
    cd ${BASE_DIR}/${VERIFICATION}

    # Use ZoKrates to generate the Solidity verifier contract
    zokrates export-verifier -i out/verification.key -o ../../contracts/Verifier${VERIFICATION^}.sol

    # Rename the contract to match the naming convention
    sed -i "s/contract Verifier /contract Verifier${VERIFICATION^} /g" ../../contracts/Verifier${VERIFICATION^}.sol

    # Navigate back to the base directory
    cd ../..

    echo "Verifier for ${VERIFICATION} exported successfully."
    echo ""
done

echo "All verifiers have been exported."
