//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TumblrCell", for: indexPath) as! TumblrCell
        let post = posts[indexPath.row]
        // Get the first photo in the post's photos array
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            // Use the Nuke library's load image function to (async) fetch and load the image from the image URL.
            Nuke.loadImage(with: url, into: cell.blogImageView)
        }
        
        //set the text on the label
        cell.overviewLabel.text = post.summary

        //let cell = UITableViewCell() //create a cell
       // let post = posts[indexPath.row] //Get the post-associated table view row
        //cell.overviewLabel?.text = post.summary
        return cell
    }
    
    
    
    
    
    //Add Table View Outlet
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //Add a property to store fetched posts
    private var posts: [Post] = []
    
    
    override func viewDidLoad() {
        tableView.dataSource = self //view controller will act as table view's data source
        super.viewDidLoad()
        
        //Assign table view data source
        fetchPosts()
    }
    //Fetch a list of posts from the Tubmlr API
    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in

                    let posts = blog.response.posts


                    print("✅ We got \(posts.count) posts!")
                    for post in posts {
                        print("🍏 Summary: \(post.summary)")
                    }
                    //store posts in the posts property so that it can be accessed anywhere in the View Controller
                    //This is what allows you to be able to have the number of rows appear to be equal to the number of posts fetched
                    self?.posts = posts
                    self?.tableView.reloadData()
                
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
