//
//  ViewController.swift
//  KripaGeorge1-Lab4
//
//  Created by Kripa on 10/30/21.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    struct APIResults:Decodable {
        let page: Int
        let total_results: Int
        let total_pages: Int
        let results: [Movie]
    }
    struct Movie: Decodable {
        let id: Int!
        let poster_path: String?
        let title: String
        let release_date: String?
        let vote_average: Double
        let overview: String
        let vote_count:Int!
    }
    
    //global vars
    var theData : APIResults = APIResults(page: 0, total_results: 0, total_pages: 0, results: [])
    var Movies : Array<Movie> = []
    var imageCache : [UIImage] = []
    var query : String = ""
    
    //for collection view layout
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        //search bar
        searchBar.delegate = self
        searchBarSearchButtonClicked(searchBar)
        setUpCollectionView()

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            query = searchBar.text ?? ""
            print(query)
            fetchDataForCollectionView()
            cacheImages()
            collectionView.reloadData()
    }
    
    func setUpCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")

    }

    func fetchDataForCollectionView(){
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=c7ded9676fb676b11e5f90d1c30c4dcd&query=\(query)")
            else {
                return
            }
            if let data = try? Data(contentsOf: url){
                theData = try! JSONDecoder().decode(APIResults.self, from:data)
                Movies = theData.results
                print(Movies.count)
            } else {
                return
            }
        }

    func cacheImages(){
        for movie in Movies{
            if (movie.poster_path != nil){
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + movie.poster_path!)
                else {
                    return
                }
                if let data = try? Data(contentsOf: url){
                    let image = UIImage(data: data)
                    //let image = UIImage(data: data) ?? UIImage(defaultPoster)
                    imageCache.append(image!) // safely handle this optional
                } else {
                    return
                }
            }
            else{
                imageCache.append(UIImage(named: "defaultPoster")!)
            }
        }
    }
    //collectionViewDataSource protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(Movies.count)
        return Movies.count
    }

    //fires every time we try to display a new cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //print(Movies[indexPath.item].title)
        //cell.largeContentTitle = Movies[indexPath.item].title
        //print(Movies[indexPath.item].poster_path)
        //cell.heightAnchor
        cell.moviePoster.image = imageCache[0]
        cell.movieTitle.text = Movies[indexPath.item].title
        cell.backgroundColor = .red
        return cell
    }
    
}
