AWS(Terraform) + Java(Spring Boot) + CI/CD 個人プロジェクト

---

## 1. プロジェクト概要
Terraformを使用してAWS上にインフラを構築し、GitHub Actionsを用いてJava (Spring Boot) アプリケーションのCI/CDパイプラインを自動化するプロジェクトです。

---

## 2. アーキテクチャ図
<img width="935" height="375" alt="image" src="https://github.com/user-attachments/assets/fddde2aa-90c8-427e-af67-4216fa865f08" />

---

## 3. インフラ構成 (Infrastructure as Code)
- コンピューティング
  - Amazon EC2: アプリケーションのDockerコンテナを実行する仮想サーバー(t3.micro)。Elastic IPによってパブリックIPアドレスが固定されています。
  - EC2 ユーザーデータ: インスタンスの初回起動時に、DockerとCloudWatch Agentを自動でインストール・設定します。

- データベース
  - Amazon RDS for MySQL: アプリケーションが使用するマネージドなリレーショナルデータベース(db.t3.micro)。

- コンテナ
  - Amazon ECR: ビルドされたDockerイメージを保存・管理するためのプライベートなコンテナレジストリ。

- ネットワーク & セキュリティ
  - Security Group
    - app-sg: EC2インスタンス用。Webアクセス(8080)とSSH(22)のインバウンド通信を許可します。
    - rds-mysql-sg: RDSインスタンス用。app-sgからのMySQL(3306)通信のみを許可する最小権限の原則に基づいています。

  - IAM (Identity and Access Management)
    - OIDC連携用ロール: GitHub ActionsがアクセスキーなしでAWSリソース（ECRなど）を操作するための権限を提供します。
    - EC2用ロール: EC2インスタンスがECRからのイメージプル、SSMからの設定読み取り、CloudWatchへのログ書き込みを行うための権限を提供します。

- 監視 & アラート
  - Amazon CloudWatch
    - Logs: EC2のシステムログと、Dockerコンテナから出力されるアプリケーションログを一元的に収集・監視します。
    - Metrics: EC2のCPU、メモリ、ディスク使用率などのメトリクスを収集します。
    - Alarms: CPU使用率がしきい値を超えた場合にアラームを発報します。
  - Amazon SNS: CloudWatchアラームからの通知を受け取り、指定されたEメールアドレスにアラートを送信します。

- 設定管理
  - AWS Systems Manager (SSM) Parameter Store: CloudWatch Agentの設定ファイルをJSON形式で一元管理します。

---

## 4. デプロイフロー(CI/CD)
GitHub Actionsを利用して、mainブランチへのプッシュをトリガーにCI/CDパイプラインを自動実行します。

- 開発者のアクション (git push)
  - 開発者がローカルで変更したコードをmainブランチにプッシュします。

- CI (品質チェック) - java-ci.yml
  - ソースコードのチェックアウト、Java環境のセットアップが行われます。
  - ./gradlew testで単体テストが実行され、コードの品質が保証されます。
  - ./gradlew buildでアプリケーションがビルドされ、静的解析ツール(SonarQube)が実行されます。
  - CIが成功すると、.jarファイルをアーティファクトにアップロードされます。

- CD (ビルド & デプロイ) - java-cd.yml
  - CIワークフローの成功をトリガーにCDワークフローが開始されます。
  - AWS認証: OIDC連携を使い、IAMロールを引き受けることで、AWSの一時的な認証情報を取得します。

  - Dockerイメージのビルド & プッシュ
    - ソースコードから本番用のDockerイメージをビルドします。
    - コミットハッシュをタグとしてイメージをECRにプッシュします。

  - EC2へのデプロイ
    - GitHub Secretsに保存された秘密鍵とElastic IPを使い、EC2インスタンスにSSH接続します。
    - EC2インスタンス上で以下のデプロイスクリプトが実行されます。

  - ECRにログイン
    - ECRから最新のDockerイメージをプル。
    - 稼働中の古いコンテナを停止・削除 (docker stop/rm)。
    - 最新のイメージで新しいコンテナを起動 (docker run)。この際、GitHub Secretsから渡されたRDSの接続情報が環境変数としてコンテナに注入されます。
