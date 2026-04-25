# OshiTecho - 機能仕様書

## システム概要
推し活・ファン活動を記録・管理・共有できるWebアプリケーション。
「母子手帳」をモチーフにした推し手帳。基本はプライベートな記録帳だが、公開設定で仲間と繋がれる。

---

## デザインコンセプト

### 手帳らしさの表現
実際の手帳・システム手帳・ほぼ日手帳のような見た目を意識したUI設計。

| 要素 | 表現方法 |
|------|---------|
| ページ区切り | 罫線・ドット罫線をCSSで再現 |
| ナビゲーション | インデックスシール風のタブUI |
| バッジ・ラベル | スタンプ・シール風のデザイン |
| カード | ノートページ風の白背景＋影 |
| 日付表示 | 手帳の日付ヘッダーを模したスタイル |
| フォーム | 罫線の上に書くような入力欄のスタイル |

### テーマ一覧
ユーザーが自分の好みに合わせて手帳のテーマを切り替えられる。

| テーマ名 | 背景 | アクセント | サブカラー | フォント | イメージ |
|---------|------|-----------|-----------|---------|---------|
| **Classic** | #FAF7F0（クリーム） | #8B6914（ゴールドブラウン） | #2C1810（深ブラウン） | Noto Serif JP | 革手帳・システム手帳 |
| **Girly** | #FFF0F6（ベビーピンク） | #F472B6（ピンク400） | #C084FC（パープル400） | 丸ゴシック | ほぼ日手帳・少女漫画 |
| **Natural** | #FAFAF7（オフホワイト） | #65A30D（lime-600） | #92400E（amber-800） | ゴシック体 | キャンプ手帳・自然日記 |
| **Cool** | #0F172A（slate-900） | #818CF8（indigo-400） | #22D3EE（cyan-400） | ゴシック体 | ビジネス手帳・技術手帳 |

### テーマ実装方式
- CSS Custom Properties（CSS変数）で色・フォントを定義
- `<html data-theme="classic">` のようにルート要素に付与
- Stimulusコントローラー（ThemeController）でテーマ切り替え
- ユーザーの選択はDB（users.theme）に保存し、ログイン時にサーバーから適用
- 未ログインユーザーはlocalStorageにフォールバック

---

## ユーザー種別

| 種別 | 説明 |
|------|------|
| ゲスト | 公開タイムライン・公開イベント・公開ログの閲覧のみ |
| 登録ユーザー | 全機能利用可能 |

---

## 機能仕様

### 1. 認証
- 新規登録（メール・パスワード・ユーザー名）
- ログイン / ログアウト
- Rails 8 Authentication Generator を使用

---

### 2. 推し管理（Oshi）
- 推しの登録・編集・削除
- 基本項目：名前、カテゴリ（声優 / アーティスト / キャラクター / アイドル / その他）、説明、アイコン画像
- **追加項目：**
  - **誕生日・記念日**：誕生日・デビュー日・初共演日など複数の記念日を登録可能（oshi_anniversariesテーブル）
  - **SNSリンク**：X（Twitter）/ YouTube / Instagram / TikTok などのURL
  - **イメージカラー**：HEX形式の色。推し詳細・カードのアクセントに反映
  - **推しハッシュタグ**：SNS用ハッシュタグ（活動ログ入力時に補完候補として表示）
- 推しは複数登録可能
- 推し別にイベント・グッズ・活動ログを紐付けて管理
- カレンダーに記念日を「🎂推し名の誕生日」として表示

---

### 3. イベント管理（Event）
- イベント登録・編集・削除
- 基本項目：タイトル、イベント種別（ライブ / 舞台 / サイン会 / 展示 / 配信 / その他）、日時、会場、説明、推し紐付け、公開/非公開
- **追加項目：**
  - **チケット代・支払状況**：金額（円）・ステータス（未払い / 支払済 / 返金済）
  - **座席番号・ブロック**：自由記述（例：「A-12」「1階 12列 24番」「スタンディング」）
  - **開演・終演時刻**：開場 / 開演 / 終演を別々に記録
  - **遠征フラグ・交通手段**：遠征かどうかのbool、交通手段（電車 / 新幹線 / 飛行機 / 車 / バス / その他）
