//
//  ViewController.swift
//  TestMessage
//
//  Created by rolodestar on 2020/8/8.
//  Copyright © 2020 Rolodestar Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var btn: UIButton!
    var connectBtn : UIButton!
    var socket = MySocket.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(getNewMssage), name: NSNotification.Name.newMessageAppend, object: nil)
        socket.connectToHost()
        btn = UIButton(frame: CGRect(x: 10, y: 100, width: 100, height: 40))
        btn.setTitle("发送", for: UIControl.State.normal)
        btn.backgroundColor = UIColor.black
        btn.addTarget(self, action: #selector(onClickedBtn), for: UIControl.Event.touchUpInside)
        
        connectBtn = UIButton(frame: CGRect(x: 10, y: 200, width: 100, height: 40))
        connectBtn.setTitle("link", for: UIControl.State.normal)
        connectBtn.backgroundColor = UIColor.black
        connectBtn.addTarget(self, action: #selector(onClickedLink), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
        self.view.addSubview(btn)
        self.view.addSubview(connectBtn)
    }


    @objc func onClickedLink(){
        socket.connectToHost()
    }
    @objc func onClickedBtn(){
//        let msg = TextBody(from: "mac", to: "server", message: "hi,server")
        let msg = ImageBody(from: "mac", to: "server", image: UIImage(named: "test")!)
        socket.sendMessage(message: msg)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func getNewMssage(){
        let msgs = MessageVector.shared
        print(msgs.messages.last?.body.description)
    }
}

