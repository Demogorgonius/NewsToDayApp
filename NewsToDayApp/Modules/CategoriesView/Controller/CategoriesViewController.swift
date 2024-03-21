//
//  CategoriesViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//


import UIKit

protocol CategoriesVCDelegate{
    func reloadCollectionView()
    func setCollectionViewDelegate(vc: CategoriesViewController)
    func setCollectionViewDataSource(vc: CategoriesViewController)
}

class CategoriesViewController: CustomViewController<CategoriesView> {
    
    var presenter: CategoriesPresenterProtocol?
    var categoriesView: CategoriesVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    private func setDelegates(){
        customView.delegate = self
        categoriesView = customView
        categoriesView?.setCollectionViewDelegate(vc: self)
        categoriesView?.setCollectionViewDataSource(vc: self)
    }
    
}
//MARK: - CategoriesPresenterViewProtocol
extension CategoriesViewController: CategoriesPresenterViewProtocol {
    
    
}
//MARK: - CategoriesViewDelegate
extension CategoriesViewController: CategoriesViewDelegate {
    
    
}

//MARK: - UICollectionViewDataSource
extension CategoriesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.resuseID, for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
        let data = presenter?.data[indexPath.row]
        cell.configCell(categoryLabelText: data?.articleCategory)
        return cell
    }
    
}
//MARK: - UICollectionViewDelegate
extension CategoriesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        //print(" array1 \(presenter?.selectedIndexPathArray)")
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCell, let presenter = presenter{
            cell.setSelectedColors()

            var cellWasRemoved = false
            for index in presenter.selectedIndexPathArray{
                if index == indexPath {
                    cell.setDefaultColors()
                    presenter.removeUnSelectedCell(indexPath: indexPath)
                    cellWasRemoved = true
                    print("delete")
                    break
                }
            }

            if !cellWasRemoved {
                presenter.saveSelectedCell(indexPath: indexPath)
                print("save")
            }
        }
       // print(" array2 \(presenter?.selectedIndexPathArray)")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // from left and right of the screen
        let minimumItemSpacing: CGFloat = 16 // between columns
        let availableWidth = customView.bounds.width - (padding * 2) - (minimumItemSpacing)
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}
