//
//  NewsCardViewCell.swift
//  MiniApp-NewsAPI-CardSwipe
//
//  Created by 近藤米功 on 2022/04/06.
//

import UIKit
import VerticalCardSwiper

// UITableViewCell → CardCellに変更
class NewsCardViewCell: CardCell {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlToImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // ライブラリのコードからそのまま拝借
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    // ライブラリのコードからそのまま拝借
    override func layoutSubviews() {
        self.layer.cornerRadius = 12
        super.layoutSubviews()
    }

    // カードの背景をランダムにする
    public func setRandomBackgroundColor() {
        let randomRed: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
}
