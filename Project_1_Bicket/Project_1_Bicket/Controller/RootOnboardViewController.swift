//
//  RootOnboardViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 10.02.2022.
//

import UIKit

class RootOnboardViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    var pages = [OnboardViewController]()
    let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "PassOnboard")
        
        let page1 = OnboardViewController()
        page1.setup(image: UIImage(named: "image2")!, titleText: "Title1", detailText: "Detail1")
        let page2 = OnboardViewController()
        page2.setup(image: UIImage(named: "image2")!, titleText: "Title2", detailText: "Detail2")
        let page3 = OnboardViewController()
        page3.setup(image: UIImage(named: "image2")!, titleText: "Title3", detailText: "Detail3")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uiPageVC()
    }
    
    func uiPageVC(){
        guard let first = pages.first else { return }
        pvc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        pvc.dataSource = self
        pvc.modalPresentationStyle = .fullScreen
        self.view.addSubview(pvc.view)
        self.view.bringSubviewToFront(pageControl)
    }
}

extension RootOnboardViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardViewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardViewController), index < (pages.count - 1) else { return nil }
        return pages[index + 1]
    }
}
