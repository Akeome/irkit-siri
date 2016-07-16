//
//  ViewController.swift
//  irkit-siri
//
//  Created by 山下 優樹 on 2016/07/16.
//  Copyright © 2016年 Yuki Yamashita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // アプリ起動時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // IRKitへ信号送信
        sendData()
        // アプリの強制終了
        finish(5)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 画面押下時の処理
    @IBAction func buttonAction(sender: AnyObject) {
        
        // IRKitへ信号送信
        sendData()
        // アプリの強制終了
        finish(5)
    }
    
    
    
    // IRKitへ信号送信
    func sendData() {
        
        // TODO: IPアドレスを貼り付ける
        let myUrl:NSURL = NSURL(string:"http://192.XXX.XXX.XXX/messages")!
        let myRequest:NSMutableURLRequest  = NSMutableURLRequest(URL: myUrl)
        
        myRequest.HTTPMethod = "POST"
        
        // JSON作成
        myRequest.addValue("application/json", forHTTPHeaderField: "X-Requested-With")
        
        let params: [String: AnyObject] = [
            "format": "raw",
            "freq": "38",
            // TODO: 信号を貼り付ける
            "data": [123,456,7890]
        ]
        
        do {
            try myRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            print(error)
        }
        
        // リクエスト送信
        let task = NSURLSession.sharedSession().dataTaskWithRequest(myRequest)
        task.resume()
        
    
    }
    
    
    
    // sec秒後にアプリを終了させる
    func finish(sec :Double) {
        
        let delay = sec * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            exit(0)
        })
    }


}

