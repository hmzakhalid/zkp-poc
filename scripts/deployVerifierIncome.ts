import hre from "hardhat";
import fs from "fs";

async function main() {

    const verifierIncome = await hre.viem.deployContract("VerifierIncome");

    console.log(
        "VerifierIncome deployed to:",
        verifierIncome.address);

    const verifierIncomeArtifact = await hre.artifacts.readArtifact("VerifierIncome");

    const verifierIncomeAddress = verifierIncome.address;

    const verifierIncomeData = {
        address: verifierIncomeAddress,
        abi: verifierIncomeArtifact.abi,
    };

    const verifierIncomeDataString = JSON.stringify(verifierIncomeData, null, 2);
    const path = "config/verifierIncomeData.json";

    fs.writeFileSync(
        path,
        verifierIncomeDataString
    );

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
