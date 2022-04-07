//
//  SearchListVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 7.03.2022.
//

import UIKit

final class SearchListVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var notFoundImageView: UIImageView!
    
    // MARK: - PROPERTIES
    
    private var selectedGameId: Int?
    private var timer = Timer()
    private let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    private let headerPageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private var isFiltered = false
    private var headerGamePages = [GameHeaderVC]()
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
    
    // MARK: - EXTERNAL FUNCTIONS
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        notFoundImageView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "PinGame"
        
        listCollectionView.register(UINib(nibName: "GameListItemCell", bundle: nil), forCellWithReuseIdentifier: "gameItemCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(endLoadDescription(notification:)), name: NotificationNames.endLoadDescription, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification:)), name: NotificationNames.reloadData, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CoreDataHelper.instance.games.isEmpty {
            CoreDataHelper.instance.loadGamesFromDB()
        }
        
        syncArrays()
        preparePageControl()
        prepareHeaderPageVC()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            self.nextPageHeader()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func syncArrays(){
        games = CoreDataHelper.instance.games
        headerGamePages = CoreDataHelper.instance.headerGamePages
    }
    
    private func preparePageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = CommonConstants.headerCount
    }
    
    private func nextPageHeader() {
        let currentPage = pageControl.currentPage
        if currentPage >= (pageControl.numberOfPages - 1) { // son sayfada -> başa al
            headerPageVC.setViewControllers([headerGamePages[0]], direction: .forward, animated: true, completion: nil)
            pageControl.currentPage = 0
        } else {
            headerPageVC.setViewControllers([headerGamePages[currentPage + 1]], direction: .forward, animated: true, completion: nil)
            pageControl.currentPage = currentPage + 1
        }
    }
    
    private func prepareHeaderPageVC() {
        guard let first = headerGamePages.first else { return }
        headerPageVC.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        headerPageVC.dataSource = self
        headerPageVC.delegate = self
        headerPageVC.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        headerStackView.insertArrangedSubview(headerPageVC.view, at: 0)
    }
    
    private func itemSelectForDetail() {
        if CoreDataHelper.instance.selectedGame?.description.isEmpty ?? false {
            let loadingIndicator = UIActivityIndicatorView().getDefaultIndicatorView()
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true) {
                DispatchQueue.main.async {
                    // Oyuna ait detaili çek
                    CoreDataHelper.instance.pullDetail(CoreDataHelper.instance.selectedGame?.id ?? -1)
                }
            }
        } else {
            pushVC(storyboardName: "Main", storyboardId: .detailPageVC)
        }
    }
    
    private func setHidden(notFound: Bool, collectionView: Bool, header: Bool) {
        self.notFoundImageView.isHidden = notFound
        self.listCollectionView.isHidden = collectionView
        self.headerStackView.isHidden = header
    }
    
    // MARK: - ObjectiveC
    
    @objc private func endLoadDescription(notification: Notification) {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true, completion: nil)
            
            CoreDataHelper.instance.loadGamesFromDB()
            guard let selectedGame = CoreDataHelper.instance.games.first(where: { $0.id == self.selectedGameId }) else { return }
            CoreDataHelper.instance.selectedGame = selectedGame
            self.pushVC(storyboardName: "Main", storyboardId: .detailPageVC)
        }
    }
    
    @objc private func reloadData(notification: Notification) {
        alert.dismiss(animated: true, completion: nil)
        games = CoreDataHelper.instance.games
    }
}

// MARK: - EXTENSIONS

extension SearchListVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = headerGamePages.firstIndex(of: viewController as! GameHeaderVC), index > 0 else { return headerGamePages[CommonConstants.headerCount - 1] }
        return headerGamePages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index =  headerGamePages.firstIndex(of: viewController as! GameHeaderVC), index < (CommonConstants.headerCount - 1) else { return headerGamePages[0] }
        return headerGamePages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let page = pageViewController.viewControllers![0]
        pageControl.currentPage = CoreDataHelper.instance.headerGamePages.firstIndex(of: page as! GameHeaderVC)!
    }
}

extension SearchListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredGames.count : games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameItemCell", for: indexPath) as? GameListItemCell else { return UICollectionViewCell() }
        cell.configure(model: isFiltered ? filteredGames[indexPath.row] : games[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width), height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CoreDataHelper.instance.selectedGame = isFiltered ? filteredGames[indexPath.row] : games[indexPath.row]
        selectedGameId = CoreDataHelper.instance.selectedGame?.id
        itemSelectForDetail()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isFiltered, indexPath.row == games.count - 1 {
            CoreDataHelper.instance.currentPagingPageNumber += 1
            UserDefaults.standard.set(CoreDataHelper.instance.currentPagingPageNumber, forKey: UserDefaultNames.currentPagingPageNumber)
            
            let loadingIndicator = UIActivityIndicatorView().getDefaultIndicatorView()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true) {
                DispatchQueue.main.async {
                    // Oyuna ait detaili çek
                    CoreDataHelper.instance.pullGameList(CoreDataHelper.instance.currentPagingPageNumber)
                }
            }
        }
    }
}

extension SearchListVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltered = false
        searchBar.text = ""
        headerStackView.isHidden = false
        listCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" && searchText.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3 {
            filteredGames = games.filter({ game in
                return game.name.localizedLowercase.contains(searchText.localizedLowercase)
            })
            
            filteredGames.isEmpty ? setHidden(notFound: false, collectionView: true, header: true) : setHidden(notFound: true, collectionView: false, header: true)
            isFiltered = true
        } else {
            isFiltered = false
            setHidden(notFound: true, collectionView: false, header: false)
        }
        
        listCollectionView.reloadData()
    }
}
