
import 'package:flutter/material.dart';
import 'package:random_api/helper/internetcheckhelper.dart';
import 'package:random_api/helper/internetcheckuihelper.dart';
import 'package:random_api/models/randommodel.dart' as rum;

class RandomPage extends StatefulWidget {
  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  Future<bool> _internetOn;

  @override
  void initState() {
    super.initState();
    _internetOn = checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildInternetBody(),
    );
  }

  Widget _buildInternetBody() {
    return buildInternetChecking(internetOn: _internetOn, body: _buildBody());
  }

  _buildBody() {
    String url = "https://randomuser.me/api/?results=10";
    return Container(
      color: Colors.white,
      child: FutureBuilder<rum.RandomUserModel>(
        future: rum.getData(url),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          if(snapshot.connectionState == ConnectionState.done){
            print(snapshot.connectionState);
            if(snapshot.hasData){
              print(snapshot.data);
              rum.RandomUserModel randomUserModel = snapshot.data;
              return _buildListView(randomUserModel.results);
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
          else{
            print(snapshot.connectionState);
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  _buildListView(List<rum.Result> resultList){
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: resultList.length,
          itemBuilder: (context, index){
            return _buidListViewItem(resultList[index]);
          }),
    );
  }

  _buidListViewItem(rum.Result result) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: Column(
        children: <Widget>[
          CircleAvatar(),

          Container(
            height: 150.0,
            child: Image.network(result.picture.medium,fit: BoxFit.cover,),
          ),
          Text('${result.name.title} ${result.name.first} ${result.name.last}'),
          Text(result.phone),

        ],
      ),
    );
  }


}




