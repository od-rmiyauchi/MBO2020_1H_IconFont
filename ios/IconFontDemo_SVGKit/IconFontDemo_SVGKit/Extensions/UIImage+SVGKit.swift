//
//  UIImage+SVGKit.swift
//  IconFontDemo_SVGKit
//
//  Created by 宮内 龍之介 on 2020/08/27.
//  Copyright © 2020 opendoor. All rights reserved.
//

import UIKit
import SVGKit

extension UIImage {

	/// SVG画像を取得
	/// - Parameters
	///   - name: SvgNameで定義されているSVG名
	///   - size: 画像サイズ
	/// - Returns: UIImageに変換したSVG画像
	class func svg(_ name: SvgName, size: CGSize) -> UIImage? {
		guard let asset = NSDataAsset(name: name.rawValue) else { return nil }
		let svg = SVGKImage(data: asset.data)
		svg?.size = size
		return svg?.uiImage
	}

	/// SVG画像を取得
	/// - Parameters
	///   - name: SvgNameで定義されているSVG名
	///   - size: 画像サイズ
	///   - color: 塗りつぶし色
	/// - Returns: UIImageに変換したSVG画像
	class func svg(_ name: SvgName, size: CGSize, color: UIColor) -> UIImage? {
		let image = svg(name, size: size)
		return image?.mask(with: color)
	}

	/// UIImageを単色でマスクする
	/// - Parameter color 塗りつぶし色
	/// - Returns: 塗りつぶされた画像
	func mask(with color: UIColor) -> UIImage? {
		let maskImage = cgImage!

		let width = size.width
		let height = size.height
		let bounds = CGRect(x: 0, y: 0, width: width, height: height)

		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
		let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

		context.clip(to: bounds, mask: maskImage)
		context.setFillColor(color.cgColor)
		context.fill(bounds)

		if let cgImage = context.makeImage() {
			let coloredImage = UIImage(cgImage: cgImage)
			return coloredImage
		} else {
			return nil
		}
	}
}
