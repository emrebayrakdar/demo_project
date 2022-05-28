import 'package:demo_project/base/model/base_view_model.dart';
import 'package:demo_project/ui/views/dashboard/model/dashboard_model.dart';
import 'package:flutter/material.dart';

class DashboardViewModel extends BaseViewModel {
//#region #init's

//#endregion

//#region #variable's
  final formKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  List<GameModel> gameList = [];

//#endregion

//#region #override's
  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init(State? s) {
    gameList.addAll([
      GameModel(gameId: 1, gameName: "Trivia", gamePath: "assets/images/f1.png"),
      GameModel(gameId: 2, gameName: "Çarkıfelek", gamePath: "assets/images/f2.png"),
      GameModel(gameId: 3, gameName: "Others-3", gamePath: "assets/images/f1.png"),
      GameModel(gameId: 4, gameName: "Others-4", gamePath: "assets/images/f2.png"),
      GameModel(gameId: 5, gameName: "Others-5", gamePath: "assets/images/f1.png"),
      GameModel(gameId: 6, gameName: "Others-6", gamePath: "assets/images/f2.png"),
      GameModel(gameId: 7, gameName: "Others-7", gamePath: "assets/images/f1.png"),
      GameModel(gameId: 8, gameName: "Others-8", gamePath: "assets/images/f2.png"),
      GameModel(gameId: 9, gameName: "Others-9", gamePath: "assets/images/f1.png"),
      GameModel(gameId: 10, gameName: "Others-10", gamePath: "assets/images/f2.png"),
      GameModel(gameId: 11, gameName: "Others-11", gamePath: "assets/images/f1.png"),
      GameModel(gameId: 12, gameName: "Others-12", gamePath: "assets/images/f2.png"),
      GameModel(gameId: 13, gameName: "Others-13", gamePath: "assets/images/f1.png"),
      GameModel(gameId: 14, gameName: "Others-14", gamePath: "assets/images/f2.png"),
    ]);
  }

//#endregion

//#region #methods's

//#endregion
}
