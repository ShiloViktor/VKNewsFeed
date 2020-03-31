//
//  NewsFeedCodeCell.swift
//  VKontakteFeed
//
//  Created by Виктор on 25.03.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import UIKit

protocol NewsFeedCodeCellDelegate: class {
    func revealText(cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    
    weak var delegate: NewsFeedCodeCellDelegate?
    
    static let reuseId = "NewsFeedCodeCell"
    
    // 1st layer
    let cardView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    // 2nd layer
    let topView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
         label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let moreTextButton: UIButton = {
       let button = UIButton()
         button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let postImageView: WebImageView = {
       let imageView = WebImageView()
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 3rd layer topView
    
    let iconImageVIew: WebImageView = {
        let iV = WebImageView()
        iV.translatesAutoresizingMaskIntoConstraints = false
        return iV
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // 3rd layer bottomView
    
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 4th layer bottomView
    
    let likesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "like")
        return imageView
    }()
    
    let likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        return label
    }()
    
    let commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "comment")
        return imageView
    }()
    
    let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        return label
    }()
    
    let sharesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "share")
        return imageView
    }()
    
    let sharesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        return label
    }()
    
    let viewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "eye")
        return imageView
    }()
    
    let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        return label
    }()
    
    override func prepareForReuse() {
        iconImageVIew.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        iconImageVIew.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageVIew.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTapped), for: .touchUpInside)
        
        firstLayerSetup()
        secondLayerSetup()
        thirdLayerOnTopViewLayout()
        thirdLayerOnBottomViewLayout()
        fourthLayerOnButtomViewViewsLayout()
    }
    
    @objc func moreTextButtonTapped() {
        delegate?.revealText(cell: self)
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageVIew.set(imageUrl: viewModel.iconUrlImageView)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesCountLabel.text = viewModel.likes
        commentsCountLabel.text = viewModel.comments
        sharesCountLabel.text = viewModel.shares
        viewsCountLabel.text = viewModel.views
        
        postImageView.frame = viewModel.sizes.postAttachmentoFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        postLabel.frame = viewModel.sizes.postLabelFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
           if let photo = viewModel.postPhoto {
               self.postImageView.set(imageUrl: photo.imageUrl)
               postImageView.isHidden = false
           } else {
               postImageView.isHidden = true
           }
       }
    
    private func firstLayerSetup() {
        
        addSubview(cardView)
        
        // Card View Constraints
        
        cardView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8 ))
    }
    
    private func secondLayerSetup() {
        
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        // topView Constraints
        
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func thirdLayerOnTopViewLayout() {
        topView.addSubview(iconImageVIew)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        // iconImageView Constraints
        iconImageVIew.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageVIew.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageVIew.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageVIew.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // nameLabel Constraints
        nameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 47).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // nameLabel Constraints
        dateLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 47).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func thirdLayerOnBottomViewLayout() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        // likesView Constraints
        likesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight).isActive = true
        likesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth).isActive = true

        // commentsView Constraints
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        commentsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight).isActive = true
        commentsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth).isActive = true
//
        // sharesView Constraints
        sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor).isActive = true
        sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        sharesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight).isActive = true
        sharesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth).isActive = true
        
        // viewsView Constraints
        viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        viewsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        viewsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight).isActive = true
        viewsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth).isActive = true
    }
    
    private func fourthLayerOnButtomViewViewsLayout() {
        likesView.addSubview(likesImageView)
        likesView.addSubview(likesCountLabel)
        bottomIconsLayout(view: likesView, imageView: likesImageView, label: likesCountLabel)

        commentsView.addSubview(commentsImageView)
        commentsView.addSubview(commentsCountLabel)
        bottomIconsLayout(view: commentsView, imageView: commentsImageView, label: commentsCountLabel)
        
        sharesView.addSubview(sharesImageView)
        sharesView.addSubview(sharesCountLabel)
        bottomIconsLayout(view: sharesView, imageView: sharesImageView, label: sharesCountLabel)
        
        viewsView.addSubview(viewsImageView)
        viewsView.addSubview(viewsCountLabel)
        bottomIconsLayout(view: viewsView, imageView: viewsImageView, label: viewsCountLabel)
    }
    
    private func bottomIconsLayout(view: UIView, imageView: UIImageView, label: UILabel) {
        imageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 0), size: Constants.bottomIconImageViewSize)
        label.anchor(top: view.topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 9, left: 3, bottom: 9, right: 3))
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