- **公開設定のイベント**は誰でも閲覧可能
- **参加表明機能**：公開イベントに対し、登録ユーザーが「参加予定」「参加済み」を登録できる
- 参加者一覧（アバター+ユーザー名）をイベント詳細に表示
- イベント前日にリマインド通知（Solid Queue）

---

### 4. フォロー / フォロワー機能
- ユーザーをフォロー / アンフォローできる
- FF（相互フォロー）の判定をモデルで管理
- フォロー中ユーザー一覧・フォロワー一覧ページ

---

### 5. FF限定カレンダー共有
- 自分とFFのユーザーのイベント（参加予定含む）をカレンダー形式で表示
- Stimulus + FullCalendar.js で実装
- 自分のプライベートイベントも表示（FF限定で表示範囲を制御）

---

### 6. グッズ管理（Goods）※完全プライベート
- グッズの登録・編集・削除
- 項目：グッズ名、カテゴリ（CD / BD / フィギュア / 写真 / アパレル / その他）、購入日、金額、画像、推し紐付け
- 公開機能なし（自分だけが見られる）

---

### 7. 活動ログ（ActivityLog）
- イベント参加後の感想・記録を投稿
- 基本項目：本文（マークダウン対応）、セトリ（JSON配列）、評価（1〜5星）、公開/非公開、イベント紐付け
- **追加項目：**
  - **複数画像添付**：1ログに複数枚の写真（プレディナー・会場外観・満買御礼など）。Active Storageのhas_many_attached
  - **交通費・宿泊費・食事代**：金額（円）を個別に記録。年間レポートで集計
  - **同行者メモ**：誰と行ったかの自由記述（ユーザーリンクまたはフリーテキスト）
- 公開設定のログはタイムラインに表示される

---

### 8. ダッシュボード（マイページ）
- 今月の推し活費用（グッズ購入総額）
- 今月の参加イベント数
- 推しごとの統計（イベント数・出費）
- 最近の活動ログ
- 近日開催のイベント

---

### 9. 公開タイムライン（探索ページ）
- 公開設定のイベント・活動ログを新着順で表示
- 推しカテゴリ・キーワードでフィルター
- ゲストも閲覧可能

---

### 10. 通知
- 自分のイベントに誰かが参加表明した
- イベント前日リマインド
- フォローされた
- Turbo Streams でリアルタイム通知バッジ更新

---

### 11. テーマ切り替え
- **ヘッダーに常時表示**（🎨アイコン）→ クリックでドロップダウンまたはモーダルが開く
- 4テーマ：Classic / Girly / Natural / Cool
- 選択したテーマはDBに保存（ログイン時）・localStorageに保存（未ログイン時）
- テーマの変更はページリロードなしで即時反映（Stimulus）
- ドロップダウン内でテーマプレビュー（色見本＋テーマ名）を表示

---

### 12. iCal / Google カレンダー連携
- イベント詳細ページに「Googleカレンダーに追加」ボタンを設置
- `.ics` ファイルのダウンロードエンドポイント（`/events/:id.ics`）
- ユーザーの参加予定イベント一覧を `webcal://` 購読URLで配信（カレンダーアプリと自動同期）

---

### 13. ユーザープロフィール（公開）
- アバター、ユーザー名、自己紹介
- 公開活動ログ一覧
- 公開イベント一覧
- フォロー/フォロワー数

---

### 14. 画面別フィルター機能
- 各一覧ページに条件絞り込みUIを設置（グローバル検索は非搭載）
- 推し一覧：カテゴリ・50音順
- イベント一覧：推し別・期間（月指定）・種別・遠征有無・公開/非公開
- 活動ログ一覧：推し別・評価（星数）・期間
- グッズ一覧：推し別・カテゴリ・購入年月
- 公開タイムライン：推しカテゴリ・キーワード（タイトル部分一致）

---

## 画面一覧（サイトマップ）

