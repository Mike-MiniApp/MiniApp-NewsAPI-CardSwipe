//
//  RequestNewsData.swift
//  MiniApp-NewsAPI-CardSwipe
//
//  Created by 近藤米功 on 2022/04/06.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol CatchNewsDataDelegate{
    func catchNewsData(newsDataArray: [NewsData],totalResults: Int)
}

class CatchNewsData{
    var delegate: CatchNewsDataDelegate?
    var newsDataArray = [NewsData]()
    func request(searchWord: String){
        let urlString = "https://newsapi.org/v2/top-headlines?country=jp&category=\(searchWord)&apiKey=2dadbe9531074cfe86934358180c7e24"
        //エンコード
        let encorderUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        // TODO: for文で回して配列に格納するようにする
        // Alamofireによるリクエストを投げて、レスポンスをもらう
        AF.request(encorderUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result{
            case .success:
                do{
                    //レスポンスデータをJSON形式として受け取る
                    let json:JSON = try JSON(data: response.data!)

                    let totalResults: Int = json["totalResults"].int ?? 0
                    self.newsDataArray = []
                    for i in 0..<totalResults{
                        if let title = json["articles"][i]["title"].string,let url = json["articles"][i]["url"].string,let urlToImage = json["articles"][i]["urlToImage"].string,let publishedAt = json["articles"][i]["publishedAt"].string,let description = json["articles"][i]["description"].string{
                            let newsData = NewsData(title: title, publishedAt: publishedAt, url: url, urlToImage: urlToImage,description: description)
                            self.newsDataArray.append(newsData)
                            }
                    }
                    self.delegate?.catchNewsData(newsDataArray: self.newsDataArray,totalResults: totalResults)
                   }
                catch{
                    print("取得失敗")
                }
            case .failure(_):
                print("失敗")
            }
        }// AF.requestここまで
    }// requestここまで
}
