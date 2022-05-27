//
//  SongsTableViewController.swift
//  API Practice
//
//  Created by Shien on 2022/5/26.
//

import UIKit
import AVKit
import AVFoundation

class SongsTableViewController: UITableViewController {
    var songs: [songResult]?

    override func viewDidLoad() {
        super.viewDidLoad()

       fetchData()
    }
    
    func fetchData() {
        if let url = URL(string: "https://rss.applemarketingtools.com/api/v2/tw/music/most-played/10/songs.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    let music = try! decoder.decode(Music.self, from: data)
                    self.songs = music.feed.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }.resume()
        }
    }

    
    @IBSegueAction func showWebView(_ coder: NSCoder) -> MusicWebViewController? {
        if let songs = songs {
            return MusicWebViewController(coder: coder, url: songs[tableView.indexPathForSelectedRow!.row].url)
        }
        return nil
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWeb", sender: nil)
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SongTableViewCell.self)", for: indexPath) as? SongTableViewCell else {
            return SongTableViewCell()
        }

        if let songs = songs {
            cell.artworkImageView.image = try? UIImage(data: Data(contentsOf: songs[indexPath.row].artworkUrl100))
            cell.songNameLabel.text = songs[indexPath.row].name
            cell.singerLabel.text = songs[indexPath.row].artistName
        }
        return cell
    }
}
