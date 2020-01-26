import 'package:carrot_club_app/configs/NetworkCall.dart';
import 'package:carrot_club_app/configs/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier{
  int messageCounter = 0;
  List receivedMessages = new List();
  String rewardPoints;

  addMessage(tittle, orderId, body){
    print("received");
    receivedMessages.add({"title": tittle, "body": body, "orderId": orderId});
    print(receivedMessages);
    notifyListeners();
  }

  incrementCounter() async{
    messageCounter++;
    getRewardPoints();
  }

  resetCounter() {
    messageCounter = 0;
    notifyListeners();
  }

  getRewardPoints() async {
    Dio dio = NetworkCall().getDio();
    Response response = await dio
        .get("${Env.environment['baseUrl']}/orders/calculate_reward_points");
    rewardPoints = response.data.toString();
    notifyListeners();
  }
}