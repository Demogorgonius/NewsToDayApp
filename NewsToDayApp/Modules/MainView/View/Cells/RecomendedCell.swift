//
//  RecomendedCell.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import UIKit
import SnapKit

class RecomendedCell: UICollectionViewCell {
    static let resuseID = "RecomendedCell"
    
    private let categoryLabel = LabelsFactory.makeCategoryLabel()
    private let articleNameLabel = LabelsFactory.makeArticleHeaderLabel()
    private let backImage = ImageViewFactory.makeCornerRadiusImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setViews()
        layoutViews()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        articleNameLabel.text = nil
        backImage.image = nil
        
    }
    
    private func setUpViews(){
        categoryLabel.font = UIFont.TextFont.Main.recommendedArticleCategory
        categoryLabel.textColor = UIColor(named: ConstColors.greyPrimary)
        articleNameLabel.textColor = UIColor(named: ConstColors.blackPrimary)
        articleNameLabel.font = UIFont.TextFont.Main.recommendedArticleLabel
    }
    
    private func setViews(){
        [
            backImage,
            categoryLabel,
            articleNameLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
//    private func applyGradient(){
//        backImage.bounds = self.contentView.bounds
//        backImage.applyGradientMask(colors: [UIColor.clear, #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)], locations: [0.1, 1.0])
//    }
    
    private func layoutViews(){
        backImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.top.equalTo(contentView.snp.top)
            make.height.width.equalTo(96)
        }
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(articleNameLabel.snp.top).offset(-8)
            make.leading.equalTo(backImage.snp.trailing).offset(16)
        }
        
        articleNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.leading.equalTo(backImage.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
        }
    }
}

//MARK: - Configure Cell UI Public Method
extension RecomendedCell{
    func configCell(categoryLabelText: String, articleNameText: String, image: UIImage?){
        categoryLabel.text = categoryLabelText
        articleNameLabel.text = articleNameText
        if let image = image{
            backImage.image = image
        } else{
            backImage.backgroundColor = .blue
            //добавить spineer
        }
        
    }
}
