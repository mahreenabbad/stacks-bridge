import {
  Cl,
  principalToString,
  Pc,
  boolCV,
  cvToValue,
  principalCV,
  makeContractCall,
  standardPrincipalCV,
  stringAsciiCV,
  createStacksPrivateKey,
  makeRandomPrivKey,
  getPublicKey,
  makeContractDeploy,
  broadcastTransaction,
  contractPrincipalCV,
  uintCV,
  callReadOnlyFunction,
  PostConditionMode,
  bufferCVFromString,
  bufferCV,
  someCV,
  FungibleConditionCode,
  makeContractFungiblePostCondition,
  makeStandardSTXPostCondition,
  makeContractSTXPostCondition,
} from "@stacks/transactions";
// import { STACKS_TESTNET } from "@stacks/network";
import { readFileSync } from "fs";
import { generateWallet, generateNewAccount } from "@stacks/wallet-sdk";
const iSTX = contractPrincipalCV(
  "STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV",
  "i-stx"
);
const wToken = contractPrincipalCV(
  "STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV",
  "w-token"
);

const nToken = contractPrincipalCV(
  "STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV",
  "n-token"
);
////////////////////////////////////////
//ADD token

// const postCondition = Pc.principal("STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV")
//   .willSendGte(100000000)
//   .ft("STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV.token-x010", "xtoken");
// const postCondition1 = Pc.principal("STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV")
//   .willSendGte(100000000)
//   .ft("STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV.token-y010", "ytoken");

const token = bufferCVFromString(0xe0f992c2dac5a9210fe5265acab51a023ed39218); // 36-byte buffer

const type = uintCV(300); // Token type
const minFee = uintCV(10);
const txOptions = {
  contractAddress: "STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV",
  contractName: "bridge",
  functionName: "add-token",
  functionArgs: [wToken, token, type, minFee],
  //   postConditions: [postCondition, postCondition1],
  PostConditionMode: PostConditionMode.Allow,
  senderKey:
    "3a020135ad063d66f11c1b6e1e1d2b2a46cf99e721dde23c70463dca132eaaec01",

  network: "testnet",
  fee: 20000n,
  validateWithAbi: true,
};

// console.log("txOpt-ions :", txOptions);
async function callAddtoPosition() {
  try {
    // Create and broadcast the transaction

    const transaction = await makeContractCall(txOptions);
    // console.log("Transaction:", transaction);
    const response = await broadcastTransaction(transaction, "testnet");
    console.log("Response:", response);
    // console.log("Function Args:", txOptions.functionArgs);
  } catch (error) {
    console.error("Error during transaction execution:", error);
  }
}
callAddtoPosition();
