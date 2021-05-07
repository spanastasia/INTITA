//
//  NotificationsViewController.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.04.2021.
//

import UIKit

class NotificationsViewController: UIViewController, Storyboarded, NibCapable  {
    
    var notifcationsBox : [Messeg] = []
    
    

    @IBOutlet weak var nameNotificationsLabel: UILabel!
    @IBOutlet weak var notificationTabelView: UITableView!
    
    var coordinator: NotificationsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTabelView.delegate = self
        notificationTabelView.dataSource = self
        
        getData { (Notifikation) in
            self.notifcationsBox = Notifikation.rows
            DispatchQueue.main.async {
                self.notificationTabelView.reloadData()
            }
        }
        
        setupCell()
    }
    
    func setupCell() {
        notificationTabelView.register(NotificationsTableViewCell.nib(),
                           forCellReuseIdentifier: NotificationsTableViewCell.identifier)
    }
    

    @IBAction func inbox(_ sender: Any) {
        
    }
    
    @IBAction func send(_ sender: Any) {
        
    }
    
    @IBAction func system(_ sender: Any) {
    }
    
    @IBAction func trash(_ sender: Any) {
    }
    
    @IBAction func backButtonToProfile(_ sender: Any) {
        coordinator?.returnToProfileScreen()
    }
    
    var requestMesseges: URLRequest? {
        guard let url = URL(string: "https://qa.intita.com/api/v1/notifications/2571") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type" : "application/json",
                                       "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImVmZDIzYmVkM2QyODFmYzU4NmIzMGRlMjliZmQ4MjFkZGY3YzA4ZGNjYzEwMzBlYjE2N2Q4NDU1MmI5NjZiZTNjMTYxOWZkMDAyOGZjMmI5In0.eyJhdWQiOiIyIiwianRpIjoiZWZkMjNiZWQzZDI4MWZjNTg2YjMwZGUyOWJmZDgyMWRkZjdjMDhkY2NjMTAzMGViMTY3ZDg0NTUyYjk2NmJlM2MxNjE5ZmQwMDI4ZmMyYjkiLCJpYXQiOjE2MTg5NDE2NDgsIm5iZiI6MTYxODk0MTY0OCwiZXhwIjoxNjUwNDc3NjQ4LCJzdWIiOiIyNTcxIiwic2NvcGVzIjpbXX0.sVoVQJwv_RcP4PGD5SK0C-iWs9qYgU_qDA3oiTTQXIBYiqt3fdZuInqiftXLsnqrKTIrYNEGK9p3AEldmrJVsj_zlaMOReSSouN9O1F3tLOtMJ1aazzBxn2SaYk1tWd3IG1M5Ux1Ll2RLCiPbog-blv1XQ-oPr3spryxEJjI1TLPF7umDHeOK3lZJw5Vxijm0p3tr3HDHDtjJkw5DgU0M1GPQjDyEfDBB_6jHOeG1LvpLujgcf2RZZDvVb8t3nKD-8bSD_Znz37NrD_OIU9vF3Ttn8gw9xx_RVAXdrvC-39WF9kGKhawW_owuC6lsobVrSOtkhzlNj4P2g6kfQ8iKzz3wIPrAA49Lf73MXn_GzUBElYw12udO5hhpgkiTP5wL-Sc6eXm7W_3udm1y5FK8ofJhjv78N3ltIGGNmNEBoG2WxFjJuXhOsX29uXEJy9TD3YKrSVWfjY7qpMTu4Cl1ZiaMkDL8Ii6sLfxHOHjy8EiE4CaHGFzBhHSWY5SSCoovd0xqG0z8pzlSV9kGCzEcHwm-WIy8UWCijx22R3yuslPt7Oztoxs6oTHeEu27TSdEF-MuNVQE_WTi6iJxdxJ4QFVQ8i7zuJzFI8BKvVuLwbsb3Hb2e5TjlOxzpHxGaVjOQPhqkYUWuMsqHKZTOu9slDMZWC4kgKaHf8VRF1TPhM"]
        var type = "sent"//"inbox' || '' || 'system' || 'trash"

        let json3 = [
                          "field": "id",
                          "type": "desc"
                    ]
        let json2 = [
                        "count": 20,
                        "page": 1,
            "sorting": [json3],
                        "filter": nil
        ] as [String : Any?]

        let json = [
          "type": type,
          "queryParams": json2
        ] as [String : Any]
        
        
        
        print(json)
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
        
//        print(request.httpMethod)
//        print(request.httpBody)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //print(request)
        return request
    }
    
    func getData(completionHandler: @escaping (Notifikation) -> Void){
            
    let session = URLSession.shared
            
            let task = session.dataTask(with: requestMesseges!) { data, response, error in
                print(task_t.self)
//                if response != nil{
//               //     print(response)
//                }
  
                if error != nil {
                    print(error)
                    return
                }
                guard let data = data else {
                    print(error)
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(Notifikation.self, from: data)
                    completionHandler(response)
                } catch {
                    print(error)
                }
            }
    
    task.resume()
    }
    


