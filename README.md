# Financial Verification ZKP

This project demonstrates financial verifications using Zero-Knowledge Proofs with ZoKrates.

## Structure

- **contracts/**: Solidity verifier contracts for each verification type.
- **zokrates/**: ZoKrates programs for financial verifications.
- **scripts/**: Utility scripts for compiling, setting up, and deploying.

## Getting Started

Follow the instructions below to set up and run the POC.

 - Compile ZoKrates programs `scripts/compile.sh`
 - Setup the Keys `scripts/setup.sh`
 - Export the Verifier Contracts `scripts/export_verifiers.sh`
 - Deploy the Verifier Contracts `npx hardhat run scripts/deployVerifierAccreditedInvestor.ts`
 - Compute a Witness `scripts/compute_witness.sh accreditedInvestor <income> <netWorth>`
 - Generate a Proof `scripts/generate_proof.sh`
 - Verify the Proof `npx hardhat run scripts/verifyAccreditedInvestorProof.ts`
