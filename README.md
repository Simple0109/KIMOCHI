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
基本的にアプリユーザーは報酬（自分の実行したいこと、欲しい物etc...）を得るための、代価（なんらかの条件、任意で複数可能）を設定します。

```mermaid
graph TD
 A(AがBに報酬と代価を提示)-->B[Bが報酬と代価を精査]
 B-->|承諾| C[Aは代価を支払うことが可能になる]
 C-->|全代価支払後| D(Aは報酬を得ることが可能になる)
 D-->|報酬を得る| E(完了)

 B-->|不承諾| G(BはAに報酬と代価の再考を求める)
 G-->H(Aは報酬および代価を修正し再度Bに提示)
 H-->|不承諾| B
 ```

## 機能一覧
| トップ画面|
| ---- |
|![readme_toppage](https://github.com/Simple0109/kimochi3/assets/128764572/7d76a557-93ba-44d3-97af-d16b745d55bd)|
|LINEによる外部認証を実装|

|プロフィール詳細画面|プレビュー画像|
| ---- | ---- |
|![profile_show](https://github.com/Simple0109/kimochi3/assets/128764572/8d0f7050-bf18-4956-a850-30678c05e357)|![preview](https://github.com/Simple0109/kimochi3/assets/128764572/20514482-c7f2-422d-b6b5-42cf7faae3e5)|
|LINEアイコンが自動で自身のアイコンになるよう実装|プレビュー画像表示機能実装|

|グループ作成画面|グループ一覧画面|
| ---- | ---- |
|![group_new](https://github.com/Simple0109/kimochi3/assets/128764572/e82541f3-7e01-4544-a98c-cd2d6df68d46)|![group_index](https://github.com/Simple0109/kimochi3/assets/128764572/c5fdf1ca-6b25-4f69-9833-52f2488ecd2a)|
|新規グループ作成機能|所属グループ一覧表示機能|

|グループ詳細画面|
| ---- |
|![group_show](https://github.com/Simple0109/kimochi3/assets/128764572/86cb4656-ad72-479f-8ddf-2acdf9d45ab5)|
|グループ詳細表示機能|

|招待リンク作成機能|
| ---- |
|![invite_group](https://github.com/Simple0109/kimochi3/assets/128764572/304ebf1b-d937-4db7-98c5-a269f75a9646)|
|招待リンクを作成し、そのリンクに他ユーザーがアクセスするとグループに所属する機能を実装|

|リクエスト作成画面|リクエスト一覧画面|
| ---- | ---- |
|![request_new](https://github.com/Simple0109/kimochi3/assets/128764572/ebdebd5b-b829-495e-b63d-f6d29225eed0)|![request_index](https://github.com/Simple0109/kimochi3/assets/128764572/f8bdf1c8-9314-4387-91c1-d8c9efe7a051)|
|新規リクエスト作成機能|状態別リクエスト一覧機能|

|リクエスト詳細画面|リクエスト状態表示|
| ---- | ---- |
|![request_show](https://github.com/Simple0109/kimochi3/assets/128764572/b594bfd6-f86c-443b-b8aa-b53a8967f623)|![request_status](https://github.com/Simple0109/kimochi3/assets/128764572/42f61011-9e5b-4198-8b03-9d25a87f88f9)|
|リクエスト詳細機能|リクエストの状態を動的に表示する機能を実装|

|リアルタイムチャット画面|リクエスト承認機能|
| ---- | ---- |
|![realtime_chat](https://github.com/Simple0109/kimochi3/assets/128764572/7904a4e6-d215-470d-8e83-728b07df806c)|![approval](https://github.com/Simple0109/kimochi3/assets/128764572/31d84895-29bf-49bc-a5a0-fe734eda0d59)|
|リクエスト毎にリアルタイムチャット機能実装|承認者によるリクエスト承認機能実装|

|タスク完了・完了取消機能|リクエスト完了機能|
| ---- | ---- |
|![task_conpleted_or_uncompleted](https://github.com/Simple0109/kimochi3/assets/128764572/f02b2704-d583-494d-a925-47a125bb028d)|![request_completed](https://github.com/Simple0109/kimochi3/assets/128764572/52a78dd5-06ae-449c-af9b-c8dcd8b45364)|
|タスク完了・完了取消機能実装(リクエストが承諾された場合表示)|リクエスト完了機能実装(タスクを全て完了した場合に出現)|

|完了リクエスト一覧画面|
| ---- |
|![completed_request](https://github.com/Simple0109/kimochi3/assets/128764572/ccc57154-4f78-4748-b69d-6ef3c9c178ed)|
|グループ毎に完了したリクエスト一覧を表示する機能実装|

|個人リクエスト一覧画面|
| ---- |
|![personal_request](https://github.com/Simple0109/kimochi3/assets/128764572/adb1d85d-120f-4fc4-b6e4-2522a74615f9)|
|ユーザー毎に作成したリクエスト一覧を表示する機能実装|

|LINEプッシュ通知画面|
| ---- |
|![push_mini](https://github.com/Simple0109/kimochi3/assets/128764572/60a5660d-6f8e-4e6f-a9fa-ec8cc03c5a30)|
|報酬の実行予定日当日8時にLINEプッシュ通知機能実装|



## 使用技術
| Category          | Technology Stack                                     |
| ----------------- | --------------------------------------------------   |
| Backend           | Ruby(3.2.2), Ruby on Rails(7.0.8)                    |
| Frontend          | Stimulus(3.2.2), Tailwind CSS(3.3.6), DaisyUI(3.9.4) |
| Infrastructure    | Heroku                                               |
| Database          | PostgreSQL                                           |
| CI/CD             | GitHub Actions                                       |
| etc.              | RuboCop, RSpec, Git, GitHub |



### GEM
* device(ログイン・認証機能)
* omniauth-line, omniauth-rails_csrf_protection(LINEログイン)
* line_bot_api(LINEプッシュ通知)
* delayed_job_active_record(招待リンクの時限式削除)
* action_cable(リアルタイムチャット)
* kaminari(ページネーション)
* ActiveStorage(ファイルアップロード、保存)
* activestorage-validator(アップロードされるファイルのバリデーション設定)
* image_processing(画像リサイズ、ファイル容量一律化)
* RSpec(テスト)
* rubocop(lintチェック)


## 画面遷移図
[figma](https://www.figma.com/file/sd5Sa6ScSJaa9vY1S6LSNU/PF(KIMOCHI%EF%BC%89?type=design&node-id=0%3A1&mode=design&t=gUPB3r8R1ZEGAyfV-1))

## ER図
[![Image from Gyazo](https://i.gyazo.com/2fcd92537849c79635a88b5895dd3346.png)](https://gyazo.com/2fcd92537849c79635a88b5895dd3346)