struct Notifikation: Codable {
    
    var rows: [Messeg]
    var count: Int
    var notificationsAmount: Int

    enum CodingKeys: String, CodingKey {
        case count
        case notificationsAmount
        case rows
    }

}

struct Messeg: Codable {
    
    var id : Int?
    var type: Int?
    var createDate: String?
    var sender: Int?
    var receiver: Int?
    var subject: String?
    var messageText: String?
    //var readDate: String?
    //var receiverDeleteDate: Int?
    var parentId: Int?
    //var senderDeleteDate: String?
    var createdAt: String?
    var updatedAt: String?
    var organizationId: Int?
    
    var userReceiver: resiver
//    var user_sender: sender
//    var organization: organization
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        type = try container.decode(Int.self, forKey: .type)
        createDate = try container.decode(String.self, forKey: .createDate)
        sender = try container.decode(Int.self, forKey: .sender)
        receiver = try container.decode(Int.self, forKey: .receiver)
        subject = try container.decode(String.self, forKey: .subject)
        messageText = try container.decode(String.self, forKey: .messageText)
        //readDate = try container.decode(String.self, forKey: .readDate)
        //receiverDeleteDate = try container.decode(Int.self, forKey: .receiverDeleteDate)
        parentId = try container.decode(Int.self, forKey: .parentId)
        //senderDeleteDate = try container.decode(String.self, forKey: .senderDeleteDate)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        organizationId = try container.decode(Int.self, forKey: .organizationId)
        
        userReceiver = try container.decode(resiver.self, forKey: .userReceiver)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case createDate = "create_date"
        case sender
        case receiver
        case subject
        case messageText = "message_text"
        //case readDate = "read_date"
        //case receiverDeleteDate = "receiver_delete_date"
        case parentId = "parent_id"
        //case senderDeleteDate = "sender_delete_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case organizationId = "organization_id"
        case userReceiver = "user_receiver"
    }
    
    
}



struct resiver: Codable{
//    var   id: Int?
//    var   firstName: String?
//    var   full_name: String?
//    var   middleName: String?
//    var   secondName: String?
//    var   nickname: String?
//    var   birthday: String?
    var   email: String?
//    var   corporate_mail: String?
//    var   facebook: String?
//    var   googleplus: String?
//    var   linkedin: String?
//    var   twitter: String?
//    var   phone: String?
//    var   address: String?
//    var   education: String?
//    var   educform: String?
//    var   interests: String?
//    var   aboutUs: String?
//    var   aboutMy: String?
//    var   avatar: String?
//    var   role: Int?
//    var   reg_time: String?
//    var   skype: String?
//    var   country: String?
//    var   city: String?
//    var   prev_job: String?
//    var   current_job: String?
//    var   education_shift: String?
//    var   title: String?
//    var   shortTitle: String?
//    var   userStatus: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        email = try container.decode(String.self, forKey: .email)
        
    }
    
    enum CodingKeys: String, CodingKey {
        case email
        
    }
    
}

struct sender: Codable  {
    var id: Int?
    var firstName: String?
    var full_name: String?
    var middleName: String?
    var secondName: String?
    var nickname: String?
    var birthday: String?
    var email: String?
    var corporate_mail: String?
    var facebook: String?
    var googleplus: String?
    var linkedin: String?
    var twitter: String?
    var phone: String?
    var address: String?
    var education: String?
    var educform: String?
    var interests: String?
    var aboutUs: String?
    var aboutMy: String?
    var avatar: String?
    var role: String?
    var reg_time: String?
    var skype: String?
    var country: String?
    var city: String?
    var prev_job: String?
    var current_job: String?
    var education_shift: String?
    var title: String?
    var shortTitle: String?
    var userStatus: String?
    }

struct organization: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var phone: String?
    var url: String?
    var coefficient_offline: Double?
    var coefficient_online: Double?
    var coefficient_module_in_course: Double?
    var facebook: String?
    var linkedin: String?
    var twitter: String?
    var logo: URL?
    // "Xz3fpI7s8nT6ScZdcAE3Q1kTfD2KAI.png"
    var created_at: String?
    var updated_at: String?
    }
}

extension NotificationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return OpportunitiesType.allCases.count
        return notifcationsBox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier, for: indexPath) as? NotificationsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.sabjectLabel.text = notifcationsBox[indexPath.row].subject
        cell.massegLabel.text = notifcationsBox[indexPath.row].messageText
        cell.emailLabel.text = notifcationsBox[indexPath.row].userReceiver.email
        cell.timeLabel.text = notifcationsBox[indexPath.row].createDate
        
        return cell
    }
    
}

extension NotificationsViewController: UITableViewDelegate {

}