```
/                        トップ（LP：サービス紹介・公開イベントサンプル表示）
/signup                  新規登録
/login                   ログイン

/dashboard               ダッシュボード（要ログイン）

/oshis                   推し一覧
/oshis/new               推し登録
/oshis/:id               推し詳細
/oshis/:id/edit          推し編集

/events                  イベント一覧（自分）
/events/new              イベント登録
/events/:id              イベント詳細
/events/:id/edit         イベント編集

/calendar                FF限定カレンダー

/goods                   グッズ一覧
/goods/new               グッズ登録
/goods/:id/edit          グッズ編集

/activity_logs           活動ログ一覧（自分）
/activity_logs/new       活動ログ作成
/activity_logs/:id       活動ログ詳細
/activity_logs/:id/edit  活動ログ編集

/users/:username         ユーザープロフィール（公開）
/users/:username/following  フォロー中
/users/:username/followers  フォロワー

/notifications           通知一覧

/settings                設定（テーマ選択・プロフィール編集・メール通知設定）
```

---

## データモデル

### users
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| email | string | unique |
| password_digest | string | bcrypt |
| username | string | unique・URLに使用 |
| display_name | string | |
| bio | text | |
| avatar | ActiveStorage | |
| theme | string | classic / girly / natural / cool（デフォルト: classic） |
| created_at / updated_at | datetime | |

### oshis
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| user_id | bigint | FK |
| name | string | |
| category | string | enum |
| description | text | |
| image | ActiveStorage | |
| color | string | HEX（例: #F472B6） |
| hashtag | string | SNSハッシュタグ |
| twitter_url | string | |
| youtube_url | string | |
| instagram_url | string | |
| tiktok_url | string | |

### oshi_anniversaries
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| oshi_id | bigint | FK |
| label | string | 例: 誕生日 / デビュー日 / 初共演 |
| date | date | 年情報含むが「毎年」扱いも可能 |
| yearly | boolean | trueなら毎年通知（誕生日など） |

### events
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| user_id | bigint | FK |
| oshi_id | bigint | FK（nullable） |
| title | string | |
| event_type | string | enum |
| held_on | datetime | |
| doors_open_at | datetime | 開場時刻 |
| starts_at | datetime | 開演時刻 |
| ends_at | datetime | 終演時刻 |
| venue | string | |
| seat_info | string | 座席番号・ブロック（例: 1階 12列 24番） |
| ticket_price | integer | 円 |
| payment_status | string | enum: unpaid / paid / refunded |
| is_far_trip | boolean | 遠征フラグ |
| transport | string | enum: train / shinkansen / airplane / car / bus / other |
| description | text | |
| visibility | string | private / public |

### event_participations
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| event_id | bigint | FK |
| user_id | bigint | FK |
| status | string | planning / attended / cancelled |
| memo | text | |

### goods
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| user_id | bigint | FK |
| oshi_id | bigint | FK（nullable） |
| name | string | |
| category | string | enum |
| price | integer | 円 |
| purchased_on | date | |
| image | ActiveStorage | |

### activity_logs
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| user_id | bigint | FK |
| event_id | bigint | FK（nullable） |
| content | text | マークダウン |
| setlist | jsonb | 曲名配列 |
| rating | integer | 1〜5 |
| travel_cost | integer | 交通費（円） |
| lodging_cost | integer | 宿泊費（円） |
| meal_cost | integer | 食事代（円） |
| companions | text | 同行者メモ |
| visibility | string | private / public |

※ 画像は Active Storage の `has_many_attached :images` で複数枚保存

### follows
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| follower_id | bigint | FK → users |
| followed_id | bigint | FK → users |

### notifications
| カラム | 型 | 備考 |
|--------|-----|------|
| id | bigint | PK |
| user_id | bigint | FK（通知を受け取るユーザー） |
| notifiable_type | string | ポリモーフィック |
| notifiable_id | bigint | ポリモーフィック |
| message | string | |
| read_at | datetime | nilなら未読 |

---

## 非機能要件
- **モバイルファースト**設計（Tailwind のデフォルト方針に従い SP 基準でスタイルを書き PC は拡張）
- レスポンシブデザイン（SP/PC両対応）
- 画像はActive StorageでローカルまたはS3に保存
- ページネーションはPagyで統一
- N+1クエリ禁止（bullet gemで検出）
- テストカバレッジ：モデル全件 / コントローラー主要フロー
