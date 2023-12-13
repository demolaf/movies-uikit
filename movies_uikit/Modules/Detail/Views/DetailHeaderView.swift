//
//  DetailHeaderView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 04/09/2023.
//

import UIKit
import RxSwift
import RealmSwift

class DetailHeaderView: UIView {

    private var notificationToken: NotificationToken?
    var saveForLaterPressedCallback: (() -> Void)?

    private let rootView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let subTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Marvel's Avengers: Infinity War, Only the beginning"
        label.font = .appFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Action & Adventure"
        label.textColor = .lightGray
        label.font = .appFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 1
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2018, 148 mins"
        label.textColor = .lightGray
        label.font = .appFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()

    private let watchNowButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 6
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true

        // Set attributed string for button
        let title = "Watch Now"
        let titleRange = title.range(of: title)!
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.appFont(ofSize: 12, weight: .semibold)
            ],
            range: NSRange(titleRange, in: title)
        )
        button.setAttributedTitle(attributedString, for: .normal)

        return button
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setImage(
            UIImage(systemName: "plus")?.withTintColor(
                .systemRed,
                renderingMode: .alwaysOriginal
            ),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1/1).isActive = true
        return button
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.grayscale300
        view.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeSubviews()
        initializeTapGestureRecognizers()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func initializeSubviews() {
        self.clipsToBounds = true

        self.addSubview(rootView)

        //
        rootView.addSubview(rootStackView)
        rootView.addSubview(separator)

        //
        rootStackView.addArrangedSubview(topStackView)
        rootStackView.addArrangedSubview(bottomStackView)

        //
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(plusButton)

        //
        bottomStackView.addArrangedSubview(subTitleStackView)
        bottomStackView.addArrangedSubview(watchNowButton)

        //
        subTitleStackView.addArrangedSubview(genreLabel)
        subTitleStackView.addArrangedSubview(releaseDateLabel)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            //
            rootView.topAnchor.constraint(equalTo: self.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: self.separator.topAnchor),

            //
            rootStackView.topAnchor.constraint(equalTo: self.rootView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: self.rootView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.rootView.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: self.rootView.bottomAnchor),

            //
            separator.leadingAnchor.constraint(equalTo: self.rootView.leadingAnchor, constant: 24),
            separator.trailingAnchor.constraint(equalTo: self.rootView.trailingAnchor, constant: -24),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }

    private func initializeTapGestureRecognizers() {
        plusButton.addTarget(
            self,
            action: #selector(saveForLaterButtonPressed),
            for: .touchUpInside
        )
    }

    @objc
    private func saveForLaterButtonPressed() {
        saveForLaterPressedCallback?()
    }

    func configureViewData(show: Show?) {
        if let show = show {
            self.titleLabel.text = show.title
            self.releaseDateLabel.text = show.releaseDate
            debugPrint("Bookmarked \(show.bookmarked)")
            updateBookmarkedState(bookmarked: show.bookmarked)
        }
    }

    private func updateBookmarkedState(bookmarked: Bool) {
        if bookmarked {
            plusButton.imageView?.image = UIImage(systemName: "checkmark")?.withTintColor(
                .systemRed, renderingMode: .alwaysOriginal)
        } else {
            plusButton.imageView?.image = UIImage(systemName: "plus")?.withTintColor(
                .systemRed, renderingMode: .alwaysOriginal)
        }
    }
}
