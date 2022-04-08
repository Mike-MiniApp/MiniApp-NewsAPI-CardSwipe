//
//  ViewController.swift
//  MiniApp-NewsAPI-CardSwipe
//
//  Created by 近藤米功 on 2022/04/06.
//

import UIKit

class NewsCategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var newsCategory = ["entertainment","business","sports","technology"]
    var selectedNewsCategory: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCategoryCell")
    }

    // TODO: このタイミングでAPI通信しても良いかも？
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cardSwipeViewController = segue.destination as! CardSwipeViewController
        cardSwipeViewController.catchNewsCategory = selectedNewsCategory
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // tableViewの編集モードをONにする
        tableView.isEditing = editing
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension NewsCategoryViewController: UITableViewDelegate,UITableViewDataSource{
    // カテゴリの数だけ、セルの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCategory.count
    }

    // カテゴリをセルに反映させる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCategoryCell = tableView.dequeueReusableCell(withIdentifier: "newsCategoryCell", for: indexPath) as! NewsCategoryTableViewCell
        newsCategoryCell.newsCategoryLabel.text = newsCategory[indexPath.row]
        return newsCategoryCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // セルをタップしたら画面遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNewsCategory = newsCategory[indexPath.row]
        performSegue(withIdentifier: "CardSwipeViewControllerSegue", sender: nil)
    }

    // TODO: なにしてるかよくわからんから後で調べる
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    // TODO: なにしてるかよくわからんから後で調べる
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    // cellの並び替えを許可
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // TODO: なにしてるかよくわからんから後で調べる
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let newsCategoryCellItem = newsCategory[sourceIndexPath.row]
        guard let indexPath = newsCategory.firstIndex(of: newsCategoryCellItem) else {
            return
        }
        newsCategory.remove(at: indexPath)
        newsCategory.insert(newsCategoryCellItem, at: destinationIndexPath.row)
    }
}

