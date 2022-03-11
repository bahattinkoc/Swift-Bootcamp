//
//  ViewController.swift
//  PinGame
//
//  Created by Bahattin Koç on 5.03.2022.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var timer = Timer()
    private var slides = [SlideVC]()
    private let pVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    private func goMainPage(){
        let onboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Pin.StoryboardID.tabbarVC)
        onboard.modalPresentationStyle = .fullScreen
        present(onboard, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissNotification(notification:)), name: Notification.Name("endLoad"), object: nil)
    }
    
    @objc func dismissNotification(notification: Notification)
    {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true, completion: nil)
            self.goMainPage()
            print("ONBOARD Games Count: \(Global.instance.games.count) --- \(Global.instance.headerGamePages.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSlides()
        
        // onboardingin otomatik olarak 3sn de bir sonraki sayfaya geçiş yapması
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            self.nextPage()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.object(forKey: "PassOnboard") != nil {
            goMainPage()
            return
        }
        UserDefaults.standard.set(true, forKey: "PassOnboard")
        
        confPageControl()
        loadPVC()
    }
    
    private func loadSlides(){
        for slide in Slide.slides{
            let page = SlideVC()
            page.configure(slide: slide)
            slides.append(page)
        }
    }
    
    func loadPVC(){
        guard let first = slides.first else { return }
        pVC.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        pVC.dataSource = self
        pVC.delegate = self
        pVC.modalPresentationStyle = .fullScreen
        self.view.addSubview(pVC.view)
        self.view.bringSubviewToFront(skipButton)
        self.view.bringSubviewToFront(nextButton)
        self.view.bringSubviewToFront(pageControl)
    }

    private func confPageControl(){
        pageControl.numberOfPages = Slide.slides.count
        pageControl.currentPage = 0
    }
    
    // Birden fazla yerde kullanıldığı için fonksiyon olarak yazıldı
    private func nextPage(){
        let currentPage = self.pageControl.currentPage
        if currentPage >= (self.pageControl.numberOfPages - 1) {
            updateBeforeDismiss()
        } else {
            self.pVC.setViewControllers([self.slides[currentPage + 1]], direction: .forward, animated: true, completion: nil)
            self.pageControl.currentPage = currentPage + 1
            
            nextButton.setTitle((currentPage+1 >= (self.pageControl.numberOfPages - 1)) ? "Finish" : "Next", for: .normal)
            skipButton.isHidden = (currentPage+1 >= (self.pageControl.numberOfPages - 1)) ? true : false
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        nextPage()
    }
    
    @IBAction func skipButton(_ sender: Any) {
        updateBeforeDismiss()
    }
    
    func updateBeforeDismiss(){
        timer.invalidate()
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true) {
            DispatchQueue.main.async {
                // GameList'i çek (ilk sayfa)
                Global.instance.pullGameList(1)
            }
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = slides.firstIndex(of: viewController as! SlideVC), index > 0 else { return nil }
        return slides[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = slides.firstIndex(of: viewController as! SlideVC), index < (slides.count - 1) else { return nil }
        return slides[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let page = pageViewController.viewControllers![0]
        self.pageControl.currentPage = slides.firstIndex(of: page as! SlideVC)!
        nextButton.setTitle((self.pageControl.currentPage >= (self.pageControl.numberOfPages - 1)) ? "Finish" : "Next", for: .normal)
        skipButton.isHidden = (self.pageControl.currentPage >= (self.pageControl.numberOfPages - 1)) ? true : false
    }
}
