import UIKit
struct AboutFilesModel {
    let name: String
}
var model: [AboutFilesModel] = []
let accesToken = "y0_AgAAAAAN2TYJAAlM9gAAAADe3rZseL9WwFmJRYiQRSoJLYBki2Qkny8"
func getDataURL(_ accesToken: String, completion: @escaping ([[String : Any]]?, Error?) -> Void){
    let validUrl = "https://cloud-api.yandex.net/v1/disk/resources/last-uploaded"
    let url = URL(string: validUrl)
    var request = URLRequest(url: url!)
    request.addValue(accesToken, forHTTPHeaderField: "Authorization")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data else {
            completion(nil, error)
            return
        }
        let someDictionaryFromJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        let arrayOfServices = someDictionaryFromJSON?["items"] as? [[String: Any]]
        completion(arrayOfServices, error)
    }
    task.resume()
}

getDataURL(accesToken) { array, error in
    guard let array = array else {
        return
    }
    
    for i in 0..<array.count {
        model.append(AboutFilesModel(name: array[i]["name"] as! String))
        print(model[i].name)
    }
}

