# practice-cloudfront-static-website

Creating a secure static website with CloudFront for your registered domain.

# Introduction

# Pre-requisites for this project:

a. An html file to be used as a static website

b. A functional domain name

c. An AWS account

# Steps in delivering the Project

Step 1 - Creating an s3 bucket

Step 2 - Creating a cloudfront distribution


# STEP 1
s3 is an AWS scalable block storage service that means simple storage service. To use s3, you would have to create a **bucket**, which apparently would contain the files and folders one would want to store. In this project, we would create a bucket and upload into it the html file that contains our static website.

i.  Sign into your AWS account

ii. Type s3 in the search and click s3 in the list of services that pop up. This takes you to the AWS s3 interface.

iii.Click on *Create bucket*

iv. Enter your bucket name (must be in lowercase and be unique). We named ours static-website-demo-practice*

v.  Choose an AWS region. Under normal circumstances, you would want to choose a region that  is closer to your audience in order to ensure low latency. But the use of Cloudfront in this project would ensure low latency and high availability.

vi. Tick ACLs enabled

vii.Untick Block all public access

iix.Tick "I acknowledge that the current settings might result in the bucket and the objects within become public".

ix. Leave everything else the way it is by default, scroll down to the last and click Create bucket

*Note that steps vi. to iix. are just to drive home a point, hence would be reversed later.*

Now we have a bucket, and you'd notice "Objects can be public" under Access
![Screenshot (902)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/722c4416-bdef-408c-8e07-98a5f35c7783)

# Uploading the files
i. Click on the bucket name to open

ii. Click "Upload"

iii. Click "Add files"

iv. Navigate to where your html file is on your local machine, click the file, and click open

v. Scroll down and click upload

We now have our html file uploaded into the s3 bucket.

# Static Website hosting

i.   Click on "Properties"
![Screenshot (906)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/c60f8761-11fb-45fe-aaa3-701857e331f7)

ii.  Scroll all the way down to Static website hosting and click Edit
![Screenshot (910)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/0907e1b4-06bf-498a-8d2f-e32b97f63eae)

iii. Tick enable

iv.  Type index.html under index document. This is the name of the file we would want to use for static website. It must match the name of the file uploaded in s3 bucket.

v.   Scroll down and click "Save changes".

# Making the bucket public.
vi. Scroll back up and click Permissions. Note "Objects can be public" under  "Access". 
![Screenshot (911)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/3bd116eb-6b84-4581-a62e-888082b6fc2c)

Also note "off" in red under "Block all public access".
![Screenshot (912)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/96638751-3edf-4670-82e7-bf12e516695f)

vii. Scroll down to Access control list (ACL) and click Edit.
![Screenshot (914)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/76a4b352-aa7a-4aa0-989e-4e861595be83)

iix. Tick 'List' and 'Read' against "Everyone(public access).
![Screenshot (915)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/328a502e-0655-4e35-b646-6bcbdb95f738)

ix. Scroll down and tick "I understand the effects of these changes on my objects and buckets."
![Screenshot (917)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/9281753b-dce9-4dd9-ba5c-594a7e582599)

x. Click "Save changes".

xi. Refresh the page and notice "Objects can be public" change to "Public".
![Screenshot (942)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/267244dc-91e4-444a-92eb-09037905b1e2)


Note that we have made the bucket public just to test accessibility to the static website directly in s3. To perform this test, go back to properties and scroll all the way down to Static website hosting, copy the link and paste it into your web browser. 
Notice the response "403 Forbidden" and Access denied. This is because the bucket has been made public, but the objects within the bucket are not yet public.
![Screenshot (921)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/0bb3c04e-ec6c-49d4-96a8-d429d40ff28c)


# Making the objects public

i.  Go to s3

ii. Click on objects

iii.Click on the object name (index.html)

iv. Click on Permissions

v.  Click on Edit

vi. Tick 'List' and 'Read' against "Everyone(public access).

vii.Scroll down and tick "I understand the effects of these changes on this object."

iix.Click "Save changes".

Now let's go back to the browser where we had pasted the static webisite link. Refresh the page and woohoo! It displays the web page. 
![Screenshot (927)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/8744d32d-c6d1-4d07-89ae-688321bff1e0)


*Let's note that bjects do not inherit the permissions of the bucket. When a bucket is made public, an object within it is not automatically public unless it is also made public.*

So far we have used the Access control list (ACL) to make the bucket and objects public. An alternative to that is the use of Bucket Policy. Lets go back and reverse the public status of both bucket and object with the Access control list (ACL) then explore the use of Bucket Policy.  

Go back to Permissions. 
Scroll down to Access Control List (ACL), click Edit and untick List and Read against Everyone(public access).

Scroll back up, click on objects, click on the object name (index.html), click on Permissions, Click on Edit, untick List and Read against Everyone(public access).

Go back to the bucket's permission tab, refresh the page and notice we now have "Objects can be public" under Access where we used to have "Public". 
![Screenshot (911)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/cd425ee3-f85c-459f-aa98-334c90577c9b)


Now go back to the the browser where we pasted the static webite link, refresh the page and notice what comes up. We are back to  "403 Forbidden" and "Access denied" because the bucket and its objects are no longer public. 

# Making the bucket and objects public using Bucket policy

i.  Enter the bucket and go to Permissions tab

ii. Scroll down to Bucket policy and click Edit
![Screenshot (943)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/5286ec4a-70f1-4a11-bd1f-69a84cd9c333)

iii.Click Policy generator, this opens a new window

iv. Select "s3 Bucket Policy"

v.  Effect should remain on "Allow"

vi. Type "*" against "Principal"
![Screenshot (936)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/9093cb1d-2a29-4da3-94fb-d71f0a898893)

vii. Tick "GetObject" for Actions
![Screenshot (935)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/eb3a89c6-88bc-46f7-8985-c8ec9a6aca10)

iix. Go back to s3 by clicking on the s3 window
![Screenshot (934)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/26533d23-e70a-4dcb-8a83-8ade5322a9b6)

ix.  Copy the bucket arn
![Screenshot (933)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/e20096ec-0758-4483-a905-55eeae4ce754)

x.   Go back to policy generator by clicking on the AWS policy generator window

xi.  Paste the copied bucket arn in the Amazon Resource Name (ARN)

x.   Be sure to add "/*" to the arn you copied. (arn:aws:s3:::static-website-demo-practice/*), this is to ensure that the policy applies not only to the bucket but all the contents in the bucket.
![Screenshot (944)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/dd533741-ea5a-44bd-9c9a-fe9720c909c5)

xi.  Click Add statement

xii. Click Generate Policy

xiii. Copy the generated policy and click close
![Screenshot (940)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/86f066ee-6bd6-49de-bc7c-504a50346108)

xiv.  Go back to s3 using the s3 window

vx.   Paste the copied policy in under Policy and click Save changes.
![Screenshot (941)](https://github.com/DelaDoreen/practice-cloudfront-static-website/assets/130064282/3e501b63-73a3-46d0-ab75-071505d6737c)

vix.  Refresh the page and notice "Public" under Access. 


Now we have made our bucket public again but this time using the bucket policy. To test this, go to the web browser where the static webisite was pasted and refresh the page. The web page is displayed taking the place of "403 Forbidden" and "Access denied".

We conclude on STEP 1 of our project on this note. 
We proceed to step 2, where we set up a cloudfront distribution and ensure access to the s3 bucket is only through cloudfront dns.
