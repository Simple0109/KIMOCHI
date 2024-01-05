// StimulusのApplicationクラスをインポート
import { Application } from "stimulus";

// 個々のStimulusコントローラーをインポート
import AvatarPreviewController from "./controllers/avatar_preview_controller";

// Stimulusのアプリケーションインスタンスを作成
const application = Application.start();

// コントローラーをStimulusアプリケーションに登録
application.register("avatar-preview", AvatarPreviewController);

// 他のコントローラーがあれば、以下のように追加
// import AnotherController from "./controllers/another_controller";
// application.register("another", AnotherController);

// これ以降に、他のJavaScriptやライブラリのセットアップを行う
