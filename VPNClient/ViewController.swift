//
//  ViewController.swift
//  VPNClient
//
//  Created by wl on 2021/3/15.
//

import UIKit
import NetworkExtension

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VPNManager.shared.loadManager()
        
        NotificationCenter.default.addObserver(self, selector: #selector(statusChange), name: .NEVPNStatusDidChange, object: nil)
    }
    
    @objc
    func statusChange() {
        guard let manager = VPNManager.shared.manager else {
            return
        }
        switch manager.connection.status {
            case .connected:
            print("已连接")
        case .connecting:
            print("正在连接")
        case .disconnected:
            print("未连接")
        case .disconnecting:
            print("正在断开连接")
        default:
            print("其他状态")

        }
    }
    
    @IBAction func connect(_ sender: UIButton) {
        
        VPNManager.shared.connect()
    }
    
    @IBAction func disconnect(_ sender: Any) {
        
        VPNManager.shared.disconnect()
    }
    
    
}

