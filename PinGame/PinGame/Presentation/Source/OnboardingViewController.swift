//
//  ViewController.swift
//  PinGame
//
//  Created by Bahattin Koç on 5.03.2022.
//

import UIKit

final class OnboardingViewController: UIViewController {

    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    private var timer = Timer()
    private var slides = [SlideVC]()
    private var pageViewController: UIPageViewController!
    private var alert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissNotification(notification:)), name: NotificationNames.endLoad, object: nil)
        
        loadSlides()
        // onboardingin otomatik olarak 3sn de bir sonraki sayfaya geçiş yapması
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] timer in
            self?.nextPage(buttonClick: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.object(forKey: "PassOnboard") != nil {
            goMainPage()
        } else {
            UserDefaults.standard.set(true, forKey: "PassOnboard")
        }
        
        preparePageControl()
        preparePageViewController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }

    // MARK: - BUTTON ACTIONS
    
    @IBAction private func nextButtonAction(_ sender: Any) {
        nextPage(buttonClick: true)
    }
    
    @IBAction private func skipButton(_ sender: Any) {
        updateBeforeDismiss()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func loadSlides(){
        Slide.slides.forEach { slide in
            let page = SlideVC()
            page.configure(slide: slide)
            slides.append(page)
        }
    }
    
    private func goMainPage() {
        presentVC(storyboardName: "Main", storyboardId: .tabbarVC)
    }
    
    private func preparePageViewController() {
        guard let first = slides.first else { return }
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.modalPresentationStyle = .fullScreen
        
        view.addSubview(pageViewController.view)
        view.bringSubviewToFront(skipButton)
        view.bringSubviewToFront(nextButton)
        view.bringSubviewToFront(pageControl)
    }
    
    private func preparePageControl() {
        pageControl.numberOfPages = Slide.slides.count
        pageControl.currentPage = 0
    }
    
    // Birden fazla yerde kullanıldığı için fonksiyon olarak yazıldı
    private func nextPage(buttonClick: Bool) {
        let currentPage = pageControl.currentPage
        if currentPage >= (pageControl.numberOfPages - 1) {
            buttonClick ? updateBeforeDismiss() : timer.invalidate()
        } else {
            pageViewController.setViewControllers([slides[currentPage + 1]], direction: .forward, animated: true, completion: nil)
            pageControl.currentPage = currentPage + 1
            
            nextButton.setTitle((currentPage+1 >= (pageControl.numberOfPages - 1)) ? "Finish" : "Next", for: .normal)
            skipButton.isHidden = (currentPage+1 >= (pageControl.numberOfPages - 1)) ? true : false
        }
    }
    
    private func updateBeforeDismiss() {
        let loadingIndicator = UIActivityIndicatorView().getDefaultIndicatorView()
        
        alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true) {
            DispatchQueue.main.async {
                // GameList'i çek (ilk sayfa)
                CoreDataHelper.instance.pullGameList(1)
            }
        }
    }
    
    // MARK: - Selector
    
    @objc private func dismissNotification(notification: Notification) {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true, completion: nil)
            self.goMainPage()
        }
    }
}

// MARK: - EXTENSIONS

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let controller = viewController as? SlideVC,
              let index = slides.firstIndex(of: controller), index > 0,
              let slide = slides.get(at: index - 1) else { return nil }
        return slide
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = slides.firstIndex(of: viewController as! SlideVC), index < (slides.count - 1) else { return nil }
        return slides[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let page = pageViewController.viewControllers![0]
        pageControl.currentPage = slides.firstIndex(of: page as! SlideVC)!
        nextButton.setTitle((pageControl.currentPage >= (pageControl.numberOfPages - 1)) ? "Finish" : "Next", for: .normal)
        skipButton.isHidden = (pageControl.currentPage >= (pageControl.numberOfPages - 1)) ? true : false
    }
}

extension Collection {
    func get(at index: Index?) -> Iterator.Element? {
        guard let index = index, indices.contains(index) else { return nil }
        return self[index]
    }
}
