# アイコンフォント調査

## 要旨
### 各手法について
アプリがiOS13以降のターゲットであれば、標準サポートしているXcode12の機能を使用したほうが良いです。  
Xcode12では、これまでのPNGなどと同じようにSVGを設定できます。  
SVG画像の塗りつぶしについては、メソッド一発で指定可能です。  
一方でライブラリを使ってしまうと、Interface Builder上で画像指定がやりにくくなってしまいます。  
また、画像の塗りつぶしについても自前で実装しなければなりません。  
そのため、同じ画像をサイズ別に大量に書き出さないといけない、といった仕様がない限り、  
対象OSの最低バージョンがiOS13になるまで、待っていたほうが良いと思います。  
Androidはもとから標準サポートしているので、Android Studioの機能で十分です。  

### 導入について
おおよそ下記のような方針で良いと思われます。
- iOS
 ターゲットがiOS13以降になってからXcode標準のものを使用
 ※ もしiOS12以前にSVGを使う必要がある場合には、SVGKitを使用
- Android
 iOSと同タイミングでSDK標準を使用

## iOS

### SVGKitを使った方法

#### ライブラリの選定
デモアプリではSVGKitを使用しており、採用理由として下記がございます。
- 現状の画像運用に沿っている  
SVGKitはSVGファイルからUIImageを取得できるライブラリです。  
現状の画像リソースの扱いを考えると、SwiftSVGといったパス関係よりも、  
SVGKitが適していると考えたためです。  
- 更新が止まっていない  
3.x系が現在開発中であり、2020年7月のコミットがあります。  
- マルチパスに対応

#### SVGKitの概要
下記のようにして、簡単にSVGからUIImageを取得できます。
```
let svg = SVGKImage(named: "sample")
svg.size = svg.bounds.size
let image = svg.uiImage
```

ただし、塗りつぶし色の指定はサポートしていません。
そのために色を指定する場合は、下記のうち、いずれかが必要です。
- SVGをカラーにする
- UIImageView.tintColorを指定
- UIImageに対するマスク処理を実装

#### デモアプリ
- プロジェクト  
  ios/IconFontDemo_SVGKit
- 概要  
  3種類のSVGを画面上に表示します。
- ポイント
  - UIImage+SVGKitにSVG画像の読み込み処理を実装
  - SVGの読み込み、塗りつぶし色を指定した読み込みに対応
  - 色の塗りつぶしは、UIImageをマスクする方法で実現

### Xcode12を使った方法

#### 概要
Xcode12からSVGが標準サポートされるようになりました。  
ただしiOS13以降対応のため、現状は採用することができません。  
iOS12以前でSVGを表示する場合はSVGKitのようなライブラリが必要です。  

#### SVG追加方法
1. Assets > ＋ > Image Setを追加
2. Image Set > Scales > Single Scaleに変更
3. Image Set > Resizing > Preserve Vector Dataにチェック  
  ※これを設定しないと、画像が滲みます
4. SVGファイルをドラッグ＆ドロップ

#### 表示方法
Interface Builderとソース上どちらでもOKです。  
- Interface Builder  
 PNGと同じように、UIImageView.imageにリソース名を設定  
- ソース  
 PNGと同じように、UIImageを作成して、UIImageView.imageに代入します  
```
// SVGをそのまま表示
self.imageView.image = UIImage(named: "star")
// 塗りつぶして表示する場合は、withTintColor（iOS13以降）を使う
self.imageView.image = UIImage(named: "star")?.withTintColor(.green)
```

#### デモアプリ
- プロジェクト  
  ios/IconFontDemo_Xcode12
- 概要  
  2種類のSVGを画面上に表示します。
  
## Android

#### 概要
AndroidはSVGを標準サポートしています（API Level 21以降）。  
マルチパスに対応していますし、SVG表示はSDK標準の機能で良いと思われます。  

基本的には、下記のようにしてSVG指定可能です。  
- リソースはdrawableで指定  
- 塗りつぶし色はtintで指定

```
<ImageView
  ~ 省略 ~
  android:src="@drawable/ic_star"
	android:tint="@color/colorPrimary" />

val imageView: ImageView = findViewById(R.id.imageView)
imageView.setImageResource(R.drawable.ic_mac)
```

#### デモアプリ
- プロジェクト  
 android/IconFontDemo  
- 概要  
 2種類のSVGを画面上に表示します。
