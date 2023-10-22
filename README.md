# Overview

- locals内に https://github.com/matsuu/cloud-init-isucon を参考にしたAMI情報を記載しています。
 `isucon_version`という変数にバージョンを指定することで、そのイメージに関連するAWSリソースをセットアップします
- aws credentialにisuconという名前でprofile設定されていること（変更したい場合はaws.tfを修正する）

    ```
    [isucon]
    aws_access_key_id = <YOUR_KEY>
    aws_secret_access_key = <YOUR_KEY>
    ```
- GitHubにSSH公開鍵が登録されていること。 https://github.com/<ユーザ名>.keys で確認できる。

# How to use
 

## plan & apply

- terraform plan 時に値を引き渡す。isucon_versionに入力する値は ec2.tfの local.ami_idsの中から選ぶ

```
terraform plan -var="isucon_version=twelve_q" -var="github_user=VTRyo -var="public_key=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICs1yBBn/9XS4gY2O5uOepMvkeTmeeL2L6Bxe6l6B/FW" 
```

- terraform apply
```
terraform apply -var="isucon_version=twelve_q" -var="github_user=VTRyo" -var="public_key=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICs1yBBn/9XS4gY2O5uOepMvkeTmeeL2L6Bxe6l6B/FW"
```

## Login

```
ssh ubuntu@xx.xx.xx.xx -i <ssh_key_path>
```

以降のoperationはこちらを参考にしてください
https://github.com/matsuu/aws-isucon


## Destroy

課金されるので忘れずに削除してください

```
terraform destroy -var="isucon_version=twelve_q" -var="github_user=VTRyo" -var="public_key=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICs1yBBn/    9XS4gY2O5uOepMvkeTmeeL2L6Bxe6l6B/FW"
```

# 免責事項

* 参照元の[免責事項](https://github.com/matsuu/aws-isucon)に準じます
