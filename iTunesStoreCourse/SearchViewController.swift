//
//  ViewController.swift
//  iTunesStoreCourse
//
//  Created by Amr Hesham on 15/01/2021.
//

import UIKit
import SDWebImage
// MARK: - SearchViewController
//
class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var searchResult = [SearchResult]()
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - UISearchBarDelegate
//
extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchData(searchText: searchBar.text ?? "")
    }
    
}

// MARK: - UITableView Delegate & DataSource
//
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell") as! SongTableViewCell
        cell.trackNameLabel?.text = searchResult[indexPath.row].trackName
        cell.artistNameLabel?.text = searchResult[indexPath.row].artistName
        if let imageURL = URL(string: searchResult[indexPath.row].imageIcon) {
            cell.iconImageView?.sd_setImage(with: imageURL, completed: nil)
        }
        return cell
    }
    
}

// MARK: - Networking
//
extension SearchViewController {
    func getSearchData(searchText: String) {
        searchResult.removeAll()
        
        
        
        let url = URL(string: "http://itunes.apple.com/search?term=\(searchText)")
        guard let validURL = url else {return}
        
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let urlRequest = URLRequest(url: validURL)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, _, error in
            guard let data = data else {return}
            self.setDataAndRefreshTable(data: data)
            
        }
        
        dataTask.resume()
    }
}

// MARK: - Parsing JSON
//
extension SearchViewController {
    
    func setDataAndRefreshTable(data: Data) {
        
        do {
            let resultWrapper = try JSONDecoder().decode(ResultWrapper.self, from: data)
            let results = resultWrapper.results
            
            results.forEach { song in
                searchResult.append(song)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch (let error){
            print(error)
        }
    }
    
}



