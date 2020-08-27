# アイコンフォント調査

## iOS

### ライブラリを使った方法

#### ライブラリの選定
デモアプリではSVGKitを使用しており、採用理由として下記がございます。
- 現状の画像運用に沿っている
SVGKitはSVGファイルからUIImageを取得できるライブラリであるため、
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
