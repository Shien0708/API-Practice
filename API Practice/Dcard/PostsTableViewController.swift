//
//  PostsTableViewController.swift
//  API Practice
//
//  Created by Shien on 2022/5/25.
//

import UIKit

class PostsTableViewController: UITableViewController {
    var posts: [Post]?
    var reuseIdetifier = "\(PostsTableViewCell.self)"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        if let url = URL(string: "https://www.dcard.tw/_api/posts") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let postResponse = try decoder.decode([Post].self, from: data)
                        self.posts = postResponse
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch { fatalError() }
                }
            }.resume()
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
        let titles = ["推薦","全部","追蹤","主題"]
        searchBar.backgroundColor = .systemBlue
        searchBar.barTintColor = .tintColor
        let segmentedControl = UISegmentedControl(items: titles)
        segmentedControl.frame = CGRect(x: -5, y: 40, width: view.bounds.width+10, height: 50)
        segmentedControl.backgroundColor = .white
        tableView.addSubview(searchBar)
        tableView.addSubview(segmentedControl)
        tableView.tableHeaderView?.backgroundColor = .tintColor
        return tableView.tableHeaderView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(reuseIdetifier)", for: indexPath) as? PostsTableViewCell else { return PostsTableViewCell() }
        
        if let posts = posts {
            cell.titleLabel.text = posts[indexPath.row].title
            cell.excerptLabel.text = posts[indexPath.row].excerpt
            if let school = posts[indexPath.row].school {
                cell.schoolLabel.text = school
                cell.schoolLabel.isHidden = false
            }
            cell.topicLabel.text = posts[indexPath.row].forumName
            cell.likeButton.titleLabel?.text = "❤️ \(posts[indexPath.row].likeCount)"
            cell.commentButton.titleLabel?.text = "💬 \(posts[indexPath.row].commentCount)"
            
            if posts[indexPath.row].gender == "M" {
                cell.topicImageView.image = UIImage(named: "male")
            } else {
                cell.topicImageView.image = UIImage(named: "female")
            }
            
            if posts[indexPath.row].withImages {
                cell.postImageView.image = try! UIImage(data: Data(contentsOf: URL(string: posts[indexPath.row].mediaMeta[0]!.url)!))
                cell.mainExcerptConstraint.constant = 100
            } else {
                cell.postImageView.image = nil
                cell.mainExcerptConstraint.constant = 10
            }
            
        }
        // Configure the cell...

        return cell
    }
    

}
