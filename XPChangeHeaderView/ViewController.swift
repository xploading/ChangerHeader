//
//  ViewController.swift
//  XPChangeHeaderView
//
//  Created by qianfeng on 2016/12/21.
//  Copyright © 2016年 耿晓鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tabView : UITableView?
    var headerView : UIView?
    var backImgView : UIImageView?
    var tempW : CGFloat?
    var tempH : CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.isNavigationBarHidden = true
        self.createbackImgView()
        self.layoutTabView()
        
    }
    
    //创建头视图
    func createbackImgView(){
        let image = UIImage(named: "back")
        self.backImgView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: Tools.screenW, height: (image?.size.height)! * 0.8))
        self.backImgView?.image = image
        tempW = backImgView?.frame.width
        tempH = backImgView?.frame.height
        self.view.addSubview(self.backImgView!)

    }
    //创建头视图
    func createHeaderView() -> UIView{
        self.headerView = UIView(frame: CGRect.init(x: 0, y: 64, width: Tools.screenW, height: 170))
        let imageView = UIImageView(image: UIImage(named: "header"))
        imageView.frame = CGRect.init(x: 0, y: 100, width: 50, height: 50)
        self.headerView?.addSubview(imageView)
        self.headerView?.backgroundColor = UIColor.clear
        return self.headerView!
        
    }
    
    func layoutTabView(){
        tabView = UITableView(frame: CGRect.init(x: 0, y: 64, width: Tools.screenW, height: Tools.screenH-64))
        tabView?.delegate = self
        tabView?.dataSource = self
        tabView?.backgroundColor = UIColor.clear
        tabView?.tableHeaderView = createHeaderView()
        self.view.addSubview(tabView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tabView?.dequeueReusableCell(withIdentifier: "1")
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "1")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentY = scrollView.contentOffset.y
        print(contentY)
        if contentY < 0{
            var rect = scrollView.frame
            rect.size.height = tempH! - contentY
            rect.size.width = tempW! - contentY
            rect.origin.x = -(rect.size.width-tempW!)/2
            rect.origin.y = 0
            self.backImgView?.frame = rect
        }else{
            var rect = scrollView.frame
            rect.size.height = tempH!
            rect.size.width = tempW!
            rect.origin.x = 0
            rect.origin.y = -contentY
            self.backImgView?.frame = rect
        }
    }
    
    
}








