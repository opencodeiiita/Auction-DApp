import 'package:flutter/material.dart';

class ContractLinking extends ChangeNotifier {

  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey = " Private Key :) ";

  Web3Client _client;

  String _abiCode;
  EthereumAddress _contractAddress;

  ContractFunction _bidderName;
  ContractFunction _bidAmount;
  ContractFunction _minAmount;
  ContractFunction _setBidder;
  ContractFunction _minBid;
}


