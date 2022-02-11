//
//  ViewController.swift
//  week-5
//
//  Created by Bahattin Koç on 4.02.2022.
//

import UIKit

// MARK: Onboarding örneği yapınız. (karşılama ekranı) (collectionview veya pageviewcontroller kullanabilirsin)
// Kaçıncı sayfada olduğumuzu gösteren birde pageControl ekleyeceğiz. (+ ya tıkla pageControl yaz)

// MARK: ViewController yaşam döngüsünü araştırınız. Her biri için neler kullanabilir örnek vermeye çalışınız. (SegmentedController)

// MARK: Searchbarda elle kelimeyi silincie tüm verileri geri getirmelisiniz
// MARK: Eğer veri bulunamıyorsa custom empty view bir view oluşturarak kullanıcıya onu göstermelisiniz. 

class ViewController: UIViewController {

    var controllers = [UIViewController]()
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        
        var vc2 = UIViewController()
        vc2.view.backgroundColor = .blue
        
        var vc3 = UIViewController()
        vc3.view.backgroundColor = .green
        
        controllers.append(vc1)
        controllers.append(vc2)
        controllers.append(vc3)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pageVC()
    }
    
    func pageVC(){
        guard let first = controllers.first else { return }
        let vc = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        vc.delegate = self
        vc.dataSource = self
        vc.modalPresentationStyle = .fullScreen
        vc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        present(vc, animated: true, completion: nil)
    }

}














extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        
        let previous = index - 1
        
        return controllers[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1) else { return nil }
        
        let previous = index + 1
        
        return controllers[previous]
    }
}
