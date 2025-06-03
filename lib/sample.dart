// 名称を main.dartにすること！
import 'package:flutter/material.dart';

//
// Flutter アプリのエントリーポイント
void main() => runApp(const CounterApp());  // runApp は、Flutter にウィジェットツリーのルートを渡す関数
// void main() {
//   runApp(const CounterApp());
// }


//
// 静的ウィジェットクラス（状態を持たない静的UI）の定義
//
class CounterApp extends StatelessWidget {
  // StatelessWidget は「状態を持たない」ウィジェットのベースクラス（静的 UI 向け）
  /// 継承することで、状態を持たない（不変な）ウィジェットとして定義される。
  /// StatelessWidgetは一度作成されると内部データが変更されることがなく、
  /// パフォーマンスが良く、シンプルな構造を持つ。

  // コンストラクタ
  const CounterApp({super.key});  // key は Flutter がウィジェットの差分検出を行うときに使う識別子
  // const CounterApp({Key? key}) : super(key: key);

  // build メソッド =>  ウィジェットの UI（Widget ツリー）を構築する。毎回呼ばれる。
  // StatelessWidget の場合はこのウィジェット自身に build を定義する
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterPage(),  // アプリ起動時に最初に表示される画面を指定
      debugShowCheckedModeBanner: false,  // DEBUG 表示バナーを非表示にする
    );
  }
}

//
// 動的ウィジェットクラス（状態を持つ動的UI）の定義
//
class CounterPage extends StatefulWidget {
  // StatefulWidget は「状態を持つ」ウィジェットのベースクラス（動的 UI 向け）
  // カウンターの値のように、ユーザー操作に応じて変化する情報を扱う場合に使用

  const CounterPage({super.key});

  // createState メソッドは、状態（State）を管理するクラス（_CounterPageState）のインスタンスを作成する
  // CounterPage が持つ UI の状態を、_CounterPageState に指定
  @override
  State<CounterPage> createState() => _CounterPageState();
}


//
// 状態を管理するためのクラス定義（React でいうところの useフック）
// CounterPage に紐づく State クラス の定義
class _CounterPageState extends State<CounterPage> {

  // データを定義
  int _count = 0; // カウントの状態を保持する変数

  // イベント関数を定義
  // カウントを 1 増やすメソッド
  void _increment() => setState(() => _count++);
  // void _increment() {
  //   setState(() {
  //     _count++;
  //   });
  // }

// カウントを 1 減らすメソッド
  void _decrement() => setState(() {  
    // 0以下にはならないように制御
    if (_count > 0) _count--;
  });
  // void _decrement() {
  //   setState(() {
  //     if (_count > 0) {
  //       _count--;
  //     }
  //   });
  // }

  // UI を構築するメソッド（毎回呼ばれる => 状態が変わるたびに再実行される）
  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Scaffoldは、基本的なレイアウト構造（ヘッダーや本文、ボタンなどの配置枠組み）を提供する土台ウィジェット

      // 上部に AppBar を設定する。
      appBar: AppBar(title: const Text('カウントアプリ')),  // タイトル部分に Textウィジェット を設定する

      // 中央に 子要素 を設定する。
      body: Center(
        child: Text('$_count', style: const TextStyle(fontSize: 64)), // 子要素に Textウィジェット を設定する
      ),

      // 右下に 配置する2つのボタン（＋と−）
      floatingActionButton: Row(  // FloatingActionButton は内部的に Hero ウィジェットでラップされている。
                                  //  => 本来 floatingActionButton: は単一のウィジェット（通常1ボタン）しか受け付けない設計だった。
                                  //  複数ボタンを置くためには、Row を包んで1つの Widget として渡すという工夫が必要。
        mainAxisAlignment: MainAxisAlignment.center,  // 
        children: [
          // − ボタン（カウントダウン）
          FloatingActionButton(
            onPressed: _decrement,  // 押下時のイベントを設定
            heroTag: 'decrement',   // 同じWidgetツリー（今回は Row 内）で FloatingActionButton を複数使っているから heroTag が必要
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),  // ボタンの間隔を空ける

          // ＋ ボタン（カウントアップ）
          FloatingActionButton(
            onPressed: _increment,  // 押下時のイベントを設定 を複数配置する場合、各ボタンで一意の heroTag が必要
            heroTag: 'increment',   // 同じWidgetツリー（今回は Row 内）で FloatingActionButton を複数使っているから heroTag が必要
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
