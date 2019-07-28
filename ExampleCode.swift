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


