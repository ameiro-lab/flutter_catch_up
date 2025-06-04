import 'package:flutter/material.dart';

/// 使いまわし可能な確認モーダルの定義
/// 
/// showメソッド呼出でモーダルを表示、ユーザーの選択（はい／いいえ）を待つ。
/// 
class DialogConfirm {

  /// モーダルを表示するメソッド
  ///
  /// [context] ダイアログを表示するためのビルドコンテキスト。
  /// [title] ダイアログのタイトルテキスト。
  /// [content] ダイアログの本文テキスト。
  ///
  /// 戻り値：
  ///   - ユーザーが「はい」を選択した場合は true、
  ///   - 「いいえ」を選択した場合は false、
  ///   - ダイアログを閉じた場合は null。
  static Future<bool?> show(
    BuildContext context, {
    required String title,    // ダイアログのタイトルテキスト
    required String content,  // ダイアログの本文テキスト
  }) {
    return showDialog<bool>(  // ユーザーの選択（反応）を Future<bool?> として非同期的に待つ、モーダルウェジット
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('いいえ'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('はい'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }
}
