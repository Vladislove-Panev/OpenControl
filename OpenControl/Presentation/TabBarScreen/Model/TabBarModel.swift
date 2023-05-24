//  
//  TabBarModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 24.05.2023.
//

import UIKit

protocol TabBarModelOutput: AnyObject {
    
}

protocol TabBarModelInput {
    var output: TabBarModelOutput? { get set }
    var controllers: [TabBarModel.Controller] { get }
}

final class TabBarModel {
    
    enum ControllerType: CaseIterable {
        
        case main
        case appeal
        case payment
        case profile
        
        var tabBarItem: UITabBarItem {

            switch self {
            case .main:
                return UITabBarItem(title:"Главная", image: R.image.mainTabBarIcon(), tag: 0)
            case .appeal:
                return UITabBarItem(title: "Обращения", image: R.image.appealTabBarIcon(), tag: 1)
            case .payment:
                return UITabBarItem(title: "Платежи", image: R.image.paymentsTabBarIcon(), tag: 2)
            case .profile:
                return UITabBarItem(title: "Профиль", image: R.image.profileTabBarIcon(), tag: 3)
            }
        }
        
        func viewController() -> UIViewController {
            
            switch self {
            case .main:
                let vc = UIViewController()
                vc.view.backgroundColor = .black
                return UINavigationController(rootViewController: vc)
            case .appeal:
                let vc = UIViewController()
                vc.view.backgroundColor = .blue
                return UINavigationController(rootViewController: vc)
            case .payment:
                let vc = UIViewController()
                vc.view.backgroundColor = .yellow
                return UINavigationController(rootViewController: vc)
            case .profile:
                let vc = UIViewController()
                vc.view.backgroundColor = .red
                return UINavigationController(rootViewController: vc)
            }
        }
        
    }
    
    struct Controller {
        
        let type: ControllerType
        let viewController: UIViewController
        
        init(with type: ControllerType) {
            self.type = type
            self.viewController = type.viewController()
            self.viewController.tabBarItem = type.tabBarItem
        }
    }
    
    weak var output: TabBarModelOutput?
    
    private var cachedControllers: [Controller] = []
}

extension TabBarModel: TabBarModelInput {
    var controllers: [Controller] {
        guard cachedControllers.isEmpty else { return cachedControllers }
        var newControllers: [Controller] = []
        ControllerType.allCases.forEach({ newControllers.append(Controller(with: $0)) })
        cachedControllers = newControllers
        return newControllers
    }
}
