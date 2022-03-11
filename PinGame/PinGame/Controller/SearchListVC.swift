//
//  SearchListVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 7.03.2022.
//

import UIKit

class SearchListVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var notFoundImageView: UIImageView!
    
    private var selectedGameId: Int?
    private var timer = Timer()
    private let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    private let headerPageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private var isFiltered = false
    private var filteredGames = [GameItem](){
        didSet{
            DispatchQueue.main.async {
                self.listCollectionView.reloadData()
            }
        }
    }
    private var games = [GameItem](){
        didSet{
            DispatchQueue.main.async {
                self.listCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notFoundImageView.isHidden = true
        tabBarController?.tabBar.isHidden = false
        listCollectionView.register(UINib(nibName: "GameListItemCell", bundle: nil), forCellWithReuseIdentifier: "gameItemCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "PinGame"
        tabBarController?.tabBar.unselectedItemTintColor = .systemGray4
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissNotification(notification:)), name: Notification.Name("endLoadDescription"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification:)), name: Notification.Name("reloadData"), object: nil)
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            self.nextPage()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Global.instance.games.count == 0{
            Global.instance.loadGamesFromDB()
            self.games = Global.instance.games
        }
        
        self.loadHeaderPageVC()
        
    }
    
    @objc func dismissNotification(notification: Notification)
    {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true, completion: nil)
            
            Global.instance.loadGamesFromDB()
            Global.instance.selectedGame = Global.instance.games.first(where: { item in
                item.id == self.selectedGameId
            })
            
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Pin.StoryboardID.detailPageVC)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @objc func reloadData(notification: Notification)
    {
        self.alert.dismiss(animated: true, completion: nil)
        self.games = Global.instance.games
    }
    
    private func nextPage(){
        let currentPage = self.pageControl.currentPage
        if currentPage >= (self.pageControl.numberOfPages - 1) { // son sayfada -> başa al
            self.headerPageVC.setViewControllers([Global.instance.headerGamePages[0]], direction: .forward, animated: true, completion: nil)
            self.pageControl.currentPage = 0
        } else {
            self.headerPageVC.setViewControllers([Global.instance.headerGamePages[currentPage + 1]], direction: .forward, animated: true, completion: nil)
            self.pageControl.currentPage = currentPage + 1
        }
    }
    
    private func loadHeaderPageVC(){
        guard let first = Global.instance.headerGamePages.first else { return }
        headerPageVC.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        headerPageVC.dataSource = self
        headerPageVC.delegate = self
        headerPageVC.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        headerStackView.insertArrangedSubview(headerPageVC.view, at: 0)
    }
    
    func itemSelectForDetail(){
        if Global.instance.selectedGame?.description == ""{
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .medium
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true) {
                DispatchQueue.main.async {
                    // Oyuna ait detaili çek
                    Global.instance.pullDetail(Global.instance.selectedGame?.id ?? -1)
                }
            }
        } else {
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Pin.StoryboardID.detailPageVC)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func setHidden(notFound: Bool, collectionView: Bool, header: Bool){
        self.notFoundImageView.isHidden = notFound
        self.listCollectionView.isHidden = collectionView
        self.headerStackView.isHidden = header
    }
}

extension SearchListVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = Global.instance.headerGamePages.firstIndex(of: viewController as! GameHeaderVC), index > 0 else { return Global.instance.headerGamePages[Global.instance.headerGamePages.count - 1] }
        return Global.instance.headerGamePages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index =  Global.instance.headerGamePages.firstIndex(of: viewController as! GameHeaderVC), index < (Global.instance.headerGamePages.count - 1) else { return Global.instance.headerGamePages[0] }
        return  Global.instance.headerGamePages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let page = pageViewController.viewControllers![0]
        self.pageControl.currentPage = Global.instance.headerGamePages.firstIndex(of: page as! GameHeaderVC)!
    }
}

extension SearchListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (isFiltered) ? filteredGames.count : Global.instance.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameItemCell", for: indexPath) as! GameListItemCell
        cell.configure(model: (isFiltered) ? filteredGames[indexPath.row] : Global.instance.games[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width), height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Global.instance.selectedGame = (isFiltered) ? filteredGames[indexPath.row] : Global.instance.games[indexPath.row]
        selectedGameId = Global.instance.selectedGame?.id
        itemSelectForDetail()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isFiltered{
            if (indexPath.row == Global.instance.games.count - 1) {
                Global.instance.currentPagingPageNumber += 1
                
                let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.style = .medium
                loadingIndicator.startAnimating()
                alert.view.addSubview(loadingIndicator)
                present(alert, animated: true) {
                    DispatchQueue.main.async {
                        // Oyuna ait detaili çek
                        Global.instance.pullGameList(Global.instance.currentPagingPageNumber)
                    }
                }
            }
        }
    }
}

extension SearchListVC: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltered = false
        searchBar.text = ""
        headerStackView.isHidden = false
        listCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" && searchText.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3{
            filteredGames = games.filter({ (game: GameItem) in
                return game.name.localizedLowercase.contains(searchText.localizedLowercase)
            })
            
            if filteredGames.count == 0{
                setHidden(notFound: false, collectionView: true, header: true)
            } else {
                headerStackView.isHidden = true
                setHidden(notFound: true, collectionView: false, header: true)
            }
            self.isFiltered = true
        } else {
            self.isFiltered = false
            setHidden(notFound: true, collectionView: false, header: false)
        }
        
        listCollectionView.reloadData()
    }
}
