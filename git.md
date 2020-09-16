


Git config list
git config --list

add proxy to git
git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:8080

Create branch at local and push to remote
    git checkout -b feature/SUNRISEDIG-12834-QoQa-Checkout-Flow-Adjustment
    git checkout -b bugfix/SUNRISEDIG-13440-add-alternative-checkout-for-qoqa-promotion

Push local branch with Changes to remote
    git push -u origin develop-to-release-merge-09-jul
    
    
Revert single file change
    git checkout src/containers/Subscription/SubscriptionTabs/Options/EditOptions/EditOptionsAction.tsx

Add File for new commit    
    Single File
        git add src/constants/product-free-standard-numbers.js

    multiple files like this
        git add folder/subfolder/*
        
    Git Tools - Interactive Staging
        git add -i

Revert all change on all files
git reset --hard
    
    
make a new Commit
    git commit -m "SUNRISEDIG-12834 [feature] Hide zero cost product for QuQa checkout"
    
remove a tag
    git tag -d 65.1.0.79.0
    git push origin :refs/tags/65.1.0.79.0


The point of this helper is to reduce the number of times you must type your username or
       password. For example:

           $ git config credential.helper store
           $ git push http://example.com/repo.git
           Username: <type your username>
           Password: <type your password>

           [several days later]
           $ git push http://example.com/repo.git
           [your credentials are used automatically]



