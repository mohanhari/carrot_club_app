import 'package:carrot_club_app/configs/NetworkCall.dart';
import 'package:carrot_club_app/configs/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RewardPointDetails extends StatefulWidget {
  final String orderId;

  RewardPointDetails(this.orderId);
  @override
  _RewardPointDetailsState createState() => _RewardPointDetailsState();
}

class _RewardPointDetailsState extends State<RewardPointDetails> {
  var data;

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  void _getData() async{
    Response response;
    Dio dio = NetworkCall().getDio();
    response = await dio.get("${Env.environment['baseUrl']}/orders/${widget.orderId}/reward_points");
    setState(() {
      data = response.data;
    });
    print(data);
  }

  Widget _buildRowDetails(name, value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(width: 10.0,),
        Expanded(
          child: Text(
            value,
          ),
        )
      ],
    );
  }

  DataRow _getDataRow(result) {
    return DataRow(
      cells: [
        DataCell(
          Text(result["item_name"])
        ),
        DataCell(
          Text(result["quantity"].toString())
        ),
        DataCell(
          Text(result["reward_points"].toString())
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reward Point Details'),
      ),
      body: Container(
        child: data == null ? Center(child: CircularProgressIndicator()) : Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Your Reward Points',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Divider(thickness: 2,),
                  SizedBox(height: 15.0,),
                  _buildRowDetails('Store Name:', data["store_name"]),
                  SizedBox(height: 10.0,),
                  _buildRowDetails('Bill No:', data["bill_no"].toString()),
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: data["items"].length == 0 ? Text('There is no Data to display'): DataTable(
                            columnSpacing: 10.0,
                            horizontalMargin: 5,
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20
                                  )
                                )
                              ),
                              DataColumn(
                                label: Text(
                                    'Quantity',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20
                                    )
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                    'Reward Points',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20
                                    )
                                ),
                                numeric: true
                              )
                            ],
                            rows: List.generate(
                                data["items"].length, (index) => _getDataRow(data["items"][index])),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Total Reward Points',
                  style: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(width: 10.0,),
                Text(
                  data["total_reward_points"].toString(),
                )
              ],
            ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
