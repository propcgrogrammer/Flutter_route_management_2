import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '保單列表',
    home: PolicyList(
      policys: [
        new Policy('心安逸一年定期住院日額健康保險', '醫療險', '定期', '低保費、強化短期住院醫療保障'),
        new Policy('逸定安心住院醫療定期健康保險', '醫療險', '定期', '強化住院與法定傳染病保障'),
        new Policy('好安安醫療終身保險', '醫療險', '終身',
            '低保費、含多項住院及手術給付、168項特定處置、8項手術自費醫材補助、身故保障'),
        new Policy('新GO心保障100定期壽險', '壽險', '定期', '承保年齡廣，高CP值壽險'),
        new Policy('貸貸有福平準型定期壽險', '壽險', '定期', '房貸專屬保險，固定保障額度，保障更完整'),
        new Policy('鑫美利101利率變動型美元終身壽險 (定期給付型)', '壽險', '終身',
            '投保後即享高保障倍數、身故保險金可採分期定期給付，滿足遺族照顧需求'),
        new Policy(
            '好全方位傷害保險附約', '意外險', '定期', '0歲70歲可承保，特定意外身故，保障加倍給付、16級失能提供每月生活補助金'),
        new Policy('享Fun假傷害保險', '意外險', '定期', '假日意外保障升級'),
      ],
    ),
  ));
}

class Policy {
// 險種名稱
  String name;
// 類型: 壽險 / 醫療險 / 意外險 / 長照險
  String type;
// 型態: 終身 / 定期
  String kind;
// 商品內容
  String detail;

  Policy(this.name, this.type, this.kind, this.detail);
}

class PolicyList extends StatelessWidget {
  List<Policy> policys;
  PolicyList({Key? key, required this.policys}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('保單列表'),
        ),
        body: new ListView.builder(
          itemCount: policys.length,
          itemBuilder: (context, index) {
            return new ListTile(
              title: new Text(policys[index].name),
// 靜態無回傳值使用
// onTap: () {
// Navigator.push(
// context,
// new MaterialPageRoute(
// builder: (context) =>
// new PolicyDetail(policy: policys[index])));
// }

              // 接受回傳值
              onTap: () async {
                // 頁面回傳值
                String result = await Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new PolicyDetail(policy: policys[index])));
                if (result != null) {
                  Scaffold.of(context).showSnackBar(
                    new SnackBar(
                      content: new Text('$result'),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              },
            );
          },
        ));
  }
}

class PolicyDetail extends StatelessWidget {
  Policy policy;
  PolicyDetail({Key? key, required this.policy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('${policy.name}'),
      ),
      body: Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Text(
                '${policy.name}\n${policy.type}\n${policy.kind}\n${policy.detail}'),
          ),
          new RaisedButton(
            onPressed: () {
              Navigator.pop(context, '${policy.name}');
            },
            child: Text('進行投保'),
          )
        ],
      ),
    );
  }
}
