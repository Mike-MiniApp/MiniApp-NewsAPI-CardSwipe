//
//  NewsCardSwipeViewController.swift
//  MiniApp-NewsAPI-CardSwipe
//
//  Created by 近藤米功 on 2022/04/06.
//

import UIKit
import VerticalCardSwiper
import SDWebImage
class CardSwipeViewController: UIViewController{
    // TODO: このあたりの命名はcatchとかでよいのか？
    public var catchNewsCategory: String = ""
    public var catchNewsDataArray: [NewsData] = []
    public var catchTotalResult: Int = 0
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

    // CatchNewsDataDelegateのデリゲートメソッド
    func catchNewsData(newsDataArray: [NewsData], totalResults: Int) {
        catchNewsDataArray = newsDataArray
        catchTotalResult = totalResults
        cardSwiper.reloadData()
    }

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        catchTotalResult
    }

    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "newsCardCell", for: index) as? NewsCardViewCell {
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            // カードの背景色を指定する
            cardCell.setRandomBackgroundColor()
            cardCell.urlToImageView.sd_setImage(with: URL(string: catchNewsDataArray[index].urlToImage),completed: nil)
            cardCell.titleLabel.text = catchNewsDataArray[index].title
            cardCell.publishedAtLabel.text = catchNewsDataArray[index].publishedAt
            cardCell.descriptionLabel.text = catchNewsDataArray[index].description
            return cardCell
        }
        return CardCell()
    }
    func sizeForItem(verticalCardSwiperView: VerticalCardSwiperView, index: Int) -> CGSize {
        // ドキュメントのコピペ
        return CGSize(width: verticalCardSwiperView.frame.width, height: verticalCardSwiperView.frame.height)
    }
    // スワイプしたときに発生するデリゲートメソッド
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        if swipeDirection == .Right{
            // webのURLを渡す
            // データベースにcount+1を渡す
            performSegue(withIdentifier: "WebNewsViewControllerSegue", sender: nil)
        }
    }
    
}
