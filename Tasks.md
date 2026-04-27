# OshiTecho - 開発タスク一覧

## ステータス凡例
- [ ] 未着手
- [~] 進行中
- [x] 完了

---

## Phase 1: 基盤構築

### 1-1. プロジェクトセットアップ ✅
- [x] Rails 8 プロジェクト作成（PostgreSQL・Tailwind CSS・Hotwire）
- [x] Gemfile 整備（RSpec, FactoryBot, Bullet, Pagy, Redcarpet 等）
- [x] Tailwind CSS v4 設定

### 1-2. テーマシステム構築 ✅
- [x] CSS Custom Properties で4テーマ定義（Classic / Girly / Natural / Cool）
- [x] `<html data-theme="...">` 切り替え方式の実装
- [x] Stimulus ThemeController 作成（クリックでテーマ切り替え）
- [x] テーマ切り替えUI（ヘッダーのトグル）
- [x] usersテーブルに theme カラム追加（マイグレーション）
- [x] ログイン時にDB値をhtmlタグに反映
- [x] 未ログイン時はlocalStorageにフォールバック

### 1-3. 手帳デザイン基盤 ✅
- [x] 共通レイアウト作成（ヘッダー・Flashメッセージ）
- [x] ヘッダーにテーマ切り替えアイコン配置
- [x] インデックスシール風タブナビゲーションコンポーネント
- [x] ノートページ風カードコンポーネント（.notebook-card）
- [x] 罫線スタイル定義（.ruled-line）
- [x] スタンプ・シール風バッジコンポーネント（.stamp-badge）
- [x] Flash メッセージ表示コンポーネント
- [x] トップページLP作成（サービス説明・4テーマのデモ・公開イベントサンプル）
- [x] ログイン済みユーザーのトップアクセス時は /dashboard へリダイレクト

### 1-4. 認証機能 ✅
- [x] Rails 8 Authentication Generator 実行
- [x] usersテーブルにusername / display_name / bio追加マイグレーション
- [x] ユーザー登録画面 UI
- [x] ログイン画面 UI
- [x] ログアウト機能

### 1-5. ユーザープロフィール ✅
- [x] プロフィール編集画面（display_name / bio / アバター）
- [x] Active Storage 設定（アバター画像アップロード）
- [x] 公開プロフィールページ（/users/:username）

---

## Phase 2: 推し・イベント機能

### 2-1. 推し管理 ✅
- [x] oshisテーブル作成・マイグレーション（color / hashtag / SNSリンク4種 含む）
- [x] oshi_anniversariesテーブル作成・マイグレーション
- [x] Oshiモデル（バリデーション・enum・has_many :anniversaries）
- [x] OshiAnniversaryモデル（バリデーション）
- [x] 推し一覧ページ（カードグリッド・SNSリンク・空状態UI）
- [x] 推し登録・編集フォーム（カラーピッカー・記念日はネスト入力）
- [x] 推し削除（確認ダイアログ）
- [x] 推し画像アップロード（Active Storage）
- [x] 推し詳細ページにSNSリンクボタン・イメージカラー反映
- [x] 推し一覧：カテゴリ・50音順フィルター

### 2-2. イベント管理 ✅
- [x] eventsテーブル作成・マイグレーション（開場/開演/終演・チケット代・支払状況・座席・遠征・交通手段 含む）
- [x] Eventモデル（バリデーション・enum複数・visibility）
- [x] イベント一覧ページ（推し別・予定/過去フィルター付き）
- [x] イベント登録・編集フォーム（時刻3項目・支払状況・遠征トグル・交通手段セレクト）
- [x] イベント削除
- [x] 公開/非公開切り替えUI
- [x] 公開タイムライン（/）にイベント表示

### 2-3. イベント参加表明 ✅
- [x] event_participationsテーブル作成・マイグレーション
- [x] EventParticipationモデル（planning/attended/cancelled enum）
- [x] 参加表明ボタン（Turbo Streamでリアルタイム反映）
- [x] 参加者数カウント表示（イベント詳細ページ）
- [x] 参加状態の切り替え（planning / attended / cancelled）

