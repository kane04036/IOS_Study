//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by 제임스 on 2022/10/20.
//

import UIKit


class DiaryDetailViewController: UIViewController {
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var starButton:UIBarButtonItem?
    
    var diary:Diary?
    var indexPath:IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    private func configureView(){
        guard let diary = self.diary else {return}
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(date: diary.date)
        self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
    }
    private func dateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @objc func editDiaryNotification(_ notification: Notification){
        guard let diary = notification.object as? Diary else {
            return
        }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else {return}
        self.diary = diary
        self.configureView()
        
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        guard let indexPath = indexPath else {
            return
        }
        guard let diary = diary else {
            return
        }
        ViewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else {return}
        NotificationCenter.default.post(name: NSNotification.Name("deleteDiary"), object: indexPath, userInfo: nil)
         self.navigationController?.popViewController(animated: true)
    }
    @objc func tapStarButton(){
        guard let isStar = self.diary?.isStar else {return}
        guard let indexPath = self.indexPath else {
            return
        }
        
        if isStar{
            self.starButton?.image = UIImage(systemName: "star")
        }else{
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        NotificationCenter.default.post(
            name: NSNotification.Name("starDiary"),
            object: [
                "diary": self.diary,
                "isStar":self.diary?.isStar ?? false,
                "indexPath":indexPath
            ],
            userInfo: nil)
        
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
