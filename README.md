# Nagano-cake
<<ながのCAKE>>の商品を通販するためのECサイト。

## 概要

#### 顧客側の機能
・アカウント作成無しでながのCAKEの商品の閲覧が可能。<br>
・通販を利用する場合は、お客様にアカウントを作成して頂き、商品をカートに入れ注文が可能。<br>
・商品の配送先は自宅以外にも登録ができ、プレゼントとして配送することも可能。<br>

#### 管理者側の機能
・商品、ジャンル、顧客情報の編集が可能。<br>
・お客様からの注文の管理、配送までの管理が可能。

## 機能
・deviceを使用したログイン機能<br>
・ransackを使用したサーチ機能<br>
・【顧客側】カート機能、注文機能、退会機能<br>
・【管理者側】ジャンル、顧客詳細、商品追加機能<br>

## 必要条件
ER図<br>https://drive.google.com/open?id=1pgDB8ticJ3Z8W7QZpGq_ZkClo1NTPaJr&authuser=mmwanco082%40gmail.com&usp=drive_fs<br>
テーブル定義書<br>https://docs.google.com/spreadsheets/d/160pgJmINAop13yF_lPqEHlBbOGwaCCXvdNuADNyk80Y/edit#gid=1303550269<br>
アプリケーション詳細設計書<br>https://docs.google.com/spreadsheets/d/1-_tuBF-6aDZ0rlGyrfeeI13VWnQbCNOUPtKuPjukSI0/edit#gid=549108681<br>

## 使い方
管理者、顧客側それぞれログインはメールアドレスを【nagano0323@gmail.com】、パスワードは【Nagano0323】で使用出来ます。
顧客側の場合、新規作成で好きなアカウントを作成しても利用が可能です。<br>
また、ジャンルが現状、ケーキ、プリン、焼き菓子、キャンディの4ジャンルあるとの事だったので最初に実装させていただきました。
ジャンルの変更や追加は可能です。

## バージョン
Rails 6.1.7
ruby  3.1.2

## インストール
$ git clone git@github.com:e-obentou-member/nagano-cake.git<br>
$ cd nagano-cake<br>
$ rails db:migrate<br>
$ rails db:seed<br>
$ bundle install<br>

## 作者
まっすー、わんこ、かっきー、あや





