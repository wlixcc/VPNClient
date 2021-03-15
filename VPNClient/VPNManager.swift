//
//  VPNManager.swift
//  VPNClient
//
//  Created by wl on 2021/3/15.
//

import Foundation
import NetworkExtension

class VPNManager {
    
    static let shared = VPNManager()
    
    var manager: NETunnelProviderManager?
    
    func connect() {
        guard self.manager != nil else {
            return
        }
        self.loadPreferences()
    }
    
    func disconnect() {
        self.manager?.connection.stopVPNTunnel()
    }
    
    //加载已保存的NETunnelProvider configurations
    func loadManager() {
        NETunnelProviderManager.loadAllFromPreferences { (managers, error) in
            guard error == nil else {
                return
            }
            if let manager = managers?.first {
                self.manager = manager
            } else {
                //新建
                self.manager = NETunnelProviderManager()
                self.manager?.localizedDescription = "myVPN"
            }
            print("VPNManager 初始化完成")
        }
    }
    
    //加载当前vpn配置
    func loadPreferences() {
        guard let manager = self.manager else {
            return
        }
        
        self.manager?.loadFromPreferences { (error) in
            guard error == nil else {
                return
            }
            
            // 如果没有对应的配置,我们需要新建配置
            if manager.protocolConfiguration == nil {
                manager.protocolConfiguration = self.newConfiguration()
            }
            
            // 设置完isEnabled需要保存配置,启动当前配置
            manager.isEnabled = true
            manager.saveToPreferences { (error) in
                guard error == nil else {
                    // 用户拒绝保存等情况,清空配置
                    manager.protocolConfiguration = nil
                    return
                }
                // 保存完成后我们需要重新加载配置,进行连接,
                //https://stackoverflow.com/questions/47550706/error-domain-nevpnerrordomain-code-1-null-while-connecting-vpn-server
                self.loadPreferencesAndStartTunnel()
            }
            
        }
    }
    
    func loadPreferencesAndStartTunnel()  {
        self.manager?.loadFromPreferences(completionHandler: { (error) in
            guard error == nil else {
                return
            }
            self.startTunnel()
        })
    }
    
    private func startTunnel() {
        do {
            try self.manager?.connection.startVPNTunnel()
        } catch  {
            print(error)
        }
    }
    

    
    func newConfiguration() -> NETunnelProviderProtocol {
        //加载ovpn文件
        guard
            let configurationFileURL = Bundle.main.url(forResource: "vpnclient", withExtension: "ovpn"),
            let configurationFileContent = try? Data(contentsOf: configurationFileURL)
        else {
            fatalError()
        }
        
        let tunnelProtocol = NETunnelProviderProtocol()
        tunnelProtocol.serverAddress = ""
        //指定network extension 确保bundleIdentifier和network extension的id一致
        tunnelProtocol.providerBundleIdentifier = Bundle.main.bundleIdentifier!.appending(".vpn-tunnel")
        tunnelProtocol.providerConfiguration = ["ovpn": configurationFileContent]
        
        return tunnelProtocol
    }
    
    
    
    private init(){
        
    }
}
