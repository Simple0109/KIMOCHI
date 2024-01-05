// StimulusのApplicationクラスをインポート
import { Application } from "stimulus";

// 個々のStimulusコントローラーをインポート
import ImagePreviewController from "./controllers/image_preview_controller";

// Stimulusのアプリケーションインスタンスを作成
const application = Application.start();

// コントローラーをStimulusアプリケーションに登録
application.register("image-preview", ImagePreviewController);

// これ以降に、他のJavaScriptやライブラリのセットアップを行う
