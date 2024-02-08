# [KIMOCHI]
![readme_top](https://github.com/Simple0109/kimochi3/assets/128764572/202cc00f-2250-4a69-b02d-a1c221fc22cf)

## サービスURL
[https://tranquil-reef-61954-2d3bbdfbb995.herokuapp.com/](https://tranquil-reef-61954-2d3bbdfbb995.herokuapp.com/)

## サービスへの思い
私は趣味の麻雀をする際、友人を誘うと「特に予定はないけど、妻に言い出しづらい…」と回答されたことがあります。
別の友人は「特に予定がないから、1人キャンプに行こうとすると妻からあまりいい顔をされないから、なかなかキャンプに行けない」と言っていました。
共同生活を送っていると「なにか悪いことを実行しようとしているわけではないのに、それを行っていいのか相手に言いづらい」という状態になることがあると思います。
上記のような状態になってしまい「実行したいと言いにくい」という悩みを解決するために、実行したいことを行うための条件提示と、調整を行いながら、お互いにちょうど良い落とし所をつけるためのサービスです。


## アプリケーションの利用フロー図
基本的にアプリユーザーは報酬（自分の実行したいこと、欲しい物etc...）を得るための、対価（なんらかの条件、任意で複数可能）を設定します。

```mermaid
graph TD
 A(AがBに報酬と対価を提示)-->B[Bが報酬と対価を精査]
 B-->|承諾| C[Aは対価を支払うことが可能になる]
 C-->|全対価支払後| D(Aは報酬を得ることが可能になる)
 D-->|報酬を得る| E(完了)

 B-->|不承諾| G(BはAに報酬と対価の再考を求める)
 G-->H(Aは報酬および対価を修正し再度Bに提示)
 H-->|不承諾| B
 ```

## 機能一覧
| トップ画面|
| ---- |
|![readme_toppage](https://github.com/Simple0109/kimochi3/assets/128764572/7d76a557-93ba-44d3-97af-d16b745d55bd)|
|LINEによる外部認証を実装|

|プロフィール詳細画面|プロフィール編集画面|
| ---- | ---- |
|![readme_profile_show](https://github.com/Simple0109/kimochi3/assets/128764572/d8b3dfd8-8fff-47ea-8466-f73ef1c060c7)|![readme_profile_edit](https://github.com/Simple0109/kimochi3/assets/128764572/50c3ab4d-9815-4ac5-943b-1186a0256777)|
|LINEアイコンの自動で自身のアイコンになるよう実装|プロフィール画像を選択した際、プレビュー画像が表示される機能実装|

|グループ作成画面|グループ一覧画面|
| ---- | ---- |
|![group_new](https://github.com/Simple0109/kimochi3/assets/128764572/e82541f3-7e01-4544-a98c-cd2d6df68d46)|![group_index](https://github.com/Simple0109/kimochi3/assets/128764572/c5fdf1ca-6b25-4f69-9833-52f2488ecd2a)|
|新規グループ作成機能|所属グループ一覧表示機能|

|グループ詳細画面|招待リンク作成機能|
| ---- | ---- |
|![group_show](https://github.com/Simple0109/kimochi3/assets/128764572/86cb4656-ad72-479f-8ddf-2acdf9d45ab5)|![invite_group](https://github.com/Simple0109/kimochi3/assets/128764572/304ebf1b-d937-4db7-98c5-a269f75a9646)|
|グループ詳細表示機能|招待リンクを作成し、そのリンクに他ユーザーがアクセスするとグループに所属する機能を実装|


## 実装を予定している機能
### MVP
* 会員登録
* ログイン
* 招待機能
* 投稿機能
* 投稿一覧表示機能
* カテゴリ機能
* アラート機能(LINE Messaging API)


### その後の機能
* リアルタイムチャット機能(ActionCable)

## 使用技術
### バックエンド
* ruby on rails 7.0.7
* ruby 3.2.2

### フロントエンド
* Tailwind CSS

### GEM
* device(ログイン・認証機能)
* omniauth-line, omniauth-rails_csrf_protection(LINEログイン)
* kaminari(ページネーション)
* Active Admin(管理画面)
* ActiveStorage(ファイルアップロード、保存)
* image_processing(画像リサイズ、ファイル容量一律化)
* rubocop(lintチェック)
* RSpec(テスト)

### デプロイ
* heroku

## 画面遷移図
[figma](https://www.figma.com/file/sd5Sa6ScSJaa9vY1S6LSNU/PF(KIMOCHI%EF%BC%89?type=design&node-id=0%3A1&mode=design&t=gUPB3r8R1ZEGAyfV-1))

## ER図
[![Image from Gyazo](https://i.gyazo.com/2fcd92537849c79635a88b5895dd3346.png)](https://gyazo.com/2fcd92537849c79635a88b5895dd3346)