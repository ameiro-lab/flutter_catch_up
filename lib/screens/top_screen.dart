import 'package:flutter/material.dart';
import 'todo_list_screen.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(    // Scaffold は Flutter が提供する、マテリアルデザインの画面レイアウトの骨組みウィジェット
      // appBar: AppBar(
      //   title: const Text('Top Screen'),
      // ),
      body: Center(
        child: ElevatedButton(  // マテリアルデザインに基づいた立体的なボタンウィジェット
          onPressed: () {       // 押下時のイベントを設定
            Navigator.push(     // Navigatorを用いて、新しい画面（ルート）をスタックに追加、遷移を実行する
              context,          // Navigatorがルートを探すために必須
              MaterialPageRoute(// マテリアルデザイン風の画面遷移（スライドイン）を提供するルートクラス
                builder: (context) => const TodoListScreen()),  // 遷移先のウィジェットを生成する。TodoListScreen を指定
            );
          },
          child: const Text('TODOリストへ進む'),
        ),
      ),
    );
  }
}
