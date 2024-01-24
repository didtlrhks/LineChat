//
//  AppDelegate.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//


import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.registerForRemoteNotifications() // 여기서 이제 우리앱의 토큰을 불러다가 호출을 해달라고 Apns 에 요청을 하는거고
        UNUserNotificationCenter.current().delegate = self // 이부분에서 노티를 연결해주는거고
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken // 여기서 data 로 받아서 사용할수있도록 하는거임
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate { //여기서 추가적인 기능들을 추가를 해주려고하는거임
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner]) // foreground 에서 푸시를 받았을때 이함수를 호출하기위해서
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler() // 알림을 눌럿을때 무언가를 할수있는 함수를 생성 
    }
}
