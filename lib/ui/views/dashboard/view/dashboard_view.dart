import 'package:demo_project/base/view/view_model_builder.dart';
import 'package:demo_project/ui/_products/shared/ui_helpers.dart';
import 'package:demo_project/ui/views/dashboard/viewmodel/dashboard_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Widget homePage(DashboardViewModel viewModel, Size size) {
    return Scrollbar(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: viewModel.gameList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var currentItem = viewModel.gameList[index];
            return Column(children: <Widget>[
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    currentItem.gameName!,
                    style: const TextStyle(fontSize: FontSizeValue.LARGE, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Image.asset(
                  currentItem.gamePath!,
                  fit: BoxFit.cover,
                  width: 100.0,
                ),
                onTap: () async {
                },
              )
            ]);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.withoutConsumer(
      viewModelBuilder: () => DashboardViewModel(),
      onInitState: (viewModel) {
        viewModel.setContext(context);
        viewModel.init(this);
      },
      onPageBuilder: (context, viewModel, child, size) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF1B1D1D),
            actions: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                      color: const Color.fromRGBO(255, 255, 255, 0.10000000149011612),
                      border: Border.all(color: const Color(0xFFA6F5EC), width: 1),
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/g_11.png"),
                        const Text("500 c"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.asset("assets/images/g_516.png", color: Colors.white),
                  const SizedBox(width: 20),
                  Image.asset("assets/images/g_484.png", color: Colors.white),
                  const SizedBox(width: 20)
                ],
              )
            ],
          ),
          body: IndexedStack(
            index: viewModel.selectedIndex,
            children: [
              homePage(viewModel, size),
              const Center(child: Text("Takım")),
              const Center(child: Text("Lig")),
              const Center(child: Text("Market")),
              const Center(child: Text("Oyunlar"))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.selectedIndex,
            onTap: (index) {
              _onItemTapped(viewModel, index);
            },
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Anasayfa'),
              BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Takım'),
              BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Ligler'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Market'),
              BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded), label: 'Ligler'),
            ],
          ),
        );
      },
    );
  }

  void _onItemTapped(DashboardViewModel viewModel, int index) {

    setState(() {
      viewModel.selectedIndex = index;
    });
  }
}
