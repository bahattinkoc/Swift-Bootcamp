//
//  ViewController.swift
//  week5Projects
//
//  Created by Bahattin Koç on 5.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var signUpBtn: UIButton!
    let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    @IBOutlet weak var logoImageView: UIImageView!
    var pages = [TemplateViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let page1 = TemplateViewController() //251,205,139,255
        page1.setup(image: UIImage(named: "1")!, titleLabel: "CONAL", detailLabel: "A TOOL FOR TRADERS AND SCALPERS", color: UIColor(red: 251/255.0, green: 205/255.0, blue: 139/255.0, alpha: 1.0))
        
        let page2 = TemplateViewController()
        page2.setup(image: UIImage(named: "2")!, titleLabel: "WATCHLIST", detailLabel: "CREATE A WATCHLIST BY CHOOSING THE CRYPTOCURRENCIES YOU WANT", color: .white)
        
        let page3 = TemplateViewController()
        page3.setup(image: UIImage(named: "3")!, titleLabel: "SIGNALS", detailLabel: "EXAMINE THE SIGNALS CREATED FOR YOU", color: .white)
        
        let page4 = TemplateViewController()
        page4.setup(image: UIImage(named: "4")!, titleLabel: "SETTINGS", detailLabel: "MANY INDICATORS AND ALL ARE CUSTOMIZABLE SELECT, SAVE AND START", color: .white)
        
        let page5 = TemplateViewController()
        page5.setup(image: UIImage(named: "5")!, titleLabel: "SELECT EXCHANGE", detailLabel: "CHOOSE FROM 30+ EXCHANGES", color: .white)
        
        let page6 = TemplateViewController()
        page6.setup(image: UIImage(named: "6")!, titleLabel: "LEARN", detailLabel: "LEARN STRATEGY FOR TRANDING AND SCALPING", color: .white)
        
        let page7 = TemplateViewController()
        page7.setup(image: UIImage(named: "7")!, titleLabel: "ANALYZE", detailLabel: "EXAMINE THE CHARTS OF THE SIGNAL", color: .white)
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        pages.append(page6)
        pages.append(page7)
        
        pageControl.numberOfPages = pages.count // pageControlün kaç nokta göstereceği
        pageControl.currentPage = 0 // pageControlün şuanki gösterim indisi
        
        signUpBtn.isHidden = true
    }
    
    @IBAction func logInAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isFirst")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pageControlView()
    }

    func pageControlView(){
        guard let first = pages.first else { return }
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.modalPresentationStyle = .fullScreen
        pageVC.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        self.view.addSubview(pageVC.view) // PageControlView'ı ana view'a ekledik
        self.view.bringSubviewToFront(pageControl) // Page Controlü üstte tutabilmek için yazdık
        self.view.bringSubviewToFront(logoImageView)
        self.view.bringSubviewToFront(signUpBtn)
        // present(vc, animated: true, completion: nil) // Bunu yaparsak ekstra bir safya açıyor. Üstteki yöntem ise var olan sayfanın içerisine ekliyor
    }
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! TemplateViewController), index > 0 else { return nil }
        
        let previous = index - 1
        return pages[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! TemplateViewController), index < (pages.count - 1) else { return nil }
        
        let previous = index + 1
        return pages[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let page = pageViewController.viewControllers![0] // şuan gösterilen sayfa
        self.pageControl.currentPage = pages.firstIndex(of: page as! TemplateViewController)! // o sayfasın bizim arrayimizdeki indisi
        signUpBtn.isHidden = (pages.firstIndex(of: page as! TemplateViewController)! == pages.count-1) ? false : true
    }
}
