# Terraformで構築する AWS VPC + EC2 + RDS 環境

Terraformを使用してAWS上に以下のインフラを構築するサンプルコードです。

- VPC
- Public/Private Subnet
- EC2（Amazon Linux 2023）
- RDS（MySQL）
- Internet Gateway / Route Table
- Security Group（EC2, RDS用）

基本的なインフラ構成の理解を目的で作成しています。

---

## 構成図（アーキテクチャ）
<img width="340" height="479" alt="image" src="https://github.com/user-attachments/assets/e2edcca3-a0d8-4a3b-83c1-bbca8f0b3c1f" />

