//
//  RootOnboardViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 10.02.2022.
//

import UIKit

class RootOnboardViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var pages = [OnboardViewController]()
    let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "PassOnboard")
        
        let page1 = OnboardViewController()
        page1.setup(image: UIImage(named: "image1")!, titleText: "24/7 Customer Service", detailText: "Our customer service team is with you 24/7 for all your transactions through bicket.com and bicket Mobile Applications. You can start Live Support and get help with one click.")
        let page2 = OnboardViewController()
        page2.setup(image: UIImage(named: "image2")!, titleText: "Secure Payment", detailText: "You can make all your bus ticket purchases easily, quickly and reliably from your home, office or mobile phone.")
        let page3 = OnboardViewController()
        page3.setup(image: UIImage(named: "image3")!, titleText: "Suitable for Every Budget", detailText: "Bicket offers you the opportunity to query and compare bus tickets of all companies. In this way, you can easily find and buy bus tickets that fit your budget.")
        let page4 = OnboardViewController()
        page4.setup(image: UIImage(named: "image4")!, titleText: "Most Exclusive Companies", detailText: "As Bicket, we have gathered the most exclusive bus companies for you. You can compare the bus tickets of all companies on obilet, find the appropriate bus ticket and buy it online.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        // onboardingin otomatik olarak 3sn de bir sonraki sayfaya geçiş yapması
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            self.nextPage(extrafunc: {
                timer.invalidate()
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uiPageVC()
    }
    
    private func uiPageVC(){
        guard let first = pages.first else { return }
        pvc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        pvc.dataSource = self
        pvc.delegate = self
        pvc.modalPresentationStyle = .fullScreen
        self.view.addSubview(pvc.view)
        self.view.bringSubviewToFront(pageControl)
        self.view.bringSubviewToFront(skipButton)
        self.view.bringSubviewToFront(nextButton)
    }
    
    // Birden fazla yerde kullanıldığı için fonksiyon olarak yazıldı
    private func nextPage(extrafunc: () -> Void){
        let currentPage = self.pageControl.currentPage
        if currentPage >= (self.pageControl.numberOfPages - 1) {
            self.dismiss(animated: true, completion: nil)
            extrafunc() // timer'ı durdurmak için eklendi
        } else {
            self.pvc.setViewControllers([self.pages[currentPage + 1]], direction: .forward, animated: true, completion: nil)
            self.pageControl.currentPage = currentPage + 1
            
            nextButton.setImage((currentPage+1 >= (self.pageControl.numberOfPages - 1)) ? UIImage.init(systemName: "checkmark") : UIImage.init(systemName: "arrow.forward"), for: .normal)
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        nextPage(extrafunc: {})
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension RootOnboardViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardViewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardViewController), index < (pages.count - 1) else { return nil }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let page = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: page as! OnboardViewController)!
        nextButton.setImage((self.pageControl.currentPage >= (self.pageControl.numberOfPages - 1)) ? UIImage.init(systemName: "checkmark") : UIImage.init(systemName: "arrow.forward"), for: .normal)
    }
}
