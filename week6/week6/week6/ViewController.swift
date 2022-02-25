//
//  ViewController.swift
//  week6
//
//  Created by Bahattin Koç on 11.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let sections = Bundle.main.decode([Section].self, from: "edevlet.json")
    var collectionView: UICollectionView!
    
    var datasource: UICollectionViewDiffableDataSource<Section, EDevlet>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(TopCell.self, forCellWithReuseIdentifier: TopCell.reuseIdentifier)
        collectionView.register(HighlightCell.self, forCellWithReuseIdentifier: HighlightCell.reuseIdentifier)
        collectionView.register(BottomCell.self, forCellWithReuseIdentifier: BottomCell.reuseIdentifier)
        view.addSubview(collectionView)
        
        createDataSource()
        reloadData()
    }
    
    private func configure<T: EDevletCellProtocol>(_ cellType: T.Type, with edevlet: EDevlet, for indexPath: IndexPath) -> T{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: edevlet)
        
        return cell
    }
    
    private func createDataSource(){
        datasource = UICollectionViewDiffableDataSource<Section, EDevlet>(collectionView: collectionView, cellProvider: { collectionView, indexPath, edevlet in
            
            switch self.sections[indexPath.section].type{
            case "top":
                return self.configure(TopCell.self, with: edevlet, for: indexPath)
            case "bottom":
                return self.configure(BottomCell.self, with: edevlet, for: indexPath)
            default:
                return self.configure(HighlightCell.self, with: edevlet, for: indexPath)
            }
        })
        
        datasource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else { return nil }
            guard let firstItem = self.datasource?.itemIdentifier(for: indexPath) else { return nil }
            
            guard let section = self.datasource?.snapshot().sectionIdentifier(containingItem: firstItem) else { return nil }
            
            if section.title.isEmpty { return nil }
            sectionHeader.title.text = section.title
            return sectionHeader
        }
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    private func createTopSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.33))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.66), heightDimension: .estimated(240))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem]) // Horizontalı da dene
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        // Burada bilerek bir şeyi eksik bıraktım
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func createHighligthSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.5))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem]) // Horizontalı da dene
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        // Burada bilerek bir şeyi eksik bıraktım
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func createBottomSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(0.5))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem]) // Horizontalı da dene
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        // Burada bilerek bir şeyi eksik bıraktım
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{ sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section.type{
                case "top":
                     return self.createTopSection()
                case "bottom":
                     return self.createBottomSection()
                default:
                 return self.createHighligthSection()
            }
        }
        
        return layout
    }
    
    // MARK: DiffableDataSource kavramını okuyunuz
    private func reloadData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, EDevlet>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        datasource?.apply(snapshot)
    }
}

