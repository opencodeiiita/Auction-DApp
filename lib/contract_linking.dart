import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey = " Private Key :) ";

  Web3Client _client;

  String _abiCode;
  EthereumAddress _contractAddress;
  EthereumAddress _ownerAddress;

  Credentials _credentials;
  DeployedContract _contract;

  ContractFunction _bidderName;
  ContractFunction _bidAmount;
  ContractFunction _minAmount;
  ContractFunction _setBidder;
  ContractFunction _minBid;

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiFile = await rootBundle.loadString("src/artifacts/Bidder.json");
    var jsonAbi = jsonDecode(abiFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
      EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }


  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownerAddress = await _credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "Bidder"), _contractAddress);

    _bidderName = _contract.function("bidderName");
    _bidAmount = _contract.function("bidAmount");
    _minAmount = _contract.function("minBid");
    _setBidder = _contract.function("setBidder");
  }

  getBidderData() async {
    List name = await _client
        .call(contract: _contract, function: _bidderName, params: []);
    List amount = await _client
        .call(contract: _contract, function: _bidAmount, params: []);
    List min = await _client
        .call(contract: _contract, function: _minAmount, params: []);
    List eligibility = await _client
        .call(contract: _contract, function: _displayEligibility, params: []);

    bidderName = name[0];
    bidAmount = amount[0];
    }
}


