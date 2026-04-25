# OshiTecho - 開発タスク一覧

## ステータス凡例
- [ ] 未着手
- [~] 進行中
- [x] 完了

---

## Phase 1: 基盤構築

### 1-1. プロジェクトセットアップ
- [ ] Rails 8 プロジェクト作成（PostgreSQL・Tailwind CSS・Hotwire）
- [ ] Gemfile 整備（RSpec, FactoryBot, Bullet, Pagy, Redcarpet 等）
- [ ] Tailwind CSS v4 設定

### 1-2. テーマシステム構築
- [ ] CSS Custom Properties で4テーマ定義（Classic / Girly / Natural / Cool）
- [ ] `<html data-theme="...">` 切り替え方式の実装
- [ ] Stimulus ThemeController 作成（クリックでテーマ切り替え）
- [ ] テーマ切り替えUI（設定ページ or ヘッダーのトグル）
- [ ] usersテーブルに theme カラム追加（マイグレーション）
- [ ] ログイン時にDB値をhtmlタグに反映するApplicationControllerの before_action
- [ ] 未ログイン時はlocalStorageにフォールバック

### 1-3. 手帳デザイン基盤
- [ ] 共通レイアウト作成（ヘッダー・フッター・ボトムナビ）※モバイルファースト
- [ ] ヘッダーにテーマ切り替えアイコン（🎨）を配置・ドロップダウンUI実装
- [ ] インデックスシール風タブナビゲーションコンポーネント
- [ ] ノートページ風カードコンポーネント
- [ ] 罫線・日付ヘッダースタイル定義
- [ ] スタンプ・シール風バッジコンポーネント
- [ ] Flash メッセージ表示コンポーネント
- [ ] トップページLP作成（サービス説明・4テーマのデモ・公開イベントサンプル）
- [ ] ログイン済みユーザーのトップアクセス時は /dashboard へリダイレクト

### 1-4. 認証機能
- [ ] Rails 8 Authentication Generator 実行
- [ ] usersテーブルにusername / display_name / bio追加マイグレーション
- [ ] ユーザー登録画面 UI
- [ ] ログイン画面 UI
- [ ] ログアウト機能

### 1-5. ユーザープロフィール
- [ ] プロフィール編集画面（display_name / bio / アバター）
- [ ] Active Storage 設定（アバター画像アップロード）
- [ ] 公開プロフィールページ（/users/:username）

---

## Phase 2: 推し・イベント機能

### 2-1. 推し管理
- [ ] oshisテーブル作成・マイグレーション（color / hashtag / SNSリンク4種 含む）
- [ ] oshi_anniversariesテーブル作成・マイグレーション
- [ ] Oshiモデル（バリデーション・enum・has_many :anniversaries）
- [ ] OshiAnniversaryモデル（バリデーション）
- [ ] 推し一覧ページ（カテゴリ・50音順フィルター付き）
- [ ] 推し登録・編集フォーム（Turbo Frame活用・カラーピッカー・記念日はネスト入力）
- [ ] 推し削除（確認ダイアログ）
- [ ] 推し画像アップロード（Active Storage）
- [ ] 推し詳細ページにSNSリンクボタン・イメージカラー反映

### 2-2. イベント管理
- [ ] eventsテーブル作成・マイグレーション（開場/開演/終演・チケット代・支払状況・座席・遠征・交通手段 含む）
- [ ] Eventモデル（バリデーション・enum複数（event_type/payment_status/transport）・visibility）
- [ ] イベント一覧ページ（推し別・期間・種別・遠征有無フィルター付き）
- [ ] イベント登録・編集フォーム（時刻3項目・支払状況・遠征トグル・交通手段セレクト）
- [ ] イベント削除
- [ ] 公開/非公開切り替えUI
- [ ] 公開タイムライン（/）にイベント表示

### 2-3. イベント参加表明
- [ ] event_participationsテーブル作成・マイグレーション
- [ ] EventParticipationモデル
- [ ] 参加表明ボタン（Turbo Streamでリアルタイム反映）
- [ ] 参加者一覧表示（イベント詳細ページ）
- [ ] 参加状態の切り替え（planning / attended / cancelled）

---

## Phase 3: フォロー・カレンダー機能

### 3-1. フォロー機能
- [ ] followsテーブル作成・マイグレーション
- [ ] Followモデル・Userモデルにfollowing/followers/ff?メソッド追加
- [ ] フォロー・アンフォローボタン（Turbo Streamで即時反映）
- [ ] フォロー中一覧ページ
- [ ] フォロワー一覧ページ

### 3-2. FF限定カレンダー共有
- [ ] FullCalendar.js導入（Stimulus経由）
- [ ] カレンダーAPIエンドポイント（JSON返却）
- [ ] 自分のイベント＋FFのイベントを表示
- [ ] 推しの記念日・誕生日を🎂アイコン付きで表示（yearly=trueは毎年表示）
- [ ] イベントクリックで詳細ポップアップ
- [ ] 月表示・週表示切り替え

