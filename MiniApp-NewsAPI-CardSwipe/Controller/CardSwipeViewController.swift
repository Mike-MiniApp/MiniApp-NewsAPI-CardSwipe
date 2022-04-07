//
//  NewsCardSwipeViewController.swift
//  MiniApp-NewsAPI-CardSwipe
//
//  Created by 近藤米功 on 2022/04/06.
//

import UIKit
import VerticalCardSwiper
class CardSwipeViewController: UIViewController{
    // TODO: このあたりの命名はcatchとかでよいのか？
    public var catchNewsCategory: String = ""
    public var catchTotalResult: Int = 10
    var requestNewsData = CatchNewsData()
    @IBOutlet weak var cardSwiper: VerticalCardSwiper!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCardSwiper()
        requestNewsData.delegate = self
        print(catchNewsCategory)
        requestNewsData.request(searchWord: catchNewsCategory)
    }

    private func setUpCardSwiper(){
        cardSwiper.delegate  = self
        cardSwiper.datasource = self
        cardSwiper.register(nib: UINib(nibName: "NewsCardViewCell", bundle: nil), forCellWithReuseIdentifier: "newsCardCell")
        cardSwiper.reloadData()
    }

}
extension CardSwipeViewController: VerticalCardSwiperDatasource,VerticalCardSwiperDelegate,CatchNewsDataDelegate{

    // CatchN
    func catchNewsData(title: String, url: String, urlToImage: String, publishedAt: String) {
        // TODO: 引数を配列にする
        print("catchNewsData")
        print(title)
        print(url)
        print(urlToImage)
    }

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        catchTotalResult
    }

    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "newsCardCell", for: index) as? NewsCardViewCell {
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            // カードの背景色を指定する
            cardCell.setRandomBackgroundColor()
            cardCell.testLabel.text = catchNewsCategory
            return cardCell
        }
        return CardCell()
    }
    
}
