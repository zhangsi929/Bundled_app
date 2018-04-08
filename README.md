# Bundled Mobile Application

**Developed by** *SixSix*  
**Team Member** *Chenqi Zhao, Wenqi Wang*

## Overview

<b>Bundled</b> is a mobile app working on Apple iOS system. 
The goal is to integrate the food recommandation, grocery shopping list, cooking instructions into one app.The App can recommend meal plan options according to users input constraints, as "Bundles", and users can make selection. Then the system will give shopping list, preparation guide and cooking recipe.<br>

### Function Overview

**Login/Register**: user can register or login to our App.<br/>
**Bundle Build**: user can build meal plans by input number of people, number of meals and dietary restrictions.<br/>
**Bundle Selection**: App provides Bundles from different region in the world.<br/>
**Bundle Detail**: user can click into the Bundle to check the details incluing shopping list, preparation videos and recipes instructions.<br/>
**Shopping List**: user can access a shopping list containing all ingredients of the Bundle. User can check the items they already bought.<br/>
**Preparation**: user can see the list of the videos of preparation.<br/>
**Recipes**: user can read the list of images and text instructions of the dishes in the Bundle.<br/>
**Account**: user can see their profile information and dietary restrictions.<br/>

### Tech Stack Overview

For the frontend part, Swift 3 is applied to develop ios UI on Xcode. 
The model is deployed on Firebase realtime database, and cocoapod Firebase is implemented as the framework to help us interact with backend.
Firebase Authentication module is used to handled user login and registration.

## Code Structure

Model-View-Controller is applied as the code structure:
Model contains all needed classes.
View contains the views that are presented to users.
Controller controls the layout of the views, and interact with the backend to transfer and parse data.

## API Reference

### login
use Firebase Authentication module<br/>:
https://console.firebase.google.com/project/bundle-d5733/authentication/users<br/>
email address and password no shorter than 8 digits is required to login.
example:<br/>
<code>
{
	"name": "nobody@nobody.com",
	"password": "nobodynobody"
}
</code>

### sign up
json body must include "name"(string), "password"(string), "email"(string)<br/>
example:<br/>
<code>
{
	"name":"nobody",
	"password": "nobodynobody",
	"email": "nobody@nobody.com",
}
</code>

### database
Data is stored in databse as json trees<br/>
https://bundle-d5733.firebaseio.com/


## Contributors
Wenqi Wang: UI design, backend build, API<br/>
Si Zhang: UI design, frontend built, authentication build<br/>
Chenqi Zhao: frontend built, data transfer, test<br/>






