//
//  ProfileHeader.swift
//  TwitterCloneApp
//
//  Created by Yildirim on 8.02.2023.
//

import UIKit

class ProfileTableViewHeader: UIView {
    
    private enum SectionTabs : String{
        
        case tweets = "Tweets"
        case tweetAndReplies = "Tweet & Replies"
        case likes = "Likes"
        case media = "Media"
        
        var index: Int{
            switch self {
            case .tweets:
                return 0
            case .tweetAndReplies:
                return 1
            case .media:
                return 2
            case .likes:
                return 3
            }
        }
    }
     
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    
    
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue:242/255, alpha:1)
        return view
    }()
    private var selectedTab = 0 {
        didSet{
            for i in 0..<tabs.count{
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                    self?.sectionStackView.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                    self?.leadingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.trailingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.layoutIfNeeded()
                }completion: { _ in }
            }
        }
    }
    
    private var tabs: [UIButton] = ["Tweets" , "Tweet & Replies", "Media", "Likes"] .map { buttonTitle in
        let button = UIButton(type:.system)
        button.setTitle(buttonTitle ,for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private lazy var sectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        
        return label
    }()
    
    private let followingTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Following"
        return label
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "24"
        return label
    }()
    
    private let followersTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Followers"
        return label
    }()
    
    private let profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private let joinDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Joined January 2022"
        return label
        
    }()
    private let joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "IOS Developer "
        label.numberOfLines = 3
        return label
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "emin"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "emin.yildirim"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let profileHeaderImageView: UIImageView = {
    
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "puma")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private func configureStackButton(){
        for(i,button) in sectionStackView.arrangedSubviews.enumerated(){
            guard let button = button as? UIButton else { return }
             
            if i == selectedTab {
                button.tintColor = .label
            }else{
                button.tintColor = .secondaryLabel
            }
            
            button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)

        }
    }
    
    @objc private func didTap(_ sender: UIButton){
        guard let label = sender.titleLabel?.text else {return}
        switch label{
        case SectionTabs.tweets.rawValue:
            selectedTab = 0
        case SectionTabs.tweetAndReplies.rawValue:
            selectedTab = 1
        case SectionTabs.media.rawValue:
            selectedTab = 2
        case SectionTabs.likes.rawValue:
            selectedTab = 3
        default:
            selectedTab = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(userBioLabel)
        addSubview(joinDateImageView)
        addSubview(joinDateLabel)
        addSubview(followingTextLabel)
        addSubview(followingCountLabel)
        addSubview(followersCountLabel)
        addSubview(followersTextLabel)
        addSubview(sectionStackView)
        addSubview(indicator)
        configureStackButton()
        configureConstraints()
    }
    
    private func configureConstraints(){
        
        for i in 0..<tabs.count{
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStackView.arrangedSubviews[i].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStackView.arrangedSubviews[i].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        
        let profileImageHeaderViewConstraint = [
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 180)
        ]
        let profileAvatarImageViewConstraint = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 10),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        let displayNameLabelConstraint = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 20)
        ]
        let usernameLabelConstraint = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5)
        ]
        let userBioLabelConstraint = [
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5)
        ]
        let joinDateImageViewConstraint = [
            joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 5)
        ]
        let joinDateLabelConstraint = [
            joinDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 2),
            joinDateLabel.centerYAnchor.constraint(equalTo: joinDateImageView.centerYAnchor)
        ]
        let followingTextLabelConstraint = [
            followingTextLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            followingTextLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor, constant: 10)
        ]
        let followingCountLabelConstraint = [
            followingCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor, constant: 4),
            followingCountLabel.bottomAnchor.constraint(equalTo: followingTextLabel.bottomAnchor)
        ]
        let followersTextLabelConstraint = [
            followersTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 8),
            followersTextLabel.bottomAnchor.constraint(equalTo: followingTextLabel.bottomAnchor)
        ]
        let followersCountLabelConstraint = [
            followersCountLabel.leadingAnchor.constraint(equalTo: followersTextLabel.trailingAnchor, constant: 4),
            followersCountLabel.bottomAnchor.constraint(equalTo: followingTextLabel.bottomAnchor)
        ]
        let sectionStackViewConstraint = [
            sectionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionStackView.topAnchor.constraint(equalTo: followersTextLabel.bottomAnchor),
            sectionStackView.heightAnchor.constraint(equalToConstant: 35)
            
        ]
        
        let indicatorConstraint = [
                leadingAnchors[0],
                trailingAnchors[0],
                indicator.topAnchor.constraint(equalTo: sectionStackView.bottomAnchor),
                indicator.heightAnchor.constraint(equalToConstant: 4)
                
        ]

        
        NSLayoutConstraint.activate(profileImageHeaderViewConstraint)
        NSLayoutConstraint.activate(profileAvatarImageViewConstraint)
        NSLayoutConstraint.activate(displayNameLabelConstraint)
        NSLayoutConstraint.activate(usernameLabelConstraint)
        NSLayoutConstraint.activate(userBioLabelConstraint)
        NSLayoutConstraint.activate(joinDateImageViewConstraint)
        NSLayoutConstraint.activate(joinDateLabelConstraint)
        NSLayoutConstraint.activate(followersTextLabelConstraint)
        NSLayoutConstraint.activate(followersCountLabelConstraint)
        NSLayoutConstraint.activate(followingCountLabelConstraint)
        NSLayoutConstraint.activate(followingTextLabelConstraint)
        NSLayoutConstraint.activate(sectionStackViewConstraint)
        NSLayoutConstraint.activate(indicatorConstraint)

    }
        
    required init?(coder: NSCoder) {
        fatalError("no imp")
    }

}
