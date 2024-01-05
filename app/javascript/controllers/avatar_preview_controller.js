// stimulusのControllerクラスをインポートすることを宣言
import { Controller } from "stimulus"
// 他のファイルからこのコントローラをインポートできるようにすることを宣言
export default class extends Controller {
  // コントローラが操作するDOM要素を定義。これによりコントローラ内でthis.inputTargetとthis.previewTargetを使用して特定のDOM要素を参照できる
  static targets = ["input", "preview"]

  //previewImageメソッドを定義
  previewImage() {
    // 作成しているコントローラ内で使用するためにinput, preview, targetを定義
    const input = this.inputTarget
    const preview = this.previewTarget
    // input.filesはユーザーが選択したファイルのリスト
    const files = input.files

    // files[0]は最初のファイルを参照する
    if (files && files[0]) {
      // readerをFileReaderオブジェクトとして定義
      const reader = new FileReader()
      // 画像が読み込まれる(e)とreader.onloadイベントが発火する
      // reader.onloadは「ファイルの読み込みが完了したら次に何をするか」という指示をするもの
      reader.onload = (e) => {
        // 発火する内容を定義
        preview.innerHTML = `<img src="${e.target.result}" style="max-width: 300px;">`
      }
      reader.readAsDataURL(files[0])
    }
  }
}
