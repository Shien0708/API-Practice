//
//  AccountCollectionViewController.swift
//  API Practice
//
//  Created by Shien on 2022/5/27.
//

import UIKit

private let reuseIdentifier = "\(AccountCollectionViewCell.self)"

class AccountCollectionViewController: UICollectionViewController {
    var posts: TimelineMedia?
    var profile: IGUser?
    let header = AccountCollectionReusableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
       
    func fetchData() {
        if let url = URL(string: "https://www.instagram.com/dachshund.owners/?__a=1") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let str = String(decoding: data, as: UTF8.self)
                        print(str)
                        let account = try decoder.decode(Account.self, from: data)
                        print("finish")
                        self.posts = account.graphql.user.edge_owner_to_timeline_media
                        self.profile = account.graphql.user
                    } catch { print(error) }
                     
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }.resume()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AccountCollectionViewCell else { return AccountCollectionViewCell() }
        if let posts = posts {
            cell.postImageView.image = try? UIImage(data: Data(contentsOf: posts.edges[indexPath.row].node.display_url!))
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(AccountCollectionReusableView.self)", for: indexPath) as? AccountCollectionReusableView else {
            return AccountCollectionReusableView()
        }
        if let profile = profile {
            view.updateUI(with: profile)
        }
        return view
    }

}

extension AccountCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 300)
    }
    
}


