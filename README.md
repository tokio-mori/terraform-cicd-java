AWS(Terraform) + Java(Spring Boot) + CI/CD 個人プロジェクト

---

## 1. プロジェクト概要
このプロジェクトは、TerraformでAWS環境を構築し、Java(Spring Boot)アプリケーションをデプロイするサンプル構成です。
商用運用を想定し、監視・セキュリティ・SLO/SLIの設計も含みます。

---

## 2. アーキテクチャ図
（後で貼る欄）
![architecture-diagram](docs/architecture.png)

---

## 3. インフラ構成
- VPC / Public Subnet / IGW / Route Table
- EC2 または ECS
- RDS（MySQL または PostgreSQL）
- ALB（必要に応じて）
- IAM（最小権限）
- CloudWatch（メトリクス・ログ）

---

## 4. デプロイフロー
1. GitHub Actionsでビルド
2. アーティファクト作成
3. AWSへ自動デプロイ
4. 環境毎の変数管理

---

## 5. SLO / SLI
> 値は後で確定

| 指標 | ターゲット (SLO) | 実測値 (SLI) | 備考 |
|------|----------------|-------------|------|
| 可用性 | 99.9% | TBD | HTTP 200 応答率 |
| p95 レイテンシ | < 300ms | TBD | ALB / CloudWatch |
| 5xx エラー率 | < 1% / 5分 | TBD | ALB / CloudWatch Logs |
| CPU 利用率 | < 70% | TBD | EC2/ECS メトリクス |

---

## 6. Runbook（雛形）

### Runbook 1：高負荷時の対応
**想定事象**：CPU 使用率 > 80% が5分以上継続  
**対応手順**：
1. CloudWatchで該当メトリクスを確認
2. 負荷原因プロセスを特定
3. スケールアウト/スケールアップ判断
4. 事後記録（Postmortem）作成

---

### Runbook 2：DB接続枯渇時
**想定事象**：DB接続数が最大値に達し、アプリエラーが発生  
**対応手順**：
1. CloudWatch/RDSメトリクスで接続数確認
2. アプリ接続プール設定見直し
3. 一時的な最大接続数拡張（必要時のみ）
4. 原因SQLやトランザクションを調査

---

### Runbook 3：デプロイ失敗時
**想定事象**：CI/CDパイプラインが失敗、またはアプリが起動しない  
**対応手順**：
1. GitHub Actionsログ確認
2. 最新安定版へロールバック
3. 変更差分のコードレビュー
4. 恒久対策チケット化

---

## 7. コスト
- 想定月額コスト（TBD）
- Cost Explorerで監視
- Budgetsでアラート設定

---
test