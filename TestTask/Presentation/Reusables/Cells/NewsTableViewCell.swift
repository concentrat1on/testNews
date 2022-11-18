//
//  NewsTableViewCell.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import UIKit
import SnapKit
import Nuke

class NewsTableViewCell: UITableViewCell {
    
    private weak var photoImageView: UIImageView!
    private weak var favoriteButton: UIButton!
    private weak var titleLabel: UILabel!
    private weak var descriptionLabel: UILabel!
    private weak var sourceLabel: UILabel!
    private weak var authorLabel: UILabel!
    
    var index = Int()
    
    var didTappedOnFavorite: ((Int) -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCellWith(_ model: ArticleModel, index: Int) {
        
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        authorLabel.text = model.author != nil ? "Author: \(model.author!)" : ""
        sourceLabel.text = "Source: \(model.source.name)"
        
        let isContains = ApplicationDataProvider.shared.realm.isArticleContains(for: model.source.name + model.publishedAt)
        
        favoriteButton.setBackgroundImage(
            UIImage(systemName: isContains ? "heart.fill" : "heart")?.withRenderingMode(.alwaysOriginal),
            for: .normal)
        
        self.index = index
        
        photoImageView.image = nil
        guard let url = URL(string: model.urlToImage ?? "") else { return }
        let request = ImageRequest(url: url)
        
        var options = ImageLoadingOptions(transition: .fadeIn(duration: 0.25))
        options.pipeline = ApplicationDataProvider.shared.imagePipeline
        Nuke.loadImage(with: request,
                       options: options,
                       into: photoImageView)
    }
    
    @objc private func favoriteAction() {
        didTappedOnFavorite?(index)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
}

// MARK: - Layout
extension NewsTableViewCell {
    
    private func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none
        makePhotoImageView()
        makeFavoriteImageView()
        makeTitleLabel()
        makeDescriptionLabel()
        makeSourceLabel()
        makeAuthorLabel()
    }
    
    private func makePhotoImageView() {
        let photoImageView = UIImageView()
        contentView.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.leading.top.equalToSuperview().inset(15)
        }
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.masksToBounds = true
        self.photoImageView = photoImageView
    }
    
    private func makeFavoriteImageView() {
        let favoriteButton = UIButton()
        contentView.addSubview(favoriteButton)
        
        favoriteButton.snp.makeConstraints {
            $0.width.equalTo(25)
            $0.height.equalTo(22.5)
            $0.top.trailing.equalToSuperview().inset(20)
        }
        
        favoriteButton.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
        favoriteButton.tintColor = UIColor.red
        self.favoriteButton = favoriteButton
    }
    
    private func makeTitleLabel() {
        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(photoImageView.snp.trailing).offset(15)
            $0.trailing.equalTo(favoriteButton.snp.leading).offset(-15)
            $0.top.equalToSuperview().inset(15)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        
        self.titleLabel = titleLabel
    }
    
    private func makeDescriptionLabel() {
        let descriptionLabel = UILabel()
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            
        }
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.numberOfLines = 0
        self.descriptionLabel = descriptionLabel
    }
    
    private func makeAuthorLabel() {
        let authorLabel = UILabel()
        contentView.addSubview(authorLabel)
        
        authorLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(sourceLabel.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().inset(5)
        }
        
        authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        authorLabel.textColor = UIColor.black
        authorLabel.numberOfLines = 0
        self.authorLabel = authorLabel
    }
    
    private func makeSourceLabel() {
        let sourceLabel = UILabel()
        contentView.addSubview(sourceLabel)
        
        sourceLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
        }
        
        sourceLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        sourceLabel.textColor = UIColor.black
        sourceLabel.numberOfLines = 0
        self.sourceLabel = sourceLabel
    }
    
}

//(custom UITableViewCell xib file should include: source, author, title, description and image with urlToImage, click should open relevant news in custom UIViewController using WKWebkit);
