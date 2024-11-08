## Steps for configuring iOS deployment

To deploy to Test Flight, follow the steps below.

<ol>
<li>Please go to <a href="https://appstoreconnect.apple.com/">App Store connect</a> and log in.</li>
<li>At the top right hand corner, click on your name and then <code>Edit profile</code>

<img src="https://raw.githubusercontent.com/andrewpmoore/simple_deploy/main/images/apple0001.png" width="100%"/>

<li>Find the <b>Developer ID</b> and make a note of it, this needs to be set in the <code>deploy.yaml</code> as the <code>developerId</code> property</li>

<img src="https://raw.githubusercontent.com/andrewpmoore/simple_deploy/main/images/apple0002.png" width="100%"/>

<li>Go to <b>Users and access</b>, <b>Integrations</b>, <b>Team Keys</b> then click on the <b>+</b> to add a key.</li>

<img src="https://raw.githubusercontent.com/andrewpmoore/simple_deploy/main/images/apple0003.png" width="100%"/>

<li>Give the Key a <code>name</code> and set the access to <code>App Manager</code> and press <b>Generate</b>.</li>

<img src="https://raw.githubusercontent.com/andrewpmoore/simple_deploy/main/images/apple0004.png" width="100%"/>

<li>Copy the <b>Key ID</b> and place it into the <code>teamKeyId</code> in the <code>pubspec.yaml</code> and press <b>Download</b> to download the private key</li>

<img src="https://raw.githubusercontent.com/andrewpmoore/simple_deploy/main/images/apple0005.png" width="100%"/>

</ol>

Place the downloaded file onto your build machine in one of the following directories

```agsl
./private_keys
~/private_keys
~/.private_keys
~/.appstoreconnect/private_keys
```

<b>If you are having problems</b>  
Ensure that `flutter build ios` is working correctly as a command at the root of your project and resolve any errors associated with that.