---

## Phase 4: グッズ・活動ログ・ダッシュボード

### 4-1. グッズ管理
- [ ] goodsテーブル作成・マイグレーション
- [ ] Goodsモデル
- [ ] グッズ一覧ページ（推し別・カテゴリ・購入年月フィルター付き）
- [ ] グッズ登録・編集フォーム
- [ ] グッズ削除
- [ ] 購入金額の月別集計

### 4-2. 活動ログ
- [ ] activity_logsテーブル作成・マイグレーション（交通費/宿泊費/食事代/同行者メモ 含む）
- [ ] ActivityLogモデル（has_many_attached :images）
- [ ] 活動ログ一覧ページ（推し別・評価・期間フィルター付き）
- [ ] 活動ログ作成・編集（マークダウンエディタ）
- [ ] マークダウンプレビュー（Stimulus + Redcarpet）
- [ ] セトリ入力UI（タグ入力形式）
- [ ] 星評価コンポーネント
- [ ] 複数画像アップロードUI（ドラッグ&ドロップ対応）
- [ ] 費用入力ブロック（交通費・宿泊費・食事代）
- [ ] 同行者メモ入力欄
- [ ] 公開ログのタイムライン表示

### 4-3. ダッシュボード
- [ ] ダッシュボードコントローラー・ビュー
- [ ] 今月の出費集計ウィジェット
- [ ] 今月の参加イベント数ウィジェット
- [ ] 推しごとの統計（イベント数・グッズ出費）
- [ ] 近日開催イベント一覧
- [ ] 最近の活動ログ

---

## Phase 5: 通知・リアルタイム機能

### 5-1. 通知機能
- [ ] notificationsテーブル作成・マイグレーション
- [ ] Notificationモデル（ポリモーフィック）
- [ ] 通知作成ロジック（参加表明・フォロー時）
- [ ] 通知一覧ページ
- [ ] 通知バッジ（Turbo Streamでリアルタイム更新）
- [ ] 既読処理

### 5-2. Solid Queue（バックグラウンドジョブ）
- [ ] Solid Queue セットアップ
- [ ] EventReminderJob（イベント前日メール送信）
- [ ] Action Mailer テンプレート（リマインダーメール）

### 5-3. ActionCable（リアルタイム）
- [ ] イベント参加者数のリアルタイム更新（Solid Cable）

---

## Phase 6: 品質・デプロイ

### 6-1. テスト
- [ ] RSpec セットアップ
- [ ] FactoryBot ファクトリー定義（全モデル）
- [ ] Userモデルテスト（バリデーション・ff?メソッド・テーマ enum）
- [ ] Oshiモデルテスト（バリデーション・enum・has_many関連）
- [ ] OshiAnniversaryモデルテスト
- [ ] Eventモデルテスト（バリデーション・visibility・scope）
- [ ] ActivityLogモデルテスト
- [ ] Goodsモデルテスト
- [ ] EventParticipationモデルテスト
- [ ] 認証コントローラーテスト（登録・ログイン・ログアウト）
- [ ] OshisコントローラーテストCRUD
- [ ] EventsコントローラーテストCRUD・visibility切り替え
- [ ] EventParticipationsコントローラーテスト（参加表明・解除）
- [ ] FollowsコントローラーテストFF判定含む
- [ ] ActivityLogsコントローラーテスト
- [ ] GoodsコントローラーテストCRUD
- [ ] ThemeコントローラーテストDB保存確認

### 6-2. UI最終調整
- [ ] レスポンシブデザイン確認・修正（SP/PC）
- [ ] 空状態（データ0件）のUX改善
- [ ] ローディング表示
- [ ] エラーページ（404/500）デザイン

### 6-3. デプロイ（Render）
- [ ] GitHub Actions CI設定（RSpec・Lint）
- [ ] render.yaml 作成（Webサービス＋PostgreSQL定義）
- [ ] 本番環境用 DATABASE_URL / RAILS_MASTER_KEY を Render に設定
- [ ] Renderへの初回デプロイ（GitHubリポジトリ連携）
- [ ] 本番DB マイグレーション実行
- [ ] 動作確認・README作成

---

## Phase 7: iCal / Google カレンダー連携

- [ ] イベントをiCal形式（.ics）でエクスポートするエンドポイント実装
- [ ] 「Googleカレンダーに追加」ボタンをイベント詳細ページに設置
- [ ] 購読URL（webcal://）を発行してカレンダーアプリと自動同期

---

## バックログ（余裕があれば）
- [ ] CSV出力（グッズ一覧・イベント一覧）
- [ ] 推し活費用の年間レポートページ
- [ ] OGP画像生成（公開イベントシェア用）
- [ ] 管理者ページ（不正コンテンツ対応）
