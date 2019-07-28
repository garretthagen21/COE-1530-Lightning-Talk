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


// Local file you want to upload
let localFile = URL(string: "path/to/image")!

// Create the file metadata
let metadata = StorageMetadata()
metadata.contentType = "image/jpeg"

// Upload file and metadata to the object 'images/mountains.jpg'
let uploadTask = storageRef.putFile(from: localFile, metadata: metadata)

// Listen for state changes, errors, and completion of the upload.
uploadTask.observe(.resume) { snapshot in
    // Upload resumed, also fires when the upload starts
}

uploadTask.observe(.pause) { snapshot in
    // Upload paused
}

uploadTask.observe(.progress) { snapshot in
    // Upload reported progress
    let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
        / Double(snapshot.progress!.totalUnitCount)
}

uploadTask.observe(.success) { snapshot in
    // Upload completed successfully
}

uploadTask.observe(.failure) { snapshot in
    if let error = snapshot.error as? NSError {
        switch (StorageErrorCode(rawValue: error.code)!) {
        case .objectNotFound:
            // File doesn't exist
            break
        case .unauthorized:
            // User doesn't have permission to access file
            break
        case .cancelled:
            // User canceled the upload
            break
            
            /* ... */
            
        case .unknown:
            // Unknown error occurred, inspect the server response
            break
        default:
            // A separate error occurred. This is a good place to retry the upload.
            break
        }
    }
}

// Create a reference to the file we want to download
let starsRef = storageRef.child("images/stars.jpg")

// Start the download (in this case writing to a file)
let downloadTask = storageRef.write(toFile: localURL)

// Observe changes in status
downloadTask.observe(.resume) { snapshot in
    // Download resumed, also fires when the download starts
}

downloadTask.observe(.pause) { snapshot in
    // Download paused
}

downloadTask.observe(.progress) { snapshot in
    // Download reported progress
    let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
        / Double(snapshot.progress!.totalUnitCount)
}

downloadTask.observe(.success) { snapshot in
    // Download completed successfully
}

// Errors only occur in the "Failure" case
downloadTask.observe(.failure) { snapshot in
    guard let errorCode = (snapshot.error as? NSError)?.code else {
        return
    }
    guard let error = StorageErrorCode(rawValue: errorCode) else {
        return
    }
    switch (error) {
    case .objectNotFound:
        // File doesn't exist
        break
    case .unauthorized:
        // User doesn't have permission to access file
        break
    case .cancelled:
        // User cancelled the download
        break
        
        /* ... */
        
    case .unknown:
        // Unknown error occurred, inspect the server response
        break
    default:
        // Another error occurred. This is a good place to retry the download.
        break
    }
}

