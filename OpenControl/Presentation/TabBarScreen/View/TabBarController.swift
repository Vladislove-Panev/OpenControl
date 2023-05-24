//  
//  TabBarViewController.swift
//  OpenControl
//
//  Created by Vladislav Panev on 24.05.2023.
//

import UIKit

protocol TabBarViewInput: AnyObject {
    var presenter: TabBarPresenterInput? { get set }
    var output: TabBarViewOutput? { get set }
    func set(controllers: [TabBarModel.Controller])
}

protocol TabBarViewOutput: AnyObject {
    func viewWillAppear()
}

final class TabBarController: UITabBarController {
    
    weak var output: TabBarViewOutput?
    var presenter: TabBarPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    private func configureTabBar() {
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.interRegular400(with: 10) ?? .systemFont(ofSize: 10)],
            for: .normal
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.interRegular400(with: 10) ?? .systemFont(ofSize: 10)],
            for: .selected
        )
        
        tabBar.unselectedItemTintColor = R.color.tabBarItemColor()
        tabBar.tintColor = R.color.mainSecondaryColor()
        tabBar.backgroundColor = R.color.tabBarColor()
        tabBar.isTranslucent = false
    }
}

extension TabBarController: TabBarViewInput {
    func set(controllers: [TabBarModel.Controller]) {
        viewControllers = controllers.compactMap({ $0.viewController })
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
}
