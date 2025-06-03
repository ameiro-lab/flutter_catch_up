/// タスクDTOクラス
class Todo {
  String title;       // タスクのタイトル
  bool isDone;        // タスクが完了しているかどうか

  // コンストラクタ：タイトルを必須とし、完了状態は初期値false
  Todo({
    required this.title,
    this.isDone = false,
  });

  // 完了状態を反転させるメソッド（完了 ⇔ 未完了 を切り替える）
  void toggleDone() {
    isDone = !isDone;
  }
}
