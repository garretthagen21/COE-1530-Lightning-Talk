// Retrieve email and password parameters from the UI
Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
    
        // Sign up has completed, now check to make sure it was successful
        guard let user = authResult?.user, error == nil else {
            // Sign up was unsuccessful. Display error message, etc and return
            return
        }
    
        // Sign up was successful. Go to appropriate view
    }




// Retrieve email and password parameters from the UI
Auth.auth().signIn(withEmail: email, password: password) { user, error in
    
    // Sign in has completed, now check to make sure it was successful
    if error != nil
    {
        // Sign in was unsuccessful. Display error message, etc and return
    }
    
    // Sign in was successful and we have recieved the Firebase user object. Go to appropriate view
  }

authHandle = Auth.auth().addStateDidChangeListener{ auth, user in
    if user != nil {
       // The user is not logged in so go to sign in view
        
    } else {
       // The user is logged in so go to the appropriate view
    }
}

// Create the database reference
let dbRef = Database.database().reference()

// Generate a unique key for the new post
guard let key = ref.child("posts").childByAutoId().key else { return }

// Create the new post
let post = ["uid": userID,
            "author": username,
            "title": title,
            "body": body]

// Specify the paths at where this post will be written
let childUpdates = ["/posts/\(key)": post,
                    "/user-posts/\(userID)/\(key)/": post]

// Perform the updates
dbRef.updateChildValues(childUpdates)






class PostFeedViewController : UIViewController {
    var postRef: DatbaseReference!
    var postHandle: DatabaseHandle!
    
    // Called once when the view is initialized
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the database reference
       dbRef = Database.database().reference.child("posts")
    }
    
    // Called every time the view appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Attach the listener to our post reference
        postHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            // Extract the contents of postDict and reload the UI
        })
    }
    
    // Called every time the view dissapears
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Detach the listener to our post reference
        postRef.removeObserverWithHandle(postHandle)
    }
}