---

## Phase 3: フォロー・カレンダー機能

### 3-1. フォロー機能 ✅
- [x] followsテーブル作成・マイグレーション
- [x] Followモデル・Userモデルにfollowing/followers/ff?メソッド追加
- [x] フォロー・アンフォローボタン（Turbo Streamで即時反映）
- [x] フォロー中一覧ページ
- [x] フォロワー一覧ページ

### 3-2. FF限定カレンダー共有 ✅
- [x] FullCalendar.js導入（Stimulus経由・CDN Global Bundle）
- [x] カレンダーAPIエンドポイント（JSON返却）
- [x] 自分のイベント＋FFのイベントを表示
- [x] 推しの記念日・誕生日を🎂アイコン付きで表示（yearly=trueは毎年表示）
- [x] イベントクリックで詳細ポップアップ
- [x] 月表示・週表示切り替え

---

## Phase 4: グッズ・活動ログ・ダッシュボード

### 4-1. グッズ管理 ✅
- [x] goodsテーブル作成・マイグレーション
- [x] Goodsモデル
- [x] グッズ一覧ページ（推し別・カテゴリ・購入年月フィルター付き）
- [x] グッズ登録・編集フォーム
- [x] グッズ削除
- [x] 購入金額の月別集計

### 4-2. 活動ログ ✅
- [x] activity_logsテーブル作成・マイグレーション（交通費/宿泊費/食事代/同行者メモ 含む）
- [x] ActivityLogモデル（has_many_attached :images）
- [x] 活動ログ一覧ページ（推し別・評価フィルター付き）
- [x] 活動ログ作成・編集（マークダウン対応textarea）
- [-] マークダウンプレビュー（Stimulus + Redcarpet）（今後対応）
- [x] セトリ入力UI（1行1曲形式）
- [x] 星評価コンポーネント
- [x] 複数画像アップロードUI
- [x] 費用入力ブロック（交通費・宿泊費・食事代）
- [x] 同行者メモ入力欄
- [x] 公開ログのタイムライン表示（LP経由）

### 4-3. ダッシュボード ✅
- [x] ダッシュボードコントローラー・ビュー
- [x] 今月の出費集計ウィジェット
- [x] 今月の参加イベント数ウィジェット
- [x] 推しごとの統計（イベント数・グッズ出費）
- [x] 近日開催イベント一覧
- [x] 最近の活動ログ

---

## Phase 5: 通知・リアルタイム機能

### 5-1. 通知機能 ✅
- [x] notificationsテーブル作成・マイグレーション
- [x] Notificationモデル（ポリモーフィック）
- [x] 通知作成ロジック（参加表明・フォロー時）
- [x] 通知一覧ページ
- [x] 通知バッジ（Turbo Frame）
- [x] 既読処理（一括既読 + Turbo Stream更新）

### 5-2. Solid Queue（バックグラウンドジョブ） ✅
- [x] Solid Queue セットアップ（config/solid_queue.yml）
- [x] EventReminderJob（イベント前日リマインダー通知）
- [-] Action Mailer テンプレート（今後対応）

### 5-3. ActionCable（リアルタイム） ✅
- [x] イベント参加者数のリアルタイム更新（EventParticipationsChannel）

---

## Phase 6: 品質・デプロイ

### 6-1. テスト ✅（48例全合格）
- [x] RSpec セットアップ（shoulda-matchers含む）
- [x] FactoryBot ファクトリー定義（User/Oshi/Event/Follow/Notification/EventParticipation）
- [x] Userモデルテスト（バリデーション・follow/ff?メソッド）
- [x] Eventモデルテスト（バリデーション・scope）
- [x] Notificationモデルテスト（scope・message・mark_as_read!）
- [x] FollowsリクエストテストFF判定含む
- [x] EventParticipationsリクエストテスト
- [x] Notificationsリクエストテスト

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
