////
////  HeadlineCell.swift
////  NewsFlash
////
////  Created by Mena Maher on 8/27/25.
////
//
//import UIKit
//
//struct HeadlineListData {
//    var img: String = ""
//    var title: String = ""
//    var souce: String = ""
//    var publishDate: String = ""
//    
//    init(img: String, title: String, souce: String, publishDate: String) {
//        self.img = img
//        self.title = title
//        self.souce = souce
//        self.publishDate = publishDate
//    }
//}
//
//class HeadlineCell: UITableViewCell {
//    @IBOutlet weak var img: UIImageView!
//    @IBOutlet weak var titleLbl: UILabel!
//    @IBOutlet weak var sourceLbl: UILabel!
//    @IBOutlet weak var publishDateLbl: UILabel!
//    
//    var data: HeadlineListData? {
//        didSet {
//            titleLbl.text = data?.title//"No Way Up"
//            sourceLbl.text = data?.souce
//            publishDateLbl.text = data?.publishDate.dateString()//"2024-01-18"
//            img.loadImage(fromPathURL: data?.img ?? "")
//        }
//    }
//}
