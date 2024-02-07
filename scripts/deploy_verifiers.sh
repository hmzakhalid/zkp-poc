#!/bin/bash

# Define an array of deployment script names
DEPLOY_SCRIPTS=("deployVerifierIncome.ts" "deployVerifierAssets.ts" "deployVerifierDebtIncomeRatio.ts" "deployVerifierAccreditedInvestor.ts")

# Navigate to the hardhat project directory
cd ../

# Loop through and execute each deployment script
for SCRIPT in "${DEPLOY_SCRIPTS[@]}"
do
  echo "Deploying ${SCRIPT%.*}..."
  npx hardhat run scripts/${SCRIPT}
done

echo "Deployment completed."
