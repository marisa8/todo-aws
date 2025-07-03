# DynamoDB テーブル作成手順（AWSコンソール）

このドキュメントでは、AWSマネジメントコンソールを使って「Todos」テーブルを作成し、サンプルのToDoアイテムを投入する手順をまとめます。

---

## ✅ 1️⃣ DynamoDBテーブル作成

1. AWSコンソールにログイン
2. 「DynamoDB」を開く
3. 左メニューから「テーブル」を選択
4. [テーブルを作成] ボタンをクリック
5. 以下を入力：
   - **テーブル名**: `Todos`
   - **パーティションキー**: `id`
   - **キーの型**: 文字列 (String)
6. 読み書き容量モードは「オンデマンド」を選択
7. そのほかの設定はデフォルトのままでOK
8. [テーブルを作成] をクリック

---

## ✅ 2️⃣ DynamoDBテーブル構成

- テーブル名: `Todos`
- パーティションキー: `id` (文字列)

> DynamoDBはスキーマレスなNoSQLなので、他の項目（title、description、created_at）は事前定義不要です。データを投入した時点で自動的に追加されます。

---

## ✅ 3️⃣ コンソールでサンプルアイテムを追加

1. DynamoDBコンソール → 作成した「Todos」テーブルをクリック
2. 「アイテム」タブを開く
3. [アイテムを作成] をクリック
4. 以下のようなJSONを入力：

```json
{
  "id": "1",
  "title": "買い物に行く",
  "description": "牛乳を買う",
  "created_at": "2025-06-30T12:34:56Z"
}
```

## ✅ AWS CLIハンズオン手順まとめ

このドキュメントは、AWS IAMユーザーをCloudFormationから作成し、そのユーザーのアクセスキーを使ってAWS CLIからDynamoDBの「Todos」テーブルを作成・確認する流れをまとめたものです。

---

## ✅ 1️⃣ IAMユーザーのCloudFormationテンプレート

以下のCloudFormationテンプレートを使い、管理者権限のIAMユーザーを作成します。

```yaml
AWSTemplateFormatVersion: 2010-09-09
Description: Create IAM User
Resources:
  IAMUser:
    Type: AWS::IAM::User
    Properties:
      UserName: CI-CD-HandsonUser
      ManagedPolicyArns: ["arn:aws:iam::aws:policy/AdministratorAccess"]
  AccessKey:
    Type: AWS::IAM::AccessKey
    Properties:
      Status: Active
      UserName: !Ref IAMUser

Outputs:
  IAMUserName:
    Value: !Ref IAMUser
    Export:
      Name: CI-CD-HandsonUser
  AccessKeyId:
    Value: !Ref AccessKey
  SecretAccessKey:
    Value: !GetAtt AccessKey.SecretAccessKey
