#!/bin/bash
echo 'Running generate_proof'

# Navigate to the ZoKrates program directory
cd zokrates

# List of verifications
VERIFICATIONS=("income" "assets" "debtIncomeRatio" "accreditedInvestor")

# Generate proof for each verification
for VERIFICATION in "${VERIFICATIONS[@]}"
do
    echo "Generating proof for ${VERIFICATION}..."
    zokrates generate-proof -i ${VERIFICATION}/compiled/${VERIFICATION}.out -w ${VERIFICATION}/out/${VERIFICATION}.witness -j ${VERIFICATION}/out/proof.json -p ${VERIFICATION}/out/proving.key
done

echo "Proof generation completed."
