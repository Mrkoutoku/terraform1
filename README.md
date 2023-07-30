export AWS_ACCESS_KEY_ID="accesskey"
export AWS_SECRET_ACCESS_KEY="secretkey"
export AWS_DEFAULT_REGION="ap-northeast-1a"
もしくは
vim ~/.aws/credentials
[default]
aws_access_key_id = accesskey
aws_secret_access_key = secretkey

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /Users/ogawamitsunori/.profile


brew install tfenv
tfenv list-remote
tfenv install 1.5.4　　//コードを書いた時のバージョンを使用
tfenv use 1.5.4
terraform --version

ssh -i "test-demo.id_rsa" ec2-user@35.74.32.103 

Dockerインストール/起動/動作確認
sudo dnf install -y docker
sudo systemctl enable --now docker
systemctl status docker
https://densan-hoshigumi.com/aws/amzn2023-docker-install

nginxインストール
sudo dnf install nginx
https://qiita.com/Tosh39/items/5f7d038f536e2565dd89
sudo systemctl start nginx


Basic認証
sudo yum install httpd-tools
sudo htpasswd -c /etc/nginx/.htpasswd kotoku
UserName:kotoku
password:password
sudo vim /etc/nginx/nginx.conf
# Proxyの設定追加
    location / {
          proxy_pass http://localhost:3000;
    }
# Basic認証の設定追加
	location / {
          auth_basic "認証情報を入力してください。";
          auth_basic_user_file /etc/nginx/.htpasswd;
	}
sudo nginx -t
sudo systemctl restart nginx
python3 -m http.server 3000
https://reigle.info/entry/2022/08/17/100000

