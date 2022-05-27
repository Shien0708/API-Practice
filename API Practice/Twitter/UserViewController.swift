//
//  UserViewController.swift
//  API Practice
//
//  Created by Shien on 2022/5/26.
//

import UIKit


enum Descriptions: String {
    case name = "Hi, my name is"
    case mail = "My email address is"
    case birthday = "My birthday is"
    case location = "My address is"
    case phone = "My phone number is"
    case password = "My password is"
}

class UserViewController: UIViewController {
    var users: RandomUsers?
    var currentNum = 0
    @IBOutlet weak var infoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        userImageView.layer.cornerRadius = userImageView.bounds.height/2
    }
    
    func updateLabels(add main: String, with description: String) {
        contentLabel.text = main
        descriptionLabel.text = description
    }
    
    func fetchData() {
        if let url = URL(string: "https://randomuser.me/api/") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let dateFormatter = ISO8601DateFormatter()
                        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                        decoder.dateDecodingStrategy = .custom({ (decoder)->Date in
                            let container = try decoder.singleValueContainer()
                            let dateString = try container.decode(String.self)
                            if let date = dateFormatter.date(from: dateString) {
                                return date
                            } else {
                                throw DecodingError.dataCorruptedError(in: container, debugDescription: "")
                            }
                        })
                        
                        let user = try decoder.decode(RandomUsers.self, from: data)
                        self.users = user
                        if let user = self.users {
                            DispatchQueue.main.async {
                                self.currentNum = Int.random(in: 0...user.results.count-1)
                                self.userImageView.image = try? UIImage(data: Data(contentsOf: URL(string:user.results[self.currentNum].picture.large)!))
                                self.showCurrentInfo()
                            }
                        }
                        
                    } catch { print(error) }
                }
            }.resume()
            
        }
    }
    
    func showCurrentInfo() {
        if let users = users {
            let user = users.results[currentNum]
            switch infoSegmentedControl.selectedSegmentIndex {
            case 0:
                let fullName = "\(user.name.title) \(user.name.first) \(user.name.last)"
                updateLabels(add: fullName, with: Descriptions.name.rawValue)
            case 1:
                updateLabels(add: user.email, with: Descriptions.mail.rawValue)
            case 2:
                updateLabels(add: user.dob.date.formatted(), with: Descriptions.birthday.rawValue)
            case 3:
                let location = "\(user.location.street.number) \(user.location.street.name) ,\(user.location.city), \(user.location.country)"
                updateLabels(add: location, with: Descriptions.location.rawValue)
            case 4:
                updateLabels(add: user.phone, with: Descriptions.phone.rawValue)
            case 5:
                updateLabels(add: user.login.password, with: Descriptions.password.rawValue)
            default:
                print("changing failed")
            }
        }
    }
    
    @IBAction func changeDetail(_ sender: UISegmentedControl) {
        showCurrentInfo()
    }
    
   
    @IBAction func changeUser(_ sender: UIButton) {
        fetchData()
        showCurrentInfo()
    }
}
