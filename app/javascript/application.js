// StimulusのApplicationクラスをインポート
import { Application } from "stimulus";

// 個々のStimulusコントローラーをインポート
import ImagePreviewController from "./controllers/image_preview_controller";
import ChatController from "./controllers/chat_controller";
import LogoutController from "./controllers/logout_controller";


// Stimulusのアプリケーションインスタンスを作成
const application = Application.start();

// コントローラーをStimulusアプリケーションに登録
application.register("image-preview", ImagePreviewController);
application.register("chat", ChatController);
application.register("logout", LogoutController);


// これ以降に、他のJavaScriptやライブラリのセットアップを行う