import hre from "hardhat";

async function main() {

    const verifierIncome = await hre.viem.deployContract("VerifierIncome");

    console.log(
        "VerifierIncome deployed to:",
        verifierIncome.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
