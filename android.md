## Steps for configuring Android deployment
To be able to deploy to the Play Store you need to follow the steps below.

Google Service Account is required to upload your binary to Google Play Store. This JSON key must be added to your account to publish apps to Google Play.

<ol>
<li>Please go to [Google Cloud Platform](https://console.cloud.google.com/apis/dashboard) and create a Google Cloud Project if you don't already have one.</li>

<li>**Enable** the `Google Play Android Developer API` for your Google Cloud Project.</li>

<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service00.01.png" width="100%"/>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service00.02.png" width="100%"/>


<li>Login with your account, then head over to **Credentials** -> **Create Credentials**, and then click **Service account**.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service01.png" width="100%"/>

<li>This screen will forward you to the **Create service account** page. Fill in the details of your service account. According to the service name you set, an automatic **Service account ID** will be created.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service03.png" width="100%"/>

<li>Select `Editor` in the Role dropdown</li>
select Editor in the Role dropdown
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service04.png" width="100%"/>

<li>Click **Done** to save this account.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service05.png" width="100%"/>

<li>Click **Manage service accounts** to open manage page.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service05-1.png" width="100%"/>

<li>Find the account you have just created. Click three dots on the Actions column, and then click **Manage keys**.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service06.png" width="100%"/>

<li>Click **ADD KEY** and then click **Create new key**.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service07.png" width="100%"/>

<li>Download your key as JSON and save it.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service08.png" width="100%"/>

<li>Go to [Google Play Console](https://play.google.com/console/developers) and login with your account and then head over to **User and permissions** and then click **Invite new users**.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service09-2.png" width="100%"/>

<li>Add the email, generated in step 6 in the **E-mail address** field.</li>
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service12.png" width="100%"/>

<li>Check the permissions of your user.
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service11-1.png" width="100%"/>

Make sure this account has access to **Releases**, **Store presence**, and **App access**.
<img src="https://github.com/andrewpmoore/simple_deploy/images/google-service11.png" width="100%"/>

Then click **Invite User**. Your account key is ready. 🎉

</li>

<li>Your account is now ready, save the `.json` file created into a location on your build machine. Don't check it into a public version control system</li>
<li>Configure your `deploy.yaml` file's `credentialsFile` property to point at the downloaded file's path from the step above.</li>

<li>Configure your `packageName` to match the package name declared in your `\android\app\build.gradle`</li>
<li>Specify what's new in this build</li>

</ol>


*** If you are having problems
Ensure that `flutter build appbundle` is working correctly as a command at the root of your project and resolve any errors associated with that.

