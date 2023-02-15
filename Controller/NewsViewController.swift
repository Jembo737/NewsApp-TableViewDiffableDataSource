//
//  ViewController.swift
//  NewsApp-TableViewDiffableDataSource
//
//  Created by Dzhemal on 13.02.2023.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    private var tableView: UITableView!
    private var articles = [Article]()
    private var dataSource: UITableViewDiffableDataSource<Int, NewsTableViewCellViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = "News"
        view.backgroundColor = .systemBackground
        
        fetchTopStories()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.delegate = self
        view.addSubview(tableView)
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, viewModel in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        })
    }
}

extension NewsViewController {
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NewsTableViewCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(articles.map({
            NewsTableViewCellViewModel(
                title: $0.title,
                author: $0.author ?? "No Author",
                imageURL: URL(string: $0.urlToImage ?? "")
            )
        }))
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func fetchTopStories() {
        DataCaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.applySnapshot()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

